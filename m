Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4F216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX/ntU/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC4F216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeHOMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:17:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42030 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeHOMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:17:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id 13-v6so322624qkl.9;
        Wed, 15 Aug 2018 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YlQh5KEUZlH1wOAPLr3L2m5sG3QzOxRkvzNtVczaFlE=;
        b=UX/ntU/CqU8SD7ckoRopMvmtGnA6TgkR0Ya0FB16AQsNtHLpPdpdkj6/iTMe3luAeD
         lLtvze/g03UACOMpqfh0ulFQ4D1kJosWeIXarA/VsxghIV57QOqClrYNgSCKALOs6IK5
         4cOmTcSRiaJ9lkHb2i60OZDlDw2gh7Ah+Xs6vIyHTojlv8Sha3/LtEbkQq61Idn4RnU8
         TbE3r2RDZlF+Wt5Gqj6LnflBma3rpqAWfsKq7YZRsGGDGuE3Ds+TPXAC2+YcoOFHxVtu
         pMDzbbndvFwW02r9/H4LfFu49cSqyQixWE6xlh9regQ77tDLxxSQdpqnnEw8jKwDfTCW
         ptTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YlQh5KEUZlH1wOAPLr3L2m5sG3QzOxRkvzNtVczaFlE=;
        b=HH+gyPNBF1ctYYz2FhNrM0N8xp/jGFC0BOJ71Q20Fy4IFCbesQn+aeX+RYQU/ZikL8
         s7FOWvxO6+ueRLCCzP/NK5CvQeahxHeYhFUJUOhycJ9gSyblD7e6C1Y4szLz5KnsVDex
         7fSk9lRArabtF+f0CoW3MNcM//Yuqw/p/wYN8M/u1Qh4iAZWgXgvFxR9ha5FBDKD6wwV
         tkvyg/n+nSWwvOlzEv3fWZIDyfimAkPuIjTFTLljEu/gU3R7CExWests/u+wrxwuXCva
         0sb2XHZ3R057dxaBl5nKzASH1NHet7zieNMdz891hZYrPWXHO9HasouRExa2Czy1GxOg
         +scA==
X-Gm-Message-State: AOUpUlHq8T9qOnuk4sP60V0D56WXxgXkkYnLzfUa4KgPi045cJW0GYCE
        KBHbMxaaarZ7gn3w2Rcfhzz0QPFnqy/2W4MWoo7/NoQZVWY=
X-Google-Smtp-Source: AA+uWPyIc1huTpNzpoUUh1T4DRCoqj6emvlgAaCw4+Y/nBQcSovD0D9Bbom0NZt+UjHEO/5oVAIuS68BA8WuGkKz5As=
X-Received: by 2002:a37:5c44:: with SMTP id q65-v6mr22363140qkb.97.1534325148669;
 Wed, 15 Aug 2018 02:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 02:25:48
 -0700 (PDT)
In-Reply-To: <CAJwJo6aAGS3vB-F889zmDJjtU3xGLd=twbVVC=DydXYufKEwPQ@mail.gmail.com>
References: <1497329993-197698-1-git-send-email-liwei.song@windriver.com> <CAJwJo6aAGS3vB-F889zmDJjtU3xGLd=twbVVC=DydXYufKEwPQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Aug 2018 12:25:48 +0300
Message-ID: <CAHp75VfTzzZoDGaBfnW4NKiU-2Ds6wgQtyUu22mZKwLK2a4rcQ@mail.gmail.com>
Subject: Re: [PATCH V2] i2c: ismt: fix wrong device address when unmap the
 data buffer
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Song liwei <liwei.song@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 5:26 AM, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> +Cc: stable
>
> Hi Greg, JFI:
> This one has hit a couple of times on autotests on v4.9 stable.
> The fix for BUG() is trivial, so probably worth to ship it to v4.9/v4.4/v3.18.
>

JFYI:

commit 17e83549e199d89aace7788a9f11c108671eecf5
Author: Liwei Song <liwei.song@windriver.com>
Date:   Tue Jun 13 00:59:53 2017 -0400

   i2c: ismt: fix wrong device address when unmap the data buffer


