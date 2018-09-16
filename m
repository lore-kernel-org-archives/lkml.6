Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A0ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C349020883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BY1G30u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C349020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeIPWta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:49:30 -0400
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:45982 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727808AbeIPWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537118752; bh=gXXeJp858zQBIxvfGsMUig+5wkEY0vwOczoj7qU+dQw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BY1G30u1rnTIdFrfqZ4YUCAzIZokobnq5yMunFY6pjXfc8v6xsexMtnfr06YB95IdBtpxtMtWNC3xX49uW5EWrrR36smeWY1HvhFF1Wr4HVLqUv/ympB+BqvhQneiSvFXLOGrr73qyzjVnNo9fgfDreDcmX+o9NpVIWzARjmCehheZDzNhpiFW4lRuvzdhs1i0FUJElCDB8wXOs44ahztS1CyvUrwo148Fpl3f21/G3FlJoKg2FDgNKBf/I88h5oi7lw9q8X11P1WB/c1zmeTMBOyzSAo4o1C2Y6cU0hJeITl41UZhRbbjaJ5qVT2nMQo3JT36jzbjxxSqboElLVtw==
X-YMail-OSG: QNpW4gIVM1lAHnraKGQXD32Lst3D80GCGBY6CioMtuyjS5hEG1cfWJ0F49si7jI
 .kz47cUTp07PwKlf_NhOOdJtuvJow6pUJjQObmJ.m9vTWy4BzbSAYBoLUlbXCozIkD6Hwi0kEHUK
 XwIi9JpU.7fkXhqGpSaPQ6.A20SAE29e4cv52v_x6uWWj8FIKAObZixtnturUzUqJmdjQVQ0naoe
 UHiOayH1eVdXesswdJbdnGzv.gtXB46nVgeuDI8J92Z3q.i8ie2DAKzgOLB4mR4rcHRcKeo22skP
 6i8t_5sHNTliAEjy7EZSmBXiS74JFvMnD6QMyBuScZss_YYM4HF4VFl5jl_EB3IsUNPojvDXchJP
 S7eRj6NWrqkLP_mFpdCi.viENHJIb6mHOE679b9xQY7DpP4CleWMnLxAD16cTgkdHGZjQ7Pfrksf
 Uwes088tNYalDVEqtZpO2eEmniRrxLIzkj_Lwajurv.RGvzfWajz2mXHcY9htolPfL67RMO1P3FM
 DG4npfBACWM9XTjmMHCEiiiRYbNme6w9Uc3JsMU1b7v8gkRq3UOnBiJc8W4am8Gg3cnxK4ROTRyX
 62SUZ0J_Dzw1SP8eWv.L7MCH1MVeSFIp9JdNieW98McsL9ikn8skF9xc2_utlxCmEWu.S6SVQobK
 3vG1gZm2A_1S2a1OQq2SPh8grMylpjgEB12q4e7NvhcIT6P.EOi9iB2xlbZvKXRQXSae3HoFsgmO
 oe9wawRgg66D.zeobDnQee0nHfqbILUiGFLq9JYUwfEuygyKn5khl96Lpx5G5.vLi53tmtPgK1BY
 mieWdj1WuE81J...TKL64AyxCqmmY4HNT9qqIyfl7TKySrOmIWqMt.eIOBHmaEAmsuu4VoRcMoT4
 KztuZPLYgSblBknu1.3t4X5ugduSEa24T1qnO3fDo984FL7NlxgFh6DbODAvZEHsjbTYfLGRv2uZ
 VtmdaAXTlReh2W8mmcyDc72QZH2Y.s45KOrcmwK6YRu214hnVOeM7dxAQI7Uhm_Hr41ov1rfgQW4
 I0ESakGmoJDZKq2IctL83tIIseV53N2CETP2iJyykJADbpk41QsqTN3q2NzM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sun, 16 Sep 2018 17:25:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 068bd768ccf880d5778dcd9284be01aa;
          Sun, 16 Sep 2018 17:25:47 +0000 (UTC)
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     mic@digikod.net, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, casey.schaufler@intel.com
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
 <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
