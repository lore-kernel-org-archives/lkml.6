Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10326C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A520862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="WILf4Lmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1A520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeKFCcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:32:33 -0500
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:40009
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729733AbeKFCcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1541437914; bh=M7IS0j1Q8QuVUGnbOGJMHaLTmRTKpPVAeyUIMzSZ4wE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WILf4LmfSqTakzVTiQbh2pL7PxfjnnF+pmNdhaoND6pBUf6eWbSU/8WLwvPUNalGAZWyF9w5MlqqJqDrAaqBTINHejyeJz46feN1g9Vvb7Z5k/BBy+d1Dz/FX1hsgIPQh1MnHXjIKsbSDJz0Dy0zvaD68xmzZIlIAE7ZSam23qKvAL2QTEISxQRyQdxlwEjIC+YTk5yXQ12j1nJqBGat8Qqfj6D7/53IHNGr0T6uvQj9FaVhHm68uP1oNucU5/3B1YnDXNGZICM4kqzJfC+TzVSrpLUULiT83lGIL7pM0tiaqAZRdaOCvFfJX4Dr9Uz7qeE7IBZFvng3nA84XF0HZA==
X-YMail-OSG: ywZl_uMVM1nq.zUX.xszdW_cGzzHRp3Afd9Dh1PNDo7JBim2DnvNYE4K214e8vc
 Yd0KTCfqjEVwl_KWtti.TYxLbaofgR8EvEbZewlbrFQHD3YtTc8pTAFYQgRGaD.80nx3rlv1yJWP
 i9CfEfe.2t1cOMQrgyEztDME5ApkNAgdAMbPSX4768adW42m8Q2u8kVJOmjiMIcudzPINAKrtwZ3
 HrTzG8EOHBR8lINogI89gciYrHSRtwDBXQRKK661MHZpYmAMv0cHjvHW_JN9IUuAoWqvecH3aQi_
 RssFO54KJnoQJyrBOkHnQYkqBBhhBmEW_BomKmxmB_jdLCVPCMc2RncHbY6Btu_moywm_GnEOYp0
 2LTZd1DcHp4_UQ4L1poJ_Wf1fpdz9LCAJvFiGKBm.dpPdRbK.C3fO_x9UajFfFr9ap8Sd4PIWtE7
 jflcerD0CpMMkfmJKHLn5aepYwRYvks.uHWVK3ThYmwEbVKg1SjNyknvgN0PBkqO9bxhn7F2_p.G
 yNzmA6hT.X_T8We2L6.QScZFmV7HW48CddgUiB61kTyh4rwX9zKevkr_lF9wX6ChFaW8Eyx.i8Dj
 uPz81CLgpQnaXtpfbGGx9VSTjI7IElHHPGv7hVFrDLRzXS_7zKsgqosNLF3hTiOeNsc1A4rK_oc9
 BfDZbuFJkg2P.sS3TymoZy2ivcH3SKBfkE7jBV.SXnV7.9Z5faN0AHaglfVp4rVwrZQYWTA0R7gQ
 Pq7VV6EhKK_HE0ii9hjVAjTjxZTjhPKT7He8d3g77ICs55NV.lhIEgf5i8Ml3QKaBTCZFiOHrw.p
 647uEj6CLsUCLBVlqUVb4dZAXzszUIglcuPJWVmW9.iHC.wKqDK6gcOHy6WZM4dqUafEillCZHFY
 np9x0fin4A_YG8gsk5Z7yCqBUQ7V1fz.BG1MxaLRyLgwDwxmAz8kPhyNYyRIQnQA3g2KCgw7XYW7
 LGjoIHOIZavnV9aiZMzqhr85mjMUNIVuIJirfJEpElAfy6bPfBf2gyvz2AysYJ0EbPZzJXE34X_3
 .6g3L8lZrnJ.PnQZ7CzjwXyTF0KSdqh.jUTB0DwLvRh4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 5 Nov 2018 17:11:54 +0000
Received: from 60.177.33.247 (EHLO [192.168.199.149]) ([60.177.33.247])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3a3443c36cf107c1ec063a51e3d2ba26;
          Mon, 05 Nov 2018 17:11:52 +0000 (UTC)
