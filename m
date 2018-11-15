Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43918C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170C822419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170C822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbeKOUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:41:18 -0500
Received: from foss.arm.com ([217.140.101.70]:59708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbeKOUlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:41:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26D64A78;
        Thu, 15 Nov 2018 02:34:02 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CD9F3F718;
        Thu, 15 Nov 2018 02:34:00 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:33:57 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181115103357.GM3505@e103592.cambridge.arm.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
 <69B07026-5E8B-47FC-9313-E51E899FAFB0@amacapital.net>
 <20181114105449.GK3505@e103592.cambridge.arm.com>
 <877ehfdgzn.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ehfdgzn.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:40:44PM +0100, Florian Weimer wrote:
> * Dave Martin:
> 
> > Fair points, though this is rather what I meant by "sane essentials".
> > Because there are strict limits on what can be done in the vDSO, it may
> > be more bloat-resistant and more conservatively maintained.
> >
> > This might provide a way to push some dumb compatibility kludge code
> > that receives little ongoing maintenance outside the privilege wall,
> > whereas it has to sit in the kernel proper today.
> >
> > In theory we could opt to advertise new syscalls only via vDSO entry
> > points, and not maintain __NR_xxx values for them (which may or may
> > not upset ptrace users.)  Anyway, I digress...
> 
> Is the vDSO available across all architectures?  (I don't think we use
> it on all architectures in glibc.)

It's probably not available on all arches.

> If not, a vDSO-based approach would merely lead to even more variance
> between architectures, which can't be a good thing.

That's a fair concern.

Channeling syscalls through the vDSO could allow for a uniform syscall
interface at the ELF linkage level, but only those arches that have a
vDSO.  There may be other issues too.

Also, I don't say that we should definitely do this, just that it's
a possibility.

Cheers
---Dave
