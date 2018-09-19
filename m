Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D77ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8ED2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="PDf9MyIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8ED2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeITBlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:41:36 -0400
Received: from one.firstfloor.org ([193.170.194.197]:35186 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeITBlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:41:35 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 6DFBD86F3B; Wed, 19 Sep 2018 22:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1537387325;
        bh=V2vrgv3nmPEi2eHzuL1wwqsmznEX36kJVYJcWGs5Saw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDf9MyIjIOjYE/1w3aetDxwdXcQ7mOm2wAkIw/ZHBovWtDJbOIoRc03mCHdSaOSn0
         lrPPf4wh42kcUAdK/OAgpmePmkQ/PagdxOyPKIb504gmSf1FrYdak700lRWPYqOSX5
         M3xpg9nRzlK52kDJhu1lFIxZlQGCTnHTS2FLYIPU=
Date:   Wed, 19 Sep 2018 13:02:04 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20180919200202.lzopwvlgdnsrokyh@two.firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-4-andi@firstfloor.org>
 <20180919181247.GC31812@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919181247.GC31812@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:12:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 29, 2018 at 10:18:27AM -0700, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Add a --insn-trace short hand option for decoding and disassembling
> > instruction streams for intel_pt. This automatically pipes the
> > output into the xed disassembler to generate disassembled instructions.
> > This just makes this use model much nicer to use
> 
> Would be nice to provide at least an URL to where to find xed, I tried
> this:
> 
> [root@seventh ~]# dnf search xed
> Last metadata expiration check: 0:25:39 ago on Wed 19 Sep 2018 02:42:36 PM -03.
> =================================================================================== Name Exactly Matched: xed ====================================================================================
> xed.i686 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)
> xed.x86_64 : X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)
> 
> https://github.com/intelxed
> 
> So I have to install a build system and then install it to then build
> intelxed?

Yes that's right.

I think some distros have it already packaged.


git clone https://github.com/intelxed/mbuild.git mbuild
git clone https://github.com/intelxed/xed
cd xed
mkdir obj
cd obj
../mfile.py
sudo ../mfile.py --prefix=/usr/local install

-Andi
