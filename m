Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A58C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799D27DFB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6799D27DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936107AbeF2LTj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:19:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754116AbeF2LTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:19:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A69FADA9;
        Fri, 29 Jun 2018 11:19:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E559DABB2; Fri, 29 Jun 2018 13:19:31 +0200 (CEST)
Date:   Fri, 29 Jun 2018 13:19:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180629111931.GN2287@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20180627085936.4f9cc4f2@canb.auug.org.au>
 <20180628161102.GJ2287@suse.cz>
 <20180629095858.655ae88f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629095858.655ae88f@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 09:58:58AM +1000, Stephen Rothwell wrote:
> Hi David,
> 
> On Thu, 28 Jun 2018 18:11:03 +0200 David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jun 27, 2018 at 08:59:36AM +1000, Stephen Rothwell wrote:
> > > After merging the btrfs-kdave tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > > 
> > > fs/btrfs/print-tree.c: In function 'print_extent_item':
> > > fs/btrfs/print-tree.c:56:3: error: implicit declaration of function 'btrfs_print_v0_err'; did you mean 'btrfs_print_tree'? [-Werror=implicit-function-declaration]
> > >    btrfs_print_v0_err(eb->fs_info);
> > >    ^~~~~~~~~~~~~~~~~~
> > >    btrfs_print_tree  
> > 
> > Should be fixed in today's branch.
> 
> Sorry, still broken.  I fetched your tree only about 5 minutes ago.

It was a build problem that I did not recognize in my setup
immediatelly, the warning appears only withtout CONFIG_BTRFS_ASSERT.
The branch has been updated, commit 1607c1cbdaa0b6b80b0d4a, sorry for
inconvenience.
