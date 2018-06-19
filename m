Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70102C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE36205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DaGH0SZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE36205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966686AbeFSPjY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:39:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35217 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:39:21 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so1031422itd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RMDscp2KSsJuvAFewPX/LbS3nWKvqY4l73j74wga+hk=;
        b=DaGH0SZpt2WMaW7Iope491EuiQJeQ39upendvKArGdAE8NhzM156p5Sp33QBFMPQ97
         AuaiFhYu1Ab5KYG7LtVB9WS/k4VCAicldz71jB7kim5JAiWw26ZzYtE4CJkkIuU+iGon
         KrmnJp9pwg4DzTTN2qoMGMlVSzI39SQbSFFxV75EKeeC1DJG3xcCHD6WQ6cgcZ4ZB4gb
         hDyFdjAl4JkabLfnbS/Ba8XpiNkTY5tRBeuW//H5MVI0MTZ3HfkXk3rUkGiINv7q/OjZ
         tiCeeBQ9krjkRGdR1VgnQ26KQuRQnIaIhZfZ4tf+kUVavoYCLNUoVa2za4iGjO4O7a1b
         enHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RMDscp2KSsJuvAFewPX/LbS3nWKvqY4l73j74wga+hk=;
        b=JCe0iTeYEwVcDWrexHGJ4JBWTAohPA9QsmWmFe/O0mgCMg6V2zOfjt/JMAPZtaYuGY
         xYkphnBuFV6ppZr/cCRpB1d8lEWGXK+1luj8+wLNAOkhoy4AAxG5ciwRHy0uPNdQCmC+
         thihetZ5Is8Zt0a+J91Pq/JJytjQHL1sb7ErTHeStmqdl6w7SQQxas4rmDdUdnYMeTCe
         J6QLf6r9/jNRGK8oxCUzyuopux++5rSr/eukIHs1kfETJaoFV9Nni1bdxxqpeTsyFZw7
         VrR12cWV5UD+XY9tlGz9NTJEV6nt/LX/vP/zvRsS4AMAOo1huhPSwezih9zqqGicQ6JZ
         qaAA==
X-Gm-Message-State: APt69E2y4VakzY8eJxjyRpH9dewKEsiLpskWlWI3Aa9Hk8ts6DnDFi7r
        JyOzinwz7cnczZfhaB5upcMHZw==
X-Google-Smtp-Source: ADUXVKKujUMpMgqpwHwlD2jsuBRFLrd6tKIXjJ0bf5FOvLFSAcHdO1477VYsdHV6oQgZJ4k60oI4GA==
X-Received: by 2002:a24:1344:: with SMTP id 65-v6mr7488000itz.82.1529422761162;
        Tue, 19 Jun 2018 08:39:21 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e18-v6sm146066itf.29.2018.06.19.08.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:39:19 -0700 (PDT)
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
To:     Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
 <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
 <87sh5jxmif.fsf@concordia.ellerman.id.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f82edaa2-4b1a-c747-3d58-ec86ceb4ee7e@kernel.dk>
Date:   Tue, 19 Jun 2018 09:39:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87sh5jxmif.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 1:29 AM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> On 6/18/18 1:33 AM, Michael Ellerman wrote:
>>> Tejun Heo <tj@kernel.org> writes:
>>> ...
>>>> Jens Axboe (10):
>>>>       libata: introduce notion of separate hardware tags
>>>>       libata: convert core and drivers to ->hw_tag usage
>>>>       libata: bump ->qc_active to a 64-bit type
>>>>       libata: use ata_tag_internal() consistently
>>>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>>>       sata_nv: set host can_queue count appropriately
>>>>       libata: add extra internal command
>>>
>>> Replying here because I can't find the original mail.
>>>
>>> The above commit is causing one of my machines to constantly spew ata
>>> messages on the console, according to bisect:
>>>
>>> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
>>>
>>> To get it to boot I have to also apply:
>>>
>>>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
>>>
>>>
>>> The system boots OK and seems fine, except that it's just printing
>>> multiple of these per second:
>>>
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>
>>> And it never seems to stop.
>>>
>>> The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
>>> presumably. Any ideas?
>>
>> Hmm that's odd. Can you include the boot log from a working boot as
>> well? Would be nice to see what devices are on the sata adapter.
>> The above just looks like a hardreset loop.
> 
> Ah yep. I stupidly assumed it was working, because the machine booted,
> but that's because the root disk is on ata1.
> 
> Booting the good kernel:
> 
>   ba80c3a572f4 ("sata_nv: set host can_queue count appropriately")
> 
> I see:
> 
>   root@p5020ds:~# ls -l /sys/class/ata_port/
>   total 0
>   lrwxrwxrwx 1 root root 0 Jun 19 06:49 ata1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/ata_port/ata1
>   lrwxrwxrwx 1 root root 0 Jun 19 17:06 ata2 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/ata_port/ata2
> 
>   root@p5020ds:~# ls -l /sys/class/block/ | grep ata
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda1
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda2 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda2
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda5 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda5
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sr0 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/block/sr0
> 
> So it's the DVD drive.
> 
>   root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat vendor 
>   Optiarc 
>   root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat model
>   DVD RW AD-7260S 
> 
> 
> Full boot log from a good boot attached if that's helpful.
> 
> All of the above looks the same when I boot with the broken setup, it
> just spams dmesg constantly.
> 
> One thing that is different, on the good kernel I see:
> 
>   root@p5020ds:~# mount /dev/sr0 /mnt
>   mount: no medium found on /dev/sr0
> 
> vs bad (88e10092f6a6):
> 
>   root@p5020ds:~# mount /dev/sr0 /mnt
>   mount: /dev/sr0 is already mounted or /mnt busy
> 
> cheers

Actually, just try this one on top of current -git.

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b8d9cfc60374..4007a9ae650d 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -395,12 +395,6 @@ static inline unsigned int sata_fsl_tag(unsigned int tag,
 {
 	/* We let libATA core do actual (queue) tag allocation */
 
-	/* all non NCQ/queued commands should have tag#0 */
-	if (ata_tag_internal(tag)) {
-		DPRINTK("mapping internal cmds to tag#0\n");
-		return 0;
-	}
-
 	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
 		DPRINTK("tag %d invalid : out of range\n", tag);
 		return 0;
@@ -1229,7 +1223,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 
 	/* Workaround for data length mismatch errata */
 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
-		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		for (tag = 0; tag <= ATA_MAX_QUEUE; tag++) {
 			qc = ata_qc_from_tag(ap, tag);
 			if (qc && ata_is_atapi(qc->tf.protocol)) {
 				u32 hcontrol;

-- 
Jens Axboe

