Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeDBMWG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:22:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48796 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeDBMWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:22:01 -0400
Date: Mon, 2 Apr 2018 14:21:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180402122140.GB8159@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330105156.GA24344@chelsio.com>
 <87k1tt2yo7.fsf@xmission.com>
 <20180402091143.GD3313@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402091143.GD3313@nanopsycho>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> The sysfs approach proposed here had been dropped in favour exporting
> >> the dumps as ELF notes in /proc/vmcore.
> >>
> >> Will be posting the new patches soon.
> >
> >The concern was actually how you identify which device that came from.
> >Where you read the identifier changes but sysfs or /proc/vmcore the
> >change remains valid.
> 
> Yeah. I still don't see how you link the dump and the device.

Hi Jiri

You can see in the third version the core code accept a free form
name. The driver builds a name using the driver name and the adaptor
name.

What i think would be good is to try to have one API to the driver
that can be used for both crash dumps and devlink snapshots. These are
used at different times, but have basically the same purpose, get
state from the device.

      Andrew
