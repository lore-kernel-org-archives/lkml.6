Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF08C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E4620837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n94nOsfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E4620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLHNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:12:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35887 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:12:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so6262782wrs.3;
        Sat, 08 Dec 2018 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iP4i7E4M46w6XncMlBgFs1Pwp7vljuqA9Ldx1Zo/AJ0=;
        b=n94nOsfyHKz22dmSWfLlBWoekM8Q4VUzgIygKsIafdbP7F/gu+efn5jLxnLi9FA6Kv
         Sz674BwTXzSAu1k52u3xg5r/tNpi99a05qlYa6FVH65RjgCLeikzkwaLkaguhwOMONBp
         19CrWBAGJ6yCrw3/qI1SpBEVqZhwD2OYATlXtbXXQnWTtFcqwlXMIGVWBRq2SXTgZfgc
         7dzQcMEASbFq/IEhwCo2YcTc0Ed3ybtATGYGD4UF5+m99Gassq49ZeA2S3m5SZLj7TCF
         y3zo0GfYq28ILMHEulvMNLRi/RiHF07XE76Z1u9meAi7M3plz7alyyb94DxEXiwRELpy
         5CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iP4i7E4M46w6XncMlBgFs1Pwp7vljuqA9Ldx1Zo/AJ0=;
        b=YeMStq8vBHaV7Vnlirc9M2xtf75cq40TPHZ/9aeDO1azdOG1RYcS/K3gD6sFTgH0+s
         pwA4qwaRDEYg25ZWbz+hO/mPMR4h2mLnR2qxFxokGEAwYxVw44SZZFmLmA0hlXvxL+b4
         srsiYhFYtfWa1i53oVVHC2nQg6/zaZ4/RWMnZu6xWOiClgGCtKxMnRO3Jicu/yWu/nhn
         vTRqoF6YmBqTA69EmgT5ApisaacfrUOhHGLD7z8CL5y/wuk2onCSlVSMh2yYDfNpGjVE
         MNtcI5vjtUL53+zDt6wdQAC+U2F6sk0JG9qMpOqD2FAefYqPOr3e+4HWUdNakekWe70w
         22Mg==
X-Gm-Message-State: AA+aEWYEjvVVuJC8SP1BtHTiuWoBCNa1mvnbzhASb/3afakAPs4VcbNp
        Sp3lIvYaCHOt6jwcCUiqiO6vTrijwk4=
X-Google-Smtp-Source: AFSGD/XfD5Sul3bKTnROfnhfdIz4sJIe8QC/YDcP0wWxrizyt/DLB18A0pA8P3YOBRy3RipbfXGgyQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr4331439wrs.7.1544274754391;
        Sat, 08 Dec 2018 05:12:34 -0800 (PST)
Received: from [192.168.1.3] (x4d06ba91.dyn.telefonica.de. [77.6.186.145])
        by smtp.gmail.com with ESMTPSA id b18sm7265935wrr.43.2018.12.08.05.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 05:12:33 -0800 (PST)
Subject: Re: [PATCH] x86/retpoline: Fix forcing me to update my compiler
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20181208123816.22952-1-k.marinushkin@gmail.com>
 <20181208124240.GE30399@zn.tnic>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <7d8aa04f-9611-fb69-b11c-21ebcf4580fd@gmail.com>
Date:   Sat, 8 Dec 2018 14:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181208124240.GE30399@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> First problem: I cannot compile the kernel with my version of compiler

>> Second problem: when I disable the feature - it cannot take effect,
>> because the parse-time error happens before `syncconfig`

On 12/08/18 13:42, Borislav Petkov wrote:
> Does this help?
> 
> https://git.kernel.org/tip/25896d073d8a0403b07e6dec56f58e6c33678207
> 

The patch which you mentioned fixes the second problem: now I can disable
CONFIG_RETPOLINE.
But, the first problem is still here: with defconfig and gcc v6.4.0, kernel
doesn't build, with this message:

~~~~
$ make
scripts/kconfig/conf  --syncconfig Kconfig
You are building kernel with non-retpoline compiler.
Please update your compiler.
make: *** [arch/x86/Makefile:311: checkbin] Error 1
~~~~

I don't think that this is a proper behavior. I suggest to allow compilation

Best Regards,
Kirill
