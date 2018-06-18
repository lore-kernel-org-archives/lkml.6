Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA520693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ydZ+sMOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FA520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936290AbeFRVrC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:47:02 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37993 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935628AbeFRVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:46:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id d5-v6so16273323oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVXZ7CZ/bWGmBh6DyVT+v/aFAdKbgAAGTXYr8dhqAto=;
        b=ydZ+sMOftQWOco/wEfvcvF+vFeseEzRSJjvF5CQ4sY8vpHu5ag3plcVebnIfhbEi9v
         3ZBO3x5HGjJBAgtzuBUezBnDSm1EPf3LvEpS7z4zQ1Ru+0kYg4ubRvvXj6w4CjJZTpe4
         Qx0I2iUtgjKHUbFtTyt4yk8SX9UFCk6EXhp6j1536UJeYNMEOU46CuC3hy9rf+A1TCwA
         r+XUjSS1ZQ1oASfHGwFGwv48XMtk9RqdDbDOcMhneR11kYw3fPPlET+ExZoG/NAIiCgk
         WoketFTZQOhcdVIBj/cIhyoz2NqnvDBv/YNTSuLU/Bh6K45J7AzY+X2AH463e46NpRDt
         mnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVXZ7CZ/bWGmBh6DyVT+v/aFAdKbgAAGTXYr8dhqAto=;
        b=medfMT8nZNxTMHAV912LZrzD2icJ8IZ+f7JSWwrAxMni1DCeqG2Mgb3PbBk0MsCvCc
         0G1tv5Zo6mHDGkDzzJ0WzG/w5T8vs2pKelulHF3JV8eTrekr8yi8YQQ+dVFSXLWQhQgu
         UZEDJHTOCH39jlxofKwpLSdhepbzHuxH3M/Rl+ikUwH9zfWX7mw/qElBrdTpXgyIh0Va
         RqisNhk92XM/n1yTN5CLCxrwr9NadNJDsMS8CNq2bRiPB+GJJL4jS8hHgIxQ1jUpazzC
         zkDj4z2FuE1YEHCH7dQyS+5MK0r9/D+OrNmJ0JxoFyb+05jVM6huWUNKgRCP+0AvegRy
         J5YA==
X-Gm-Message-State: APt69E0XZK0lUM4wDD0HJr5sdHOpzO2+CqAcUrxUsbRq39Xgm2XFsNM2
        MUFV/HZlQgvXT9pWPtXR1JjIE4dxOZxeP0wB+5xwCw==
X-Google-Smtp-Source: ADUXVKKzCrbuj3pJmpTkrzAGCgWm5ZY+1F0CwvCFB29c64ja+vyibn+U61Nwenfv8ZJZpr2FNCPOJFRmD868SDHOEyA=
X-Received: by 2002:aca:ab15:: with SMTP id u21-v6mr8285573oie.272.1529358419292;
 Mon, 18 Jun 2018 14:46:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 14:46:58
 -0700 (PDT)
In-Reply-To: <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com> <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com> <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 14:46:58 -0700
Message-ID: <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI 6.1
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Li, Juston" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 2:37 PM, Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>
>> -----Original Message-----
>> From: Dan Williams [mailto:dan.j.williams@intel.com]
>> Sent: Monday, June 18, 2018 2:47 PM
>> To: Kani, Toshi <toshi.kani@hpe.com>
>> Cc: linux-kernel@vger.kernel.org; linux-nvdimm@lists.01.org; Moore, Robert
>> <robert.moore@intel.com>; Li, Juston <juston.li@intel.com>;
>> rjw@rjwysocki.net; linux-acpi@vger.kernel.org; Elliott, Robert (Persistent
>> Memory) <elliott@hpe.com>
>> Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with
>> ACPI 6.1
>>
>> On Mon, Jun 18, 2018 at 12:39 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>> > On Mon, 2018-06-18 at 12:01 -0700, Dan Williams wrote:
>> >> On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani@hpe.com> wrote:
>> >> >
>> >> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
>> >> > as follows.
>> >> >  - Valid Fields, Manufacturing Location, and Manufacturing Date
>> >> >    are added from reserved range.  No change in the structure size.
>> >> >  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
>> >> >    format).  The spec clarifies that they need to be represented
>> >> >    as arrays of bytes as well.
>> >> >
>> >>
>> >> Circling back on this a couple years too late... where are you reading
>> >> this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
>> >> says that vendor id is stored LSB of the id is stored at the lowest
>> >> byte in SPD, which is little endian. So it seems Linux has showing the
>> >> incorrect value for a long time now.
>> >
>> > This follows ACPI 6.2a section 5.2.25.10 NVDIMM Representation Format,
>> > which Robert cited in his comment below:
>> > https://patchwork.kernel.org/patch/10237609/
>>
>> Right, the representation format has the fields big-endian for some
>> reason, but the individual values for sysfs should be show
>> little-endian as far as I can see. What am I missing?
>
> In practice, the serial numbers from three major DDR4 DIMM manufacturers
> are being assigned as big-endian, like in this set of NVDIMM-Ns:
> /sys/bus/nd/devices/nmem0/nfit/serial:0x122f8255
> /sys/bus/nd/devices/nmem1/nfit/serial:0x122f7f5e
> /sys/bus/nd/devices/nmem2/nfit/serial:0x122f818f
> /sys/bus/nd/devices/nmem3/nfit/serial:0x122f821c
> /sys/bus/nd/devices/nmem4/nfit/serial:0x122f817e
> /sys/bus/nd/devices/nmem5/nfit/serial:0x122f81cd
> /sys/bus/nd/devices/nmem6/nfit/serial:0x122f821e
> /sys/bus/nd/devices/nmem7/nfit/serial:0x122f819b
> /sys/bus/nd/devices/nmem8/nfit/serial:0x122f81a2
> /sys/bus/nd/devices/nmem9/nfit/serial:0x122f8198
> /sys/bus/nd/devices/nmem10/nfit/serial:0x122f8193
> /sys/bus/nd/devices/nmem11/nfit/serial:0x122f7f58
> /sys/bus/nd/devices/nmem12/nfit/serial:0x122f81cb
> /sys/bus/nd/devices/nmem13/nfit/serial:0x122f8181
> /sys/bus/nd/devices/nmem14/nfit/serial:0x122f8210
> /sys/bus/nd/devices/nmem15/nfit/serial:0x122f821f
>
> and this set of regular DIMMs:
> 396851B4
> 3968134C
> 396852DA
> 396850AB
> 39685A13
> 39685317
> 396852DD
> 396852D9

Let's take something simple like Vendor ID. What is the Vendor ID for
these DIMMs and what does Linux print in sysfs?

> Of the possible approaches for the sysfs nfit field decodes:
> fixed big-endian:
>   matches printed label content (text and barcode)
>   matches ACPI display advice for management tools
>   probably matches SMBIOS Serial Number string format (although
>     that depends on the system firmware)
>   requires user to know that this OS uses big-endian
>   has been upstream for a while now
> fixed little-endian:
>   harder to see that cd812f12 matches 122f81cd seen elsewhere
>   harder to notice that B4516839 is a peer of 4C136839
>   might match other little-endian-only OSes
>   requires user to know that this OS uses little-endian
> native endian:
>   most confusing
>   config/status files referencing the DIMMs are not portable
>   requires user to know that this OS uses native endianness
>   requires user to know the CPU endianness
>   was upstream several years ago

The time upstream is painful, but if Linux is needlessly swizzling the
bits this needs to be fixed.
