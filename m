Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeBVOIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:08:24 -0500
Received: from a8-57.smtp-out.amazonses.com ([54.240.8.57]:48376 "EHLO
        a8-57.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932564AbeBVOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:08:23 -0500
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
To: Marco Martin <notmart@gmail.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
Date: Thu, 22 Feb 2018 14:08:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1628582.nV6hDClBbL@phobos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.02.22-54.240.8.57
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 05:21 AM, Marco Martin wrote:
> On giovedì 22 febbraio 2018 06:14:07 CET Jeremy Cline wrote:
>> Hey folks,
>>
>> Commit 30323fb6d552c41997baca5292bf7001366cab57 (Support tablet mode
>> switch) causes the keyboard on my XPS 13 to stop working. This
>> particular model has a touch screen (which I've disabled in the BIOS),
>> but isn't a 2-in-1 with a tablet mode. My guess is it's being put in
>> tablet mode and that's disabling the keyboard? In any case, I'm happy
>> to test fixes and provide any necessary information.
> 
> 30323fb6d552c41997baca5292bf7001366cab57 initializes the switch to the correct 
> state, in theory, it seems VGBS() is returning the wrong thing? could it 
> report it has the switch and in a closed state even if it doesn't have it?
>  also seems device specific, on my inspiron6352 if i go in teblet mode the 
> keyboard keeps working until i fold it completely (which i don't know/don't 
> think is something detectable at all from the software side)
> 
> can you test with the command evtest (if an external keyboard works, or via 
> ssh)?, then looking at the state of the intel virtual button driver it should 
> show you the current state of the switch
> 

Hi,

Here's the evtest output for the virtual button driver:

Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
Input device name: "Intel Virtual Button driver"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 116 (KEY_POWER)
    Event code 125 (KEY_LEFTMETA)
    Event code 240 (KEY_UNKNOWN)
    Event code 561 (?)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 5 (EV_SW)
    Event code 1 (SW_TABLET_MODE) state 1
Properties:
Testing ... (interrupt to exit)


Regards,
Jeremy
