Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbeBZOsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:48:17 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:41584 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeBZOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:48:12 -0500
X-Google-Smtp-Source: AG47ELuHZIrP2JVohTSLTjC8dI+BfxjgN9AV3jnq9GzVB/1j5NUlkP/osPOe4SuYuGNlqA6CMmMKCA==
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
 <1519613406-32237-1-git-send-email-minyard@acm.org>
 <CAHp75Vd8mEZRTVYiR5Nz4X8HM8VUHArc5C1SyfN4K8c-Y9+taw@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <5ae019f4-a997-fe96-4f16-c12893b816cf@acm.org>
Date: Mon, 26 Feb 2018 08:48:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd8mEZRTVYiR5Nz4X8HM8VUHArc5C1SyfN4K8c-Y9+taw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2018 08:34 AM, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 4:50 AM,  <minyard@acm.org> wrote:
>
>> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
>> KCS controller, but whatever it is, it's not one.  Ignore it if seen.
>> +static struct pci_device_id ipmi_pci_blacklist[] = {
>> +       /*
>> +        * This is a "Virtual IPMI device", whatever that is.  It appears
>> +        * as a KCS device by the class, but it is not one.
>> +        */
>> +       { PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x816c) },
>> +       { 0, }
> { PCI_VDEVICE(REALTEK, 0x816c) },
> { }
>
> ?

That's better, thanks.

-corey

>
>> +};
>> +       if (pci_match_id(ipmi_pci_blacklist, pdev))
>> +               return -ENODEV;
>
