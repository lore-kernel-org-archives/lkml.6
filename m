Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2170BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79EC20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="m55q/M6P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+VxqVYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79EC20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeGIHGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:06:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58091 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750974AbeGIHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:06:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 60521218FD;
        Mon,  9 Jul 2018 03:06:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Jul 2018 03:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+Rz9aPbW+zwFibWjkOAPkuT/1Nw8hBIVvlJnfok2fOY=; b=m55q/M6P
        a7huOToa8/13E8y9Jbo4U1adtic3VxDIcHCQ7QUCley6O02YWr2BBTZTAZvCX0kn
        q7nA8oqDOFBoiTSu2Y5ewangL+svpvVdmPYuqTIwr0kFtNp2/VrccFoh/1T+r5bG
        BfJmH5dbA6BAbTXMKLJbA8bGDUYyBRvEXfM78aPNFR66q5iMMe35L7J/3+Ontv2U
        HPbRJtFVYMoJsz/y9vBejO2BpWId1hqLNA9SJntlQ5IMPdnmn+2SKBPOd28OOcY0
        U2T+FIouaD5IrfW3oWb8INFiN1fcHvlOmu/9Mf/I7wbnAjoBSi3EffH/9sU/Xb08
        aJBS7PR6oVUKGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=+Rz9aPbW+zwFibWjkOAPkuT/1Nw8h
        BIVvlJnfok2fOY=; b=c+VxqVYouTcqCz3Y10lSymmJHvEShqJBbW05U0/gS3mvb
        uVjHTF4G7zeoYAd105pKJ11rbjBMnf+11/9TUytA7gbl7U/3Ob2M8L6NMlqKmxFh
        A0RWrsfVriAvbK5JJQPHCVl2tA6zgQE02Ay0h98cyFBWIEOFxvDsiZbsPGNZOzeY
        zo4uoEzc8twNcTE9ZhugcXeA3dZxjrAU3qGfPxGlmU0emI8hVdsgNmTHE+zMju3C
        w8tnyz5G5nT62JwIZzaN9OwLfHsRMXICtBsbnJCg/k3pmypIGV6VV8by7PQ1x/d2
        LIP2zEGr4nB13tY6Yv6EnT6nrSBhyc+U2Ijb8JBqg==
X-ME-Proxy: <xmx:fglDW4ARdbHJDjn-Ucyjt-AnHrThvk3Kyl_KnPKhkTeMAbQMK74AtA>
    <xmx:fglDW8GwPxGNW1zqv5rcVUUAkcm-QJT7ClsMwxmzT9QPNH0U5jbFsQ>
    <xmx:fglDW60-Yif6xfbANG4h-D7PakBrOM8MccERBIKvdQIdi8upSts0Zg>
    <xmx:fglDW1PvngEMyyNcQ3bhUc79PehPUpHlxcqIfTuSbL10GFGMzNV4Hg>
    <xmx:fglDWyaGzd_6t7bgm1zhr7KGMITNyi2HJ7iNeoC8jUxShDtzjBrBpQ>
    <xmx:fwlDW5U2sE7wMaDgA3_sGEuCNDVbNOJEz7z3uHWt6q6ka0TIwuQQ9w>
X-ME-Sender: <xms:fglDW-CXI-byeCqlSrkP76Y66qnkTcRY80FUIv7yUGItqeXYB5jqCw>
Received: from localhost (unknown [46.44.180.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF4B2102B3;
        Mon,  9 Jul 2018 03:06:37 -0400 (EDT)
Date:   Mon, 9 Jul 2018 09:06:35 +0200
From:   "greg@kroah.com" <greg@kroah.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Message-ID: <20180709070635.GB13285@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <20180709054842.GB7618@kroah.com>
 <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:46:50AM +0000, Alexey Brodkin wrote:
> Hi Greg,
> 
> On Mon, 2018-07-09 at 07:48 +0200, Greg KH wrote:
> > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > might be aligned by either word (32-bits) or double word (64-bits).
> > > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > > 
> > > At least for 32-bit ARC cores ABI requires "long long" types
> > > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > > 12 bytes. Which is still OK as long as we use 32-bit data only.
> > > 
> > > But once we want to use native atomic64_t type (i.e. when we use special
> > > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > > misaligned access exception.
> > 
> > So is this something you hit today?  If not, why is this needed for
> > stable kernels?
> 
> Indeed we hit that problem recently when Etnaviv driver was switched to
> DRM GPU scheduler, see
> commit e93b6deeb45a ("drm/etnaviv: hook up DRM GPU scheduler").
> The most important part of DRM GPU scheduler is "job_id_count" member of
> "drm_gpu_scheduler" structure of type "atomic64_t". This structure is put
> in a buffer allocated by devm_kzalloc() and if "job_id_count" is not 64-bit
> aligned atomic instruction fails with an exception.
> 
> As for stable requirements - mentioned commit was a part of 4.17 kernel
> which broke GPU driver for one of our HSDK board so I guess back-porting
> to 4.17 is a no-brainer.

Ok, so 4.17 is as far back as you need?  Please try to be specific when
asking for stable backports.

> > > That's because even on CPUs capable of non-aligned data access LL/SC
> > > instructions require strict alignment.
> > 
> > Are you going to hit this code with all types of structures?
> 
> If there're other cases which lead to 4-byte aligned "atomic64_t" variables
> there will be a problem as well but it's quite hard to predict those cases.
> That said if we manage to reproduce more similar issues there will be more
> patches with fixes :)
> 
> > What happens when you do have an unaligned access?
> 
> Atomic instructions are a bit special as compared to normal loads and stores.
> Even if normal loads and stores may deal with unaligned data atomic instructions
> still require data to be aligned because it's hard to manage atomic value that
> spans through multiple cache lines or even MMU pages. And hardware just
> raises an alignment fault exception.
> 
> And that's not something special for ARC, I guess all CPUs are the same in
> that regard, see here's an extract from ARM(r) Architecture Reference
> Manual ARMv7-A and ARMv7-R edition: https://lkml.org/lkml/2017/12/5/440
> From "Table A3-1 Alignment requirements of load/store instructions"
> it's seen that LDREXD, STREXD instructions will cause alignment fault
> even if SCTLR.A=0 (strict alignment fault checking disabled) for non
> double-word-aligned data.

Thanks for the better explaination, that helps out a lot.  Can you redo
the patch with all of that information so that others do not have the
same questions as I did?

thanks,

greg k-h
