Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FB720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FB720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeGYWgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:36:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:36:19 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 154A1D8D;
        Wed, 25 Jul 2018 21:22:47 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:22:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Coly Li <colyli@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/3] lib: add crc64 calculation routines
Message-Id: <20180725142246.23e354fcc21ef041bb3f87e6@linux-foundation.org>
In-Reply-To: <01f8e352-a49f-2f41-6264-bb6395bb0bf2@suse.de>
References: <20180718165545.1622-1-colyli@suse.de>
        <20180718165545.1622-2-colyli@suse.de>
        <20180724042637.GA1944@sol.localdomain>
        <dd95ab25-562e-1318-19e9-c8163969252f@suse.de>
        <399c1cc851f983370a0308c76c68a97ff41a5d4f.camel@linux.intel.com>
        <01f8e352-a49f-2f41-6264-bb6395bb0bf2@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 10:37:23 +0800 Coly Li <colyli@suse.de> wrote:

> > IIUC this series in Andrew's quilt. So, it's still possible to replace
> > it with better one, I suppose. Ask Andrew (at least I remember recent
> > case where he just replaced series by fixed one).
> 
> Hi Andrew,
> 
> It seems there should be some fix/update for this series. I see current
> series is in linux-next for now. If I want to add the fix, should I post
> a new version of the series, or the incremental patches to fix current
> series ?

mm...  it sounds like the changes will be large, so probably a new
series would be better at this early stage.  If the changes are small
then little fixup patches would be nicer to the people who have already
reviewed v1.

