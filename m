Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F40C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC15A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC15A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeLEI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:56:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:35085 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEI4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:56:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 00:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="115783133"
Received: from raj-desk2.iind.intel.com ([10.223.107.30])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2018 00:56:24 -0800
Date:   Wed, 5 Dec 2018 14:15:41 +0530
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     tiny.windzz@gmail.com,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181205084540.GA20250@raj-desk2.iind.intel.com>
References: <20181201155229.8532-1-tiny.windzz@gmail.com>
 <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
 <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
 <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
 <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com>
 <CAEExFWtxJrGnoCq1_Nx3uMCW009Qe3LksG4e10s6nW3=p=UWiw@mail.gmail.com>
 <CAHp75Vd1Nzd+CDArk+26vwJvq=rULXxOHfq5rQEQjByJtWjH9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd1Nzd+CDArk+26vwJvq=rULXxOHfq5rQEQjByJtWjH9w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:42:21AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 5, 2018 at 3:47 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> > On Wed, Dec 5, 2018 at 1:39 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Dec 4, 2018 at 6:58 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> 
> > > > $ git remote set-branches --add origin for-next
> > > > $ git br -vv
> > > > * for-next 651022382c7f [origin/for-next] Linux 4.20-rc1
> > >
> > > Here is the problem,
> > >
> > > For a few days at least we have
> > > 4ecd94b8e13b (HEAD -> for-next) platform/x86: dell-laptop: Mark
> > > expected switch fall-throughs
> 
> > Where can I find the correct git repository？
> 
> I think even old address still exists:
> http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git
> 
> > I haven't found the correct one for a long time,
> > which include the commit(4ecd94b8e13b ) you said.
> 
> And newest one is available via
> http://git.infradead.org/linux-platform-drivers-x86.git
> 
> http://git.infradead.org/linux-platform-drivers-x86.git/commit/4ecd94b8e13b014a28be48c94f751fb62f7c749e
> 
> Though it's already advanced to contain new portion of accepted
> patches (doesn't matter for you, because they don't touch file in
> question).

Hi Andy, i was thinking of having it split into two patches as it touches
two unrelated files. What is your opinion?

Functionality wise, it looks good to me.

> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
Best Regards,
Rajneesh
