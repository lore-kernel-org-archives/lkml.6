Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D53C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BB82151D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MilgTRXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BB82151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeHOORT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:17:19 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:44711 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHOORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:17:18 -0400
Received: by mail-qt0-f172.google.com with SMTP id b15-v6so722060qtp.11;
        Wed, 15 Aug 2018 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5SA3mLXAZaUbdpp81/3UadvNg2+8uG9MEHThL1J1JtI=;
        b=MilgTRXWPstfBpA/dY3BTcFRMtu2WrM70QGUDAJM8mnZgNrqYjbtrb4wXQlWdmfUDc
         S6RBAhzqjrGDWRj4AadX8uvKVP9GBNj8aiAkqmFt0UDKyhN1MDPeidoL5jY5eip6qJnD
         sKjhEb0WXBrXddvq50GVxmuCJ0wVnjcID/J1i+cxH0iU9IxleaTskYUXczaD18EEpRQB
         pTejmv2e2/T07A4SGspTt4f3zCpWfmNRFdAcqUx62Zujp2S9ipAkVt96BS+zgOEgMbym
         MlcWMrUeR7cYMaLE7v8p0YcXCGEGD4JvHDLiAn7DYZt3Lu51tTG32cmSPskdpgp66/cF
         f3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5SA3mLXAZaUbdpp81/3UadvNg2+8uG9MEHThL1J1JtI=;
        b=VgyRDRNdu3Xii9VL2CDy12KGJL2oIGULSVYrp4anUQI9qvRNlzhWc0EHdHIRxrKcQR
         C87EyTbmKTcBXW/iir0BKAP5zJ3oZEa2M1si7jQZhZwqE3sZqXNan4lDL6+xVtOzJCyk
         oUTOB70MTIK30ZyjPR6pd3u5dbmAF5hTe5i41EPn3QnfikQzR1b1gX7yx/8Blxn/6ByZ
         /zcOOQVtLGAq+5noEnmoHCx9AAlSMo8/XbZKc+bhkrIkiz6Q9SynquUiMXRLR2vrEV49
         D8vTlj9gkp5aQO92SnOkc1ESISxnyunY4uTXopFUdeyCvK5LbSxG6+r/iJbtRR/kVqtT
         1HGQ==
X-Gm-Message-State: AOUpUlEe/CanmSrPj9L8IE2mcQsiD9wKKJ6BOsvtXwJwhm9JX6jSey4d
        8uet4SX9y1Orh46um0dqLiVC39sj
X-Google-Smtp-Source: AA+uWPyLi03ibQGH2Ru4ei8/Hh7m8bKuJKY3hCC0bSXPRSF5Nxx5r7qkFL+x2y8jzocBSylRVzzWuw==
X-Received: by 2002:a0c:9d0b:: with SMTP id m11-v6mr22109770qvf.228.1534332330717;
        Wed, 15 Aug 2018 04:25:30 -0700 (PDT)
Received: from [191.9.206.254] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id n24-v6sm17109344qkh.39.2018.08.15.04.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 04:25:29 -0700 (PDT)
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
 <057b6600-0fef-4067-54ca-216b591d43f8@gmail.com>
 <9531d57f-2271-7eb8-b734-dac6d33f0ec1@suse.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <3896e121-0f68-6773-fd3e-921d89756349@gmail.com>
Date:   Wed, 15 Aug 2018 07:25:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9531d57f-2271-7eb8-b734-dac6d33f0ec1@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-14 03:41, Hannes Reinecke wrote:
> On 08/13/2018 09:29 PM, Austin S. Hemmelgarn wrote:
>> On 2018-08-13 15:20, Hannes Reinecke wrote:
>>> On 08/13/2018 08:42 PM, David Sterba wrote:
>>>> On Fri, Aug 10, 2018 at 03:04:33AM +0900, Naohiro Aota wrote:
>>>>> This series adds zoned block device support to btrfs.
>>>>
>>>> Yay, thanks!
>>>>
> [ .. ]
>>>> Device replace is disabled, but the changlog suggests there's a way to
>>>> make it work, so it's a matter of implementation. And this should be
>>>> implemented at the time of merge.
>>>>
>>> How would a device replace work in general?
>>> While I do understand that device replace is possible with RAID
>>> thingies, I somewhat fail to see how could do a device replacement
>>> without RAID functionality.
>>> Is it even possible?
>>> If so, how would it be different from a simple umount?
>> Device replace is implemented in largely the same manner as most other
>> live data migration tools (for example, LVM2's pvmove command).
>>
>> In short, when you issue a replace command for a given device, all
>> writes that would go to that device are instead sent to the new device.
>> While this is happening, old data is copied over from the old device to
>> the new one.  Once all the data is copied, the old device is released
>> (and it's BTRFS signature wiped), and the new device has it's device ID
>> updated to that of the old device.
>>
>> This is possible largely because of the COW infrastructure, but it's
>> implemented in a way that doesn't entirely depend on it (otherwise it
>> wouldn't work for NOCOW files).
>>
>> Handling this on zoned devices is not likely to be easy though, you
>> would functionally have to freeze I/O that would hit the device being
>> replaced so that you don't accidentally write to a sequential zone out
>> of order.
> 
> Ah. Oh. Hmm.
> 
> It would be possible in principle if we freeze accesses to any partially
> filled zones on the original device. Then all new writes will be going
> into new/empty zones on the new disks, and we can copy over the old data
> with no issue at all.
> We end up with some partially filled zones on the new disk, but they
> really should be cleaned up eventually either by the allocator filling
> up the partially filled zones or once garbage collection clears out
> stale zones.
> 
> However, I fear the required changes to the btrfs allocator are beyond
> my btrfs knowledge :-(
The easy short term solution is to just disallow the replace command 
(with the intent of getting it working in the future), but ensure that 
the older style add/remove method works.  That uses the balance code 
internally, so it should honor any restrictions on block placement for 
the new device, and therefore should be pretty easy to get working.

