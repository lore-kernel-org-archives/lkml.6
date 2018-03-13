Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCMH1f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:27:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40893 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeCMH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:27:31 -0400
X-Google-Smtp-Source: AG47ELtIbJRR8Xav/eixlDSF3KB/mO8ZLtIK1l0WzKBxz6Ex0J5wg5ybDfaLEp/lEM45Du28mAFTYMmsvDBO1/1k3TQ=
MIME-Version: 1.0
In-Reply-To: <1519613406-32237-1-git-send-email-minyard@acm.org>
References: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
 <1519613406-32237-1-git-send-email-minyard@acm.org>
From: Daniel Drake <drake@endlessm.com>
Date: Tue, 13 Mar 2018 15:27:30 +0800
Message-ID: <CAD8Lp45pebxPSbPHXi_fT0Yg+mC01S12P-6cX2MWyQZwRbheMQ@mail.gmail.com>
Subject: Re: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
To: minyard@acm.org
Cc: Chris Chiu <chiu@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 26, 2018 at 10:50 AM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
> KCS controller, but whatever it is, it's not one.  Ignore it if seen.
>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>
> I haven't heard anything from you on this.  Here is a patch that should
> blacklist that device, though I don't have a way to easily test it.
> If you would prefer this, could you test it?

Sorry for the slow response, and thanks for the patch!

We have tested it here and it seems to be working fine now - the IPMI
stuff no longer initializes system interfaces, and hence doesn't get
in the way when going into suspend or reboot later.

This is a consumer desktop platform, so if some kind of IPMI
functionality is really present in the hardware then it is not really
going to be relevant for the ordinary user. So it should be fine to
just ignore the hardware as you have done.

Thanks
Daniel
