Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D048C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEFA240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEFA240E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeGEU0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:26:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbeGEUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:56 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 160DF89B;
        Thu,  5 Jul 2018 20:24:56 +0000 (UTC)
Date:   Thu, 5 Jul 2018 13:24:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
Message-Id: <20180705132455.2a40de08dbe3a9bb384fb870@linux-foundation.org>
In-Reply-To: <20180705144941.drfiwhqcnqqorqu3@linux-x5ow.site>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
        <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
        <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
        <20180705144941.drfiwhqcnqqorqu3@linux-x5ow.site>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 16:49:41 +0200 Johannes Thumshirn <jthumshirn@suse.de> wrote:

> On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
> > ...but that also allows 'echo "syncAndThenSomeGarbage" >
> > /sys/.../memmap_state' to succeed.
> 
> Yep it does :-(.
> 
> Damn

sysfs_streq()
