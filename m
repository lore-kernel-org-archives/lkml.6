Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-83959-1525854238-2-6782756740081792037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525854238; b=Jp55idctdbsP1iUPRKyjEK4XGSkmY0JZPLjpBsAZ5jHOJPTSO4
    1VHYg5Kgr0Ncr9BaYX3NCYATfxUAv8WWXByksBBdAKQNw+LKaOwSKwCEuxRc2LuQ
    0FwcPwzrdfJdQ/Ih7H+JleuPbpwFwtMjU4ayM5mfjNSE76Ol9niPHI2StZpuuDq8
    8Xx7a2oxebL6ZzojGjrPalII/DLOvWmXD7xcYrWQvrdMJxBKTa4YikSjAfAEdLHx
    aaVVdtShUSodWnSf3XMa3CmmsjC5MW3KQCrcMKNIvWhXLo/M+g4hIxWib608TzEW
    1Ziv49OUbosuS3O3jFbHdxgAMfdGVmI+WGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525854238; bh=xW+NAp5MnUZbUwwcCKDINsqGctEuBs
    VVt5dyj/9uIWc=; b=enmxc3LmW5LOFSjaEOW9wtUwbEhlGvoYIgYb3uOR+IK2rN
    H2jyGtdB3HUzsOvE9aRlijTBMjJzYyEOyK+VHsQ2cDoIidIbcsFHoi1AgmADCQGq
    zJqidwI5qKlqixXhJbqIzhA04aKt78bTt+NTaLZW1EJTWIFprr8Sch9qF7wFn/RS
    b4i/ItduCjLaowoZfpcCWQ0h/CoI27r3kulEVT/RIvdzemw3FDXCJp4w1bw43a2Y
    dN/TCKN4XXYHMSdKmomngZ+P8OxdFYdFsTBzgaxuasQpmUeG5AapUn+ZwFdSDCJE
    MrwWszZfw+gddaqC55l1qm04OyWAzjFsy1ku12cw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNMxUuI92xq+4betDHSvGqE4xKXdk58eHVp8cNYrbKI7XzPBE6GYyPEWiU5/psxvPd3rUqIcbFEhj25l5Ai9Q1kJ+R0EvI6fOqR8WeoXty90fE9l1F8P
    LO7mMY3e2hKBm5D5y9tjBBbWrrvUl+8NaebyJVuUmS/SyWfylT2uYk9VWansC4Aedl/9SMrR3TE88b4vDPqaxk3T8XOGPh5c7P5qzqIycU2r5+Jdr7ZR75Ak
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=92GmJv159eMOvW9L4CAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeEIIX4 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 04:23:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:18617 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933811AbeEIIXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 May 2018 04:23:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="44418951"
Date: Wed, 9 May 2018 16:13:42 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com,
        arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/5] regulator: add dummy function
 of_find_regulator_by_node
Message-ID: <20180509081341.ahx7xuqs366gmqaf@intel.com>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
 <1525566016-30172-3-git-send-email-changbin.du@intel.com>
 <20180509082114.GQ13402@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509082114.GQ13402@sirena.org.uk>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 05:21:14PM +0900, Mark Brown wrote:
> On Sun, May 06, 2018 at 08:20:13AM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > If device tree is not enabled, of_find_regulator_by_node() should have
> > a dummy function since the function call is still there.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Hmm, I saw your merging notification too late. Let me refresh the series. Sorry
for confusing.

-- 
Thanks,
Changbin Du
