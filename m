Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBZUPa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:15:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeBZUP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:15:29 -0500
Subject: Re: [07/18] thunderbolt: Handle rejected Thunderbolt devices
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
References: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
 <20180222231736.GA628@mini-rhel.redhat.com>
 <20180226102029.GG27191@lahna.fi.intel.com>
 <20180226133802.GR27191@lahna.fi.intel.com>
 <a3eaf2cd-5820-4ef5-a799-d17a3dc84907@redhat.com>
 <20180226194645.GA3774@lahna.fi.intel.com>
From: Jeremy McNicoll <jmcnicol@redhat.com>
Organization: Red Hat
Message-ID: <6560a597-0075-549e-f723-1bc5eb54c7bc@redhat.com>
Date: Mon, 26 Feb 2018 12:15:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226194645.GA3774@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-26 11:46 AM, Mika Westerberg wrote:
> On Mon, Feb 26, 2018 at 11:28:16AM -0800, Jeremy McNicoll wrote:
>> On 2018-02-26 5:38 AM, Mika Westerberg wrote:
>>> On Mon, Feb 26, 2018 at 12:20:29PM +0200, Mika Westerberg wrote:
>>>> On Thu, Feb 22, 2018 at 03:17:38PM -0800, Jeremy McNicoll wrote:
>>>>>> +	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
>>>>>> +		tb_info(tb, "switch at %u.%u was rejected by ICM firmware\n",
>>>>>> +			link, depth);
>>>>>
>>>>> This kind of condition sounds more like an error instead of info.
>>>>> Please bump this up to tb_WARN/tb_warn ideally tb_err().
>>>>
>>>> No, this is not an error.
>>>
>>> To be more clear, it is totally fine to have the firmware to reject some
>>> devices. For example in case of the new usbonly security level the
>>> firmware rejects other devices but the first.
>>>
>>
>> Ok. Is that kind of information available to the kernel?  What security
>> mode we are in?
>>
>> ie) if (LINK_REJECTED && !USB_SECURITY)
>>         print "Error switch %u was rejected since its not usbonly"
>>      endif
>>
>> I am sure something like that simplified pseudo code above would
>> be somewhat useful to users when debugging.
> 
> That's why it is on info level so it goes to dmesg but does not scare
> the user :-)
> 

The point I am trying to make is that it would be nice to be able to
know WHY the link was rejected and not just that it was rejected.
