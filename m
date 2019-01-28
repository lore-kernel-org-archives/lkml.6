Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FF12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfA1QyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:54:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:60092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733287AbfA1QyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:54:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56700ADC2;
        Mon, 28 Jan 2019 16:54:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B84A4DA78C; Mon, 28 Jan 2019 17:53:42 +0100 (CET)
Date:   Mon, 28 Jan 2019 17:53:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20190128165342.GH2900@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <20190124095338.523fc3a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124095338.523fc3a3@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:53:38AM +1100, Stephen Rothwell wrote:
> Hi David,
> 
> After merging the btrfs-kdave tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> fs/btrfs/relocation.c: In function 'insert_dirty_subv':
> fs/btrfs/relocation.c:2138:6: warning: unused variable 'root_objectid' [-Wunused-variable]
>   u64 root_objectid = root->root_key.objectid;
>       ^~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   7b837199c581 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots()")
> 
> Presumably the ASSERT is compiled out in this configuration.

Agreed, thanks for the report. I'll drop the temporary variable.
