Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AE820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJQ2W7hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AE820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeGLIGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:06:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45411 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeGLIGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:06:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id a17-v6so4500989plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6VYIcVnYtrLP1cYApgYsyTR8peq86AtxcMdjXt2A0Y=;
        b=hJQ2W7hHIbpeQsf+V7MtCxRCIIcD31vzu8FgGiYP3/zjupuQEHwuqS0l/5LBDY8Qu2
         59SKXVUrADyLV9COg595DmA6wCsaNvEM5f44zNMJkrTfrph7kLHyH9LBOdlNBzReiDDb
         mzTrlIl4kGTb5puRo2wkJJHMKDp7suPHrIclKe+4O0QKy8OViDMfBdTCioSwqwNbVlc6
         XyRbE+kBfvUp5K3ZOMbMz7LD0o3wsSf6EGDKBNYNU8jIgtiwq6ZqKJjwNcmUBJdYw3X/
         BjERem64Yo81thYlNApuqPxR4ldWf32uKkpllw6hYFNHg1DI2jkOvs4WQgGyuCAlvSRm
         27Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6VYIcVnYtrLP1cYApgYsyTR8peq86AtxcMdjXt2A0Y=;
        b=KUfKGorrIKPUS0fvpHd1hC8xl4pfwaLzPgb/xjyg3GEqvBkuSqXco2CCtf13uoW4U+
         OZvbAo889MVmBM6K9TnVbkf6IWTME08M3chloaa54Fk3a1hNBJxxdAnWsMP73da22hkm
         dsDOU7d7YUBICKngfvCvlZQEgNAvmIsaWNJKmnJCVt8DKopQ1/1h+FvBOZhb+IAMmVol
         50r0rCpOamdsvmU10qh2g/ASZwxdKRn26gNoqXvPPcGiV5UAElWc6jhB5RSCl7hlLu0J
         8wL+IpaJtH+CQyXkXrWcwoTw6Z8ku4V+cMLIDRLHhdtdtZVixEpIQzuVP8Tc9UrDjEVZ
         /nlA==
X-Gm-Message-State: AOUpUlHpd7hyDRqLnmgV/Ccxve8QufBxaEv+hHE7CaDHi0acaudLe7vI
        3p6SEtbbVJxQVclZjye8lT+K2A==
X-Google-Smtp-Source: AAOMgpdqbMiLOgmEAbpgplvLwIgXjRuzy5RvQn0ZOV3GZQQjAVH3fzjTc1mtVaZ2UPz77y0Y0BlK7Q==
X-Received: by 2002:a17:902:d711:: with SMTP id w17-v6mr1139996ply.200.1531382294255;
        Thu, 12 Jul 2018 00:58:14 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id 4-v6sm17046712pgj.22.2018.07.12.00.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 00:58:13 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:58:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        paulus@samba.org, Bjoern Noetel <bjoern@br3ak3r.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Replaced msleep(x) with
 msleep(OPAL_BUSY_DELAY_MS)
Message-ID: <20180712175805.263898e2@roar.ozlabs.ibm.com>
In-Reply-To: <87bmbd80rl.fsf@concordia.ellerman.id.au>
References: <878t6hami4.fsf@concordia.ellerman.id.au>
        <1531346584-9157-1-git-send-email-eleon@ele0n.de>
        <87bmbd80rl.fsf@concordia.ellerman.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 15:46:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Daniel Klamt <eleon@ele0n.de> writes:
> 
> > Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
> > to diocument these sleep is to wait for opal.
> >
> > Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> > Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>  
> 
> Thanks.
> 
> Your change log should be in the imperative mood, see:
> 
>   https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?id=HEAD#n133
> 
> 
> In this case that just means saying "Replace" rather than "Replaced".
> 
> Also the prefix should be "powerpc/xive". You can guess that by doing:
> 
>   $ git log --oneline arch/powerpc/sysdev/xive/native.c
> 
> And notice that the majority of commits use that prefix.
> 
> 
> I've fixed both of those things up for you.

Sorry, just noticed this. I've got a patch which changes the xive stuff
to the "standard" format this will clash with.

               if (rc == OPAL_BUSY_EVENT) {
                       msleep(OPAL_BUSY_DELAY_MS);
                       opal_poll_events(NULL);
               } else if (rc == OPAL_BUSY) {
                       msleep(OPAL_BUSY_DELAY_MS);
               }

If it's already merged that's fine, I can rebase.

Thanks,
Nick
