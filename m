Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeCFQkX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:40:23 -0500
Received: from mx.exactcode.de ([144.76.154.42]:47664 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbeCFQkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:40:22 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] k10temp support for AMD Ryzen w/ Vega gfx
From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
In-Reply-To: <4938bed8-e612-959a-1b72-29dba0839ceb@roeck-us.net>
Date: Tue, 6 Mar 2018 17:40:14 +0100
Cc: linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        linux-kernel@vger.kernel.org
Message-Id: <E3F75B2B-434E-4BBB-952C-9A31A00A363A@exactcode.de>
References: <1769691A-DD1D-4641-B7BA-62C1BA571EBF@exactcode.de> <20180305230350.GA13099@roeck-us.net> <E39517F8-AEF1-444D-BA90-DE84CF656D7F@exactcode.de> <4938bed8-e612-959a-1b72-29dba0839ceb@roeck-us.net>
X-Mailer: Apple Mail (2.1878.6)
X-Spam-Score: 0.3 (/)
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w26GeTeO031564

Hi,

On 06 Mar 2018, at 11:06, Guenter Roeck <linux@roeck-us.net> wrote:

> On 03/05/2018 10:48 PM, René Rebe wrote:
>> Hi,
>> On 06 Mar 2018, at 00:03, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>>> On Mon, Mar 05, 2018 at 11:38:24PM +0100, René Rebe wrote:
>>>> Hi,
>>>> 
>>>> This enables k10temp for the new AMD Ryzen APUs w/ Vega Mobile Gfx.
>>>> Tested on Ryzen 5 2500U, the temperature looked plausible.
>>>> 
>>>>  Signed-off-by: René Rebe <rene@exactcode.de <mailto:rene@exactcode.de>>
>>>> 
>>>> PS: 1st RFC - might get white-space damaged, will resend when ACKed.
>>>> Sorry my Xemacs/Mew broke.
>>>> 
>>>> --- linux-4.15/drivers/hwmon/k10temp.c.vanilla2018-03-05 22:22:30.974331180 +0000
>>>> +++ linux-4.15/drivers/hwmon/k10temp.c2018-03-05 22:24:17.186327291 +0000
>>>> @@ -40,6 +40,10 @@
>>>> #define PCI_DEVICE_ID_AMD_17H_DF_F30x1463
>>>> #endif
>>>> 
>>>> +#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
>>>> +#define PCI_DEVICE_ID_AMD_17H_RR_NB0x15d0
>>>> +#endif
>>>> +
>>>> /* CPUID function 0x80000001, ebx */
>>>> #define CPUID_PKGTYPE_MASK0xf0000000
>>>> #define CPUID_PKGTYPE_F0x00000000
>>>> @@ -89,6 +93,8 @@
>>>> { 0x17, "AMD Ryzen Threadripper 1950", 10000 },
>>>> { 0x17, "AMD Ryzen Threadripper 1920", 10000 },
>>>> { 0x17, "AMD Ryzen Threadripper 1910", 10000 },
>>>> +{ 0x17, "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx", 20000 },
>>>> +{ 0x17, "AMD Ryzen 7 2700U with Radeon Vega Mobile Gfx", 20000 },
>>> 
>>> Do you have a confirmation that the temperature offset is correct ?
>> I tried all of the three currently used offsets and this was looked the most plausible.
>> For me having some indication of temperature is better than having none at all.
>> Maybe some contact at AMD can shed some light on it, too?
> 
> Per the information I got (not from AMD), those CPUs are not supposed to have an offset.
> 
> Does the system have a Super-IO chip ? If so, what temperature does it report ?
> Also, what temperatures do you see with 0 offset ?

hm, interesting – as other Ryzens were marked with this offsets I did not imagine the mobile ones would have none, …

Without offset it would mean the ideapad 720s would idle after fresh boot in a (really) cold room at a little over 40°C.
The machine does not feel that warm, but maybe it is under the heatsink (my boot w/ full-disk encryption takes a bit)?

Should I resend the patch without the offsets as baseline for other users to test? Without the chipset PCI ID it obviously currently does not match on those new mobile machines, ...

	René

-- 
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de
