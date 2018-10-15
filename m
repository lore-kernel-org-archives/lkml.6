Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CFD2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ikXfwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CFD2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJPB4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:56:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45769 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:56:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so9677342plr.12;
        Mon, 15 Oct 2018 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgNzcXSE3VovdIBrnHgZsjxTfG62YSLhfS1xeIL9JRI=;
        b=Y0ikXfwc5bOt/n2Fk5wKYdZtjgPgsckAiLNlrEHHocKi1PSFx6RshXK2h056S84PuB
         mhdanChSlxNVhcdTCMtX27ThsPoCOM/5ubvk8ptWZLzVLgQow5B3Uv89Pq1N9NkYI4D1
         5cqe60/2rEt4kIHRxXzAU95Ni2JgQbB+sPoQE1Az1OoOUKhMu1Pv7PrGfiGqKjl+tgQW
         ZhF1vC5K1FeewHhflvt6Derbvg+Itu6h4XIbLCfZPUEPsyW0aM5VxYXluDvLAojE4acm
         Vmrlxnn4TXtIJmCXO4dC4ac+SxHPT+OzGsjKDqsUuqtv6g9Qtc8+TECP56YsF8s2YGwZ
         XHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgNzcXSE3VovdIBrnHgZsjxTfG62YSLhfS1xeIL9JRI=;
        b=Xn5aojN37QDnwo7gpzF/dvGquLwGTFEnspLRxXcflqgWMcX6468m2uv2KcPxxJpVeV
         RFSeW8/BgNXiyRcVcAmeU/xNZV8HXHdKGIyXzA8jwFppu69H2fM7a91Qi69IZm2mJcci
         t0Hw3G4Y1XQo1sW+fpZXwUe3KlHfrLspLR0gaB8NL7mLHLWIZVTCDU0qMvz9Z75HM/Q0
         tn1JicC+Jgq8cVcYeOD2PX+s2Y8yjrga8JjNXuK6QCSoTm3k+dHcUuHYL4MVpAJUhtnz
         Gg3lA4UjKjKAABJwe3UbkaR2CetPZ8laspsN9EmcOW/Gwx22DXKGJG78SMSNlfi2vfnX
         8sBQ==
X-Gm-Message-State: ABuFfoiIyNx0C0BTKuhkrnJHrIbnOitwIhMX66HE7H5G3M+FqQAD9GN0
        ruYmuTUgPcuta9sxqjcdI8w=
X-Google-Smtp-Source: ACcGV61iEPICuZKQGK7GcNa1xCIH5/W0mPvh/9o7vQAwTOnw4e9tQi2vsk0gdNoXW2LT1d4htXosBA==
X-Received: by 2002:a17:902:b092:: with SMTP id p18-v6mr17226982plr.124.1539626992584;
        Mon, 15 Oct 2018 11:09:52 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 3-v6sm13402036pga.12.2018.10.15.11.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 11:09:51 -0700 (PDT)
Subject: Re: [PATCH] of: overlay: user space synchronization
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
References: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e69685d5-e09f-5f7d-2ff0-7ead12500371@gmail.com>
Date:   Mon, 15 Oct 2018 11:09:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 01:24, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Mon, Oct 15, 2018 at 3:36 AM <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> When an overlay is applied or removed, the live devicetree visible in
>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>> changes.  There is no method for user space to determine whether the
>> live devicetree was modified by overlay actions.
>>
>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>> user space to determine if the live devicetree has remained unchanged
>> while a series of one or more accesses of /proc/device-tree/ occur.
> 
> Thanks for your patch!
> 
>> The use of both dynamic devicetree modifications and overlay apply and
>> removal are not supported during the same boot cycle.  Thus non-overlay
>> dynamic modifications are not reflected in the value of tree_version.
> 
> What does this mean exactly, for users?
> I am used to applying and removing overlays at run time (still
> carrying Pantelis'
> overlay configfs patches), but when would I use non-overlay dynamic
> modifications?

To find some examples, 'git grep of_add_property'.  (This is not a
comprehensive list, there are other similar functions.)

