Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030834AbeBNO35 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:29:57 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:38858 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030429AbeBNO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:29:56 -0500
X-Google-Smtp-Source: AH8x224I3pdJ8GOVuGm7RFJH5rEFrs8wMzPSWBAfDg+O0+aEFhRtvooWwZTYd+HfjQmQpyECyPwRJ3NpE2aGFT6dUkA=
MIME-Version: 1.0
In-Reply-To: <20180214142809.GT27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-19-mika.westerberg@linux.intel.com> <CAHp75VcwWDTFnBcLotrABvWhT7a=-Z-vue8nB6hko1BaSqKQPQ@mail.gmail.com>
 <20180214142809.GT27191@lahna.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 16:29:54 +0200
Message-ID: <CAHp75Vf+2z9-osrsFuuQqbOGsoBYQ9TV=0aN0VP8RS-=xDh1mw@mail.gmail.com>
Subject: Re: [PATCH 18/18] thunderbolt: Add support for Intel Titan Ridge
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 4:28 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Feb 14, 2018 at 04:23:44PM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:

>> > +static inline u64 get_parent_route(u64 route)
>> > +{
>> > +       int depth = tb_route_length(route);
>> > +       return depth ? route & ~((u64)0xff << (depth - 1) * TB_ROUTE_SHIFT) : 0;
>>
>> 0xffULL ?

Agreed or not?

>> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI        0x15dc
>> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI   0x15dd
>> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI 0x15de
>>
>> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI         0x15e8
>> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE      0x15e7
>> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI         0x15eb
>> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE      0x15ea
>> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE      0x15ef
>>
>> Can we keep it sorted?
>
> It is sorted by the controller type ;-)

Yes, this is not what I'm talking about. Inside the group you can
easily keep it sorted.

-- 
With Best Regards,
Andy Shevchenko
