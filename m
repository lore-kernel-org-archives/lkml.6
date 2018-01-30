Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeA3PWV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:22:21 -0500
Received: from a8-61.smtp-out.amazonses.com ([54.240.8.61]:35560 "EHLO
        a8-61.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751559AbeA3PWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:22:19 -0500
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <0100016147a95d33-f8348740-cd78-4221-8612-116ef66afc66-000000@email.amazonses.com>
Date: Tue, 30 Jan 2018 15:22:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180128094021.572ab366@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.01.30-54.240.8.61
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/2018 03:40 AM, Jonathan Cameron wrote:
> On Sun, 14 Jan 2018 10:43:30 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 9 Jan 2018 21:24:01 +0000
>> Jeremy Cline <jeremy@jcline.org> wrote:
>>
>>> On 12/10/2017 12:21 PM, Jonathan Cameron wrote:  
>>>> On Wed, 6 Dec 2017 17:52:34 +0000
>>>> Jeremy Cline <jeremy@jcline.org> wrote:
>>>>     
>>>>> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
>>>>> device. Check for a companion device and handle a second i2c_client
>>>>> if it is present.
>>>>>
>>>>> Signed-off-by: Jeremy Cline <jeremy@jcline.org>    
>>>> The requirement for this is still horrible, but you have done a nice
>>>> clean job on implementing it.
>>>>
>>>> I'll let this sit for a few more days though before applying it.
>>>> Probably next weekend if we don't get any feedback before then.    
>>>
>>> Hey,
>>>
>>> I didn't see this land anywhere (I was looking in
>>> git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git, maybe that's not
>>> the right place?) and I just wanted to make sure this didn't get lost in
>>> the holiday shuffle.  
>> It did indeed get lost - thanks for the reminder.  Now applied to the
>> togreg branch of iio.git.  However, unfortunately we may be too near
>> to the merge window opening for it to make it.  Depends on what Linus
>> says later today when rc8 comes out.
> 
> I've added some #ifdef CONFIG_ACPI defenses against the case
> of no ACPI support being compiled in.  Alternative would be to add
> stubs for those functions that don't have them...
> 
> probably just acpi_device_hid.
> 
> But that would take much longer.  Feel free to propose it and a patch
> removing the ifdef fun if you like!

Great, thanks for handling that. I'll look at taking care of the stubs
and whatnot.


Regards,
Jeremy
