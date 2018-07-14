Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E919ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631FC2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631FC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGNUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:10:56 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57718 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727315AbeGNUK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:10:56 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id E410B3A69A9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 21:10:42 +0200 (CEST)
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AC0EB200015;
        Sat, 14 Jul 2018 19:10:34 +0000 (UTC)
Date:   Sat, 14 Jul 2018 12:10:31 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-ID: <20180714191030.GA17877@localhost>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
 <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
 <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
 <87pnzpvdtd.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnzpvdtd.fsf@xmission.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:04:46PM -0500, Eric W. Biederman wrote:
> For a config option that no one has come forward with an actual real
> world use case for disabling, that cost seems much too high.

The real-world use case is precisely as stated: code size, both storage
and RAM.

I regularly encounter systems I'd *like* to put Linux in that have
around 1MB of storage and 1MB of RAM, or even less.
