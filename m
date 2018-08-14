Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF97C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1642173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1642173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeHNHm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:42:58 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:60002 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeHNHm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:42:58 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowABXMxwVYXJbAPUVAQ--.9106S2;
        Tue, 14 Aug 2018 12:57:10 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 07/17] x86/pci: add Hygon PCI vendor and northbridge
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
References: <cover.1533989492.git.puwen@hygon.cn>
 <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
 <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ec0ef867-3254-9e17-bf37-de697e9d0709@hygon.cn>
Date:   Tue, 14 Aug 2018 12:56:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowABXMxwVYXJbAPUVAQ--.9106S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy5GFWDJFW5JFWkZrW3Awb_yoWDJFc_Jw
        n7Wa1DKr4UZF1rtan3J3W5Aw43C34vqF18Xa9YgrZxuF1UtrZ5Jr9rG3s7ZFs5Kwn8KrW5
        J3Za9w40934qvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26F4j6r4UJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU1eWlDUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/14 6:14, Bjorn Helgaas wrote:
> On Sat, Aug 11, 2018 at 09:27:42PM +0800, Pu Wen wrote:
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 2950223..d0e98a9 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -511,6 +511,8 @@
>>   #define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
>>   #define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
>>   
>> +#define PCI_VENDOR_ID_HYGON		0x1d94
> 
> Please add this entry so pci_ids.h remains sorted by Vendor ID, then Device
> ID, as the comment at the top suggests.

Thanks for the suggestion. Will place PCI_VENDOR_ID_HYGON between 
PCI_VENDOR_ID_AMAZON(0x1d0f) and PCI_VENDOR_ID_TEKRAM(0x1de1) in next
patch set.

Pu Wen

> 
> With that changed,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> 
>>   #define PCI_VENDOR_ID_AMD		0x1022
>>   #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
>>   #define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
>> -- 
>> 2.7.4
>>

