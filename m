Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE29C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863DF20871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpIBUySd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863DF20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeGGOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:23:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46628 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeGGOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:23:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so4108223pld.13;
        Sat, 07 Jul 2018 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efxd470cn6MDdRp+7sbnLgoFDcMTXCpGyNx0Jz2UQe0=;
        b=KpIBUySdksZUKKH21c0mFfMKdBwtscbSayR35zpSMUFNCKd/RZXGr0a7R8XYHad5FJ
         6N0j6rGFRoK47VyJqHmpIckFYpCEfQ+tzlBkPTAn/2ymgjJJtnNAhOvkIGBbXVaa7NjK
         B/i+ngdSsJS2qScMfe/gao14n+MxhzAfv42tDv+pfxsZXAN1MCS8y2Ozbf89895knOzt
         NMSxA8R3u6lpiGYxKoDuDxbfFPLCI5U3DDmIeqnuge/Jex2y5+6Yigj11CEGhF0yLipv
         Aj0yyf0vqsc18qvOu/uoJVKTJP3P6BuFbnsaIfCE0X+79dw4OMhXV/Gy/DKzGqy7vcu5
         VPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=efxd470cn6MDdRp+7sbnLgoFDcMTXCpGyNx0Jz2UQe0=;
        b=c0xGOHCyew7kf20H+sQ3quxs12UDPqueXZ486EcrJ8uHh375H6IvDaOMghR4EPxLXe
         ELgW2hlrKRCB2ojkhXEVXsRHObdgrkRN4JGQeOOxksWj71VeSi9FWFNTeXF3JPaLm5S/
         FsMEc0GMsgEN7AGbYjm9/OtB4h/qUA/UdIDbzCSlWklH4yRsRvHz03W383MabI8n0dcI
         2lPbrMphbUI1R3KQRybboctzyF06MnOQLYap+YVCRZSlgXerKhOayxwclrnmIrwM1vfl
         kocKCyMpt7jNYCPgnfRbVk8kOylgpHmaguo6XSTAwkp90AQ3YUQ4t4RIrRedcq5nK2+5
         Y0Gw==
X-Gm-Message-State: APt69E23gThbDgmnOIGtltxLCwkRaaedWO81E3It43ytQqZTwryG3NHi
        BlDI1ugYNcCRQ+rFaMP6HJUVfsWi
X-Google-Smtp-Source: AAOMgpc7eVbq1d9U5NDqNyfro74UHy28hLzGo/zSOWP6wuZ2izFc6ldV62DU2/Ty/VwJVtfsQPwkuQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr13748008pla.147.1530973398196;
        Sat, 07 Jul 2018 07:23:18 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-126-112-211.tukw.qwest.net. [97.126.112.211])
        by smtp.googlemail.com with ESMTPSA id s5-v6sm20847308pgo.65.2018.07.07.07.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:23:17 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] timex: use __kernel_timex internally
To:     Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, linux-alpha@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-7-deepa.kernel@gmail.com>
From:   Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 xsBNBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAHNI1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+wsCBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVzsBNBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAHCwGUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <f47f0a96-9d47-944c-8054-697db7bd6eb0@twiddle.net>
Date:   Sat, 7 Jul 2018 07:23:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180707054247.19802-7-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 10:42 PM, Deepa Dinamani wrote:
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index 6e921754c8fc..ec86e77d3055 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -1260,7 +1260,7 @@ struct timex32 {
>  
>  SYSCALL_DEFINE1(old_adjtimex, struct timex32 __user *, txc_p)
>  {
> -        struct timex txc;
> +	struct __kernel_timex txc;
>  	int ret;
>  
>  	/* copy relevant bits of struct timex. */

Acked-by: Richard Henderson <rth@twiddle.net>


r~
