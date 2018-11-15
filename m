Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7CFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56A52087B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="tuz/77yg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y5UIukD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56A52087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeKPKHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:07:02 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37481 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeKPKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:07:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EC6622BCB;
        Thu, 15 Nov 2018 18:56:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Nov 2018 18:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=iGxbPXZiAeIc6wM5MgXcNQU3hrX
        ZX8JYakFfKn0Lpf8=; b=tuz/77yg3bBuBppczw9FTYGViUDcrM+eYWqvODL1UeI
        SBOLJ/DyDjzW5Pw8I6fzZkJwhTEYaTxrKdAlJnnMdJZIqf3Ak43eSjgJ5KRJF+Qm
        hkk5qEZ50D3NxFZFLwxtbfoeYwE92aCueDqgu7N+uFApGcYES75BxjtW3bD5pFMn
        ANAVbCkpwT2qXk4K2JLNipKNjiV/XvUVda1VO1NxrbWZBdWPoHQKgwKCDzZupKBI
        BTyGIwmDihL2GmQT7NwwZFtxW8Yr5+53TwmyUUSIHQno3w6xxE5cm1nCfW9sNnfs
        ZL9n4OlkS+6OYmt4s3EDorFFBGp/DZCUYbMmATC5CFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iGxbPX
        ZiAeIc6wM5MgXcNQU3hrXZX8JYakFfKn0Lpf8=; b=y5UIukD77PXXIMt7ZSUteC
        Jfj0Me04tx1Xn6P64KUHoCND0HEvp4F+X+pDgp94Mdx6XVERXyk6IQmcQQZqPmVe
        dI4IoDtEALOJ7bE+ZGfHVhIpO+mmNK7v9i123FfqmXgk7gtKguAQ8XOhCOx9cgP/
        HiQUpVSpxYYD5qQflbic5b1Is+a3WM6lZsk2Up/YbVxcl6RlzSd+P5IXnCAqyFWt
        C9YhH6gDpAJcr2S90VstnXaDxVlWxZCSe0cWLie3p8p1zyNFl0jXuZkXScSUb8eE
        9PY72oulpskC1xucrCf9k8hBuYWdBQW85jFGVO0JHFki8qU8Ra0exONzeZQJPHeg
        ==
X-ME-Sender: <xms:ygfuW7LhyHLxPlz1AS-TBNIA1tO19PYDdQ50cmdfSRM_Cumr1kbz5w>
X-ME-Proxy: <xmx:ygfuW60hsHZhm00moyFtnAFC1JqlNtAm_0AjIOQf8A5vlfqEWDXoMw>
    <xmx:ygfuW-VFlXRX9Ej7eu3PN49O9C-3uXLaS8VoCKMT1byZUXTusmHNjw>
    <xmx:ygfuW4M7FhPXnMFonWwcAZ7sboFr6dSm1tW2_4-EdZ_ybDqlAlo23A>
    <xmx:ygfuW5ya6195yoimq8jU169y__I4E8X2gvVSkYETtrlFC6EA6jWJCA>
    <xmx:ygfuW9jIMCYgar8ivrMQWZawVbPLMpBKaeTkvB3SABT95Z2JT7wAAA>
    <xmx:ywfuW5HD9hdrK_GeC7BzhdTHHoHynYbn7VMLk5XpR5Tp6wv1B6HsUA>
Received: from localhost (unknown [64.114.255.97])
        by mail.messagingengine.com (Postfix) with ESMTPA id 025361037D;
        Thu, 15 Nov 2018 18:56:57 -0500 (EST)
Date:   Fri, 16 Nov 2018 10:56:51 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        linux-doc@vger.kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181115235651.GD5782@caerus>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87pnv6ivl7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnv6ivl7.fsf@intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:38:44AM +0200, Jani Nikula wrote:
> 
> Cc: linux-doc
> 
> On Wed, 14 Nov 2018, Dan Williams <dan.j.williams@intel.com> wrote:
> > As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> > Profile is proposed as a way to reduce friction between committers and
> > maintainers and perhaps encourage conversations amongst maintainers
> > about best practice policies.
> >
> > The profile contains short answers to some of the common policy
> > questions a contributor might have, or that a maintainer might consider
> > formalizing. The current list of maintenance policies is:
> >
> > Overview: General introduction to maintaining the subsystem
> > Core: List of source files considered core
> > Leaf: List of source files that consume core functionality
> > Patches or Pull requests: Simple statement of expected submission format
> > Last -rc for new feature submissions: Expected lead time for submissions
> > Last -rc to merge features: Deadline for merge decisions
> > Non-author Ack / Review Tags Required: Patch review economics
> > Test Suite: Pass this suite before requesting inclusion
> > Resubmit Cadence: When to ping the maintainer
> > Trusted Reviewers: Help for triaging patches
> > Time Zone / Office Hours: When might a maintainer be available
> > Checkpatch / Style Cleanups: Policy on pure cleanup patches
> > Off-list review: Request for review gates
> > TODO: Potential development tasks up for grabs, or active focus areas
> >
> > The goal of the Subsystem Profile is to set expectations for
> > contributors and interim or replacement maintainers for a subsystem.
> 
> First of all, I welcome documentation efforts like this.
> 
> The cover letter mainly focuses on the maintainer aspect, and the
> documentation is added to the maintainer handbook. However, here you set
> the goal as setting expectations for contributors. The example nvdimm
> profile in patch 3/3 addresses the reader as a new maintainer, yet goes
> on to set expectations also for contributors, not just the maintainer.
> 
> I do think the documentation for contributors and maintainers/committers
> should be kept separate. Most contributors will never care about the
> documentation for the latter. We have Documentation/process for
> contributors, and I think the audience of Documentation/maintainer
> should be strictly maintainers.
> 
> In summary, I do think we need all of the documentation you propose, and
> I appreciate you taking this on, but I think this should be split by
> audience.

I got confused by this at first also Jani.  This document is a template
for use by maintainers.  The files created from the template (by a
subsystem maintainer) are for contributors.  So I believe this document
is in the correct place.

Hope this helps to clarify.

     Tobin
