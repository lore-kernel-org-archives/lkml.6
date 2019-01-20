Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6767AC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAAB20880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfATQES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:04:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:58813 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfATQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:04:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 08:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,499,1539673200"; 
   d="scan'208";a="127235859"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.134])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2019 08:04:15 -0800
Date:   Sun, 20 Jan 2019 18:04:13 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190120160413.GB30478@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547849358.2794.90.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:09:18PM -0800, James Bottomley wrote:
> On Fri, 2019-01-18 at 16:25 +0200, Jarkko Sakkinen wrote:
> > I get this on a Geminilake NUC after rebasing my maintainer trees:
> > 
> > tpm tpm0: A TPM error (-1) occurred attempting the self test
> > 
> > I checked the latest commit ID from drivers/char/tpm to make sure
> > that I did not put anything broken to my last PR [1]. It works
> > without issues.
> > 
> > In addition [2] gives me an empty diff.
> > 
> > Something outside of the TPM driver must have happened that breaks
> > the driver. Any ideas?
> > 
> > [1] commit 9488585b21bef0df1217e510c7134905d1d376a7
> > [2] git diff 9488585b21bef0df1217e510c7134905d1d376a7 master
> > drivers/char/tpm/
> 
> I'm afraid you're going to have to bisect to find the offending in-
> kernel commit, which is going to be painful since it seems to depend on
> physical hardware.  My first instinct is that we're getting a zero
> length read somewhere, but I still can't see anything in the merge
> window that would cause that behaviour.

Yeah, I've started to bisect it (still 9 rounds to go).

/Jarkko
