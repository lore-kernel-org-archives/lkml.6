Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31FC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9799E2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="B5YeboJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9799E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJFND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:03:26 -0400
Received: from imap.thunk.org ([74.207.234.97]:37674 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeJFND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yYOH+dNhbRCktPLecNlUgYA50I+ZrhCJfAXEkYAhHD0=; b=B5YeboJ6X+0qO7UzPQKoOZtlzD
        Et7Pm1fOPTiq/imR5y/lDlN/CeYiSUKEQQ+x7k71dH4cIlj0ea8ngb9FewkBx42DxKyjsMgFUnwTv
        maZbnWDGzgdp6/cBgYEfJUyCPA/0vT798kQFMI6VSu6PiAqoxY+RXFPKr6KTi69zP9v8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g8feU-0000El-VL; Sat, 06 Oct 2018 06:01:23 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EB8CA7A5240; Sat,  6 Oct 2018 02:01:21 -0400 (EDT)
Date:   Sat, 6 Oct 2018 02:01:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mario.Limonciello@dell.com
Cc:     mika.westerberg@linux.intel.com, whitequark@whitequark.org,
        heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org
Subject: A different PD controller firmware problem?
Message-ID: <20181006060121.GA4050@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com,
        whitequark@whitequark.org, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
 <3a666f66d6e342e2971b800caae7c889@whitequark.org>
 <3b76178ca0de4990a38362cfd4836fdc@ausx13mpc120.AMER.DELL.COM>
 <20180911093239.GW14465@lahna.fi.intel.com>
 <fd00612c1bb94f69820be2b1f1e171f9@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd00612c1bb94f69820be2b1f1e171f9@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:02:00PM +0000, Mario.Limonciello@dell.com wrote:
> > I tried 9370 and it detects the adapter correctly. IIRC I did the same
> > for 5530 and it worked as well.
> 
> Thanks for confirming that.  Hopefully the same change can be ported to PD controller
> firmware then on other models, I'll inquire.

Hey Mario,

Sorry for the thread hijack (I've changed the subject line to make it
clear it's a separate issue), but just this evening I just had a
very.... interesting problem with my Dell XPS 9370, and it appears to
be related to the PD controller.

Sortly after 12:30am US/Eastern, I got a low power warning on my
system, and the battery power had dropped below 10%.  Apparently the
laptop was not accepting any charge any more.  I tried doing a suspend
to ram, and then unsuspended it, and it still wasn't accepting any
charge, even though the adapter indicated it was plugged in and
supplying power.  I then did a power cycle, and still the laptop
didn't indicate it was charging with a USB C 45W power supply plugged
in.

I inserted a Satechi USB C voltage monitor in-line, and found that
while it was powered on, the laptop has pulling 0 mA at 5V.  If the
laptop was suspended, it would pull 3A at 5V.  Rebooting and power
cycling didn't change this syndrome.

What *did* fix it was powering down, and disconnecting the power
adapter for 30 seconds or so.  Then when I plugged it back in, the
laptop started accepting 20V at 2A.  I assume what happened is that
the PD controller had crashed, and it required a powerdown *and*
unplugging the power to force the EC to reset.

I have noticed other problems where a USB C to HDMI adapter doesn't
quite work right (the laptop refuses to talk to the display), and the
*only* way to fix things is to powerdown Linux and then remove the
power plug.  So this is not the first time that this particular
technique is needed to make my Dell XPS 9370 (with NVMe SSD, currently
running XPS 13 9370 System Firmware version 0.1.5.1) happy again.

What's the best place to report this sort of problem?  And is there
anything more I can do to debug these sorts of apparent PD Controller
/ EC bugs?

					- Ted
