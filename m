Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeCML7R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:59:17 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36516 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCML7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:59:16 -0400
X-Google-Smtp-Source: AG47ELuQmF44D/HUX6yFadrAm/ChXOcxvXxeuGnQNDbRaJJ4D4q8mYvI3zIfpWhLRJpJp66n7U3B7g==
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
To: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
 <1519613406-32237-1-git-send-email-minyard@acm.org>
 <CAD8Lp45pebxPSbPHXi_fT0Yg+mC01S12P-6cX2MWyQZwRbheMQ@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <7630b31f-0b6a-6725-aac0-3c06c142d557@acm.org>
Date: Tue, 13 Mar 2018 06:59:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp45pebxPSbPHXi_fT0Yg+mC01S12P-6cX2MWyQZwRbheMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 02:27 AM, Daniel Drake wrote:
> Hi,
>
> On Mon, Feb 26, 2018 at 10:50 AM,  <minyard@acm.org> wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
>> KCS controller, but whatever it is, it's not one.  Ignore it if seen.
>>
>> Reported-by: Chris Chiu <chiu@endlessm.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>
>> I haven't heard anything from you on this.  Here is a patch that should
>> blacklist that device, though I don't have a way to easily test it.
>> If you would prefer this, could you test it?
> Sorry for the slow response, and thanks for the patch!
>
> We have tested it here and it seems to be working fine now - the IPMI
> stuff no longer initializes system interfaces, and hence doesn't get
> in the way when going into suspend or reboot later.

Ok, thanks, I will add it with a "Tested-by" from you, if that is ok.

-corey

>
> This is a consumer desktop platform, so if some kind of IPMI
> functionality is really present in the hardware then it is not really
> going to be relevant for the ordinary user. So it should be fine to
> just ignore the hardware as you have done.
>
> Thanks
> Daniel
