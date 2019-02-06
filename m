Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72079C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B5218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDWATK7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBFVL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:11:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AS6/kJI8BSh2uPpf+3SySKPubLSB35qy07ItEaQIhOc=; b=qDWATK7tcku6Uzlt5u18C+UuB
        mrTFnrlEFBCVWA8NeEmUfXobMWA3NYxMJyy1oLJwmLQpNgIkVamIX7IHwfi3BGdZa8JbkpTwcVuRQ
        5o9LK7Y4q/j1UZXupP740LWYS9UFi8gocfEoGga57lWWjOSuO36blZmPPXzR5m0yqs6VxF7o86Dz7
        7BM69Js2mniDSynQL0G09nF7JI1DtOF99//BwBUvvEFt8vgfwur1RV9jw70E6w1XaKOX8RlCP1sph
        vLo3oIGMstQFTs7NdVPSIC8M3rWcSmfcDMx3AFqi++okp7IrX2EFCcKzWQTbYy5wcHwaQ/7SYp867
        EdLE2f8ZQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grUTc-0002MQ-JD; Wed, 06 Feb 2019 21:11:24 +0000
Subject: Re: linux-next: Tree for Feb 6 (drivers/edac/skx* and i10nm)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>
References: <20190206170000.286b1f53@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f095f3e-ace0-aadb-ead1-01908da5c08c@infradead.org>
Date:   Wed, 6 Feb 2019 13:11:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190206170000.286b1f53@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 10:00 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190205:
> 
> The mips tree gained conflicts against the mips-fixes tree.
> 
> The opp tree gained a conflict against the pm tree.
> 
> The drm-intel tree gained a conflict against the drm tree.
> 
> The akpm-current tree gained a conflict against the powerpc-fixes tree.
> 
> Non-merge commits (relative to Linus' tree): 5801
>  6493 files changed, 242140 insertions(+), 152493 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 296 trees (counting Linus' and 69 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

on x86_64:

ld: drivers/edac/skx_common.o: in function `skx_mce_check_error':
skx_common.c:(.text+0x982): undefined reference to `adxl_decode'
ld: drivers/edac/skx_common.o: in function `skx_adxl_get':
skx_common.c:(.init.text+0x11): undefined reference to `adxl_get_component_names'


CONFIG_EDAC_I10NM=y
but CONFIG_EDAC_SKX is not set.
since # CONFIG_ACPI is not set

Should EDAC_I10NM depend on ACPI also?


-- 
~Randy
