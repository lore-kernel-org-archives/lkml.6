Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F04C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE820685
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=laptop.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJaIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:50:16 -0400
Received: from civicrm.laptop.org ([18.85.44.157]:53839 "EHLO swan.laptop.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbeJaIuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:50:15 -0400
Received: from esk.lan (unknown [1.144.143.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by swan.laptop.org (Postfix) with ESMTPSA id 81C694C0479;
        Tue, 30 Oct 2018 19:54:36 -0400 (EDT)
Received: from james by esk.lan with local (Exim 4.86_2)
        (envelope-from <quozl@laptop.org>)
        id 1gHdqA-0001n7-IC; Wed, 31 Oct 2018 10:54:30 +1100
Date:   Wed, 31 Oct 2018 10:54:30 +1100
From:   James Cameron <quozl@laptop.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181030235430.GF30863@us.netrek.org>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030102610.GC21529@amd>
Organization: Netrek Vanilla Server Dictator
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Pavel,

On Tue, Oct 30, 2018 at 11:26:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75
> > > 
> > > I didn't test it yet -- will do when I get home in the evening. But
> > > chances are it's good enough and I guess you'd be able to get it
> > > working even if I messed up some details.
> 
> Instruction say make, but you really need to do make zImage and make
> mmp2-olpc-xo-1-75.dtb .
> 
> Instructions say "make -j", which is nice way to crash a machine. I
> suggest "make -j 8" :-).
> 
> Ok, I think I followed the instructions. I am using empty root
> filesystem, just with /boot -- want to see kernel messages first
> before I mess with the userland.
> 
> But I don't get kernel messages during boot:
> 
> OLPC 1B1, 512 MiB memory...
> OpenFirmware Q4C02 EC Frimware 0.3.02
> 
> Type any key to interrupt...
> (but keys do not interrupt anything, ouch).
> Warning... partition type is 0xb...
> Boot device: /usb/disk:\boot\olpc.fth Arguments:
> Boot device ....
> Warning... partition type is 0xb...

That firmware has problems with USB drives.  Please upgrade to Q4D38.
Quickest tested method is http://wiki.laptop.org/go/Upgrading_firmware

I'm firmware releaser and signer.

> And that's it, cursor and no kernel messages.
> 
> Any ideas?
> 
> Could I get prepared binary zImage for testing?
> 
> Thanks,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
James Cameron
http://quozl.netrek.org/
