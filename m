Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeEUV5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:57:36 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:56402 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeEUV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:57:18 -0400
Date: Mon, 21 May 2018 14:57:18 -0700
From: Vito Caputo <vcaputo@pengaru.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] v4.17-rc4: xgalaga fails to start in fullscreen
 (default) mode
Message-ID: <20180521215718.7zwhhdanpnibp6la@shells.gnugeneration.com>
References: <20180521195320.6stbpnebgjowxwjp@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521195320.6stbpnebgjowxwjp@shells.gnugeneration.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 12:53:20PM -0700, Vito Caputo wrote:
> Hello all,
> 
> 4.17-rc4 (my latest kernel ATM) consistently fails to start xgalaga
> without -window.  I will try find time to build the latest rc this
> evening.
> 
> > ~$ xgalaga
> > X Error of failed request:  BadValue (integer parameter out of range for operation)
> >   Major opcode of failed request:  152 (XFree86-VidModeExtension)
> >   Minor opcode of failed request:  10 (XF86VidModeSwitchToMode)
> >   Value in failed request:  0x120004e
> >   Serial number of failed request:  199
> >   Current serial number in output stream:  203
> 
> Haven't dug into this much yet, only did a perfunctory check by booting into a
> few older kernels (4.11, 4.12, 4.16) and the problem is absent on all of them.
> It appears to be a 4.17-specific regression right now.
> 
> Also observed, though this is surely a different regression, the game
> ran like molasses with -window, showing some prominent kworkers in top:
> 
>   692 vc        20   0  312852  45884  20556 R  32.0  1.2   0:08.69 Xorg           
>   102 root      20   0       0      0      0 R  11.2  0.0   0:01.43 kworker/1:3    
>    94 root      20   0       0      0      0 I   8.9  0.0   0:00.83 kworker/0:2    
>   696 vc        20   0   39948   4124   2912 S   1.0  0.1   0:05.57 vwm            
>   902 vc        30  10   46372   4144   3500 S   0.7  0.1   0:00.08 xgalaga        
>   891 vc        30  10   44924   3868   3156 R   0.3  0.1   0:00.09 top            
>   903 vc        30  10    4180   1184   1100 S   0.3  0.0   0:00.01 xgal.sndsrv.oss
> 
> The windowed performance issue was observed on the older kernels tested
> as well, though 4.11 felt better and didn't have the busy kworkers.
> 
> I have not attempted to play xgalaga for ages, but it used to be perfectly
> playable on this machine in windowed mode when I last did.
> 
> Machine is the venerable Thinkpad X61s, 1.8Ghz, Debian 9, config attached.
> 

Just built and booted v4.17-rc6, still broken.
