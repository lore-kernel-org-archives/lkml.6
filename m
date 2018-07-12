Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B9FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9420875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeGLFyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:54:06 -0400
Received: from ozlabs.org ([203.11.71.1]:39255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeGLFyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:54:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R4g30LB0z9ryt;
        Thu, 12 Jul 2018 15:46:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Daniel Klamt <eleon@ele0n.de>,
        Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep(x) with msleep(OPAL_BUSY_DELAY_MS)
In-Reply-To: <1531346584-9157-1-git-send-email-eleon@ele0n.de>
References: <878t6hami4.fsf@concordia.ellerman.id.au> <1531346584-9157-1-git-send-email-eleon@ele0n.de>
Date:   Thu, 12 Jul 2018 15:46:06 +1000
Message-ID: <87bmbd80rl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Klamt <eleon@ele0n.de> writes:

> Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
> to diocument these sleep is to wait for opal.
>
> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>

Thanks.

Your change log should be in the imperative mood, see:

  https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?id=HEAD#n133


In this case that just means saying "Replace" rather than "Replaced".

Also the prefix should be "powerpc/xive". You can guess that by doing:

  $ git log --oneline arch/powerpc/sysdev/xive/native.c

And notice that the majority of commits use that prefix.


I've fixed both of those things up for you.

cheers
