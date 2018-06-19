Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F4CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FF8205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AaDW45vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FF8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966654AbeFSP0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:26:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40195 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966193AbeFSP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:26:21 -0400
Received: by mail-io0-f194.google.com with SMTP id g22-v6so569377iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+AN6OXTeeiWDsnSatDOdeTRQctw5c5oYbkYQIb93IU=;
        b=AaDW45vXnMDACHyom8sTTd0jROPnAlqMl7b41+exjRjhKf5xE1s1D5IdhPXOmMmQW1
         LR52kKQIiaYenP7i7CeKMcClZi+lI13pccmkN6pj5Sj2PCr1eSPZ9I5Jq2xom3b+hS56
         VNvW6z0wEYx17Ndaa42jfsLZO1eA69RZmf3BZlN/vjMkOrpHdszRTeL75bKUiUI8lfgQ
         UKKv+1ToaGCq6eIccMkVpKVIrI+9FcCvpW4C1LPnSq8aeHCNtHjAAJKPcDNvETQqduXT
         nEhPG57fB58FTMs2E6PrnfPYdpKskUCQGr8pXUR4LdPeOIRB2f0CAdOkI9dCgOzinkfi
         +aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+AN6OXTeeiWDsnSatDOdeTRQctw5c5oYbkYQIb93IU=;
        b=ojazRDpYGcl9bDWPWlLL0fZK1CODJHGiz9orD11JAe04GSrKp5xIwwlQ8ETcPf5zCC
         8drhJbWkFBa3nwGsYgsDHWrH9QuoGp5lv4cxTDN/Tyk4C98lw0CTe2fItlwPLu2N4N2e
         HV2YqSidthOf+50ak9HwvwISuVCVLcr6JpP9EwNsxED2jObHzxPVvAV3NxyMf2tmRzq/
         RQwgJPCDoIsK2KQyn6DTs9VC0qa0pfeaKmjO/p3FVoIkzotkubmo+eaySOfQBKDL2z4R
         dMXyxgbSzgOq4flQviD7W/T214W2tYgHrtfbEsDXB5AW1If6POM+sPKFZEnaq+7G1tOy
         9UvA==
X-Gm-Message-State: APt69E01VEmnloMBW1q+p8kILL1EUsDTzeUiscHj3XLiUas4zaSuQwf1
        JyAbq3D1Lj2UNU+9pLm0K3uUUA==
X-Google-Smtp-Source: ADUXVKK3p6vamkUX/r+OkZ9JXdpC+xnK3fskxE9X86QzyOS8vyAJKfIaq4wCLcz4wwAyuS3rx9QpXQ==
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr14602494iog.238.1529421980480;
        Tue, 19 Jun 2018 08:26:20 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c102-v6sm5738675itd.3.2018.06.19.08.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:26:18 -0700 (PDT)
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
Message-ID: <21c94bb3-f2d6-535d-f9fe-399e7919c59c@kernel.dk>
Date:   Tue, 19 Jun 2018 09:26:17 -0600
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

Can you try the below patch, on both 4.17 and on current -git? Might
help shed some light on this. The fsl driver does weird stuff with
the internal tag, I'm guessing that's related.


diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b8d9cfc60374..9bac5ba36dac 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -28,6 +28,9 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#undef DPRINTK
+#define DPRINTK printk
+
 static unsigned int intr_coalescing_count;
 module_param(intr_coalescing_count, int, S_IRUGO);
 MODULE_PARM_DESC(intr_coalescing_count,
@@ -318,7 +321,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
 
 	DPRINTK("interrupt coalescing, count = 0x%x, ticks = %x\n",
 			intr_coalescing_count, intr_coalescing_ticks);
-	DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
+	DPRINTK("ICC register status: (hcr base: 0x%p) = 0x%x\n",
 			hcr_base, ioread32(hcr_base + ICC));
 }
 
@@ -1479,7 +1482,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	}
 
 	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
-	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
+	DPRINTK("sizeof(cmd_desc) = %d\n", (int) sizeof(struct command_desc));
 	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
 
 	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);

-- 
Jens Axboe