Some Powerpc systems use dynamic modifications of device trees, for
example adding and removing cpus.

Kexec uses dynamic modifications just before booting a new
kernel (so no interference with overlays).  Devicetree
unittest uses it, with no interference with overlays.

There are also a few places platform code or a driver uses dynamic
modification.  Possible conflicts with overlays are:
   arch/arm/mach-mvebu/coherency.c
   arch/arm/mach-omap2/timer.c

rcar_du_of.c is a known use that is grandfathered in.  It currently
is not compatible with overlays.

drivers/macintosh/smu.c should not be an issue because I don't
expect any macintosh overlay.

Some of the reasons for not supporting both overlays and other
dynamic modifications on the same system might be possible to
resolve with additional code, but some might be difficult or
impossible to resolve.  So that restriction might be loosened
or removed in the future.  Some of the reasons are:

  - dynamic modifications do not use the same locking mechanism
    as overlay apply and removal, thus the devicetree could be
    corrupted

  - dynamic modifications of portions of the devicetree that
    are the result of applying an overlay will (may?) cause
    removal of the overlay to fail (or devicetree corruption?)

  - (future concern: ) static validation of an overlay (or set
    of overlays) against a specific base devicetree would not
    be valid if the base devicetree is further modified by
    dynamic modifications - this is theoretical since validation
    is a currently under development feature and we do not know
    what the final feature will look like

The plan for overlays has been to add specific use models (or
functionality or features) in a limited fashion initially, to
ensure that each feature is implemented to a sufficient degree
(in other words is not a hack that only works in limited
circumstances, such as the correct phase of the moon), works
robustly and is maintainable.  Then as each feature or set
of features is found to be good enough, add more features.

I suspect that dynamic modification in general will remain not
compatible with overlays, with limited exceptions.  Possible
exceptions would require stringent review and auditing, and
could incude devicetree unittest (even this one makes me
nervous) and some platform code (especially early boot code).


>> --- a/Documentation/ABI/testing/sysfs-firmware-ofw
>> +++ b/Documentation/ABI/testing/sysfs-firmware-ofw
>>
>> +What:          /sys/firmware/devicetree/tree_version
>> +Date:          October 2018
>> +KernelVersion: 4.20
>> +Contact:       Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
>> +Description:
>> +               When an overlay is applied or removed, the live devicetree
>> +               visible in /proc/device-tree/, aka
>> +               /sys/firmware/devicetree/base/, reflects the changes.
>> +
>> +               tree_version provides a way for user space to determine if the
>> +               live devicetree has remained unchanged while a series of one
>> +               or more accesses of /proc/device-tree/ occur.
>> +
>> +               The use of both dynamic devicetree modifications and overlay
>> +               apply and removal are not supported during the same boot
>> +               cycle.  Thus non-overlay dynamic modifications are not
>> +               reflected in the value of tree_version.
>> +
>> +               Example shell use of tree_version:
>> +
>> +               done=1
>> +
>> +               while [ $done = 1 ] ; do
>> +
>> +                  pre_version=$(cat /sys/firmware/devicetree/tree_version)
>> +                  version=$pre_version
>> +                  while [ $(( ${version} & 1 )) != 0 ] ; do
>> +                     # echo is optional, sleep value can be tuned
>> +                     echo "${version}  sleeping"
>> +                     sleep 2;
>> +                     pre_version=$(cat /sys/firmware/devicetree/tree_version)
>> +                     version=${pre_version}
>> +                  done
>> +
>> +                  # 'critical region'
>> +                  # access /proc/device-tree/ one or more times
>> +
>> +                  post_version=$(cat /sys/firmware/devicetree/tree_version)
>> +
>> +                  if [ ${post_version} = ${pre_version} ] ; then
>> +                     done=0
>> +                  fi
>> +
>> +               done
> 
> Please say explicitly that tree_version contains a 32-bit unsigned
> decimal number, which is incremented before and after every change.
> I had to deduce that from the code.

Good point.  I'll add that.


> 
> IMHO that is more important than having the sample script here.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

