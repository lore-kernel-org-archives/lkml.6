Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D973C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ABC21934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srzqd+nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfBOBGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:06:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44877 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBOBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:06:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so3977303pfh.11;
        Thu, 14 Feb 2019 17:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8tEkel44IVdcHQ8lsgzrLMyzLctIKO+ndUdbIrBUS/I=;
        b=Srzqd+nDwzyfmNJX8hQmg7F1pxp+nh4rAnGTLMJ8TG79mS774dNxiHVGW+NNe7n7+l
         1Alh7TEF8E1jIo9Ms4thEjM5TKJWrjRS4FPFoiQ9Gb3070wjqe4+TvafK7ov1WcJp2m4
         pxV5VmHZeXkgtxPRiaIsGCvFBjzAcz7BuMDu9tupxnNbXQ/NpM2mf439WA2pXck6/olO
         3Qpo/oesowJLi2Q8BARs+p3uUbSoPLyjZv1BbODDtPrC7VRB6G3BIspb2WJXi1xJxnrD
         /gXI46zBH8jvwd7A18UlOlQFhyE0k45DzW7Lv5ZRDLH2WOVWGjJqiUhU1RMZalkqI6XW
         cT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8tEkel44IVdcHQ8lsgzrLMyzLctIKO+ndUdbIrBUS/I=;
        b=augYgee/F3FyUi/4A5+QM3eHjSq9NcKEtGv6plihAPVxcZKrP8M6lYpYHOsAhyiJ2s
         hmcmTk/xmUU9hnNVKZGTXAVHexmD8fl3iOV7isda9UFP/nPBK2gF3D/Ij4evmrE0LJuG
         hFzp+8sMMfmt75j35ewlWFZZYJ3k6NFyBb/rJMnG4FJ3UrgYkB2hXJySSdkMv+1nBdlB
         nHPc1Pe4tDdHrPIG94mOesVkzdHRb1dhXuLwBZ5ytLTEO2uCPUr8Zw7ip9AExaH9B+gf
         b1lZ9XLzkvEZuRdI6ApY6Uu8X1Tvd2ivNg9DfXnDUi/jUfClwHDbF4tXLjNyTFmWf3Oj
         KalA==
X-Gm-Message-State: AHQUAubJ79JUPNRgSKUJNsCx0Z2lfsIemCgQeBYhQwQQ7TRGyNWmlwlu
        dZLPBVd4pzkPSgDTR/HzH/E=
X-Google-Smtp-Source: AHgI3IZyhkoqygC6MrrEV+9LBGKd2Aof8Q5BXinNfDSopoPrY95pO8XS3z/EZs0GGoBvicus9+HK7Q==
X-Received: by 2002:a63:8048:: with SMTP id j69mr2733248pgd.432.1550192800241;
        Thu, 14 Feb 2019 17:06:40 -0800 (PST)
Received: from [10.67.48.220] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z13sm5949418pgf.84.2019.02.14.17.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 17:06:39 -0800 (PST)
Subject: Re: [PATCH net] net: stmmac: Fix NAPI poll in TX path when in
 multi-queue
To:     David Miller <davem@davemloft.net>, jose.abreu@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
References: <a264c48823687434e4d18aeb5830707e00c64250.1550077162.git.joabreu@synopsys.com>
 <20190214.090107.1088098621242009425.davem@davemloft.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <f8da6c15-991f-b774-a856-d3e8e45a33b6@gmail.com>
Date:   Thu, 14 Feb 2019 17:06:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214.090107.1088098621242009425.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 9:01 AM, David Miller wrote:
> From: Jose Abreu <jose.abreu@synopsys.com>
> Date: Wed, 13 Feb 2019 18:00:43 +0100
> 
>> Commit 8fce33317023 introduced the concept of NAPI per-channel and
>> independent cleaning of TX path.
>>
>> This is currently breaking performance in some cases. The scenario
>> happens when all packets are being received in Queue 0 but the TX is
>> performed in Queue != 0.
>>
>> I didn't look very deep but it seems that NAPI for Queue 0 will clean
>> the RX path but as TX is in different NAPI, this last one is called at a
>> slower rate which kills performance in TX. I suspect this is due to TX
>> cleaning takes much longer than RX and because NAPI will get canceled
>> once we return with 0 budget consumed (e.g. when TX is still not done it
>> will return 0 budget).
>>
>> Fix this by looking at all TX channels in NAPI poll function.
>>
>> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
>> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
> 
> No this isn't right.
> 
> The TX interrupt events for Queue != 0 should clean up the TX packets
> on those queues.
> 
> Furthermore you are breaking the locality of the TX processing.
> 
> I'm not applying this, sorry.

Agreed, why don't you create per-queue NAPI instances such that they are
all independent and can complete their TX completion/RX processing
entirely separately?
-- 
Florian
