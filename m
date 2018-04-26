Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeDZHdH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:33:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:60750 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753654AbeDZHc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:32:57 -0400
Date: Thu, 26 Apr 2018 03:32:55 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426073255.GH18803@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 10:05:55PM -0700, Sultan Alsawaf wrote:
> 
> Correct, I'm running Xubuntu 18.04 with my own kernel based off linux-stable.
>

Hmm, can you let the boot hang for a while?  It should continue after
a few minutes if you wait long enough, but wait a minute or two, then
give it entropy so the boot can continue.  Then can you use
"systemd-analyze blame" or "systemd-analyize critical-chain" and we
can see what process was trying to get randomness during the boot
startup and blocking waiting for the CRNG to be fully initialized.

	    	     	     	     - Ted
				     
