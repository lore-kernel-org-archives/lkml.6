Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89557ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8F2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF8F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbeIULMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:12:51 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60112 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbeIULMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:12:50 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8L5PdG7025913
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:25:39 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8L5PYVR028368
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:25:39 -0400
Received: by mail-qk1-f198.google.com with SMTP id p192-v6so9373680qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 22:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=A6LjSWrrRMU4EJFlKYSkYGIjPDgO/+XpDm40JiXJc7I=;
        b=T/GWi/so5+yZza9qe9WSNjB9aO3rpapB3ccu2ubtkOiUz2wN9JCxwNF62zqNyQ5kPT
         t8vMdfP4eVJDKRi+3+KS6ftNl1RJjjg+Yb7z6dVhCxmswIt/aliJb5ocXXirDM/wIHvh
         FIgSU3wcN4k7Krbg0LGiTIQxP/T2M/lDz6uZle1Ty5CBPX0ijFydT85aT7x6QWF18A+W
         RwNpWooTSHkutRwTx0dg1NwVQcbnL/B6ZJKzSpyClIYfOgllETVIVE91sKXCzCrTjxws
         yF+76P0SnQiQLj/w0WoNaWcdXTnZytpjv/ytvc7jkDG+qi20nG9zdvrtkrBBa4K80iqB
         mX8w==
X-Gm-Message-State: ABuFfoiyWkhySoja/NCscWrogGNEXNNVv27xpukBVrmx7rrxutX840Hr
        P3XM9B/+vcb1mMIZ6Gkq8vClGifeCSnkkonyFS4wSPaVb8hb6GTxvhBiB32+DJWNJKRiSR1SyMq
        CZ7mzQyCZ509nrNgIcK5ZQiagNQlLO0/LHSY=
X-Received: by 2002:a37:b101:: with SMTP id a1-v6mr398065qkf.222.1537507534612;
        Thu, 20 Sep 2018 22:25:34 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60yg4yNNbL5T1QwhVZ6udDU0r1wYUgTpI0mKUZTSuuxJNkmPYRQQvAu63d+iMVRWDOvUBiLnQ==
X-Received: by 2002:a37:b101:: with SMTP id a1-v6mr398059qkf.222.1537507534400;
        Thu, 20 Sep 2018 22:25:34 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::d53])
        by smtp.gmail.com with ESMTPSA id o15-v6sm18508192qtj.46.2018.09.20.22.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 22:25:32 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Remove unnecessary pointer check
In-Reply-To: <20180920212648.25181-1-natechancellor@gmail.com>
References: <20180920212648.25181-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1537507531_3004P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Sep 2018 01:25:32 -0400
Message-ID: <32473.1537507532@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1537507531_3004P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 Sep 2018 14:26:49 -0700, Nathan Chancellor said:
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context:
>
> drivers/staging/wilc1000/linux_wlan.c:267:20: warning: address of
> 'vif->ndev->dev' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!(&vif->ndev->dev))
>             ~  ~~~~~~~~~~~^~~
> 1 warning generated.
>
> Since this statement always evaluates to false due to the logical not,
> remove it.

Often, "just nuke it because it's now dead code" isn't the best answer...

At one time, that was likely intended to be checking whether ->dev was a null
pointer, to make sure we don't pass request_firmware() a null pointer and oops
the kernel, or other things that go pear-shaped....

So the question becomes:   Is it safe to just remove it, or was it intended to
test for something that could  legitimately be null if we've hit an error along
the way (which means we should fix the condition to be proper and acceptable
to both gcc and clang)?



--==_Exmh_1537507531_3004P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW6SAy40DS38y7CIcAQJHIggAmsE27bK1qtrpnn8vS0CpNAe8Il5BdTsU
Ykt1ANM5C47PvWStiA/zTBFDXIvN9WEBj9rcH4x18tQltHu50Prsk83EmBPHQXmn
d/8+xJiqoLbAd3cmCHajIvIBRfzyc6lw+Cq64PX8vgYXdcf5VBfIklQJ0e/2GsEA
8gfunfMfDUNUf/28gMXhbmAs9I6se8oICtb9GRDlreVOeAlDwPyEMihgmU+kUD+2
KYFDR65aHv6dE33145XLKivYqAaFaD/VGUWElbCAkjA5jGym9uILA3x8IurTZJML
8DeDPWza1YRkzK/rYJNVSm+UGOHp4mEf1eZW1ITUMx1pJjE6VwzpMQ==
=F6B6
-----END PGP SIGNATURE-----

--==_Exmh_1537507531_3004P--
