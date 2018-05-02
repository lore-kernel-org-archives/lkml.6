Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeEBA4J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:56:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:51366 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeEBA4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:56:07 -0400
Date: Tue, 1 May 2018 20:56:04 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180502005604.GJ10479@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Jeremy Cline <jeremy@jcline.org>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502004317.kxwiu2oephgbi6ok@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502004317.kxwiu2oephgbi6ok@sultan-box>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 05:43:17PM -0700, Sultan Alsawaf wrote:
> 
> I've attached what I think is a reasonable stopgap solution until this is
> actually fixed. If you're willing to revert the CVE-2018-1108 patches
> completely, then I don't think you'll mind using this patch in the meantime.

I would put it slightly differently; reverting the CVE-2018-1108
patches is less dangerous than what you are proposing in your attached
patch.

Again, I think the right answer is to fix userspace to not require
cryptographic grade entropy during early system startup, and for
people to *think* about what they are doing.  I've looked at the
systemd's use of hmac in journal-authenticate, and as near as I can
tell, there isn't any kind of explanation about why it was necessary,
or what threat it was trying to protect against.

						- Ted
