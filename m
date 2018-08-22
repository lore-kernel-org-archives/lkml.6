Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22956C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7B3208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7B3208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeHVXtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:49:19 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:49006 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbeHVXtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:49:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0F76C100E86C0;
        Wed, 22 Aug 2018 20:22:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fall93_36b32d9af8b5c
X-Filterd-Recvd-Size: 2363
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Aug 2018 20:22:55 +0000 (UTC)
Message-ID: <dac95ea92cf3334318cf95d133553c8b7d1110b5.camel@perches.com>
Subject: Re: [PATCH V2] license-rules.rst and LICENSES: Use only spdx
 version 3 with -only and -or-later
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Wed, 22 Aug 2018 13:22:54 -0700
In-Reply-To: <20180822201201.GC19458@bombadil.infradead.org>
References: <9f90ed3678d32bdde88d63e877880dcb08a97e15.1534519501.git.joe@perches.com>
         <7275a821f20ba080b6a262089ceeaf8fa94d4bab.camel@perches.com>
         <CA+55aFyd5D9Rj2Wm+rP9QnZg2Jd_LKqPTKTmPv+doYN=JXra=w@mail.gmail.com>
         <alpine.DEB.2.21.1808222115050.1652@nanos.tec.linutronix.de>
         <d0d292a4d9637c1a94eb40abd8a4ee2dd1f0d823.camel@perches.com>
         <20180822201201.GC19458@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 13:12 -0700, Matthew Wilcox wrote:
> On Wed, Aug 22, 2018 at 12:47:57PM -0700, Joe Perches wrote:
> > Perhaps it's better to stick to a single SPDX version style for
> > all kernel files.
> > 
> > Right now, there are already several -only and -or-later uses.
> > 
> > $ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
> > 144
> > 
> > So perhaps a patch and a tool to do the reverse conversion:
> 
> No.  Any tool which does anything useful just has to understand both
> 2.0 and 3.0 naming.  They're aliases for each other, that's all.

But that same tool would have to be updated if ever
yet-another spdx version appears.

So it'd probably be better to support just 1 version.

