Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDEHW2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:22:28 -0400
Received: from mout.web.de ([217.72.192.78]:37403 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDEHWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:22:24 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <CAL_Jsq+Gu=gwcxJnOF2xybXCh9N2Fp1NV05kuvQ2rif1fdHYrA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <935d6135-c5db-e5f8-b850-8ef26ce0c0a0@web.de>
Date: Thu, 5 Apr 2018 09:22:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Gu=gwcxJnOF2xybXCh9N2Fp1NV05kuvQ2rif1fdHYrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6VVad5ccTS1OPpB6ZgvmFMvPOdoIePbGcrtEY4cV97soRp6VykV
 fSzFSTxrYQy04xnIWbFtlUjvq4Dk+i+4L/Zb7XiCuinsrq+PaKajJGpWaXhKdSFPTbllFbQ
 DbDZ3jllWRw7X8D7t9xGRBzloILENTcFTEizgfe5ZXkEsbtEqRrIZr6sYquIBudAzAS/SdB
 awwRsLvmVBhMXNrsxjLRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Go8sDhqdBmo=:Au63ZbBNJDnhPswRzY+KUs
 ZIqMIYf4cHSWh5Rs8zJfVkd7Rn6Eme26sZqUkNpLK+XWljdAcPNgkQUbMOcXbWrrIOFLy6qxk
 MUBXyQqn/6NRygFuzb9an6J9q7XcSWXDVX+DWBVheGg1YvoMm+WYM8iV0Hk/kDzGRDr8X4Z4L
 Udtse+0hTCpTbv1w+S/1d4bWhbsVVslSvMwJTi2gYaBWq1DCTUvK+Pmgw9UJRT95sSL2JglSq
 eAtyp3KHGfVqpSuFNnEvqTGUcWRyMl5RheR45l+YaFXvSvgCh1uLsEPP8EYMCq+FG6A5k1w2K
 YGhybFkfFDOphh//nMexPRHx2hN7qQH8YiKqIZwfJhxMoo1anXgNgc3wDap6RSGNR/JwmLgt1
 QoBbZLGidATs7F2rW54suySCScaqGnPWYFQuBCoxrVs8qT4bZ+jbtjbx/DhdesGYM0+NIgDTk
 hl3j+YvRr5e85K5jmEP/lrvVaLLI2s7mFaALdqhRWR20fkDWs7Xq1r/aiGUnNCaQPczzGtLx/
 7t5SrMWNn/pASvqCVjfM9Q/KGEV/qQe/2ks/CUvjqJs6/ZmUS10O4BBkmTAAtUhz3vpjH7kdA
 Qrrb4i3pUysE9JabE9IwNzxHtk1wc9RdcUpwHpWBP1hKEmHCyeBMS2zTLu6l3h/lsEJ6f/ZnR
 ZBAJcnHzzxhwNtCbrLSzwfPRq6h249XWFAfNRReC8D1OykPSHQLDiA6yej0aGx0GsMmCftHNO
 5W9Sj+DPIG25l4HOeIiPPGTa6cz6QGs53+T90tWMf6Q/f+hEhTD40P7yKCdNVkBtzMxHNV/bk
 EnhHJDCcWguZYbReVFwY7YkolxHbw/DTL6EWu9mymX1PTa9BTo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 02:55, Rob Herring wrote:
> On Wed, Apr 4, 2018 at 5:35 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> Hi Frank,
>>
>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Move duplicating and unflattening of an overlay flattened devicetree
>>> (FDT) into the overlay application code.  To accomplish this,
>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>
>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>> original FDT.
>>>
>>> The unflattened devicetree now belongs to devicetree code, which is
>>> thus responsible for freeing the unflattened devicetree.
>>>
>>> These ownership changes prevent early freeing of the duplicated FDT
>>> or the unflattened devicetree, which could result in use after free
>>> errors.
>>>
>>> of_overlay_fdt_apply() is a private function for the anticipated
>>> overlay loader.
>>
>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>> device during hypervisor activation with Linux. The DT overlay is
>> created from a a template but modified prior to application to account
>> for runtime-specific parameters. See [1] for the current implementation.
>>
>> I'm now wondering how to model that scenario best with the new API.
>> Given that the loader lost ownership of the unflattened tree but the
>> modification API exist only for the that DT state, I'm not yet seeing a
>> clear solution. Should we apply the template in disabled form (status =
>> "disabled"), modify it, and then activate it while it is already applied?
> 
> No. I don't think that will work.
> 
> The of_overlay_apply() function is still there, but static. We can
> export it again if the need arises.

That would be the simplest solution from our perspective, but I'm not
sure if that is in the original spirit of this change.

> 
> Another option is there is a notifier callback OF_OVERLAY_PRE_APPLY,
> but I'm not sure we want to make that be the normal interface to make
> modifications.

And would calling modification functions from that callback be legal at all?

Jan
