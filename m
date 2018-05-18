Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeERHs2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:48:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34094 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeERHsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:48:25 -0400
X-Google-Smtp-Source: AB8JxZoeo5IbvILMI0zHqDO5Ytv/Fn0DQWJMszh0XrVoTUN8APtpdkA4AvnfbpoJ7UtVUn68aTJWcw==
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>
Cc: Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
 <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
 <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
 <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
 <c1343704-6b1a-14b5-3942-a8a33f73feee@linux.intel.com>
 <CAB4CAwe6kjJ10s0KtVJrPMSC8UA+YLCiqbnkZ_-oFTKTFPTwCw@mail.gmail.com>
 <7728da79-8a7a-b87d-d09c-b36978b3032e@linux.intel.com>
 <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba99be8e-8e8b-87c1-8607-24ace8a01c64@redhat.com>
Date: Fri, 18 May 2018 09:48:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko, et.al.,

On 17-05-18 09:48, Jarkko Nikula wrote:
> Hi
> 
> On 05/15/2018 01:20 PM, Jarkko Nikula wrote:
>> On 05/15/2018 06:22 AM, Chris Chiu wrote:
>>> What if I change the 120MHz to 180MHz and then make sure that the I2C operates
>>> in target FS mode frequency 400kHz via scope? Would there be any side effect?
>>> Maybe some other busses frequency could be also affected and causing some other
>>> component malfunction?
>>>
>> Should be safe. It is only clock rate information when registering a fixed clock with known rate in intel-lpss.c and i2c-designware uses that info when calculating the timing parameters. I.e. it doesn't change any internal clocks.
>>
>> I'm trying to find a contact who can confirm what is the expected rate of I2C input clock and is it common to all Cannon Lake HW.
>>
> I got confirmation that input clock is actually even higher 216 Mhz.
> 
> While checking does it cover all of those CNL CNL-LP and CNL-H PCI IDs may I add your Jian-Hong, Chris and Daniel email addresses to Repored-by tags in a fix patch?

Could it be the i2c input clock definition in drivers/mfd/intel-lpss-pci.c
is also wrong for Apollo Lake (N3450) ?  There are lots of people having
various issues with i2c attached touchpads on Apollo Lake devices, this bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1728244

Is sort of a collection bug for these. Various models laptops, lots of
reporters. Note not sure thie is an i2c-designware issue, but it would
be good to double check the input clock on Apollo Lake.

I've checked the datasheet and the datasheet mentions 133MHz as
"serial input clk" in the lpio_bxt_regs Registers Summary, which is
also part of the LPSS, no clk is mentioned in the "Summary of
DW_apb_i2c_mem_map_DW_apb_i2c_addr_block1 Registers".

Regards,

Hans
