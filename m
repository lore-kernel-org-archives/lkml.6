Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeDKFma (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:42:30 -0400
Received: from mout.web.de ([212.227.15.4]:48941 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbeDKFm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:42:27 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
 <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de>
Date: Wed, 11 Apr 2018 07:42:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1pU0CxBj+3190oZE/kz6+rQN/otjf10IN8z5XyB34eEw+TgFb5w
 mg3WAOK8nqfEhIX9TeY2eHAe+8bCEx6bypR1j1Z/xJYACI+n6JfV6+Uy9D66SoeiLZKzgEg
 /qUgLOCHC+qJrOCqVS2BUOPpJSKTIZPrWcaG1ncSGlJg+QMMq805fh+JkV58ZwVj6vQqbSc
 vxz/Yoj+LDXIVtQUvcxww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AXzh/XGHGlI=:DV1BpMtc/X9G89ZisleC8I
 dSNTM0lWvy2gzYPFK+UTSaLAAHVomcUPxrnIt9AKIZsAv5SQVyqrW6WBLC604VIs3Ww7Ws1R4
 SoQ2/AmWoAE5Adzt61IoNrU/xcrkKdYDxRosRI655/Z3JOJk0+pVgiTyZ1Bwnd/S6NzISV4dG
 bneupV61CCslEpW3jD43/acSewI4CTrD0H6eFI2j48CF51vOuURA5QrlijZyQd0s9YqM8u0qP
 h4M+Jg4FaFrKUJ8wFIuwKRBXlnYNwGFKARYAWbkeDFeaXn/ItcqIlAPjKC+ONspvaiChlTWb4
 IJ9zRZMlIptHRN6tXPx0gGGcvmuTX2TKjQJ9WLoll9pwGCEyw7xFIOdoGV/wEP8NYxfKikSHy
 h123C2bnlosnBRXMDnsnU4PCNj6hZSjkmBeOEqDSrdnGsn7nfDdkNorDQiqnFeeEfb2EceUCr
 vkSGBdYR705at1zZgMSSpNL3DHoAF4dkdyKv+rpItYU89wTFE3a4bim/E2gx8Lr/3Bb4UN4OJ
 oAA1RLSeZBXCC29iP0WSZScZ/No+oLuT8uoLOQoMeOBH67JsW1VtbzkDgLiG+YT3zdeJUvh+u
 /s/XdUBiLGXbSQ9hUpF36aub6PAE4xHKwcv+wwg4dirWZnquWSC9/IUdf1BDnjUslix0nPyhp
 O9c7zSIdQWQXq/V2QVwC3rpy5Uj7Nf31vVna/h3/pqsp5BbwiqgHS3+qDJ8Fkn5AVhs+6H0pW
 0OqepNS6ILeROM7xHwIP5MXeuPMUmtnY9IwnSUAcx2RLl6seCe5RLpfnjBXyroyGNem2syza8
 s4l0wzqEcDWtAiqwKNJx64VOrq2Cl/HuWSdl449pJ+qaAz5m8M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 23:12, Rob Herring wrote:
> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 04/05/18 12:13, Jan Kiszka wrote:
>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>> Hi Jan,
>>>>
>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>> Hi Frank,
>>>>>
>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>
>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>
>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>> original FDT.
>>>>>>
>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>
>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>> errors.
>>>>>>
>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>> overlay loader.
>>>>>
>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>> created from a a template but modified prior to application to account
>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>
>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>
>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>> understand the use case and consider solutions.
>>>>
>>>> If you can make the changes directly on the FDT instead of on the
>>>> expanded devicetree, then you could move to the new API.
>>>
>>> Are there some examples/references on how to edit FDTs in-place in the
>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>
>> I don't know of any existing in-kernel edits of the FDT (but they might
>> exist).  The functions to access an FDT are in libfdt, which is in
>> scripts/dtc/libfdt/.
> 
> Let's please not go down that route of doing FDT modifications. There
> is little reason to other than for early boot changes. And it is much
> easier to work on unflattened trees.

I just briefly looked into libfdt, and it would have meant building it
into the module as there are no library functions exported by the kernel
either. Another reason to drop that.

What's apparently working now is the pattern I initially suggested:
Register template with status = "disabled" as overlay, then prepare and
apply changeset that contains all needed modifications and sets the
status to "ok". I might be leaking additional resources, but to find
that out, I will now finally have to resolve clean unbinding of the
generic PCI host controller [1] first.

Thanks,
Jan

[1] http://lkml.iu.edu/hypermail/linux/kernel/1606.3/00072.html
