Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220729-1521443979-2-16111378354536738357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521443978; b=w5UPUXDcVt4HG8y7N9m98MxwARkJ5SQRKC6SnkdZufqxxa3
    9dGw1pwTKoNa9/oeHiejkGFTPL0Az8Pc9iCFljF/e3f/idFsanKqbRneT7NlRodD
    VxnHuLfr64oCk8RwZRbdSMyHM9IpVD6JRLykZFMiQdGPjGIYLAAmu4WsCrWQqfAh
    WRsK8xSIjXMn9+zd/9v9Bm2JOL7BddKXRdABI7cmeSAp78tE+Z98g0sYzZNqzUHY
    5pXfscQ35ppyo5q+Obz6Oi/rvso9U3tFo6B9WVwAypn1dsmacR6hBNeuuiRgc2Vv
    8WinGoPLKGBG/ZiI062R08635TcchFXIOVRy9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521443978; bh=nUNQz5R1eyKUYPHzZip/FacFJ2
    E0JdOuHgPBRCXHtOE=; b=mLxNmRq4p2DYi4e+qLZ8rHYDFiHpPqVOtNyOWAiLa5
    h96HOQO2irNlWGnagOE5Tv8zcW5FVAdXvOhuuwtIYRx8XygXphE7vSP/PkPVylvT
    4WVPRf8r+koXz2Xm24wcz+S0oV/gxY/7FnNlMBKvgFbqBnlXNIuc2prDjeAk0yNN
    7Gmlu8y+SzLzGhAU5bkmw2XDGyKJg2QPKNqu5SZVmk4yNWKIBpeByPW6vsBOy+dS
    wCAuVbVfPwkXGvfAYzJf4QI2PaIABE+ZN70hOoWNxnVuAaIBvbgcORrETU0n/+l5
    Rnn9EDAD1TZQ+JF38/X9xIk+zYcCrSC2RNBhTbW55MDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepgghinhhougcumfhouhhluceovhhinhhougdrkhhouhhlsehinhhtvghlrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghltghirdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudefgedrudefgedrudefiedrvdegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgeeikeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepgghinhhougcumfhouhhluceovhhinhhougdrkhhouhhlsehinhhtvghlrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghltghirdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudefgedrudefgedrudefiedrvdegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgeeikeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCSHTh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:19:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:21863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932190AbeCSHTg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 03:19:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="26445305"
Date: Mon, 19 Mar 2018 12:53:41 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Message-ID: <20180319072341.GL15443@localhost>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps>
 <20180317143253.GI15443@localhost>
 <20180318102417.GA30164@kroah.com>
 <20180318104451.GA19721@kroah.com>
 <20180319030840.GJ15443@localhost>
 <e83c7924-7e52-eeab-adf2-ba2af159cfac@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83c7924-7e52-eeab-adf2-ba2af159cfac@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 09:14:00AM +0200, Peter Ujfalusi wrote:
> 
> 
> On 2018-03-19 05:08, Vinod Koul wrote:
> > On Sun, Mar 18, 2018 at 11:44:51AM +0100, Greg Kroah-Hartman wrote:
> >> On Sun, Mar 18, 2018 at 11:24:17AM +0100, Greg Kroah-Hartman wrote:
> >>>>> This patch is causing a build error on arm and arm64 per i.e.
> >>>>> https://kernelci.org/build/id/5aac017e59b5141cb1b3a4d5/
> >>>>>
> >>>>> Builds are also failing for arm/arm64 on 4.15 and this patch seems to be a
> >>>>> problem there as well, but I have not verified it yet.
> >>>>
> >>>> I think we are missing commit 1c7f072d94e8. Pls cherrypick that as well
> >>>>
> >>>> commit 1c7f072d94e8b697fd9b70cdb268622a18faf522
> >>>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>> Date:   Tue Nov 14 16:32:04 2017 +0200
> >>>>
> >>>>     dmaengine: virt-dma: Support for race free transfer termination
> >>>>
> >>>> This adds vchan_terminate_vdesc API..
> >>>
> >>> Thanks, that helped.  I've now added this and send out a -rc2 for this
> >>> kernel.
> >>
> >> Oops, no, that broke the build for all arches :(
> >>
> >> Let me just go drop this patch, and the two dmaengine patches that
> >> relied on this one.  If you think these should be applied to the stable
> >> trees, can you send me a series of working patches?
> > 
> > Okay let me grab your tree and cherry-pick all that is required and send
> > you. Stay tuned...
> 
> I think these are the patches that need to be picked for this to work/compile:
> 
> 2c6929d2ea70 dmaengine: s3c24xx-dma: Use vchan_terminate_vdesc() instead of desc_free
> 3ee7e42f3c9b dmaengine: k3dma: Use vchan_terminate_vdesc() instead of desc_free
> 397c59bce6cb dmaengine: img-mdc-dma: Use vchan_terminate_vdesc() instead of desc_free
> 47d71bc75d07 dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free
> f0dd52c85d61 dmaengine: dma-jz4780: Use vchan_terminate_vdesc() instead of desc_free
> de92436ac40f dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
> 174334bcd9f8 dmaengine: edma: Use vchan_terminate_vdesc() instead of desc_free
> b1faf0f564ff dmaengine: omap-dma: Use vchan_terminate_vdesc() instead of desc_free
> 1c7f072d94e8 dmaengine: virt-dma: Support for race free transfer termination
> 6af149d2b142 dmaengine: virt-dma: Add helper to free/reuse a descriptor
> 
> Most probably we missed the 6af149d2b142 and that caused the build failures.

Yeah that looks to be the case, I have pushed out topic/dmaengine_stable
after cherry-picking the old topic branch for these. My build tests passed,
waiting for Fenguuang's bit to bless it and send :)

-- 
~Vinod
