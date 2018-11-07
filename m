Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D653C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A68720882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A68720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKHId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:33:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeKHId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:33:27 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6FCDB941;
        Wed,  7 Nov 2018 23:00:53 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:00:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Oleksiy.Avramchenko@sony.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] z3fold: encode object length in the handle
Message-Id: <20181107150052.ed3d26414c3b2f74956a3d42@linux-foundation.org>
In-Reply-To: <CAMJBoFMWV-HbymH6D0PYF6EJFoLoheDHCwaQgZiadvd7BZSE2w@mail.gmail.com>
References: <20181025112821.0924423fb9ecc7918896ec2b@gmail.com>
        <20181025124249.0ba63f1041ed8836ff6e6190@linux-foundation.org>
        <CAMJBoFMWV-HbymH6D0PYF6EJFoLoheDHCwaQgZiadvd7BZSE2w@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 13:27:36 +0100 Vitaly Wool <vitalywool@gmail.com> wrote:

> Hi Andrew,
> 
> Den tors 25 okt. 2018 kl 21:42 skrev Andrew Morton <
> akpm@linux-foundation.org>:
> 
> > On Thu, 25 Oct 2018 11:28:21 +0200 Vitaly Wool <vitalywool@gmail.com>
> > wrote:
> >
> > > Reclaim and free can race on an object (which is basically ok) but
> > > in order for reclaim to be able to  map "freed" object we need to
> > > encode object length in the handle. handle_to_chunks() is thus
> > > introduced to extract object length from a handle and use it during
> > > mapping of the last object we couldn't correctly map before.
> >
> > What are the runtime effects of this change?
> >
> 
> I haven't observed any adverse impact with this change used in zswap (and
> in fact, this is a bugfix for zswap operation). There is a slight under 1%
> impact when z3fold is used with ZRAM but since the support for ZRAM over
> zpool is still out of tree, I take it doesn't matter at this point, right?
> 

I mean "runtime effects", not "run time effects" ;)

Apart from wishing to document this change fully, I'm trying to
understand which kernel version(s) need the fix.  To understand that, I
need to know the effect upon end-user-visible behaviour.  You say it
fixes a bug - please describe that bug: how it is triggered, what
effect is has, etc.

Also, any suggestions as to which kernel versions we should fix is
always welcome.