Subject: Re: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <3455f753-8f7c-91a8-c926-e06f5ed2d1bb@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <f30835ca-f6e8-1e31-3364-cb1d958d76bf@aol.com>
Date:   Tue, 6 Nov 2018 01:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3455f753-8f7c-91a8-c926-e06f5ed2d1bb@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

ping... is there someone interested in this patch?

It seems bit_spinlock performs much better by using
smp_cond_load_relaxed than just do busy-loop in arm64...

Thanks,
Gao Xiang

On 2018/10/30 13:52, Gao Xiang wrote:
> Hi,
> 
> On 2018/10/30 14:04, Gao Xiang wrote:
>> It is better to use wrapped smp_cond_load_relaxed
>> instead of open-coded busy waiting for bit_spinlock.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>
>> change log v2:
>>  - fix the incorrect expression !(VAL >> (bitnum & (BITS_PER_LONG-1)))
>>  - the test result is described in the following reply.
>>
>> Thanks,
>> Gao Xiang
> 
> 
> Simple test script:
> #include <linux/kthread.h>
> #include <linux/bit_spinlock.h>
> #include <linux/module.h>
> 
> unsigned long global_lock;
> 
> int test_thread(void *data)
> {
> 	unsigned long thread_id = (unsigned long)data;
> 	int i;
> 	u64 start = ktime_get_ns();
> 
> 	for (i = 0; i < 500000; ++i) {
> 		bit_spin_lock(0, &global_lock);
> 		__asm__("yield");
> 		bit_spin_unlock(0, &global_lock);
> 	}
> 	pr_err("Thread id: %lu time: %llu\n", thread_id, ktime_get_ns() - start);
> 
> 	do_exit(0);
> }
> 
> 
> static int __init bitspinlock_test_module_init(void)
> {
> 	int i;
> 
> 	for (i = 0; i < 8; ++i) {
> 		if (IS_ERR(kthread_run(test_thread, (void *)(unsigned long)i, "thread-%d", i)))
> 			pr_err("fail to create thread %d\n", i);
> 	}
> 
> 	return 0;
> }
> 
> static void __exit bitspinlock_test_module_exit(void)
> {
> }
> 
> module_init(bitspinlock_test_module_init);
> module_exit(bitspinlock_test_module_exit);
> MODULE_LICENSE("GPL");
> 
> 
> ...and tested in the following ARM server environment:
> 
> Processor: HI1616 (https://en.wikichip.org/wiki/hisilicon/hi16xx/hi1616)
> Board: HiSilicon D05 Development Board (http://open-estuary.org/d05/)
> Memory: 512GB
> Host OS: Ubuntu 18.04.1 LTS (Ubuntu 4.15.0-29.31-generic 4.15.18)
> QEMU KVM OS: Linux 4.19 + buildroot
> QEMU KVM cmdline: qemu-system-aarch64 -enable-kvm -cpu host -smp 4 -m 256M -kernel Image -M virt,kernel_irqchip=on -nographic -hda rootfs.ext2 -append 'root=/dev/vda console=ttyAMA0 earlycon=pl011,0x9000000' -serial mon:stdio -net none
> 
> Without this patch:
>   Thread 0   Thread 1   Thread 2   Thread 3   Thread 4   Thread 5   Thread 6   Thread 7
> 1 1283709480 1271869280  454742480 1173673820 1145643640 1118846920  774616920 1144146140
> 2  643580180  625143860  576841700  322982340  649987880  585749000  529178880  373374780
> 3  672307220  847315000  880801860 1039502040  667086380 1033939940 1035381120 1046898300
> 4  568635580  440547020  737000380  910040880  804543740  712314280  868896880  867049000
> 5  749107320  726397720  776134480  611970100  756721040  753449440  711691300  609343300
> 
> With this patch:
>   Thread 0   Thread 1   Thread 2   Thread 3   Thread 4   Thread 5   Thread 6   Thread 7
> 1  170327620  196322160  169434180   74723860  178145600  178873460  143843260   70998780
> 2  166415220  129649200  166161240  175241520  155474460  112811860  157003140  150087420
> 3  511420780  117655640  598641860  596213720  462888760  430838600  554346300  428035120 
> 4  174520240  156311800  120274280   87465380  172781400  136118620  163728340   63026360
> 5  153677940  202786860  183626500  140721300  150311360  161266840  168154340  107247460
> 
> Thanks,
> Gao Xiang
> 