Date:   Sun, 16 Sep 2018 10:25:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2018 9:54 AM, Salvatore Mesoraca wrote:
> On Wed, 12 Sep 2018, James Morris <jmorris@namei.org> wrote:
>> Adding the SARA and LandLock authors for review & comment.
>>
>> Salvatore & Mickaël: does this patchset meet your needs for merging to
>> mainline?
> Since the last time I submitted the patch to the ML, it grew a bit: now it needs
> inode's blob stacking (which is already included for Landlock) and
> kern_ipc_perm's
> blob stacking.
> The last one isn't implemented in this patchset, but it isn't
> absolutely necessary.
> I can merge a version of SARA that doesn't need it and than update it
> when possible.
> I can provide the same level of protection without using kern_ipc_perm
> blob, I'm using it
> just to minimize some potential side effects.

Adding kern_ipc_perm is easy. As it looks like there will need to be
a few revisions I will add it to the next set.

>
>> On Tue, 11 Sep 2018, Casey Schaufler wrote:
>>
>>> LSM: Module stacking in support of S.A.R.A and Landlock
>>>
>>> v2: Reduce the patchset to what is required to support
>>>     the proposed S.A.R.A. and LandLock security modules
>>>
>>> The S.A.R.A. security module is intended to be used
>>> in conjunction with other security modules. It requires
>>> state to be maintained for the credential, which
>>> in turn requires a mechanism for sharing the credential
>>> security blob. The module also requires mechanism for
>>> user space manipulation of the credential information,
>>> hence an additional subdirectory in /proc/.../attr.
>>>
>>> The LandLock security module provides user configurable
>>> policy in the secmark mechanism. It requires data in
>>> the credential, file and inode security blobs. For this
>>> to be used along side the existing "major" security
>>> modules mechanism for sharing these blobs is provided.
>>>
>>> A side effect of providing sharing of the crendential
>>> security blob is that the TOMOYO module can be used at
>>> the same time as the other "major" modules.
>>>
>>> The mechanism for configuring which security modules are
>>> enabled has to change when stacking in enabled. Any
>>> module that uses just the security blobs that are shared
>>> can be selected. Additionally, one other "major" module
>>> can be selected.
>>>
>>> The security module stacking issues around networking and
>>> IPC are not addressed here as they are beyond what is
>>> required for TOMOYO, S.A.R.A and LandLock.
>>>
>>> git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  Documentation/admin-guide/LSM/index.rst |  23 ++-
>>>  fs/proc/base.c                          |  64 ++++++-
>>>  fs/proc/internal.h                      |   1 +
>>>  include/linux/lsm_hooks.h               |  20 ++-
>>>  include/linux/security.h                |  15 +-
>>>  kernel/cred.c                           |  13 --
>>>  security/Kconfig                        |  92 ++++++++++
>>>  security/apparmor/domain.c              |   2 +-
>>>  security/apparmor/include/cred.h        |  24 ++-
>>>  security/apparmor/include/file.h        |   9 +-
>>>  security/apparmor/include/lib.h         |   4 +
>>>  security/apparmor/lsm.c                 |  53 ++++--
>>>  security/apparmor/task.c                |   6 +-
>>>  security/security.c                     | 293 ++++++++++++++++++++++++++++++--
>>>  security/selinux/hooks.c                | 215 ++++++++---------------
>>>  security/selinux/include/objsec.h       |  37 +++-
>>>  security/selinux/selinuxfs.c            |   5 +-
>>>  security/selinux/xfrm.c                 |   4 +-
>>>  security/smack/smack.h                  |  42 ++++-
>>>  security/smack/smack_access.c           |   4 +-
>>>  security/smack/smack_lsm.c              | 283 +++++++++++-------------------
>>>  security/smack/smackfs.c                |  18 +-
>>>  security/tomoyo/common.h                |  31 +++-
>>>  security/tomoyo/domain.c                |   4 +-
>>>  security/tomoyo/securityfs_if.c         |  15 +-
>>>  security/tomoyo/tomoyo.c                |  57 +++++--
>>>  26 files changed, 899 insertions(+), 435 deletions(-)
>>>
>> --
>> James Morris
>> <jmorris@namei.org>

