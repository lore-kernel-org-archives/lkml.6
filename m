Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D73C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFFD2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZRlOqxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFFD2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIJLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:23:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37508 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:23:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so20031884wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=92uMQgyk220MLRk4dNE18dVKwlI/zZRqmDqlAHZQKlE=;
        b=QZRlOqxoVAwSyk75JyPLqX8/vu4Ab8Di3AFeH/TcTVKkFKZZ4s9bKrqfiJkmD3wpoh
         mwpTli19cY/haY5cO0Ph172OXNJoytl5v6YsmpHb625qHLiDQDZx0hJbNU0PflFIecii
         mlrkdpFknAQWqs77xajfA0bLgG6XiRB44euxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=92uMQgyk220MLRk4dNE18dVKwlI/zZRqmDqlAHZQKlE=;
        b=MbMDYn0ayFoVRZpA/RLw63XqrH5qU53ozVmpLFyQGJHTpCLpc5eYFhUtO31au4Nv8p
         oEzqkdYJ3cboPxDm8SDD7Q085+om/6BVpd4G5OPrX5VD/HdjsTd8gCN8m4uUgi60iN/w
         GpJFUQM6BzwicOxTU73CFRE28TGno40SLFmkYftOTVKExodoIP2vSJ7zPKmcM/W/kDQS
         pDagAIT59lnZsSNrlswBO1mix3LD2HnMiKaJFE/+yT46G0ecsKavGHSfNSayVHCKJM/S
         wv8wCRBmVYuRQltbi+zESMHidAro6p2TgvjwFOkeFUYO8orT/fh82fgICBJjZAMtObHd
         BsGA==
X-Gm-Message-State: APzg51D7O/Yp4nSRFzRvoiKjI/Cim/eqaKlQLeMdBcEdVv4QJqabwHIa
        Noyys5X8KWoW7KbuLVSBRXfVPA==
X-Google-Smtp-Source: ANB0VdZyML/Z25+4giJZmC2o++BxbBWbGnDzALqLRRtHYMJWEWtY7fvBcJRciGAsqV5j2ra2ReZwug==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr12100082wmb.29.1536561057168;
        Sun, 09 Sep 2018 23:30:57 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm15015280wrs.85.2018.09.09.23.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 23:30:56 -0700 (PDT)
Subject: Re: [PATCH] ASoC: core: add support to card rebind
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, bgoswami@codeaurora.org
References: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
 <20180906105425.GE5360@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8c856984-889c-1604-ccc7-c6d5969f57ca@linaro.org>
Date:   Mon, 10 Sep 2018 07:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180906105425.GE5360@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/18 11:54, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 10:37:08AM +0100, Srinivas Kandagatla wrote:
>> Current behaviour of ASoC core w.r.t to component removal is that it
>> unregisters dependent sound card totally. There is no support to
>> rebind the card if the component comes back.
>> Typical use case is DSP restart or kernel modules itself.
> 
> This looks OK but needs rebasing against current code.
Thanks I will rebase and send the patch.

thanks,
srini
> 
