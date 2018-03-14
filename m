Return-Path: <stern+5aab093e@rowland.harvard.edu>
X-Google-Smtp-Source: AG47ELuHHCw5DTYOvjtC+GmbnTVz4dFMRFWDYcZioshjxVfIuK110ZzzPkHnfQP67eGCpcilfL2J
ARC-Seal: i=1; a=rsa-sha256; t=1521045850; cv=none;
        d=google.com; s=arc-20160816;
        b=Wj696ASwmicTX2/McBOEyklQ3gfezn0yimcaTcShiSTDOWehKlygFIqAS6GXuPS/CH
         OZNdyP/vR3zFdzdKlwj+pU/l9iGDpDaFsIqYCFflGIkbjyvUy9Qj/a1tyujnwlU1BHKe
         bCx4JV6uPihtm27MxytDBnEFLYKmcX5EH0y+JnrI+Po+K54YgGV4+3Y3IjCNsieRofMV
         F9GtOhwOu5L8pxkmv/GLBHvF+92ed+ZEyB2731ArFux19XQdnaQCsxwkjhMb4eIBHx10
         acr6K/Ohy2T2/EVHIepog4QSmZPsD1hCm3rMoCRWFhSzbUZ6Izl4ixILNR58B1jwp0zk
         zOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=zWBi3ImE7jB4pjoaykjiuwKuPc+LVrYcyeO9vN0OOZQ=;
        b=hApqCkEMySkNBXH2YAiV4diYLIWw18HqM5x1YlJaVZCIux3/cYw1M6LBukdU+bxWCc
         MiECM9YVLTC3EcP72I0voHqGHrANJgEW0s30XdrkooCIZdp1lPwPnsMTPu5wp0CCyfik
         goyrcWFItdy9IUd+dXxZsMHEGlOTtr+oi3W6wz9xBaTPI2Q86SCd2fPv6bdP28h+Yvq0
         1gDl7V0BIJi1Zx3CMxd9EajRuKkrtGIbQvJh8ULnS6IePTTQtOew1/sH/ADp7lMiCl9l
         qhicVStnd39/fxWLjeDCA6eOmidH8jvJQrMk5kHCgLkzvUGNoCyNg+tIqN8uU5Zwa7MT
         1Xfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Date: Wed, 14 Mar 2018 12:44:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Arnd Bergmann <arnd@arndb.de>,  <linux-kernel@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 37/47] usb: host: remove tilegx platform glue
In-Reply-To: <20180314163344.GK4279@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1803141243540.1386-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928836259530787?=
X-GMAIL-MSGID: =?utf-8?q?1594932173578504555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018, Greg Kroah-Hartman wrote:

> On Wed, Mar 14, 2018 at 04:35:50PM +0100, Arnd Bergmann wrote:
> > The tile architecture is getting removed, so the ehci and ohci platform
> > glue drivers are no longer needed. In case of ohci, this is the last
> > one to define a PLATFORM_DRIVER macro, so we can remove even more.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/usb/host/ehci-hcd.c    |   5 -
> >  drivers/usb/host/ehci-tilegx.c | 207 -----------------------------------------
> >  drivers/usb/host/ohci-hcd.c    |  18 ----
> >  drivers/usb/host/ohci-tilegx.c | 196 --------------------------------------
> >  include/linux/usb/tilegx.h     |  35 -------
> >  5 files changed, 461 deletions(-)
> >  delete mode 100644 drivers/usb/host/ehci-tilegx.c
> >  delete mode 100644 drivers/usb/host/ohci-tilegx.c
> >  delete mode 100644 include/linux/usb/tilegx.h
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
