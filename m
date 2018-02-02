Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2029342-1517563067-2-330279515777068155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517563067; b=XUeByixl8Ur/B5UvD2xI8dUZoNAWMvK9tCq0ugNtiMODASM
    PAGTrkwMqJOfwC/XutEPS7+N2915CBepSmshEz5jBHCJbCYLUuaz07sVgNmgS/gR
    eHQ5Ss2OU0fULSiQXcBI01Y8yz4Zlcs8sPC6wuCkRKRH4UyjWbnz9c7JHVH2of82
    yKOK/OrUfIefjDvD63K/3rsV/sZ1xlWXIyjN4gko4SPNwoZI+nREb+mbqsJGc9Kh
    hkIXcAztiDQMorncjKyaaAOd1aAhJmAhTQpJPNSDAuGHMnb3eV/Jm0bwDoHFQfyN
    Z6X+ZXG5GWOxkd7dEgGrQ+uu2AP/L4pCiyfnZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517563067; bh=C5rKMmnMFCTeYtYynqJTEjvhpO
    5pf5lm1wZ/q/9LW/Q=; b=jbSmP4FhBN5ZMrESaTzEzCLwmsDJaRhY3jaqdIj4mh
    X4vMYeIfcFDwCb+V5JCqT/uEYaRHYHRS2OocCl0KaMW2PT3L8C1L0L4Ec3x8FnU/
    Bm573yWD8nkoNkB+qLSegnDO5GYdPaeVG2Qtl6WbnMPliZrWZ6yzMLV8UqY+uI6C
    H/pztNHjAMpkLVuCVCpDB9vBMo9Lj3hpo2ydlK5g8BD/IX//ojOQKChXRtZPVTGv
    28r5SqeTULFFKdb/nukvgdyCJMNCzS2vfZGOnXzSfvOW04o3VUdBvfVrOYmJp9y5
    sdY6unvoMyHLLYgjRbwW14sxZJUZhk5ecZ3wISpOKr6g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBBJRq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 04:17:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:56425 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeBBJRo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Feb 2018 04:17:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="14485889"
Date: Fri, 2 Feb 2018 17:08:22 +0800
From: Wu Hao <hao.wu@intel.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 19/21] fpga: dfl: afu: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180202090822.GA17015@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-20-git-send-email-hao.wu@intel.com>
 <CANk1AXSfUfVbtbuREwG5Ck8TNZrqBg1fO5AuDDdFk-x=UjRTiw@mail.gmail.com>
 <20180201051625.GD10273@hao-dev>
 <20180201151309.q3jjx42y6ldcrhc6@insfl13.etec.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201151309.q3jjx42y6ldcrhc6@insfl13.etec.uni-karlsruhe.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 04:13:09PM +0100, Moritz Fischer wrote:
> On Thu, Feb 01, 2018 at 01:16:25PM +0800, Wu Hao wrote:
> > On Wed, Jan 31, 2018 at 08:52:36AM -0600, Alan Tull wrote:
> > > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> > > 
> > > Hi Hao,
> > > 
> > > I'm adding my "Acked-by' below.  When you post v4, please add it so
> > > that we can keep track of what got acked.
> > 
> > Sure, thanks a lot for the code review. :)
> > 
> > Hao
> > 
> > > 
> > > Thanks,
> > > Alan
> > > 
> > > > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
> > > > need to be supported by all feature devices drivers including FME and AFU.
> > > > This patch implements above 2 ioctls in FPGA Accelerated Function Unit
> > > > (AFU) driver.
> > > >
> > > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Looks good,

Thanks a lot for the code review. :)

Hao

> 
> Moritz


