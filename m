Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeEQJFo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:05:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52269 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeEQJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:05:40 -0400
X-Google-Smtp-Source: AB8JxZpAm8fh5Sl6BQJueGdDCMZsxIHi6TTGvUWafRYAIK2ujldmglyi2X2nCxXgg3DRdLEvUtQT+ENaGZbHAiegCUo=
MIME-Version: 1.0
In-Reply-To: <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
 <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com> <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
 <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
 <c1343704-6b1a-14b5-3942-a8a33f73feee@linux.intel.com> <CAB4CAwe6kjJ10s0KtVJrPMSC8UA+YLCiqbnkZ_-oFTKTFPTwCw@mail.gmail.com>
 <7728da79-8a7a-b87d-d09c-b36978b3032e@linux.intel.com> <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 17 May 2018 17:05:38 +0800
Message-ID: <CAB4CAwdEYJncAxD30UxbFcdz57+AoJnda_L9X3kR6vs=z-dmdQ@mail.gmail.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 3:48 PM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> Hi
>
> On 05/15/2018 01:20 PM, Jarkko Nikula wrote:
>>
>> On 05/15/2018 06:22 AM, Chris Chiu wrote:
>>>
>>> What if I change the 120MHz to 180MHz and then make sure that the I2C
>>> operates
>>> in target FS mode frequency 400kHz via scope? Would there be any side
>>> effect?
>>> Maybe some other busses frequency could be also affected and causing some
>>> other
>>> component malfunction?
>>>
>> Should be safe. It is only clock rate information when registering a fixed
>> clock with known rate in intel-lpss.c and i2c-designware uses that info when
>> calculating the timing parameters. I.e. it doesn't change any internal
>> clocks.
>>
>> I'm trying to find a contact who can confirm what is the expected rate of
>> I2C input clock and is it common to all Cannon Lake HW.
>>
> I got confirmation that input clock is actually even higher 216 Mhz.
>
> While checking does it cover all of those CNL CNL-LP and CNL-H PCI IDs may I
> add your Jian-Hong, Chris and Daniel email addresses to Repored-by tags in a
> fix patch?
>
> --
> Jarkko

No problem. Thanks
