Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbeBPPYo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:24:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53941 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeBPPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:24:42 -0500
Date: Fri, 16 Feb 2018 16:24:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] rtc: tx4939: avoid unintended sign extension on a 24
 bit shift
Message-ID: <20180216152440.GH14177@piout.net>
References: <20180215193614.28684-1-colin.king@canonical.com>
 <20180215204453.GE14177@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215204453.GE14177@piout.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 at 21:44:53 +0100, Alexandre Belloni wrote:
> On 15/02/2018 at 19:36:14 +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The shifting of buf[5] by 24 bits to the left will be promoted to
> > a 32 bit signed int and then sign-extended to an unsigned long. If
> > the top bit of buf[5] is set then all then all the upper bits sec
> > end up as also being set because of the sign-extension. Fix this by
> > casting buf[5] to an unsigned long before the shift.
> > 
> 
> The timing of the discovery of this issue is suspicious. I believe it is
> because I just enabled COMPILE_TEST on that driver and now this gets
> compiled on a 64bit architecture.
> 
> Can I ask on which architecture this is an issue? I don't think (and a
> small test program confirms) x86 does the sign extension because both
> sec and buf are unsigned.
> 

Actually, my test program was wrong and you are right.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
