Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6AEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4582721779
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBqLaAzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4582721779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeHMWMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:12:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38191 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:12:45 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so15930630iog.5;
        Mon, 13 Aug 2018 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8PswDkxctpmWOCpOD2kpH/TTc+ortzH8PFSfvvTPhTk=;
        b=WBqLaAzwH4fTvcABhVHxYqwXeBnKC4Yc27fsjJiNGY9pR5iDLW/m0M0TOJcMsVd+9h
         ctUwCIivfv98fXiS36hgr5ZAf84eT0iM7k062hofNS2i8FeoIGVu+yoGoLoB7P5vGDzK
         DzXZk4FiBVBYRJ09PCpBm6Le3oTwd/dviCPSZrCkiSaRnhoJygJTgmMrlPFrzP71z7TR
         qWoSFO7Ao+vwD/65jJX1UZI8DA0d/NVEI7gGnlvRczEdWwWrWrf7rAsNZQf+uuLawFew
         04hofFWHaVFm84JxNT/H7IfvFoPiQy8qDCb7N1hy8sZ4yk5EAjmlt1ANkFZNtYKxAvTW
         Zb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PswDkxctpmWOCpOD2kpH/TTc+ortzH8PFSfvvTPhTk=;
        b=jJttbSfmh78/5vSNUaca3R/XEyK0Aq/nwI+Xp89xKnC4fJO+wuJiHeSYmY6u1e1jMN
         Hdx6ZftIQMzS1NSbSkOn4EkvNRVdD6ZOzvM9wY4uriivoviVkGrM1qqNhBfDxnbChL7v
         qIHm6a6Xkn5YTk8YUuT7wcOPtX6X49gXN/b4ggk8THL0l+Qpq8rZwbNf6duwfaPGmG/s
         aOq+T754K/C639g02QXzLiIcsxRc+lYyOtBzlDdAipoG3JBaGPiTaXBeRZ6QspwVyv12
         3GoV6cTpfALT+X/RjM0XdM+Lz4RzTpAhVSmLTHNMNK8ZQnobRom5qrEdRLU8e7mIekT0
         xtSg==
X-Gm-Message-State: AOUpUlEsxQ2rZ7Vjf7ZBKrvvCh2GaJ/OjBT5GWTOoeX0T27n29Iz0XOr
        CEAxH31M0aFNEOCcHGqqBHA=
X-Google-Smtp-Source: AA+uWPz4J3pzeiteKfKZNIxVdCspDJuZD6RM3QdiP6RIEMzeL8REbmYAlY1UDEgZdsBGMoFZpGS+HA==
X-Received: by 2002:a6b:b845:: with SMTP id i66-v6mr14979773iof.142.1534188548942;
        Mon, 13 Aug 2018 12:29:08 -0700 (PDT)
Received: from [191.9.206.254] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id h123-v6sm5334347itb.32.2018.08.13.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:29:07 -0700 (PDT)
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
To:     Hannes Reinecke <hare@suse.com>, dsterba@suse.cz,
        Naohiro Aota <naota@elisp.net>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180813184251.GC24025@twin.jikos.cz>
 <86bddb14-104e-182b-29a1-6ab8150f09a8@suse.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <057b6600-0fef-4067-54ca-216b591d43f8@gmail.com>
Date:   Mon, 13 Aug 2018 15:29:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86bddb14-104e-182b-29a1-6ab8150f09a8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-13 15:20, Hannes Reinecke wrote:
> On 08/13/2018 08:42 PM, David Sterba wrote:
>> On Fri, Aug 10, 2018 at 03:04:33AM +0900, Naohiro Aota wrote:
>>> This series adds zoned block device support to btrfs.
>>
>> Yay, thanks!
>>
>> As this a RFC, I'll give you some. The code looks ok for what it claims
>> to do, I'll skip style and unimportant implementation details for now as
>> there are bigger questions.
>>
>> The zoned devices bring some constraints so not all filesystem features
>> cannot be expected to work, so this rules out any form of in-place
>> updates like NODATACOW.
>>
>> Then there's list of 'how will zoned device work with feature X'?
>>
>> You disable fallocate and DIO. I haven't looked closer at the fallocate
>> case, but DIO could work in the sense that open() will open the file but
>> any write will fallback to buffered writes. This is implemented so it
>> would need to be wired together.
>>
>> Mixed device types are not allowed, and I tend to agree with that,
>> though this could work in principle.  Just that the chunk allocator
>> would have to be aware of the device types and tweaked to allocate from
>> the same group. The btrfs code is not ready for that in terms of the
>> allocator capabilities and configuration options.
>>
>> Device replace is disabled, but the changlog suggests there's a way to
>> make it work, so it's a matter of implementation. And this should be
>> implemented at the time of merge.
>>
> How would a device replace work in general?
> While I do understand that device replace is possible with RAID 
> thingies, I somewhat fail to see how could do a device replacement 
> without RAID functionality.
> Is it even possible?
> If so, how would it be different from a simple umount?
Device replace is implemented in largely the same manner as most other 
live data migration tools (for example, LVM2's pvmove command).

In short, when you issue a replace command for a given device, all 
writes that would go to that device are instead sent to the new device. 
While this is happening, old data is copied over from the old device to 
the new one.  Once all the data is copied, the old device is released 
(and it's BTRFS signature wiped), and the new device has it's device ID 
updated to that of the old device.

This is possible largely because of the COW infrastructure, but it's 
implemented in a way that doesn't entirely depend on it (otherwise it 
wouldn't work for NOCOW files).

Handling this on zoned devices is not likely to be easy though, you 
would functionally have to freeze I/O that would hit the device being 
replaced so that you don't accidentally write to a sequential zone out 
of order.
> 
>> RAID5/6 + zoned support is highly desired and lack of it could be
>> considered a NAK for the whole series. The drive sizes are expected to
>> be several terabytes, that sounds be too risky to lack the redundancy
>> options (RAID1 is not sufficient here).
>>
> That really depends on the allocator.
> If we can make the RAID code to work with zone-sized stripes it should 
> be pretty trivial. I can have a look at that; RAID support was on my 
> agenda anyway (albeit for MD, not for btrfs).
> 
>> The changelog does not explain why this does not or cannot work, so I
>> cannot reason about that or possibly suggest workarounds or solutions.
>> But I think it should work in principle.
>>
> As mentioned, it really should work for zone-sized stripes. I'm not sure 
> we can make it to work with stripes less than zone sizes.
> 
>> As this is first post and RFC I don't expect that everything is
>> implemented, but at least the known missing points should be documented.
>> You've implemented lots of the low-level zoned support and extent
>> allocation, so even if the raid56 might be difficult, it should be the
>> smaller part.
>>
> FYI, I've run a simple stress-test on a zoned device (git clone linus && 
> make) and haven't found any issue with those; compilation ran without a 
> problem, and with quite decent speed.
> Good job!
> 
> Cheers,
> 
> Hannes

