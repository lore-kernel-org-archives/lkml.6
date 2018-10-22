Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B3C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424772083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424772083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeJVRyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:54:01 -0400
Received: from ozlabs.org ([203.11.71.1]:32773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeJVRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:54:01 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drxV6k8jz9sDF; Mon, 22 Oct 2018 20:36:14 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6beb3381b12793726783a5e9428250743659c6cf
In-Reply-To: <c562b688661c64c0b58bfa689c60a6ed38fd82a8.1535358405.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/sysdev/ipic: check primary_ipic NULL pointer before using it
Message-Id: <42drxV6k8jz9sDF@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:36:13 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 08:27:27 UTC, Christophe Leroy wrote:
> ipic_get_mcp_status() is used by targets implementing NMI
> watchdog in target specific machine check handler in order
> to known whether a machine check results from a watchdog
> NMI reset.
> 
> In case of very early machine check, primary_ipic pointer
> might not have been set yet, so ipic_get_mcp_status() needs
> to check it for nullity before using it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6beb3381b12793726783a5e9428250

cheers
