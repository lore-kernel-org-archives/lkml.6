Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEMT5a (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:57:30 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:52936 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeEMT52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:57:28 -0400
Date: Sun, 13 May 2018 20:57:26 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: serial: custom baud rate
Message-ID: <20180513205726.5029c88a@alans-desktop>
In-Reply-To: <pcfka2$gie$1@blaine.gmane.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
        <pcfka2$gie$1@blaine.gmane.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018 18:27:14 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> On 2018-05-03, Muni Sekhar <munisekharrms@gmail.com> wrote:
> 
> > If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
> > Linux serial framework has any supporting method?  
> 
> Sure, use the termios2 structure instead of the termios structure:
> 
>   #include <linux/termios.h>
> 
>   struct termios2 t;
> 
>   ioctl(fd, TCGETS2, &t)
> 
>   t.c_cflag &= ~CBAUD;
>   t.c_cflag |= BOTHER;
>   t.c_ispeed = baud;
>   t.c_ospeed = baud;
> 
>   ioctl(fd, TCSETS2, &t)
> 
> [Not all devices/drivers support termios2]

That shouldn't be true - all devices get passed ispeed/ospeed and
everything in tree was using the correct fields as far as I could tell
last time I checked this

Alan
