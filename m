Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757184AbeD0AAZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:00:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:36190 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753646AbeD0AAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:00:23 -0400
Date: Thu, 26 Apr 2018 20:00:13 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180427000013.GH5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christian Brauner <christian.brauner@canonical.com>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426204748.GA7540@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426204748.GA7540@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:47:49PM +0200, Christian Brauner wrote:
> 
> We have observed a similiar problem  with libvirt. As soon as entropy is
> provided the boot finishes otherwise it hangs for a long time.
> This is not happening with v4.17-rc1 afaict.

For libvirt there is at least an easy workaround.  Make surue the
guest kernel has CONFIG_HW_RANDOM_VIRTIO enabled, and then make sure
qemu is started with the options:

	-object rng-random,filename=/dev/urandom,id=rng0 \
	-device virtio-rng-pci,rng=rng0

Cheers,

					- Ted
