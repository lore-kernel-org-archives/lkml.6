Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D20C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C02086A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511C02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeJOG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:56:56 -0400
Received: from gherkin.frus.com ([192.158.254.49]:59124 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeJOG44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:56:56 -0400
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 0A82B3D001; Sun, 14 Oct 2018 18:14:20 -0500 (CDT)
Date:   Sun, 14 Oct 2018 18:14:20 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     Michael Cree <mcree@orcon.net.nz>, Meelis Roos <mroos@linux.ee>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Relocation (type 4) overflow on alpha for big module
Message-ID: <20181014231420.GA17263@gherkin.frus.com>
References: <5bc11e00-258d-a6ea-fe63-ddcfdb847071@linux.ee>
 <20181014173306.GA14639@gherkin.frus.com>
 <20181014184148.m6jb5ohb5onu6c3k@tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014184148.m6jb5ohb5onu6c3k@tower>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:41:48AM +1300, Michael Cree wrote:
> On Sun, Oct 14, 2018 at 12:33:06PM -0500, Bob Tracy wrote:
> > On Sun, Oct 14, 2018 at 10:07:13AM +0300, Meelis Roos wrote:
> > > I decided to try btrfs on one of my alphas and got a surprise - btrfs module does not load:
> > 
> > Confirmed on a PWS 433au running 4.19.0-rc6 with latest "sid" toolchain.
> 
> Known and long-standing problem in the Alpha kernel module loader.
> Requires extra code implmented to support loading such large modules
> which no one has done.  Workaround is to build the kernel with such
> modules (e.g. radeon, btrfs) in-built.

ACK on the workaround.  Never noticed the problem with, per your
example, the radeon driver because I seldom build a driver as a
module for a piece of hardware (or filesystem type) that's present
at boot and won't be removed.

--Bob
