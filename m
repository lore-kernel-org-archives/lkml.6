Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75820835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED75820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJODFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:05:41 -0400
Received: from smtp-1.orcon.net.nz ([60.234.4.34]:51392 "EHLO
        smtp-1.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeJODFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 23:05:41 -0400
X-Greylist: delayed 2502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 23:05:40 EDT
Received: from [121.99.228.40] (port=5878 helo=tower)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <mcree@orcon.net.nz>)
        id 1gBlKr-0002Tr-Py; Mon, 15 Oct 2018 07:41:53 +1300
Date:   Mon, 15 Oct 2018 07:41:48 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     Bob Tracy <rct@gherkin.frus.com>
Cc:     Meelis Roos <mroos@linux.ee>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Relocation (type 4) overflow on alpha for big module
Message-ID: <20181014184148.m6jb5ohb5onu6c3k@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Bob Tracy <rct@gherkin.frus.com>, Meelis Roos <mroos@linux.ee>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5bc11e00-258d-a6ea-fe63-ddcfdb847071@linux.ee>
 <20181014173306.GA14639@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014173306.GA14639@gherkin.frus.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 12:33:06PM -0500, Bob Tracy wrote:
> On Sun, Oct 14, 2018 at 10:07:13AM +0300, Meelis Roos wrote:
> > I decided to try btrfs on one of my alphas and got a surprise - btrfs module does not load:
> 
> Confirmed on a PWS 433au running 4.19.0-rc6 with latest "sid" toolchain.

Known and long-standing problem in the Alpha kernel module loader.
Requires extra code implmented to support loading such large modules
which no one has done.  Workaround is to build the kernel with such
modules (e.g. radeon, btrfs) in-built.

Cheers
Michael.
