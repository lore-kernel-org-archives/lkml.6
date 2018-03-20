Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCTXN3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:13:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36056 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCTXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:13:28 -0400
Date: Tue, 20 Mar 2018 23:13:09 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Stefan Agner <stefan@agner.ch>
Cc: ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
Message-ID: <20180320231309.GJ2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320230206.25289-4-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:02:04AM +0100, Stefan Agner wrote:
> As documented in GCC naked functions should only use Basic asm
> syntax. The Extended asm or mixture of Basic asm and "C" code is
> not guaranteed. Currently this works because it was hard coded
> to follow and check GCC behavior for arguments and register
> placement.

Those checks have nothing to do with that at all.  The whole point of
__asmeq() is to catch situations where you use register variables,
specifying which register you want them in, and GCC then ends up
passing them to assembly code in some other random register(s).

This was found with older GCCs, and the problem was fixed.  It has
nothing to do with naked functions per se.

In fact, as you're introducing further register variables, these
checks become more important to have than they were with the
previous code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
