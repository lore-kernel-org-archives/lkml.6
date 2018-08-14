Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAADC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C3215A5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LCcpprw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155C3215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeHNVQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:16:55 -0400
Received: from sonic303-29.consmr.mail.gq1.yahoo.com ([98.137.64.210]:44054
        "EHLO sonic303-29.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbeHNVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1534271309; bh=nAQFJEYg3pOd5GKYynD43hOR1hcALYmaBmLSZpT9+xY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LCcpprw75dOShCbg70hkSWOlKtdGQOrLUfKuDykBtfocYEWTqGq284eEbrbtE5uVyk4v2/ti/5eU6RG/+2hMt/V6e2MHJkpd2JYyw2uvnl1Eur+fLeq7uRjVsEJIbIecpfxzYh4JQl37/R29eoAkydrL/CU5cZIwbPq3VAb6sKU0Lpilg1VK2JHX6etxSfPERgycZqv+1k12BJ0UX7Xpj39cnMnunSw4JpBpSx5cCGSrd2S4c8kGwIgBS7HioB0hTFsXmHIlkXoAVzxwgl32T24+DPtejYqey1Hi99XvAPD6xWlwesHy+7iehUqxgoKQJGKJTUxsfMJTvnlQykHMgg==
X-YMail-OSG: hmHoeCcVM1kdII5in5RxcylwUIM78uEezZMTmO5fT3SgzAucAviHoVlObuZGE_v
 XAM5VMon5ZgQOghZwmQjkmgepou9e6c_IGKPR6pEN_iGc6zCC0pYz4kNAoK5wHwZ488kNAxti_Lh
 GZnB_r.DEz0w4BjAwAYzAHQuYRjM1kjbZCEiT5_PmNcd6T5lBEVXNAwy9LxKbqWneFc_KsZ4dLw_
 gWAk.tDgsr55SFkhMPrlWkprbIROBG_MsWaXq_aKdr1pVGWKWfz_rESLdKIRqkfF9WBGuwVn3ypQ
 _b0pu35fwbnCAxvMbqfkQb32JIMN7M6S9a62_c83NDMtptfa50PkDOHpXxCr5YWkhSwVWkhTtpMc
 3225qdHHvfDOmaRbCwIDVz5keiPncL4Jkv1m4q2BjKW.pnLYYa5kVUvISdIi7bf5mb5wWJusiB9r
 xGDHFR79y9ePJNEfWGo_2e.7SrRMyXdn3AnLL_x9NbcPhrVqe94wSPQ7boCKVBACwEch_mciP1ID
 pzIYCxpLw1IHTQ7lrA9UzMeVWWeDV6E1AzoXwYFq1D__R_7K9.vRhcu.eTR3fd7jvVdGwMFHFQC2
 FTQOCgliNzL2sFAihgpuMJLJukd32UJRsYKRLlPsTPkzx4YHUQRPWKbmHtYjk0ZjnDQe5jWOt_Al
 5Bh2YK1PMzVnk0Sen.Sp78XMvm2toLHEYzhSPXPtUQoOxfSFvwAMiZUIptTaprAgMps8eyWuV44_
 fE1OuEuDwTUU09aeSE.cRTc7acZfmCNAvE8eaHCoOfwsjSJnEnB79hQf7iTj2lUezltEExotqEXH
 k.OrGFW1tHWmSsOai.E5bw5k.f1CMC_hpHois1Ue.ZRQH5Lpvu.HBegNtULwC82QVYZ6_dhzaepW
 FBusGR9iK3an2KtQ1Lb6B.VDuWSpw6y16eacS7bE4nbMAz9tOdRL7991H0ALroo6rAxMf7JYZKH0
 kpiTGkqszqcAbJv3NBOhCKHJGcLxBie13ssgIf0CzykW_Rv4MV0240jBTdr6X8oZMtfw6rtAWVNX
 zsRlIExXLUqHJ4oOnAHRwx_g4DwPJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Tue, 14 Aug 2018 18:28:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3242b7d698ccb2dcebe46da1121efa9c;
          Tue, 14 Aug 2018 18:28:26 +0000 (UTC)
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
Date:   Tue, 14 Aug 2018 11:28:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2018 10:05 AM, Sargun Dhillon wrote:
> On Mon, Jul 16, 2018 at 10:53 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> LSM: Full security module stacking
>>
>> I'm calling this v1 not because it's the first version
>> I've put out but because it's the first version I'm getting
>> serious external pressure to get upstream.
> Awesome work, I'm glad that this is getting further.

It's following the 90/90 rule pretty closely. The first
90% of the work took 90% of the time, and the last 10% is
taking the other 90% of the time.

>> The blob management part (through "LSM: Sharing of security blobs")
>> is ready for prime-time. These changes move the management of
>> security blobs out of the security modules and into the security
>> module infrastructure. With this change the proposed S.A.R.A,
>> LandLock and PTAGS security modules could co-exist with any of
>> the existing "major" security modules. The changes reduce some
>> code duplication.
>>
>> Beyond the blob management there's a bit of clean-up.
>> Mounting filesystems had to be changed so that options
>> a security module doesn't recognize won't be considered
>> a fatal error. The mount infrastructure is somewhat
>> more complex than one might assume.
>>
> Casey,
> Do you think you can break out 1 into its own patch? It seems like
> that'd be valuable to everyone.

Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
other security modules could be added upstream if this part of the
work was available. It would not provide everything needed to stack
all the existing modules. I believe there is concern that if this
much went upstream the work on finishing what's required to make
everything work might be abandoned.

> What's your thought here if we ever introduce dynamic security
> modules? It's nice that we now have a way around rolling back blobs if
> one fails, but what if a new module was activated, would we just
> resize the slab cache?

Making the blob size dynamic at run time makes the blob management
more complicated because you have to keep track of the modules in
play when the blob was allocated, and pay attention to that when hooks
are called. It's a lot simpler if you don't let blobs get smaller,
but still requires more bookkeeping than if the size is static. It
is completely doable. I have played with it a bit. There are performance
implications.

