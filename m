Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeCNDeu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:34:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933259AbeCNDes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:34:48 -0400
Date: Tue, 13 Mar 2018 20:34:45 -0700
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180314033445.GA10337@localhost.localdomain>
References: <4716007c23abeb0e42015786794539454aff487b.1520886814.git.dvhart@infradead.org>
 <20180312202319.GA88572@localhost.localdomain>
 <20180312220751.GA1757@light.dominikbrodowski.net>
 <CA+55aFzUgk8c2n7GQfcCdYU-Jo86-W_b51gZCLyJahv_ZWMVsQ@mail.gmail.com>
 <20180312233311.GA3848@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312233311.GA3848@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:33:11PM -0700, Darren Hart wrote:
> On Mon, Mar 12, 2018 at 03:17:57PM -0700, Linus Torvalds wrote:
> > On Mon, Mar 12, 2018 at 3:07 PM, Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > >
> > > I'm awfully sorry, but this patch doesn't solve the issue.
> > > CONFIG_ACPI_WMI=y was/is set, but still enabling CONFIG_DELL_SMBIOS_WMI=y
> > > causes a very-early crash of v4.16-rc5. In fact, so early that the normal
> > > boot messages never show up on the screen...
> > 
> > Hmm. My xps13 works fine, but it's the 9350 version so not the same machine.
> > 
> > But it does sound like that commit 25d47027e10 ("platform/x86:
> > dell-smbios: Link all dell-smbios-* modules together") should just be
> > reverted. It has clearly caused a lot more pain than it fixed.
> 
> Unfortunately, yes. This will re-instate the race condition it "fixed".
> I'll work with Mario to fix this properly in 4.17, preferably in a way
> that we can apply to stable. Pending an "oops, nevermind, the patch
> works" from Dominik by tomorrow morning, I'll submit the pull request to
> revert dell-smbios changes back to and including 25d47027e10.
> 
> Apologies for the noise on this one Linus, it got away from me.

Hi Linus,

OK, I think we've identified the ordering issues and I have a patch out
pending testing from Dominik (hopefully tonight). I'd like to hold off
one more day on reverting if you're OK with that.

At RC5, we're certainly further into the RC cycle than I want to see
these changes. So if you just want to call it now, I understand and I'll
send you the revert pull request. If you can give me another day, I
think we may finally have found the end of this loose string.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
