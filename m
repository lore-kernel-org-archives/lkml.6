Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeDVRwU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:52:20 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:40836 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDVRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:52:19 -0400
Date: Sun, 22 Apr 2018 10:43:00 -0700
From: vcaputo@pengaru.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Ferry Toth <ftoth@telfort.nl>, linux-kernel@vger.kernel.org
Subject: Re: DOS by unprivileged user
Message-ID: <20180422174300.srzhf3veqxfigqhg@shells.gnugeneration.com>
References: <9023506.UBh6vynRGa@delfion>
 <20180422101654.GA26243@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422101654.GA26243@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 12:16:54PM +0200, Pavel Machek wrote:
> On Thu 2018-04-19 21:13:35, Ferry Toth wrote:
> > It appears any ordinary user can easily create a DOS on linux.
> > 
> > One sure way to reproduce this is to open gitk on the linux kernel repo 
> > (SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and quad core 
> > + hyperthreading. But I will be easy enough to get the same effect with more 
> > RAM, other fs etc.
> 
> You may want to disable swap.
> 

I run without swap on my laptops, and still observe long periods of
thrashing on the road towards OOM.  What seems to occur is the active
file-backed mappings of executables/libraries become a sort of swap
area, repeatedly being discarded and faulted back in as the context
switches occur.

If there's any good way to prevent this, I'd like to know.

Regards,
Vito Caputo
