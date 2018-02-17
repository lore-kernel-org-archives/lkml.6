Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeBQUJ4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:09:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53663 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751159AbeBQUJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:09:55 -0500
X-ME-Sender: <xms:EoyIWuNK9i51MKlf1-aTU2JojUVLGwcxl1EiwNS12EGKyArWSLUc8w>
Date: Sat, 17 Feb 2018 18:09:49 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Check microcode revision before updating
 sibling threads
Message-ID: <20180217200949.dktgcwhb7reopwnk@khazad-dum.debian.net>
References: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
 <20180217134247.sccdynjiqnk2mjby@khazad-dum.debian.net>
 <20180217142132.GA30848@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217142132.GA30848@pd.tnic>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018, Borislav Petkov wrote:
> On Sat, Feb 17, 2018 at 11:42:48AM -0200, Henrique de Moraes Holschuh wrote:
> > I wonder when this broke,
> 
> It didn't break - we're just printing the update only once.

It was before that change, when the microcode subsystem still printed a
message for every CPU that got updated or early-updated.

It was fixed to properly refresh the microcode revision in the percpu
area right before deciding whether it should update that cpu or not, and
thus it would skip the second thread on Intel cores because it would
notice it was already up-to-date.

Maybe it was just the late loader, though...  I'd need to do some git
log digging.

-- 
  Henrique Holschuh
