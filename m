Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDEAC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCF42244C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuN6FNbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCF42244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeHJUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:52:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeHJUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:52:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so9067313wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qo65ECmky3MG3rQEE2JIvGZQrHIjBVVDPUJOzaStr9k=;
        b=OuN6FNbvxQ8BmpLzTxHrq1LuafQvNIN4toBlMUCOfzGp/t7Vj57dxhLMSnvwqha6oO
         0LhipA/wP25w2X4pn6cEt+4ee16IdELNAvIeu1m2IuO1o/97DzynVdLD5vR+klzp+P30
         lb31FXPEH5dZzUruhGl52aVFz6vCjFRpeWnQt7YXwGsmKAS23tVdFZSCnJ2bBBfyM+nA
         JbDJue91rpO3n0i46+bchAbNzg9uDY4Klk/guVH+0tKOccu3wwV2Hzs4fFz8UMp7lXSg
         3Gr63JYoi8pGIUC8ejljkg7gHlUwiTYKNJS2jyNTQMG83kmeZo62AoAngPVUtfNO0j6Y
         svNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qo65ECmky3MG3rQEE2JIvGZQrHIjBVVDPUJOzaStr9k=;
        b=dt14ZOLOscciFz3949ExHmaDbIvsFE6C/mEjgIKMmJPvIHGKXWv1hvozzANutloKT2
         /uKFp9tMi/9r9oJPKnkIY3MCAHnQvFZxNde0zSnFYoOZGze0FlzyfdtlMttoos8emivj
         cRgMfrle/Bsvy/GSECIH8WcnfZWGNLFjdZoYQRfkpHu1sCbDU9qxOV+8Ndp8MQAkz+uK
         2VgKUMV5fyZJGpy8dKx2VLCvV8+gmtZfb+QhLMCFr8ed5vxEKptbZLH9NLLRRCdW8SbB
         qNygnV4ZgBx7j0J4W/8jSZt5cqHrf99X4OHE/XLKqkJVSSVkDXj3epvQneRNUGW8/HNI
         W0gw==
X-Gm-Message-State: AOUpUlGd19cCKeip4DyHS6FeGFYG1q1uD8hCPE+6bzk7BbiX4RRx3lGE
        UvUu9/IW0rZ0l4Dh6n4k9wsa4hrp
X-Google-Smtp-Source: AA+uWPxOTpBQF6mLCOid4gNoJT5BwoLEjFIwNOwlXHcPKxM5xg2rGI7rjSeELRbuQaSSIVSJNdcPiA==
X-Received: by 2002:adf:94c6:: with SMTP id 64-v6mr841987wrr.99.1533925286434;
        Fri, 10 Aug 2018 11:21:26 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:2d5d:7423:2a5d:6ca9? ([2a02:8108:85c0:57c8:2d5d:7423:2a5d:6ca9])
        by smtp.gmail.com with ESMTPSA id o10-v6sm7188379wrw.79.2018.08.10.11.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 11:21:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_security.c
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180810105133.31224-1-straube.linux@gmail.com>
 <20180810113132.p3go5yduhyz6cr65@mwanda>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <76d01501-e2b2-8f98-724f-8d4c326013e4@gmail.com>
Date:   Fri, 10 Aug 2018 20:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810113132.p3go5yduhyz6cr65@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 13:31, Dan Carpenter wrote:
> No no...  I only gave it a Reviewed-by tag because I didn't want you to
> resend again...  :P

Ah, sorry. So I shouldn't have added the tag?
Should I remove it again? I guess not..
How are those tags (reviewed, acked, etc.) handled normaly?
I'm a bit confused now. ;)

Michael
