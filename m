Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFAMcK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:32:10 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:54914 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeFAMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:32:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,465,1520899200";
   d="scan'208";a="681272211"
From: "Sironi, Filippo" <sironi@amazon.de>
To: Borislav Petkov <bp@alien8.de>
CC: "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_info instead of
 boot_cpu_data
Thread-Topic: [PATCH] x86/MCE: Get microcode revision from cpu_info instead of
 boot_cpu_data
Thread-Index: AQHT+Zv+wHTY51FtbEioMg+BTihN/6RLUmeAgAADcwA=
Date: Fri, 1 Jun 2018 12:32:02 +0000
Message-ID: <56E0BDAC-816A-4F72-A4C6-2747F4A8AA67@amazon.de>
References: <1527852626-7258-1-git-send-email-sironi@amazon.de>
 <20180601121939.GA23298@nazgul.tnic>
In-Reply-To: <20180601121939.GA23298@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.110]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B39A8A2B7449F48B175AFD2B118D309@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51CWEx5032455

> On 1. Jun 2018, at 14:19, Borislav Petkov <bp@alien8.de> wrote:
> 
> On Fri, Jun 01, 2018 at 01:30:26PM +0200, Filippo Sironi wrote:
>> Commit fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check
>> records") extended MCE entries to report the microcode revision taken
>> from boot_cpu_data. Unfortunately, boot_cpu_data isn't updated on late
>> microcode loading,
> 
> Actually, I'd prefer if we fixed *that* instead by adding:
> 
> 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> 	if (c->cpu_index == boot_cpu_data.cpu_index)
> 		boot_cpu_data.microcode = <new rev>;
> 
> to the end of ->apply_microcode() functions so that boot_cpu_data has
> the correct revision too, in case something else queries it.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>    Boris.
> 
> ECO tip #101: Trim your mails when you reply.
> --

I've that patch in my tree already, I can post it.
I'm still curious on why you'd prefer to use boot_cpu_data for all
CPUs instead of using cpu_data(m->extcpu) though.

Regards,
Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
