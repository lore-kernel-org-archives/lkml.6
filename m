Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AAC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C856214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fPfOaT8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C856214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeJJDCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:02:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41074 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbeJJDCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:02:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9CC0C8EE2EC;
        Tue,  9 Oct 2018 12:44:16 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rOMTCmc-RIFk; Tue,  9 Oct 2018 12:44:16 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 29BB48EE0E9;
        Tue,  9 Oct 2018 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539114256;
        bh=tobsf7QEDRh7aQ2eqPP85qlNZF0iP7Bspt1Gf6PhmYg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fPfOaT8duqN9mWNL62Yl4xkWGcz6S6K0odEN30hl5VDsDbrn9H34AOfDljadzNBTZ
         w8v+eJLmLBv7FVz9xcys/IUydDGkyeMMIveixvMiPCwCY5vidQ0TO2XBtqjei79fKm
         qyjkWgtI0Tfyt+jh5CW0L4pLoEzUYVw3Ek5mSPy0=
Message-ID: <1539114254.4876.7.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rainer Fiebig <jrf@mailbox.org>
Date:   Tue, 09 Oct 2018 12:44:14 -0700
In-Reply-To: <1877914.JXSoZ9jg4d@avalon>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1718828.OxLgMoHbrt@siriux> <20181009185622.GA20960@localhost>
         <1877914.JXSoZ9jg4d@avalon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 22:38 +0300, Laurent Pinchart wrote:
> Hi Josh,
> 
> On Tuesday, 9 October 2018 21:56:23 EEST Josh Triplett wrote:
> > On Tue, Oct 09, 2018 at 08:29:24PM +0200, Rainer Fiebig wrote:
> > > Am Montag, 8. Oktober 2018, 08:20:44 schrieb Josh Triplett:
> > > > On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley
> > > > wrote:
> > > > > The current code of conduct has an ambiguity in the it
> > > > > considers publishing private information such as email
> > > > > addresses unacceptable behaviour. Since the Linux kernel
> > > > > collects and publishes email addresses as part of the patch
> > > > > process, add an exception clause for email addresses
> > > > > ordinarily collected by the project to correct this
> > > > > ambiguity.
> > > > 
> > > > Upstream has now adopted a FAQ, which addresses this and many
> > > > other questions. See https://www.contributor-covenant.org/faq .
> > > > 
> > > > Might I suggest adding that link to the bottom of the document,
> > > > instead? (And then, optionally, submitting entries for that
> > > > FAQ.)
> > > 
> > > The Code of Conflict has 28 lines, including the heading.
> > > The Code of Conduct has 81 lines, including the heading. And it
> > > needs a FAQ. Hm.
> > 
> > Yes, it turns out to be a more complicated problem than it was
> > previously oversimplified to. People don't automatically share a
> > common understanding.
> 
> I see an elephant in the room in the fact that we have carefully
> avoided  discussing whether people share a common goal here :-/

We don't need to share a common goal; we just need to find the
document useful on its merits.  That's why we're a mostly GPLv2
project without signing up to most of the FSF philosophy.  However,
that's also why we would keep our own interpretations, understandings
and clarifications in house, as it were.

James