> 2017-06-13 5:59 GMT+01:00 Song liwei <liwei.song@windriver.com>:
>> From: Liwei Song <liwei.song@windriver.com>
>>
>> Fix the following kernel bug:
>>
>> kernel BUG at drivers/iommu/intel-iommu.c:3260!
>> invalid opcode: 0000 [#5] PREEMPT SMP
>> Hardware name: Intel Corp. Harcuvar/Server, BIOS HAVLCRB0.X64.0013.D39.1608311820 08/31/2016
>> task: ffff880175389950 ti: ffff880176bec000 task.ti: ffff880176bec000
>> RIP: 0010:[<ffffffff8150a83b>]  [<ffffffff8150a83b>] intel_unmap+0x25b/0x260
>> RSP: 0018:ffff880176bef5e8  EFLAGS: 00010296
>> RAX: 0000000000000024 RBX: ffff8800773c7c88 RCX: 000000000000ce04
>> RDX: 0000000080000000 RSI: 0000000000000000 RDI: 0000000000000009
>> RBP: ffff880176bef638 R08: 0000000000000010 R09: 0000000000000004
>> R10: ffff880175389c78 R11: 0000000000000a4f R12: ffff8800773c7868
>> R13: 00000000ffffac88 R14: ffff8800773c7818 R15: 0000000000000001
>> FS:  00007fef21258700(0000) GS:ffff88017b5c0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000066d6d8 CR3: 000000007118c000 CR4: 00000000003406e0
>> Stack:
>>  00000000ffffac88 ffffffff8199867f ffff880176bef5f8 ffff880100000030
>>  ffff880176bef668 ffff8800773c7c88 ffff880178288098 ffff8800772c0010
>>  ffff8800773c7818 0000000000000001 ffff880176bef648 ffffffff8150a86e
>> Call Trace:
>>  [<ffffffff8199867f>] ? printk+0x46/0x48
>>  [<ffffffff8150a86e>] intel_unmap_page+0xe/0x10
>>  [<ffffffffa039d99b>] ismt_access+0x27b/0x8fa [i2c_ismt]
>>  [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
>>  [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
>>  [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
>>  [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
>>  [<ffffffff8143dfd0>] ? pci_bus_read_dev_vendor_id+0xf0/0xf0
>>  [<ffffffff8172b36c>] i2c_smbus_xfer+0xec/0x4b0
>>  [<ffffffff810aa4d5>] ? vprintk_emit+0x345/0x530
>>  [<ffffffffa038936b>] i2cdev_ioctl_smbus+0x12b/0x240 [i2c_dev]
>>  [<ffffffff810aa829>] ? vprintk_default+0x29/0x40
>>  [<ffffffffa0389b33>] i2cdev_ioctl+0x63/0x1ec [i2c_dev]
>>  [<ffffffff811b04c8>] do_vfs_ioctl+0x328/0x5d0
>>  [<ffffffff8119d8ec>] ? vfs_write+0x11c/0x190
>>  [<ffffffff8109d449>] ? rt_up_read+0x19/0x20
>>  [<ffffffff811b07f1>] SyS_ioctl+0x81/0xa0
>>  [<ffffffff819a351b>] system_call_fastpath+0x16/0x6e
>>
>> This happen When run "i2cdetect -y 0" detect SMBus iSMT adapter.
>>
>> After finished I2C block read/write, when unmap the data buffer,
>> a wrong device address was pass to dma_unmap_single().
>>
>> To fix this, give dma_unmap_single() the "dev" parameter, just like
>> what dma_map_single() does, then unmap can find the right devices.
>>
>> Fixes: 13f35ac14cd0 ("i2c: Adding support for Intel iSMT SMBus 2.0 host controller")
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  drivers/i2c/busses/i2c-ismt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
>> index f573448..e98e44e 100644
>> --- a/drivers/i2c/busses/i2c-ismt.c
>> +++ b/drivers/i2c/busses/i2c-ismt.c
>> @@ -584,7 +584,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
>>
>>         /* unmap the data buffer */
>>         if (dma_size != 0)
>> -               dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
>> +               dma_unmap_single(dev, dma_addr, dma_size, dma_direction);
>>
>>         if (unlikely(!time_left)) {
>>                 dev_err(dev, "completion wait timed out\n");
>> --
>> 2.7.4
>>
>
>
>
> --
>              Dmitry



-- 
With Best Regards,
Andy Shevchenko
