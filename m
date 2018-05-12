Return-Path: <linux+multiple=linux-foundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZrsAJ/yClXdDjgV1l//X3maRUWnwWXDnBloICWZN88AbybQXZOu5Q7e/ADRH0qQJmivVdfs
ARC-Seal: i=1; a=rsa-sha256; t=1526116021; cv=none;
        d=google.com; s=arc-20160816;
        b=VEenN3v60Jb1HWrQnPlDs1VHpf1OVDvx6O+QG2J19ajJYc8ScDEiBtoEix9bI8yA8O
         B/P3W6UQ7dmp5x/zrGNWG9uJ0YknmJWa8Vy194+k953jOSHUdjs9PxThpCv97DlY72ci
         FPJ49hC2OysBBwCCEozqSwLydl5I2Cm7LrUuMT65rB3joNEKlkUPzvBzQAbm/RW0okcF
         hskPXoET9BBMIvyr6fQeFOOuWR4km09/zid0pOZZcnq/9sowVigbxcpqglHbluitP/7J
         o3rBIoLGwJO4t2bS4dxte4E+DMwjDi1x8RGOfcehe4t6Tiu1cwo5lAwRjh5rbWMCLqjd
         VWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rW9Qst371XGMptyOTbPNrl5+fw+3cnGhYMezqz6oh5I=;
        b=ookDa5CEiy4OUeeUzyNwTvyp7YxHV3zrNL1e1C3OMvKuW/jcJm+dO3KBYKb+qScD9/
         N7lUKfYLAvDc2X7mR8Yk6rjWvhDTgj+Dt/q5Mprs1mhfkbv6lBImI/ks8idfDvacBGmi
         4U2ikGpIZEkWvcJEeDwuXqQ/T8tVoV46FuIEqZEbHlIXhYljoCZJmpym9ULVF1oQK8YP
         zvJx0T9bQaZcMXOEG0H5STwHuChpXzXXU2ARgX3PBH3FicWhbBMIJ8VF1HrEihU5OENt
         X8cqzEGAW/ueEYadt0h5kRTl+xxBD2DX5PTTuKSC1I6/JMeetbkRq8H3N+XYNfOvTi89
         YHxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=QGxhzuKw;
       spf=pass (google.com: best guess record for domain of linux+multiple=linux-foundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+multiple=linux-foundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=QGxhzuKw;
       spf=pass (google.com: best guess record for domain of linux+multiple=linux-foundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+multiple=linux-foundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Sat, 12 May 2018 10:06:44 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: gregkh@linux-foundation.org, Wang Nan <wangnan0@huawei.com>,
	Will Deacon <will.deacon@arm.com>, Jon Medhurst <tixy@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Long <dave.long@linaro.org>, stable@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-ID: <20180512090644.GD16141@n2100.armlinux.org.uk>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
 <20180508112503.GD16141@n2100.armlinux.org.uk>
 <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600216887599109111?=
X-GMAIL-MSGID: =?utf-8?q?1600248631907562691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 09:42:21AM +0900, Masami Hiramatsu wrote:
> Hi Greg,
> 
> Could you pick this series to stable?

You've added the Cc for stable, so when they get committed to mainline,
they will be automatically picked up without further need to ask.

However, they do _first_ need to end up in mainline before they can go
anywhere near stable trees as per stable tree rules.  For more
information on stable trees and their rules, please see:

  Documentation/process/stable-kernel-rules.rst

> 
> Thank you,
> 
> On Tue, 8 May 2018 12:25:03 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> > > Hi,
> > > 
> > > This is the 3rd version of bugfix series for kprobes on arm.
> > > This series fixes 4 different issues which I found.
> > > 
> > >  - Fix to use smp_processor_id() after disabling preemption.
> > >  - Prohibit probing on optimized_callback() for avoiding
> > >    recursive probe.
> > >  - Prohibit kprobes on do_undefinstr() by same reason.
> > >  - Prohibit kprobes on get_user() by same reason.
> > > 
> > > >From v2, I included another 2 bugfixes (1/4 and 2/4)
> > > which are not merged yet, and added "Cc: stable@vger.kernel.org",
> > > since there are obvious bugs.
> > 
> > Please submit them to the patch system, thanks.
> > 
> > > 
> > > Thanks,
> > > 
> > > ---
> > > 
> > > Masami Hiramatsu (4):
> > >       arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
> > >       arm: kprobes: Prohibit probing on optimized_callback
> > >       arm: kprobes: Prohibit kprobes on do_undefinstr
> > >       arm: kprobes: Prohibit kprobes on get_user functions
> > > 
> > > 
> > >  arch/arm/include/asm/assembler.h  |   10 ++++++++++
> > >  arch/arm/kernel/traps.c           |    5 ++++-
> > >  arch/arm/lib/getuser.S            |   10 ++++++++++
> > >  arch/arm/probes/kprobes/opt-arm.c |    4 +++-
> > >  4 files changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > --
> > > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> > 
> > -- 
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> > According to speedtest.net: 8.21Mbps down 510kbps up
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
