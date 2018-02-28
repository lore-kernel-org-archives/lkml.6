Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeB1NMD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:12:03 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40195 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752329AbeB1NMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:12:00 -0500
X-ME-Sender: <xms:n6qWWjHqT6Nbe6T9MZpFryeNa6kUt-rqFh6aCZx3aRVGunE78fxBxw>
Date: Wed, 28 Feb 2018 10:11:56 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] x86/microcode: Do not upload microcode if CPUs are
 offline
Message-ID: <20180228131156.i4y6la7besdflffd@khazad-dum.debian.net>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228102846.13447-5-bp@alien8.de>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Borislav Petkov wrote:
> Avoid loading microcode if any of the CPUs are offline, and issue a
> warning. Having different microcode revisions on the system at any time
> is outright dangerous.

Even if we update that microcode during CPU early bring-up, before we
mark it on-line and start using it?

AFAIK, late-loading or not, this is what should happen in the current
code: APs that are brought up after a microcode update is loaded (either
by the early or late driver, it doesn't matter) will be always
*early-updated* to the new microcode.

Is it dangerous to have an offline core at an older microcode revision
than the online cores?

I am not against the patch, mind you, but I am curious about why it is
supposed to be dangerous if we're updating the CPUs before we start
using them *anyway*.

Also, if this is really dangerous, does it means safe CPU hotplug isn't
possible?  AFAICT, the firmware would have to do it for us, but it
*doesn't* have the up-to-date microcode (*we* had to update it)...

-- 
  Henrique Holschuh
