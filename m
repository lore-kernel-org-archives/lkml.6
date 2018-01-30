Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeA3PkC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:40:02 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37023 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeA3PkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:40:00 -0500
X-Google-Smtp-Source: AH8x226z5Ir4b2AkSnRtlp2SB/92mhF2ymGQeeASpVR89spGC+gHBCUE1923vhfXW2ZdfbPGTeFVdtjwvzEyIMjBTeE=
MIME-Version: 1.0
In-Reply-To: <30071dd5d1574ef9bf85eb34fda1277f@ausx13mpc120.AMER.DELL.COM>
References: <1517267756-29878-1-git-send-email-mario.limonciello@dell.com>
 <20180130110247.5w4qreycdp2o5pjw@pali> <30071dd5d1574ef9bf85eb34fda1277f@ausx13mpc120.AMER.DELL.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 17:39:58 +0200
Message-ID: <CAHp75Vd4N2DNpnFgE-k85Kz7_sZ=SH=-L8sagLkFx=WMj8xW=Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Guard SMBIOS calls with a mutex
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 5:35 PM,  <Mario.Limonciello@dell.com> wrote:

>> >     dell_set_arguments(0x2, 0, 0, 0);
>> >     ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>>
>> Hi! I'm looking at this code, and do we need shared global buffer with
>> mutex protection at all? Is not buffer allocated on stack enough?
>
> Oh you mean rather than create buffer mutex to just remove global
> buffer and allocate in each function?  That seems like a workable
> approach to me too.
>
> I'm fine with either way.
>
> Andy or Darren, what's your preference in this area?

It reminds me USB stuff where buffer for transfer is allocated on heap
before performing communication.
So, it looks similar to some extent and I have no objection on that
kind of approach.

-- 
With Best Regards,
Andy Shevchenko
