Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A63C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE9D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeJVR6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:58:36 -0400
Received: from ozlabs.org ([203.11.71.1]:52073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeJVR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:58:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42ds2m2MS9z9sDJ; Mon, 22 Oct 2018 20:40:48 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0f99153def98134403c9149128e59d3e1786cf04
In-Reply-To: <c0cec03a57070ef3662ae7e2ddffbdeefb128b81.1539891327.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, radu.rendec@gmail.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/msi: Fix compile error on mpc83xx
Message-Id: <42ds2m2MS9z9sDJ@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:40:47 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 06:12:50 UTC, Christophe Leroy wrote:
> mpic_get_primary_version() is not defined when not using MPIC.
> The compile error log like:
> 
> arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
> fsl_msi.c:(.text+0x150c): undefined reference to `fsl_mpic_primary_get_version'
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Reported-by: Radu Rendec <radu.rendec@gmail.com>
> Fixes: 807d38b73b6 ("powerpc/mpic: Add get_version API both for internal and external use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f99153def98134403c9149128e59d

cheers
