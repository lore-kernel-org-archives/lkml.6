Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21217C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54462150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TURqnKhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54462150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeHBO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:56:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43886 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbeHBO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:56:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17-v6so1153094pgv.10;
        Thu, 02 Aug 2018 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtff0t8fNWhEV5RBXQy++phGHsZ3Pg+Wkrub5g63zhA=;
        b=TURqnKhpHezKZ2M80FzEBZlz6TJrov7c4NrDM+eg+qyTp1Ri+2P6suQY8d/OgJVvsd
         mjU6seESeMavICPl3KDEtyyKL3SlA2eLOs9mNjtF28VErX/jz2KJ4dLztjYL28HnNMkI
         pY0hTEr5hLKF5O8j/dyeTKmiRif9XdJ0KCYFgYva6IdWoi7df8KcCyheiBbSDMg9E5vM
         QqgkYDMAQ3xWPHUREbHVzEHWvAKOSBHDe7vfoxSBfDPou0BuyVUPdlQxkzX5/Dnj1Qqn
         HLgtsYGhoRaQi8iO+G/5/RwihM8/SfTCSK/Dwzk3JKNHIyJUHrsK0dGrQLJMVBtdwQTM
         4FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtff0t8fNWhEV5RBXQy++phGHsZ3Pg+Wkrub5g63zhA=;
        b=Pyx5Xy1ZmTRtU+6GyyAzT0ZJtP/us1y8OSFGY01KWyRxjxzQp2RxKIAoOYMDqImo8+
         xml3tfFt36ogwXxinO1OZ51fbMOZ0b6Gb0mYfeV8SEt49p5FwhDIFVIFD/VFIcc+M0Qo
         O5U5Qwgv36BHhXuSg1jdqsG52ecBs8HE2qeZRI7OaSxcDp4walboDObYNmsXxOvKKqvZ
         vlZ2hXNOoRedMS6I+EPqVKtSsqOgz5yjQARuzrc+NVBoeMuAiMR2IOs5esobpAnonbFB
         w4nkOGqYeAUcDsA0OnPVviTlsRmBRx00ycGzGZKqgYMG5jsUO5aaxSRrlfkD5EumYMu9
         ul5A==
X-Gm-Message-State: AOUpUlFg6x+mJmGUKkv6sv0uDvc349EQGr6u/tZ+WaIjhFAGoO05hxOh
        QoVn9unoHlqVvFsWEYUITaI=
X-Google-Smtp-Source: AAOMgpeRNp8eFaYg6qXpFkAVlWdtsxOAn2eBGKsmZhuIQ+quBFqxY0fjC3tsOLPqOrmaNxIfOgYCIA==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr2905084pfa.197.1533215118642;
        Thu, 02 Aug 2018 06:05:18 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t76-v6sm3685127pfe.109.2018.08.02.06.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:05:17 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     Ming Lei <tom.leiming@gmail.com>, linux-ide@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com>
 <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
 <CACVXFVMT7UwWHPQ6K-eNWZJOoZ77==Ki7zmX5UtDz4ZQFFB0Jw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a10a509a-7e5c-1706-52ee-79849cad4224@roeck-us.net>
