Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755982AbeDYQW0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:22:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:54885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932102AbeDYQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:21:18 -0400
Message-ID: <1524673273.8257.2.camel@gmx.de>
Subject: Re: DOS by unprivileged user
From: Mike Galbraith <efault@gmx.de>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Ferry Toth <ftoth@telfort.nl>, linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 18:21:13 +0200
In-Reply-To: <20180425155459.5a4e40e0@alans-desktop>
References: <9023506.UBh6vynRGa@delfion> <4285098.DEWjdbWF2X@delfion>
         <1524325275.8078.2.camel@gmx.de> <6057755.ozdVOybsI6@delfion>
         <1524470676.5451.1.camel@gmx.de> <20180425155459.5a4e40e0@alans-desktop>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Nf309raBT0H+CfDYDVbQRnARZ3ogqBhVKIWNun0pHoiH5SVOAyL
 Qwix9+M+kAQaWocI7Y36Dj2vje0tjtq/xaCNw5UjFd/Lb+RGIdlSGP3BX5Whg2BnIZj3ffu
 2d1CTmOAevouifHDMnU71vqg8Gv3UeP/5xchEAJ1FYkwFBeVSESWhcCSfkHdjR1/G5Dh02m
 NNW/dGZXuSx8cKGpGnGYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GH0zhk/Y+Js=:QU5qZIiorF2eIEXev+p0bb
 5RLuG0dQrHd+1sYz9sX2VUH4+jb/i3iF2A72iW38k0fn0gu07Nm7IyPNJKTy9d1Xp6eQWEr4u
 +aiUg6y8wRAoC3K5YfYZiDQE+z3ywCMXZm3BdkbWFssgsx5OSBgAtYxuEloKInCimDbMHpdvF
 O6ghi2Mn2GpG3TySuErmhc5LcM0QSKKFMqL4ZRRnzAvaEscCdhYFwMyKikCIJsiyJOFns2DUF
 4c+al9uAyMUBz3yvoG7s/h8EWg10hOr+xZePBUobIWBLH/XS9W2SWcEex7FaNlzkc+ZqXcBVk
 0iJOPnwSJEwqQ7K6cqgOINmxNTtcZV4+kXK7HGZ0A++XwE6+4DqnmyKb5RhtBHLzV4mYXZIfA
 iQyALvxpoGtx0tqu6U3hX8hYrRTNEyQncmN0zCYPJYj3rUdRAnJsouzmoTWohQk88ZY36F1Ni
 /76Ym8p3Kx5mYLKIB4vrQh0+KenvcgfPiGU1+CGzDVv1ArnwTfjSQE6zKjJIbkLvBd85/GUFn
 8+DU7b6DnxZ9OqyZCvJp+iQmym/bVDUCeZ4dWVuBaY87mFuRhgvbI78rtHIqPARUPnFkn7qRH
 Ktq6V/EkqTEGcaG/Ueaa48K/c3i474VfyQ+Imi4Az39y3HUHNRSc3FfWAtUcQDSl1NzucIlsM
 UXOMQSfa88RI+27R5PcufJcxF/mmmJ7h0WkvL6WMQuT4OxZxkSJ8CdapJ+loqtSCDiEvQbhJJ
 8YlNzfbGJv6930nDmJ95llyie76ovwALSvt43Lf8R4K97ma4DjCRNoOar7x2OtQh2Ehh8KwG3
 BZ3WMRdN36c6/yd57NtrX8LAihScWPAk9nYfhaiB2jS3t9yFqw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 15:54 +0100, Alan Cox wrote:
> > > I think memory allocation and io waits can't be decoupled from
> > > scheduling as they are now.  
> > 
> > The scheduler is not decoupled from either, it is intimately involved
> > in both.  However, none of the decision making smarts for either reside
> > in the scheduler, nor should they.
> 
> It belongs in both.

If mm decision making belongs within the process scheduler, it follows
that IO requests, dirty page writeback etc. do as well.  Nope, I don't
think we want to create a squid-uler, with tentacles extending all over
the dang kernel.

The thrashing problem could use some attention, but we'll have to agree
to disagree about the scheduler growing mm, io (etc) smarts.

	-Mike
