Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeA3Afg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:35:36 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38598 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeA3Afe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:35:34 -0500
X-Google-Smtp-Source: AH8x224gwcrESOUHUqR9jbFqZwz26lmMGw8s3u/tdQm5lgZXd7iW/eI7WPJeiE6cESqO1Csf1H33nQ==
Subject: Re: [PATCH 0/2] of: change overlay apply input data from EDT to FDT
From: Frank Rowand <frowand.list@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1517194414-19932-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdWrhgvLv6syjFxfN42ah7pkO9Ye9SJYDTCwRMQCFrJAeg@mail.gmail.com>
 <df065acc-2479-2513-ac3d-63d065d2ffa1@gmail.com>
Message-ID: <d009592b-ee82-7706-29ff-2749cd0e3c20@gmail.com>
Date: Mon, 29 Jan 2018 16:35:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <df065acc-2479-2513-ac3d-63d065d2ffa1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

In this patch series one of the changes was to change some
devicetree unittest overlay source to use the new sugar syntax to
specify overlay nodes instead of hand coding the fragment nodes.

One reviewer reminded me to update Documentation/ files that
show the hand coding of overlay fragment nodes.  One of those
files is Documentation/devicetree/bindings/fpga/fpga-region.txt.
I plan to submit a patch to update the example devicetree source
to use the sugar syntax.  There is one place where I can not
make that change, which is the "Overlay DTS Format" section.
In this section, the use of 'target-path="/path" is shown as
one of two ways to specify the target of the fragment.  The
sugar syntax creates a fragment using the 'target=<phandle>'
form instead of 'target-path="/path"' form.  With sugar
syntax, there is no way to specify target-path.  Is the
target-path form needed by the fpga subsystem, or can this
be removed?

-Frank

On 01/29/18 16:22, Frank Rowand wrote:
> On 01/29/18 06:08, Geert Uytterhoeven wrote:
>> Hi Frank,
>>
>> On Mon, Jan 29, 2018 at 3:53 AM,  <frowand.list@gmail.com> wrote:
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
>>> The unflattened device tree (aka expanded device tree, EDT) now
>>> belongs to devicetree code, which is thus responsible for freeing
>>> the EDT.
>>>
>>> These ownership changes prevent early freeing of the duplicated FDT
>>> or the EDT, which could result in use after free errors.
>>>
>>> These changes led to migrating some unittest overlay data into
>>> their own devicetree source files, and then converting most of
>>> them to use sugar syntax instead of hand coding fragments.
>>
>> Thanks for your series!
>>
>>> Frank Rowand (2):
>>>   of: change overlay apply input data from EDT to FDT
>>>   of: convert unittest overlay devicetree source to sugar syntax
>>
>> Do you plan to update Documentation/devicetree/overlay-notes.txt
>> and Documentation/devicetree/bindings/fpga/fpga-region.txt, too?
> 
> Thanks for the pointers.
> 
> I will add updates to Documentation/devicetree/overlay-notes.txt in
> this series.
> 
> The changes to Documentation/devicetree/bindings/fpga/fpga-region.txt
> are related to the relatively new sugar syntax in dtc, not to the
> changes introduced by this patch series.  I'll create a patch outside
> this series to update this documentation.
> 
> 
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                 -- Linus Torvalds
>>
> 
> 
