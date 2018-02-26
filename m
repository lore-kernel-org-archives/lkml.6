Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeBZOee (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:34:34 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:45347 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeBZOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:34:27 -0500
X-Google-Smtp-Source: AG47ELsPocnO/4BSjouTrBJdwWNlsBKIDoBWCsgDjccjA1MYGWMWkxYMAFuhvNmQhn9iEHpxPXO7QhOWjVhvjyMArQ4=
MIME-Version: 1.0
In-Reply-To: <1519613406-32237-1-git-send-email-minyard@acm.org>
References: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
 <1519613406-32237-1-git-send-email-minyard@acm.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:34:26 +0200
Message-ID: <CAHp75Vd8mEZRTVYiR5Nz4X8HM8VUHArc5C1SyfN4K8c-Y9+taw@mail.gmail.com>
Subject: Re: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
To: Corey Minyard <minyard@acm.org>
Cc: Chris Chiu <chiu@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 4:50 AM,  <minyard@acm.org> wrote:

> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
> KCS controller, but whatever it is, it's not one.  Ignore it if seen.

> +static struct pci_device_id ipmi_pci_blacklist[] = {
> +       /*
> +        * This is a "Virtual IPMI device", whatever that is.  It appears
> +        * as a KCS device by the class, but it is not one.
> +        */

> +       { PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x816c) },
> +       { 0, }

{ PCI_VDEVICE(REALTEK, 0x816c) },
{ }

?

> +};

> +       if (pci_match_id(ipmi_pci_blacklist, pdev))
> +               return -ENODEV;


-- 
With Best Regards,
Andy Shevchenko
