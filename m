Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7090C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818D221872
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547029643;
	bh=6UdRO6Tf7AMjF5v9Te1XpTI0EujpWzfpznZJgcjJ7UA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t/Xnk4HjyH48iZku1IOd5YMeMau3c+AUNrRrYvotiDqa0XDR5Pr7FvmPE2oVTXy/v
	 aEMfkv5TAfLqniM7TRpbJ4HZ6VCMq5hho0chjbH3m4suGJ8kqA4+/CU01Gg78NeKDE
	 SxyHNGlAB7i6cTDt7h54U33DDLB7/OF3UsZTn01w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfAIK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbfAIK1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:27:22 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464ED21741;
        Wed,  9 Jan 2019 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547029641;
        bh=6UdRO6Tf7AMjF5v9Te1XpTI0EujpWzfpznZJgcjJ7UA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ttPHatCC2PW+Ga2hQYbNCH731y2SaP4mHMBsIs4UYwszIWFbyacwcnTGjht4Ijsc3
         el2i648hbpX2nf27bdCFSyXFsS59PePxMHohHHLtTEiVR8viwRmXJBRhP8T80z8iRK
         S9LVJT6/Ad/eOH4fUNqmbwWOxSgoDcrVcECF9vBU=
Received: by mail-lj1-f179.google.com with SMTP id c19-v6so6018597lja.5;
        Wed, 09 Jan 2019 02:27:21 -0800 (PST)
X-Gm-Message-State: AJcUukcBmZAaybeyvd765b9v29IIrB9Qzk9C02Oka3gD2R1ECkYH/PdV
        AS2Pfmbjsx2CQhFlUDxmH+Mco+qR3sLwbzPQEyM=
X-Google-Smtp-Source: ALg8bN4dTJCF2aqcXfn0A9E7z4KPjzNDUsO5E4Z7d89fZt0kVfzOjlQEgynwFkU4xzjPtQp7CEtO1vX0QB/t1XOW9mk=
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr2920278ljf.82.1547029639411;
 Wed, 09 Jan 2019 02:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com> <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Jan 2019 11:27:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcqcyimyUBD5ka60FZCeehqkE=GNH8YYYkgQpJ4=yQ3nw@mail.gmail.com>
Message-ID: <CAJKOXPcqcyimyUBD5ka60FZCeehqkE=GNH8YYYkgQpJ4=yQ3nw@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after
 cpufreq change
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 21:05, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit replaces printk with pr_debug, so we don't flood kernel log.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
