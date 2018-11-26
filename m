Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561E120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C16wMtie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561E120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeK0BwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:52:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42271 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0BwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:52:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so19235850wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1k3K3ISxEZanBE3UUREGo2di9hLOXGOCwpJ8/upQSq0=;
        b=C16wMtie3QwvJuLlxYPT22PbiedSoGGxLRvI3HeyaAVmTetnc5eh0ihX6eLZts3Zwz
         jV4Iwux+Kal5vfbadk6GmjJY955Y5CEFPOUI0XAt/vsnhhDQjOCbwC5fNlQLoAsLPdKh
         6PADBr/EkDmxHnCOq+5pKIAeRHSjVUIfO9BG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1k3K3ISxEZanBE3UUREGo2di9hLOXGOCwpJ8/upQSq0=;
        b=j36wH+npwRvE/qffSV1pwWGFoUlAYeEzkQ7XdCSEFC2T1hnPUsqkbhUgAFxWSikLGX
         B+yyeiBWLV8hZ7bkozhHQSVMtcwYNoRbjanVrI4j/8U9AVAXyiGdPdBCc5rHs8cJCM2/
         Jnzw2VBDyy0WoX6EblNPh4xDqOZLjM3XYb8lPcm9hDgqxmq9j1oLC1ETez9czgdbgCif
         3dUdQiDZEV0tVGGduFCOpylano1rQ1aHKD0kH9ZGfejIRC4BOZ+Ag2rM/otNFf0KezkQ
         BppkOn86xFNuXQqXaHL0ka9Qkyo048lOtmBQX8SzkI6dyF4+KNr6+wkNIkeuUSEN5L0f
         tNgg==
X-Gm-Message-State: AA+aEWYxeHC6vgBBoJxZYo5Hk3Bp7jBxhURRaj4WHfGynMbnQxFl4w9v
        0mLJQEQbWVVuVsGEAbquzdKjGA==
X-Google-Smtp-Source: AFSGD/UVItdwoUYrNwHvOlFcNNdy5JLN6GuB7gwrcWbAuohJtIzDT85+qEn5uqSh9RWZHk/cJuDYBA==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr20580620wrq.38.1543244259571;
        Mon, 26 Nov 2018 06:57:39 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 66sm450039wmn.38.2018.11.26.06.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 06:57:38 -0800 (PST)
Subject: Re: [PATCH v3] media: venus: amend buffer size for bitstream plane
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Malathi Gottam <mgottam@codeaurora.org>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
 <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <f6106d20-abee-979c-8ac1-6c9115e8373c@linaro.org>
Date:   Mon, 26 Nov 2018 16:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 11/26/18 3:37 PM, Hans Verkuil wrote:
> On 11/26/2018 11:12 AM, Malathi Gottam wrote:
>> Accept the buffer size requested by client and compare it
>> against driver calculated size and set the maximum to
>> bitstream plane.
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> 
> Sorry, this isn't allowed. It is the driver that sets the sizeimage value,
> never the other way around.

I think for decoders (OUTPUT queue) and encoders (CAPTURE queue) we
allowed userspace to set sizeimage for buffers. See [1] Initialization
paragraph point 2:

    ``sizeimage``
       desired size of ``CAPTURE`` buffers; the encoder may adjust it to
       match hardware requirements

Similar patch we be needed for decoder as well.

> 
> If you need to allocate larger buffers, then use VIDIOC_CREATE_BUFS instead
> of VIDIOC_REQBUFS.
> 
> What problem are you trying to solve with this patch?
> 
> Regards,
> 
> 	Hans
> 

-- 
regards,
Stan

[1] https://www.spinics.net/lists/linux-media/msg142049.html
