Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979F520652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979F520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIFQQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:16:23 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:53343 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbeIFQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:16:23 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowADHy19FEpFbEgpTCA--.23655S2;
        Thu, 06 Sep 2018 19:40:55 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
 <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
 <20180906083924.GB10768@zn.tnic>
Message-ID: <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
Date:   Thu, 6 Sep 2018 19:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906083924.GB10768@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowADHy19FEpFbEgpTCA--.23655S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxKF48CFWUCr1Duw17ZFb_yoWDCrb_u3
        s7WF1DWw15CanFqFn7Grs5Zry5Kr42kFyFvrWqqFZFv34fXFZ5C3Z3GrWYva1UJanFqr9I
        93ZxXr1av3W7ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU5cjjPUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/6 16:39, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 11:52:42AM +0800, Pu Wen wrote:
>> In most of the normal use cases MCE is necessary. Rarely in some cases
>> such as for test purpose MCE may be unselected.
>
> Test with MCE disabled? Please elaborate.

The first is the compilation test. Test the kernel with both MCE selected
and unselected to see if is the compiling process successful or not.
The other test is functionality test. For example, during the MCE BIOS
development, to see if the MCE functions OK, it may need to select and
unselect MCE in kernel for double checking.

Actually in normal use scenario and in real product the MCE should be
always selected. To ensure this, I think there are two ways as below:
- Select X86_MCE_AMD in CPU_SUP_HYGON config entry, it also cater to the
  first test scenario, but meanwhile lacks flexibility.
- The linux distros(Ubuntu, CentOS, etc) ensure that X86_MCE_AMD is
  selected to the default config file, and indeed they do.
Which way is better?

-- 
Regards,
Pu Wen

