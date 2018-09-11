Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F67C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEF520645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEF520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIKLhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:37:34 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:45214 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeIKLhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:37:34 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAAHDpInY5dbFM_TCA--.9790S2;
        Tue, 11 Sep 2018 14:39:36 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR
 number
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1536550549.git.puwen@hygon.cn>
 <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
 <20180910180613.GE4386@zn.tnic>
Message-ID: <da680b5b-be9d-64c3-35f1-72f8ab02fc7d@hygon.cn>
Date:   Tue, 11 Sep 2018 14:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910180613.GE4386@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowAAHDpInY5dbFM_TCA--.9790S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7k0a2IF6w1UM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
        6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr
        0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z2
        80aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI
        62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU1CPfJUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 2:06, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 09:16:03PM +0800, Pu Wen wrote:
>> The Hygon Dhyana CPU have a special magic MSR way to force WB for
> 
>  From the last review round:
> 
> Also, it is "The ... CPU has a special..."
> 
> Please take your time and incorporate *all* review feedback - no need to
> *rush* a new revision out and drop review feedback.

Sorry for not taking much care of the usage between singular and plural.
Will fix those typos.

-- 
Regards,
Pu Wen

