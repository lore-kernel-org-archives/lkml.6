Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbeBSWBO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:01:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49302 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeBSWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:01:13 -0500
Date: Tue, 20 Feb 2018 09:01:11 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: David Miller <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
In-Reply-To: <20180219.141137.2095980245673495027.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1802200844340.8@nippy.intranet>
References: <cover.1519007130.git.fthain@telegraphics.com.au> <db538e6962eb16045ec85c15aee2b9b30eedcce5.1519007130.git.fthain@telegraphics.com.au> <20180219.141137.2095980245673495027.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, David Miller wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)
> 
> > The lib8390 module parameter 'msg_enable' doesn't do anything useful:
> > it causes an ancient version string to be logged.
> 
> Since you are removing the last reference to this 'version' string
> you should remove it as well.
> 
> I'm surprised the compiler doesn't warn about this.
> 

I compile-tested every 8390 module and I didn't come across any compiler 
bugs.

Please take another look. I think you'll find that lib8390.c is always 
#included by a module which does define that symbol.

Thanks.

-- 
