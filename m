Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA409C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60920892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="QWTRCFN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKKGAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:00:11 -0500
Received: from imap.thunk.org ([74.207.234.97]:36876 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725761AbeKKGAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jXVUfJak31xbkKS8k+gEOXydWf5hRS+nePTyyPqfCUE=; b=QWTRCFN3S62ok+B4Zh6ZiBPZ9x
        GhiIVZTserqN+SO/gjUFdkMYapQPIKJ8oGTSTFfw6hcEJ3N5rTv2+ZOO/odIXPFhlYYJDvg58KlkX
        XxSTGUsbmwL37RIZpLoYq+L5CF9qWb8t3fJ+xYmuKDdYzIZg7OhLplPJCW62UeRM9IjQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gLZdh-0005Ky-Vb; Sat, 10 Nov 2018 20:13:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8200F7A4EC7; Sat, 10 Nov 2018 15:13:52 -0500 (EST)
Date:   Sat, 10 Nov 2018 15:13:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com,
        whitequark@whitequark.org, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: A different PD controller firmware problem?
Message-ID: <20181110201352.GA2203@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com,
        whitequark@whitequark.org, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
 <3a666f66d6e342e2971b800caae7c889@whitequark.org>
 <3b76178ca0de4990a38362cfd4836fdc@ausx13mpc120.AMER.DELL.COM>
 <20180911093239.GW14465@lahna.fi.intel.com>
 <fd00612c1bb94f69820be2b1f1e171f9@ausx13mpc120.AMER.DELL.COM>
 <20181006060121.GA4050@thunk.org>
 <d92aef18a8ac4ef5ab3fcafaaf03afec@ausx13mpc120.AMER.DELL.COM>
 <20181108211540.GG1080@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108211540.GG1080@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:15:40PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Nov 08, 2018 at 06:00:59PM +0000, Mario.Limonciello@dell.com wrote:
> > > Sortly after 12:30am US/Eastern, I got a low power warning on my
> > > system, and the battery power had dropped below 10%.  Apparently the
> > > laptop was not accepting any charge any more.  I tried doing a suspend
> > > to ram, and then unsuspended it, and it still wasn't accepting any
> > > charge, even though the adapter indicated it was plugged in and
> > > supplying power.  I then did a power cycle, and still the laptop
> > > didn't indicate it was charging with a USB C 45W power supply plugged
> > > in.
> > 
> > Just to be clear was this a Dell adapter or another manufacturer?
> > 
> > If it's non-Dell, there could easily be an untested combination of controllers
> > and one getting into a bad state.

It happened again, just now.  Unfortunately I didn't have a Dell
charger handy when it did, but it was the same symptoms.  One
interesting thing that I did discover is that by observing the voltage
being negotiated via USB-C PD, using a Satechi USB-C power monitor, I
discovered that when the laptop gets into this state, while the laptop
is suspended or powered off, it will negotiate to 5 volts at 3 amps
(assuming the power supply supports it).  So apparently the problem is
that the PD controller on the XPS 13 was refusing to negotiate any
other voltage *besides* 5 volts.  The fact that it could negotiate 3
amps means that it was doing USB-C PD negotiation; it was just doing
so... badly.

As before, the problem persisted across multiple USB-C power sources,
and I could switch between them so long as the laptop was booted into
Linux, suspended, or powered off but with a power supply attached.
The way the problem got fixed is by unplugging the power supply with
the laptop in a powered of state.  Apparently that (and only that)
will reset the problem in the EC or USB-C PD controller.

If there is something that I should try next time (other than trying
to use a Dell USB-C power supply; I'll start carrying it around in the
future), please let me know.  I couldn't find any obvious EC Logs that
I could download, unfortunately.

Firmware versions:

<tytso.root@cwcc> {/usr/projects/linux/ext4-fsverity}, level 2   (master)
1008# fwupdmgr get-devices
XPS 13 9370 System Firmware
  DeviceId:             8a21cacfb0a8d2b30c5ee9290eb71db021619f8b
  Guid:                 7ceaf7a8-0611-4480-9e30-64d8de420c7c
  Guid:                 43ea5588-d9a4-5031-8ad3-308045302d6b
  Guid:                 230c8b18-8d9b-53ec-838b-6cfc0383493a
  Plugin:               uefi
  Flags:                internal|updatable|require-ac|supported|registered|needs-reboot
  Version:              0.1.5.1
  VersionLowest:        0.1.5.1
  Icon:                 computer
  Created:              2018-11-10

KXG50ZNV1T02 NVMe TOSHIBA 1024GB
  DeviceId:             f954c7acdf5fab61aeaca1cd71d29ea5ade6992f
  Guid:                 4d0aed03-a30c-52c6-99e7-a8977797c3d9
  Guid:                 ad9fe8f7-cdc4-52c9-9fea-31b6f4988ffa
  Serial:               Y77S10C8TYAT
  Summary:              NVM Express Solid State Drive
  Plugin:               nvme
  Flags:                internal|updatable|require-ac|registered|needs-reboot
  Vendor:               Toshiba America Info Systems
  VendorId:             NVME:0x1179
  Version:              AADA4102
  Icon:                 drive-harddisk
  Created:              2018-11-10

XPS 13 9370 Thunderbolt Controller
  DeviceId:             8885ea984074c84d636e5458d6b6d12649df2e5d
  Guid:                 4eeb9d07-a96c-56d6-92d3-4a23ee7a6e4a
  Summary:              Unmatched performance for high-speed I/O
  Plugin:               thunderbolt
  Flags:                internal|updatable|supported|registered
  Vendor:               Dell
  VendorId:             TBT:0x00D4
  Version:              33.00
  Icon:                 computer
  Created:              2018-11-10




