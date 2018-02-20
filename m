Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeBTVcw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:32:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:45163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbeBTVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:32:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19826239"
Date: Tue, 20 Feb 2018 13:32:47 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        joe.konno@linux.intel.com, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, matthew.garrett@nebula.com,
        Jeremy Kerr <jk@ozlabs.org>, ak@linux.intel.com, pjones@redhat.com,
        luto@kernel.org,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180220213246.43y2vbiiikqyx2ys@agluck-desk>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CACdnJusL1Vj_rvhZY+0_KZkrk=fwnQcr1y+vxOBmUXa4xdHHsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJusL1Vj_rvhZY+0_KZkrk=fwnQcr1y+vxOBmUXa4xdHHsg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 09:22:29PM +0000, Matthew Garrett wrote:
> On Tue, Feb 20, 2018 at 1:18 PM Luck, Tony <tony.luck@intel.com> wrote:
> 
> > Does this rate an exception to the "don't break userspace" for a security
> issue?
> 
> To be clear, when you say "security" is this in reference to it being a
> denial of service, or are you worried about other interactions that may
> cause wider security issues?

The immediate problem is the denial of service attack.  I have
a nagging worry that allowing a user to cause an SMI at a precise
time might also be a problem. But I don't know how that could be
leveraged in some other attack.

Making the efivar files 0600 would stop the user from causing the
SMIs. The rate limit solution could include a random delay to make
it tricky to use any attack that relies on an SMI during some specific
code sequence.

-Tony
