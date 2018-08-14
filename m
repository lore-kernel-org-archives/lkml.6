Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D431C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F021216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NwYADPIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F021216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeHOCju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:39:50 -0400
Received: from sonic303-29.consmr.mail.gq1.yahoo.com ([98.137.64.210]:35767
        "EHLO sonic303-29.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727854AbeHOCju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1534290616; bh=Q5ueiMz8B20u2Ep3Bb8PK52De67dhT4pLva/afp2GIs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NwYADPIrb40i3Wl1OzYqXHb7FXfDKCi2KX1G6eb6H1Kgl9JyqWknfqXvSA6K/6IQ+7vcmJAA1T0Vso9PXeBlzMB1mT5Pavmvz5eHXRgvXSfUgpXHfWChgf31Mje1o4MO6DWgS5Gf1oTrHBhVlPgpStH9W68L8b4g0JDrc6TNRGWPRlRmIljR30Gj7bpZs9i8qRu+TVGGJnLA1v+pZR+PjLJmZ/o6RVIC/gOVkJI1Hl/w+Sf4F2vEVR6OaD8Ea1wBQnPj+x/founQSOmhCFAOpySAyr30WnsrpLU0tLWfCx9pcWbN9AB5S2giNr9XrU8atPNfp4g0s6G8P0griE2d2A==
X-YMail-OSG: lkeuAUoVM1lw.oZzTtX7r2bZszenz6AswDKbEE2A4ffUXkSJsYUJOUUJMKE0WFo
 LMLFbVWR50oRVzEi8agqw4_VhSz9Xrt_VFY4Hxmkoi9Ah1OAuYHbK.WzV4cBryATQFGhMki_zHPG
 5KOsvZv1tB5lnRKFCgNTmXiE2v8INGkMW9vuoc4OyoiwTsicGyETv7Zqim1LogYxAsyKY4V_AwWI
 JCsMv4oFRdk6Ylh66sFxl3jQHxEjm32n79Rt4Csn6ILVqNoZXqWtlq7B2ig7QdAWWennwMvUA15n
 4DNdQUzJ7dwALtu7Rt.RiT4LCReLpJmVSse_ftThT2sBekd1nOqryI1Ngy.E0JnnFxBIeaCuor5i
 t9nlfgcjZEBZIJr3qBq92l_lt7pSyVqSl_KaBWSnn.xcfmPPsPWncp5EJGA1gRoIVtCB6Ue26Mvp
 1ZSAU6HKoEcLrRq2HRpinI4mElq1f7FE1hduItCiKzF_oMjyt5raEcg2RrYzdqmHBgseIxrOGlhB
 8SM_iKSsmxYHaH6OR.YUVEZl.JPdYitTyab4pvPCipKB1C8oXYVfFgbWF16OsJK1yb00fd0htCxG
 ij5eXHwY_JRSCh08MPEe6crBcTxQ7WqsKUE6OnrKV2EuFyoy5lMhMoFcp3KwgKYBgZR7RAOiMRjc
 ugl2SIUuZUlqPaz3MRuwcBT6lMb4UiiaCkLtQW42fOy1QQVcEjy0G8WsGXGVOd5HLKkUIk65bGYP
 XcsOXB56hB_euJ1eBm_YOm4p_XXsFZ8YfI7VCoP.KtL_y_rY5dlV38QrAH8a2VHrSoDpAuiy2Uvx
 Pt5QCUiKNnv83kw.GWgt1Fqp3absQ_9TqxmGdfvNaZtvYqFOHv4yj090lFnklQsS8j40jE7xwytR
 Ex8rt9ASmDbIqCR6O1N4pKVtSGtyTz38DlBUjEeCYo8sh_MKN_3PdWb2kqo.Q0SDlH41MMbmwrd5
 tUfE62fZGq8fLzUgEKMED86sv4Idl2QsdfUq_H.10J.DR0OI9aC9zkTfHojvmR_HlPhi60qBvLiD
 UMuNRfs3ZEJx1P0fDCZvGGWpxs2z6hA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Tue, 14 Aug 2018 23:50:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 254696bb2964527cfb3116650c9b2a8a;
          Tue, 14 Aug 2018 23:50:13 +0000 (UTC)
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LSM <linux-security-module@vger.kernel.org>,
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
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
Date:   Tue, 14 Aug 2018 16:50:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2018 4:22 PM, Jordan Glover wrote:
> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>
>>>> The blob management part (through "LSM: Sharing of security blobs")
>>>> is ready for prime-time. These changes move the management of
>>>> security blobs out of the security modules and into the security
>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>> LandLock and PTAGS security modules could co-exist with any of
>>>> the existing "major" security modules. The changes reduce some
>>>> code duplication.
>>>> Beyond the blob management there's a bit of clean-up.
>>>> Mounting filesystems had to be changed so that options
>>>> a security module doesn't recognize won't be considered
>>>> a fatal error. The mount infrastructure is somewhat
>>>> more complex than one might assume.
>>> Casey,
>>> Do you think you can break out 1 into its own patch? It seems like
>>> that'd be valuable to everyone.
>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>> other security modules could be added upstream if this part of the
>> work was available. It would not provide everything needed to stack
>> all the existing modules. I believe there is concern that if this
>> much went upstream the work on finishing what's required to make
>> everything work might be abandoned.
>>
> On the other hand there is concern that those security modules might
> be abandoned if they have to wait until everything is finished :)

There is some truth to that. If we can get commitment from the developers
of those security module to push for getting upstream, a statement of
intent to support additional modules (e.g. Landlock, S.A.R.A.) from a
significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
maintainers of the existing modules we should be able to breeze right in.

Yeah, I think that's about all it would take.

