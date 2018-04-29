Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeD2UIu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 16:08:50 -0400
Received: from imap.thunk.org ([74.207.234.97]:43234 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753985AbeD2UIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 16:08:48 -0400
Date: Sun, 29 Apr 2018 16:08:46 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429200846.GP5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429183057.kk666r4z5biamzvs@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429183057.kk666r4z5biamzvs@sultan-box>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 11:30:57AM -0700, Sultan Alsawaf wrote:
> 
> Mind you, this laptop has a 45W CPU, so power savings were definitely not
> considered in its design. Do you have any machines that can provide enough
> boot entropy to satisfy crng init without requiring user-provided entropy?

My 2018 Dell XPS 13 laptop, running "egrep '(random|EXT4)' /var/log/kern.log":

Apr 24 17:05:01 cwcc kernel: [    0.000000] random: get_random_bytes called from start_kernel+0x83/0x500 with crng_init=0
Apr 24 17:05:01 cwcc kernel: [    1.363383] random: fast init done
Apr 24 17:05:01 cwcc kernel: [    3.567432] random: lvm: uninitialized urandom read (4 bytes read)
Apr 24 17:05:01 cwcc kernel: [    3.593132] random: lvm: uninitialized urandom read (4 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.584838] random: cryptsetup: uninitialized urandom read (2 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.600685] random: cryptsetup: uninitialized urandom read (2 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.803194] random: cryptsetup: uninitialized urandom read (2 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.831050] random: lvm: uninitialized urandom read (4 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.851884] random: lvm: uninitialized urandom read (4 bytes read)
Apr 24 17:05:01 cwcc kernel: [    7.875382] random: lvm: uninitialized urandom read (2 bytes read)
Apr 24 17:05:01 cwcc kernel: [    8.162552] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
Apr 24 17:05:01 cwcc kernel: [    8.646497] random: crng init done

       		     	     	  	    	    	 - Ted
