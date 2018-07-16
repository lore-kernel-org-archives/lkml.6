Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCCECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC79320871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC79320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:45:06 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:39474 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeGPNpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:45:06 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w6GDHYdv005275;
        Mon, 16 Jul 2018 14:17:34 +0100
Date:   Mon, 16 Jul 2018 14:17:34 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     viro@zeniv.linux.org.uk,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to
 return negative number not equal to -1
Message-ID: <20180716141734.01ddee8c@alans-desktop>
In-Reply-To: <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com>
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
        <878t6c7f8p.fsf@mail.parknet.co.jp>
        <20180715143043.GM30522@ZenIV.linux.org.uk>
        <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Oops, I was just doing some testing and thought that correct behavior
> for crafted FS is to return arbitrary valid error code (like -EIO) or
> some arbitrary data, say, not larger than FS (not disclosing the
> kernel memory, of course). Please excuse me if I was wrong. If fixing
> this would slow down some hot code path, then I am not insisting on
> returning valid errno. :)
> 
> Meanwhile, how should be considered such discrepancies with man pages
> for invalid FS images: should it be considered low priority bug,
> not-a-bug or feature request (diagnostics)?

If you can crash the machine or exploit it with a carefully crafted disk
then its serious. If you get weird behaviour only it's not too serious.

It's nice (but often not possible) if a filesystem at least forces itself
R/O when it detects a corruption to avoid doing more damage.

Alan
