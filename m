Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C2EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C557206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FHHwUu/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C557206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeIKV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:26:35 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:44828
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbeIKV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536683189; bh=zURbNl6VpmvtgnUOSIzJioExI/4fKFwu9E1NaQA4sx0=; h=To:From:Cc:Subject:Date:From:Subject; b=FHHwUu/BvyvAjSWRm2aWLy6vcg2ZVXMa7bdBmrJjQxXtR30EyeXPc89sxJn2RgU8hfyEauDyNRNfT40iaZpV3F9yCI8e+z/+sEDU3ip+IME5+TmcWiPULwsvzO+xvJ9m4XhqzvdbsbiDbVojEQ9j0Rl8ga5ludAen3x3brifniw40gPF6zTmmG0OiTJza9+RbBSeVJIqja9XAyPZD3SKmDWkTyZ+k/AKi1cPIpq7FCTSeNcIl88nhGcOeKk7KNLMzIQi+K61T0PsmsHay7ReWF6JW8tpPU61Tdn8qnndQkvFxX7Yg9a472QPDC1WImbpkmF3VWPdxi4ctQu1wPLzsg==
X-YMail-OSG: Kf0C.zUVM1mqaDrK0RWvt2yFjvE9eN1mRrj_S1sGUBPuKjmvEVVbNiYcYMcZa5J
 uep7dwPiwhlaZmm0eNIoX5QnREviup7rKf6yqKf7NDV_HfwQUr3sAvI..Xei5.95IDKGGy72Fqv.
 4IGz_n9PH10wOGpj1rI53gyK4JpqWMvtDNGu.GPfFq2V9HAsgIaeth.40yWNv04oz3MnQALmRPtI
 iZdZqKULTqZKRNXtkBFl2C_Ob1vlpP2TqfIWfDheqMNr6UPshTiRT0OZb_rL9_YcRBiC.BnFnbkX
 JJkTEZ_F9cHulTXvwQB8ir4b5mcVIQ0.TDweRwbw88YTsHRE6EgJjyF4oxSpOM2Z5aKi0ieViw08
 2rp__6Tl1mw1qBg3Vt3e.WAC0gUy1.LIJeD6EHCgyP.0n_cud0DqdFeC3nv_Yb7dG_6ob1UEaPnb
 dmILtcHAprqn9DepWpLR58dTkRMtj3ATM4d_k65fxsQBXS1ZP82QUKAK2zq8Bi1pvlTE226RblgL
 bzE_Zq5LlBO6OQSy1QiPP1ym34Y.ZEmOqN1vZmJb8K37sBrTgRbtLpKYT2Di9yJ.aw6Hf4x_6QJ8
 bw.rshDiAQkxP8gvNZ.tf51yE41SJp_xHN9vW60s52E.0NojTr9untXSCuyTpNk.SYaBCzcOJZ6h
 tW4VTafkN7Ah.78d16UxWud3StXGnd7iy6klAJbnx0lPqIU6Lx3epJzgTW.kIPElkxb5N4Kxo7vU
 EErQArHkfeY9OfF4QMcMMWd4nM4WArrsuWjUW.o5kWDZ3InRGQBjjZrYuZ2K49ts1W3JeYHH4d0E
 qOy98OhnFwRhqE4XzLWPBL7420L3W2y7BCKG38wboMCyBnPRmGobrbzAjWJXvUbrIsJfM4mRBMh1
 im12xEEfLaNHB_9H5TRV8cWWuMmmB7wSUdOlr17Yt2ct3KWdWPZtFXoZQz.QM6f9.fhsGIcMH9qy
 1zZNydBq9c3_ywhQ107iwpdBqJQKG.6WdkgGSIPt5Ks5N_66XUEfs3ZWXUkjiWIouV1LRp1HaZAj
 oNccI64Fjn.k.LNyaZGt.jCaQ4Me1Mxs0rwVA.e3HlAXd8DtYnrkB4uA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Sep 2018 16:26:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID da7615c57ead9698b5b5b8ef21f732cc;
          Tue, 11 Sep 2018 16:26:24 +0000 (UTC)
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
Message-ID: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
Date:   Tue, 11 Sep 2018 09:26:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM: Module stacking in support of S.A.R.A and Landlock

v2: Reduce the patchset to what is required to support
    the proposed S.A.R.A. and LandLock security modules

The S.A.R.A. security module is intended to be used
in conjunction with other security modules. It requires
state to be maintained for the credential, which
in turn requires a mechanism for sharing the credential
security blob. The module also requires mechanism for
user space manipulation of the credential information,
hence an additional subdirectory in /proc/.../attr.

The LandLock security module provides user configurable
policy in the secmark mechanism. It requires data in
the credential, file and inode security blobs. For this
to be used along side the existing "major" security
modules mechanism for sharing these blobs is provided.

A side effect of providing sharing of the crendential
security blob is that the TOMOYO module can be used at
the same time as the other "major" modules.

The mechanism for configuring which security modules are
enabled has to change when stacking in enabled. Any
module that uses just the security blobs that are shared
can be selected. Additionally, one other "major" module
can be selected.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, S.A.R.A and LandLock.

git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 ++-
 fs/proc/base.c                          |  64 ++++++-
 fs/proc/internal.h                      |   1 +
 include/linux/lsm_hooks.h               |  20 ++-
 include/linux/security.h                |  15 +-
 kernel/cred.c                           |  13 --
 security/Kconfig                        |  92 ++++++++++
 security/apparmor/domain.c              |   2 +-
 security/apparmor/include/cred.h        |  24 ++-
 security/apparmor/include/file.h        |   9 +-
 security/apparmor/include/lib.h         |   4 +
 security/apparmor/lsm.c                 |  53 ++++--
 security/apparmor/task.c                |   6 +-
 security/security.c                     | 293 ++++++++++++++++++++++++++++++--
 security/selinux/hooks.c                | 215 ++++++++---------------
 security/selinux/include/objsec.h       |  37 +++-
 security/selinux/selinuxfs.c            |   5 +-
 security/selinux/xfrm.c                 |   4 +-
 security/smack/smack.h                  |  42 ++++-
 security/smack/smack_access.c           |   4 +-
 security/smack/smack_lsm.c              | 283 +++++++++++-------------------
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  31 +++-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 +++++--
 26 files changed, 899 insertions(+), 435 deletions(-)

