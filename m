Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC32ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141E20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141E20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeIXSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:10:12 -0400
Received: from shell.v3.sk ([90.176.6.54]:59435 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbeIXSKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:10:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 508C0BA2D5;
        Mon, 24 Sep 2018 14:08:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mVOH_OqHBSbU; Mon, 24 Sep 2018 14:08:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A4A6FBA2D8;
        Mon, 24 Sep 2018 14:08:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wjupdijVJjrh; Mon, 24 Sep 2018 14:08:15 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C29F4BA2D5;
        Mon, 24 Sep 2018 14:08:14 +0200 (CEST)
Message-ID: <cba084f2a3fc438b64ca222014ed679638aebfb1.camel@v3.sk>
Subject: Re: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved
 keyword as a struct member name"
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Date:   Mon, 24 Sep 2018 14:08:13 +0200
In-Reply-To: <26184.1537790420@warthog.procyon.org.uk>
References: <20180924094723.487697-1-lkundrak@v3.sk>
         <26184.1537790420@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.0 (3.30.0-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 13:00 +0100, David Howells wrote:
> Lubomir Rintel <lkundrak@v3.sk> wrote:
> 
> > This changes UAPI, breaking iwd and libell:
> > 
> >   ell/key.c: In function 'kernel_dh_compute':
> >   ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member
> > named 'private'; did you mean 'dh_private'?
> >     struct keyctl_dh_params params = { .private = private,
> >                                         ^~~~~~~
> >                                         dh_private
> > 
> > This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.
> > 
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: <stable@vger.kernel.org>
> 
> Can I stick your Signed-off-by on it?

   1. Yes, please do.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

> 
> David

