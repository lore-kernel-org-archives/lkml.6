Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeD2XHc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 19:07:32 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:59932 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754352AbeD2XHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 19:07:31 -0400
Date: Sun, 29 Apr 2018 19:07:29 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429230728.whjg3fpeunxuvkyn@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
 <20180429230202.rcsjtnp2jhbqyag2@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429230202.rcsjtnp2jhbqyag2@codemonkey.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 07:02:02PM -0400, Dave Jones wrote:
 > On Tue, Apr 24, 2018 at 09:56:21AM -0400, Theodore Y. Ts'o wrote:
 > 
 >  > Can you tell me a bit about your system?  What distribution, what
 >  > hardware is present in your sytsem (what architecture, what
 >  > peripherals are attached, etc.)?
 >  > 
 >  > There's a reason why we made this --- we were declaring the random
 >  > number pool to be fully intialized before it really was, and that was
 >  > a potential security concern.  It's not as bad as the weakness
 >  > discovered by Nadia Heninger in 2012.  (See https://factorable.net for
 >  > more details.)  However, this is not one of those things where we like
 >  > to fool around.
 >  > 
 >  > So I want to understand if this is an issue with a particular hardware
 >  > configuration, or whether it's just a badly designed Linux init system
 >  > or embedded setup, or something else.  After all, you wouldn't want
 >  > the NSA spying on all of your network traffic, would you?  :-)
 > 
 > Why do we continue to print this stuff out when crng_init=1 though ?

answering my own question, I think.. This is a tristate, and we need it
to be >1 to be quiet, which doesn't happen until..

 > [  165.806247] random: crng init done

this point.

	Dave
