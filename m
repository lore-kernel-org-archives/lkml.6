Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCUIlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:41:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47473 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCUIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:41:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 09:41:41 +0100
From: Stefan Agner <stefan@agner.ch>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
In-Reply-To: <20180320231309.GJ2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
 <20180320231309.GJ2743@n2100.armlinux.org.uk>
Message-ID: <98806397d62084bf01c475fd210cd186@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 00:13, Russell King - ARM Linux wrote:
> On Wed, Mar 21, 2018 at 12:02:04AM +0100, Stefan Agner wrote:
>> As documented in GCC naked functions should only use Basic asm
>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>> not guaranteed. Currently this works because it was hard coded
>> to follow and check GCC behavior for arguments and register
>> placement.
> 
> Those checks have nothing to do with that at all.  The whole point of
> __asmeq() is to catch situations where you use register variables,
> specifying which register you want them in, and GCC then ends up
> passing them to assembly code in some other random register(s).
> 
> This was found with older GCCs, and the problem was fixed.  It has
> nothing to do with naked functions per se.
> 

Ok, will reword that part to something like:

As documented in GCC naked functions should only use Basic asm
syntax. The Extended asm or mixture of Basic asm and "C" code cannot
be depended upon.

Furthermore with clang using parameters in Extended asm in a
naked function is not supported:
...

> In fact, as you're introducing further register variables, these
> checks become more important to have than they were with the
> previous code.

Ok I see, so I definitely have to leave them in.

You generally agree with the change otherwise?

--
Stefan
