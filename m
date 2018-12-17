Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB95C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4960A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeLQRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:21:35 -0500
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:56945 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727186AbeLQRVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:21:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 190238368EF8;
        Mon, 17 Dec 2018 17:21:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: act66_2a57bb9961154
X-Filterd-Recvd-Size: 3109
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Dec 2018 17:21:30 +0000 (UTC)
Message-ID: <d45ce5f7612ef579a9bc687bab4339f27ee35660.camel@perches.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
From:   Joe Perches <joe@perches.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        marc.w.gonzalez@free.fr, bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Dec 2018 09:21:29 -0800
In-Reply-To: <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
References: <cover.1545063166.git.amit.kucheria@linaro.org>
         <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 21:49 +0530, Amit Kucheria wrote:
> Several drivers didn't have a specific maintainer (other than the
> subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
> patterns to capture all of them and add exceptions to the couple of
> drivers that contain 'msm' but are not related to qcom hardware.
> 
> Thanks to Marc for the idea to use the N regex.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1929,20 +1929,14 @@ M:	Andy Gross <andy.gross@linaro.org>
>  M:	David Brown <david.brown@linaro.org>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/soc/qcom/
> -F:	arch/arm/boot/dts/qcom-*.dts
> -F:	arch/arm/boot/dts/qcom-*.dtsi
> -F:	arch/arm/mach-qcom/
> -F:	arch/arm64/boot/dts/qcom/*
> +N:	qcom
> +N:	msm

It is generally better to use a comprehensive list of F: patterns
over N: patterns as N: patterns are not used as properly maintained
entries for files matched by the get_maintainer.pl script.

git history is used by default for the N: entries and that can
cause whitespace style commit authors to be cc'd on various changes
to matched files.

Also msm is a pretty common filename pattern and the X: exclusions
for various matching but not associated files might need to be added
to quite often.

From MAINTAINERS:

	N: Files and directories with regex patterns.
	   N:	[^a-z]tegra	all files whose path contains the word tegra
	   One pattern per line.  Multiple N: lines acceptable.
	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
 	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.


