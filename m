Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDETil (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:38:41 -0400
Received: from mout.web.de ([212.227.17.12]:57197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbeDETij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:38:39 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
 <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <255dffbd-4ff1-42a4-033b-311d49339102@web.de>
Date: Thu, 5 Apr 2018 21:38:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wfMDJEwlO2M0XByY+Du3Zi1ffrM3agH0TgolPgwcoM7ecwFEkEu
 yCbgjqYMyBNK4CPFttHpAAEEdJc/U/wCsvG2edzlbUBaZ/sc0LU8+0zCjceJcWzCi5yLDii
 8ZRtA8N//4SM3SNJ/eftTr9Dwpz7ize5lKaAHcBoKk4KXk+wK42+36iNreqAxVLME9nTB3u
 cR6F1vqTI4RQ/gRKaRjIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FSHnvk9S5Bk=:ymKuzdCV/R48qbXcqsfiq+
 d11GecqdEiDC2iOtT8UfzCxdGgUmdkbeZK5rIVvOfxiXPUIFyP72KWzqi3nrfMGBF2SNt7h4v
 1Oz4n6z9auH2+bNiPPVzzB9rrwBxeJFPxIyHnwNXjUooQLyBx0Rw4ZSdbmtaN78HWotuct1XQ
 VJrAxB7VSn4lJqEZ/l3vRxyEypAj2muyQHNVdMM7RwcWDR7cx1FVOPJAlOSM7/n/OXeLPXqzc
 ePa0671geC80FVl+jzAw1XS0zRx+S1y/VpUlgCnpyXrUOtjlSTDJaBKKCe4VPbZLjozBJ0Ppd
 VpLDxIRDSrkmJ852vIqEuJmEBDYdtJ3GJoY0pdu0iop5HMdb1KXyOK5UAru+0n0179xenIwI5
 bmVXnaz3rd/Rv/Fgyt8zqaYdTzW7/wnzx/1+Sc+KqN/0s7MeoJDU5fjI87wztRi7hdtGXkxRi
 z+HxdUk41Rz73flCoXrKQwZRyeRf2m5KD1d9f3agCBBVYDGB434tIHKlFKRXSlj3BRoNfLDJR
 0WnrX37eUpKSzmaRWRATvENnHwZUaM6fokRtyufeL/8wvKM3QrEOiU5FtxtLvXJ22sqX1SfJr
 9pwiolN1AOh3X3OzqzMHd/4cOnX7sVBfDq49AEnqwSTA/YNCzYYzkFgUSHo9jWGn3BXYvALLZ
 cArK2H5bfIzyXzD24pjW7HTYsOuwCxTP108yw7rxt3fYk2wewTTW07lULO+zCwNF9v7OTj5jY
 Sv3tuKBTsyPAoh7mDBzhIOlPuGpFxjBii7Bm0fgPi0xlhfgXdTfW3hIZAF5YRvRdWucV62cjm
 w8b0SQmF2dFIl6BipZyhdT+LPeHjFfpbW5YwF8egqkUFwGqYPI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 21:28, Frank Rowand wrote:
> On 04/05/18 12:13, Jan Kiszka wrote:
>> On 2018-04-05 20:59, Frank Rowand wrote:
>>> Hi Jan,
>>>
>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>> Hi Frank,
>>>>
>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>
>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>> original FDT.
>>>>>
>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>
>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>> or the unflattened devicetree, which could result in use after free
>>>>> errors.
>>>>>
>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>> overlay loader.
>>>>
>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>> device during hypervisor activation with Linux. The DT overlay is
>>>> created from a a template but modified prior to application to account
>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>
>>>> I'm now wondering how to model that scenario best with the new API.
>>>> Given that the loader lost ownership of the unflattened tree but the
>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>> clear solution. Should we apply the template in disabled form (status =
>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>
>>> Thank you for the pointer to the driver - that makes it much easier to
>>> understand the use case and consider solutions.
>>>
>>> If you can make the changes directly on the FDT instead of on the
>>> expanded devicetree, then you could move to the new API.
>>
>> Are there some examples/references on how to edit FDTs in-place in the
>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
> 
> I don't know of any existing in-kernel edits of the FDT (but they might
> exist).  The functions to access an FDT are in libfdt, which is in
> scripts/dtc/libfdt/.
> 

Ah, libfdt is available for kernel drivers as well. That looks like a
viable path on first sight. I'll try that and come back in case it does
not solve all issues.

> 
>>>
>>> Looking at the driver, I see one potential issue with that approach.
>>> The property "interrupt-map" is added directly to the changeset
>>> instead of being an existing property in the overlay.  Is it possible
>>> to have this property in the overlay when needed?
>>
>> Well, the size of that property has a runtime dependency on the gic's
>> #address-cells. If that is easy to account for depends a bit on the
>> available FDT manipulation services. Or it would take multiple templates
>> to handle the different cases (0, 1, or 2 IIRC).
> 
> If I understand create_vpci_of_overlay() correctly, it is assuming a
> fixed size of 4 cells.  Line 314 is: for (n = 0, cell = 0; n < 4; n++) {
> 
> Off the top of my head, it is theoretically possible to create a property
> that can contain the largest possible size for the property, then shrink
> the size by inserting NOPs at the end of the property to shrink it.

Well, I even find fdt_appendprop which sounds like we could keep adding
that property on the fly.

How does memory management work with libfdt? Do I have to ensure that
the fdt is already backed by an area large enough also for it modified form?

Thanks,
Jan
