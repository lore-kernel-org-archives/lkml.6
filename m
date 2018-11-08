Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884DA20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884DA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKHT5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:57:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:42863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeKHT5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:57:45 -0500
Received: from [213.144.13.140] ([213.144.13.140]) by web-mail.gmx.net
 (3c-app-gmx-bs57.server.lan [172.19.170.141]) (via HTTP); Thu, 8 Nov 2018
 11:22:50 +0100
MIME-Version: 1.0
Message-ID: <trinity-0d747914-3749-46c4-a5e8-fb7141a9b7c2-1541672570683@3c-app-gmx-bs57>
From:   "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
To:     "Suraj Singh" <suraj1998@gmail.com>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com
Subject: Aw: [PATCH] staging: net: ipv4: tcp_westwood: fixed warnings and
 checks
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 8 Nov 2018 11:22:50 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1541670377-17483-1-git-send-email-suraj1998@gmail.com>
References: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
 <1541670377-17483-1-git-send-email-suraj1998@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:wESOkapkNCVM5/neREw5PgsTy7Jf5xXP0WjRIlmblGiXotpihG4njykYrl3zk+bvdFNZm
 vbhPMLyDkcvnj9OZ3+o33B2I4shnUZYBuKFVfip5rdF+Zsm18sdSXTx4VCG3Oob/SiYWloSImj6e
 U1PUzE6lZUQDsy6TgJ4+YZqWuXQpVbmBi1+rIEOXi4SzL92FgQtse/snG4frzOGBfE+LeMrTUzip
 SJGGRcDVL68+8/z9g+MQP8xeycAKWea+J2as2Z0IDInqjEC0ejxA2PjP8NqfqSkMwS1iy9wOvhV9
 nI=
X-UI-Out-Filterresults: notjunk:1;V01:K0:21yCKqWQ7Kw=:nQ6dOrhUPYvA8dB+FOysgx
 x2lQugVqzy2qMSgCQpRm2EOZU2NiPxYOmW2xwMW6myGxiThbNkz4/AaKbxPZEV4RG2tXBtGwm
 ODm2iKNznOFheIy1WQKyNLgj4aYrdjreDbSWGtwPZ68XZ8Q88WVLmOkJfaeSV1ZXrmr0/qpnA
 w2A22BApkv3ICMDRHLnrsKsDxyi39DeChGm/B/Q7QpbojArEOl/gFyv25oHcMoONX3Vzne23/
 O2YuYaVTwSp73JqriC2/oDGS/JXD0gpV/zH2G5FxMKQ+a1Jxfh3j9USD0d/OgL+FhHoXH5Jxt
 TXqRRHF5usGqLIboerGaU/ORzCHiqmoalmC36UO6PZ3426/NgjppKglf2A7wAhzZADyMgyuZy
 6IIsZOmfzxK6Ld4Haye0PHDj+HNDsgGD4AI+BAPDy7ohmyLbTUv2S1GbSwX8P7gRfNfXpLBv8
 SdElCwVGsLu7aOpxxFhDD4s0ScKZypuHUT8B6zVh28NMg9GaTT/rFmejZlWHt92cZvS845IJf
 HjlVCwSN867mMldDZtM/J6jGLLf9pmfKoJ7megV5S58o6H4+2BZnLTGDOFHviKLSDUCl5NCaN
 DFXgbX5lD2J6c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Donnerstag, 08. November 2018 um 10:46 Uhr
> Von: "Suraj Singh" <suraj1998@gmail.com>
> An: davem@davemloft.net
> Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, suraj1998@gmail.com
> Betreff: [PATCH] staging: net: ipv4: tcp_westwood: fixed warnings and checks
>
> Fixed warnings and checks for TCP Westwood
> 
> Signed-off-by: Suraj Singh <suraj1998@gmail.com>
> ---


You use the prefix "staging" again in you subject line, which still is wrong. "staging" means that you
fix something from the staging area (see drivers/staging/ in the kernel sources. BTW: the staging area is a much
better starting point for first patches than the core parts of the network subsystem).
Also if you send a subsequent version of a patch you have to write the version number (e.g. v2) in the 
subject line. Have a look at other patch submissions on this mailing list for examples.

Regards,
Lino