Date:   Thu, 2 Aug 2018 06:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMT7UwWHPQ6K-eNWZJOoZ77==Ki7zmX5UtDz4ZQFFB0Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 04:35 AM, Ming Lei wrote:
> On Thu, Aug 2, 2018 at 12:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 08/01/2018 05:03 PM, James Bottomley wrote:
>>>
>>> On Thu, 2018-08-02 at 07:57 +0800, Ming Lei wrote:
>>>>
>>>> On Thu, Aug 2, 2018 at 7:47 AM, Guenter Roeck <linux@roeck-us.net>
>>>> wrote:
>>>>>
>>>>> On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
>>>>>>
>>>>>> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
>>>>>>>
>>>>>>> On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> Changes since 20180731:
>>>>>>>>
>>>>>>>> The pci tree gained a conflict against the pci-current tree.
>>>>>>>>
>>>>>>>> The net-next tree gained a conflict against the bpf tree.
>>>>>>>>
>>>>>>>> The block tree lost its build failure.
>>>>>>>>
>>>>>>>> The staging tree still had its build failure due to an
>>>>>>>> interaction
>>>>>>>> with
>>>>>>>> the vfs tree for which I disabled CONFIG_EROFS_FS.
>>>>>>>>
>>>>>>>> The kspp tree lost its build failure.
>>>>>>>>
>>>>>>>> Non-merge commits (relative to Linus' tree): 10070
>>>>>>>>    9137 files changed, 417605 insertions(+), 179996 deletions(-
>>>>>>>> )
>>>>>>>>
>>>>>>>> -----------------------------------------------------------
>>>>>>>> ------
>>>>>>>> -----------
>>>>>>>>
>>>>>>>
>>>>>>> The widespread kernel hang issues are still seen. I managed
>>>>>>> to bisect it after working around the transient build failures.
>>>>>>> Bisect log is attached below. Unfortunately, it doesn't help
>>>>>>> much.
>>>>>>> The culprit is reported as:
>>>>>>>
>>>>>>> 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
>>>>>>>
>>>>>>> The preceding merge,
>>>>>>>
>>>>>>> 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
>>>>>>>
>>>>>>> checks out fine, as does the tip of scsi-next (commit
>>>>>>> 103c7b7e0184,
>>>>>>> "Merge branch 'misc' into for-next"). No idea how to proceed.
>>>>>>
>>>>>>
>>>>>> This sounds like you may have a problem with this patch:
>>>>>>
>>>>>>       commit d5038a13eca72fb216c07eb717169092e92284f1
>>>>>>        Author: Johannes Thumshirn <jthumshirn@suse.de>
>>>>>>        Date:   Wed Jul 4 10:53:56 2018 +0200
>>>>>>
>>>>>>            scsi: core: switch to scsi-mq by default
>>>>>>
>>>>>> To verify, boot with the additional kernel parameter
>>>>>>
>>>>>> scsi_mod.use_blk_mq=0
>>>>>>
>>>>>> Which will reverse the effect of the above patch.
>>>>>>
>>>>>
>>>>> Yes, that fixes the problem.
>>>>
>>>>
>>>> That may not the root cause, given this issue is only started to
>>>> see from next-20180731, but d5038a13eca7 (scsi: core: switch to
>>>> scsi-mq by default)
>>>> has been in -next for quite a while.
>>>>
>>>> Seems something new causes this issue.
>>>
>>>
>>> Read my other email about how to find this.
>>>
>>> https://marc.info/?l=linux-scsi&m=153316446223676
>>>
>>> Now that we've confirmed the issue, Gunter, could you attempt to bisect
>>> it as that email describes?
>>>
>>
>> So, I am more and more baffled.
>>
>> I ran another round of bisect, this time each test executing twice,
>> once with "scsi_mod.use_blk_mq=1" and once with "scsi_mod.use_blk_mq=0",
>> requiring both to pass. Bisect still points to the merge as culprit.
>>
>> Ok, one step further: Actually _revert_ commit d5038a13eca72 before running
>> each test, meaning the default is use_blk_mq=0. Still run both tests.
>> Bisect _still_ points to the merge of scsi-next as culprit.
>>
>> So, to me it looks like the problem is triggered by _something_ in
>> scsi-next, combined with _something_ in -next prior to the merge,
>> not specifically associated with use_blk_mq=[0|1] or d5038a13eca72,
>> but to a combination of some patch in scsi-next and some other patch.
> 
> Today I am a bit busy, and not trace it much.
> 
> So far, I found the code hangs in scsi_test_unit_ready()
> <-get_capabilities()<-sr_probe(), and scsi_queue_rq()/ata_scsi_queuecmd()
> has queued the command successfully, but never completed.
> 
> Also tried to revert commits merged to ata tree on 30th, 31th,
> but no difference.
> 

Looking at my commit logs, the problem started to happen after various DMA
changes were introduced. The boot tests fail on ppc (few), mips (all 32 bit,
most 64 bit), i386 (all), x86_64 (most). All other platform pass, even with
the same type of boot tests. Here is an example from alpha:

Building alpha:defconfig:initrd ... running .... passed
Building alpha:defconfig:sata:rootfs ... running ..... passed
Building alpha:defconfig:usb:rootfs ... running ..... passed
Building alpha:defconfig:usb-uas:rootfs ... running ...... passed
Building alpha:defconfig:scsi[AM53C974]:rootfs ... running ....... passed
Building alpha:defconfig:scsi[DC395]:rootfs ... running ....... passed
Building alpha:defconfig:scsi[MEGASAS]:rootfs ... running ...... passed
Building alpha:defconfig:scsi[MEGASAS2]:rootfs ... running ...... passed
Building alpha:defconfig:scsi[FUSION]:rootfs ... running ...... passed
Building alpha:defconfig:nvme:rootfs ... running ..... passed

arm64:

Building arm64:virt:defconfig:smp:initrd ... running ..... passed
Building arm64:virt:defconfig:smp:usb:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:usb-uas:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:virtio:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:nvme:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:mmc:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:scsi[DC395]:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:scsi[AM53C974]:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:scsi[MEGASAS]:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:scsi[MEGASAS2]:rootfs ... running ..... passed
Building arm64:virt:defconfig:smp:scsi[53C810]:rootfs ... running ...... passed
Building arm64:virt:defconfig:smp:scsi[53C895A]:rootfs ... running ...... passed
Building arm64:virt:defconfig:smp:scsi[FUSION]:rootfs ... running ...... passed
Skipping arm64:xlnx-zcu102:defconfig:smp:initrd:xilinx/zynqmp-ep108 ...
Skipping arm64:xlnx-zcu102:defconfig:smp:sd:rootfs:xilinx/zynqmp-ep108 ...
Skipping arm64:xlnx-zcu102:defconfig:smp:sata:rootfs:xilinx/zynqmp-ep108 ...
Building arm64:xlnx-zcu102:defconfig:smp:initrd:xilinx/zynqmp-zcu102-rev1.0 ... running ....... passed
Building arm64:xlnx-zcu102:defconfig:smp:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 ... running ......... passed
Building arm64:xlnx-zcu102:defconfig:smp:sata:rootfs:xilinx/zynqmp-zcu102-rev1.0 ... running ...... passed
Building arm64:raspi3:defconfig:smp:initrd:broadcom/bcm2837-rpi-3-b ... running ..... passed
Building arm64:raspi3:defconfig:smp:sd:rootfs:broadcom/bcm2837-rpi-3-b ... running ........ passed
Building arm64:virt:defconfig:nosmp:initrd ... running ..... passed
Skipping arm64:xlnx-zcu102:defconfig:nosmp:initrd:xilinx/zynqmp-ep108 ...
Skipping arm64:xlnx-zcu102:defconfig:nosmp:sd:rootfs:xilinx/zynqmp-ep108 ...
Building arm64:xlnx-zcu102:defconfig:nosmp:initrd:xilinx/zynqmp-zcu102-rev1.0 ... running ......... passed
Building arm64:xlnx-zcu102:defconfig:nosmp:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 ... running ......... passed

ppc:

Building powerpc:mac99:qemu_ppc_book3s_defconfig:nosmp:rootfs ... running ....... passed
Building powerpc:g3beige:qemu_ppc_book3s_defconfig:nosmp:rootfs ... running ...... passed
Building powerpc:mac99:qemu_ppc_book3s_defconfig:smp:rootfs ... running ....... passed
Building powerpc:virtex-ml507:44x/virtex5_defconfig:devtmpfs:initrd ... running .... passed
Building powerpc:mpc8544ds:mpc85xx_defconfig:initrd ... running .... passed
Building powerpc:mpc8544ds:mpc85xx_defconfig:scsi:rootfs ... running ..... passed
Building powerpc:mpc8544ds:mpc85xx_defconfig:sata:rootfs ... running .... passed
Building powerpc:mpc8544ds:mpc85xx_smp_defconfig:initrd ... running .... passed
Building powerpc:mpc8544ds:mpc85xx_smp_defconfig:scsi:rootfs ... running ..... passed
Building powerpc:mpc8544ds:mpc85xx_smp_defconfig:sata:rootfs ... running .... passed
Building powerpc:bamboo:44x/bamboo_defconfig:devtmpfs:initrd ... running .... passed
Building powerpc:bamboo:44x/bamboo_defconfig:devtmpfs:scsi[AM53C974]:rootfs ... running ..... passed
Building powerpc:bamboo:44x/bamboo_defconfig:devtmpfs:smp:initrd ... running .... passed
Building powerpc:bamboo:44x/bamboo_defconfig:devtmpfs:smp:scsi[AM53C974]:rootfs ... running ..... passed
Building powerpc:sam460ex:44x/canyonlands_defconfig:devtmpfs:initrd ... running ..... passed
Building powerpc:sam460ex:44x/canyonlands_defconfig:devtmpfs:usbdisk:rootfs ... running ...... passed
Building powerpc:mac99:pmac32_defconfig:devtmpfs:zilog:initrd ... running .................................. failed (timeout)
Building powerpc:mac99:pmac32_defconfig:devtmpfs:zilog:rootfs ... running .................................. failed (timeout)

Maybe that is a coincidence, but it is at least suspicious.

Guenter
