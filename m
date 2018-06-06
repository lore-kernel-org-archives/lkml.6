Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6622960555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeFFJwC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:52:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbeFFJwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:52:01 -0400
Date: Wed, 6 Jun 2018 11:52:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon 0000:1d:00.0: GPU lockup (current fence id
 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
Message-ID: <20180606095201.GA10840@zn.tnic>
References: <20180605144404.GA7389@zn.tnic>
 <7921bc34-6e63-7869-0695-70baf9d480a1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7921bc34-6e63-7869-0695-70baf9d480a1@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:26:15AM +0200, Christian König wrote:
> Well what did you do to trigger the lockup? Looks like an application send
> something to the hardware to crash the GFX block.

So what I observed was (in that order): machine was building a kernel so
was busy, X didn't respond for a couple of seconds (which it should not
do) and I switched to tty8 to see what dmesg says (I am routing dmesg to
tty8).

At that moment it showed the lockup splat and then X restarted showing
me the login prompt again. I'm guessing the X restart was caused by the
GPU reset.

So if I had to guess, maybe pressing Ctrl+Alt+F8 caused the modeset
change and thus reset? Hmm, this is just me guessing with my
non-knowledge about graphics. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
