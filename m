Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00483C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EC5208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P77Plwwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EC5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeK0KSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:18:38 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:33693
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbeK0KSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543274570; bh=K00PF8JPHI9bzQkvZYFvbvZvCj8ZciWak9UFgtmEYGM=; h=To:From:Cc:Subject:Date:From:Subject; b=P77PlwwldKhx7WDgHxODiQghD3cgX8B1POIIXPAAYPXolZjhde4+49lP4496a4KJt+1sc/3sDypCeE7B6Ehlqe4njM4LQxKx6NWNdTHfnSW4ldvYwt8TnoFrW2q9E8dxxYkSkSrg/ClZ6k5NtqmfgqkOMB4fDqIGhGXIndBDuTWSITcKfPh7DPTDqODAyFV5RSaa/TZX/ILRz7L+J7I1IAwW95ULPHBQ+i67rGApbt7OBEeycmzSY1O79XvNC9jciHH3pIzxQqUB2flYSxvABd/B++GMESfnV7XjwPzrqgu0Z/rAcIdBFSVEG/+tpdl2YGDoMp1LBcWb2NHmxzbe7A==
X-YMail-OSG: 6Q7.LAIVM1m4Fez3pCSkMFjN7RHq4tGQ2d8qWA8QC29yA8VKM6UYLP5Jzwcg2d0
 PNg.JVoZOrw7yapUd6mQE2TVbHQ8SDBAUc4wLAO0XKqUjNzO.FDqccHs77e5_kdMuO8XeJVqC8nX
 pfpzUJC75UWB8bCd97DMRPyHd5WYw9XtBo7Aa5zXJW4YK_gnOFTMZIukOpVMkaTzK9138d7i0Fk_
 DYkGHsqz3BS1B4H4lIUcIo3XDxsE1zPNF0cT5DTaUxWJL2vwx0PB9s.jeWX6SuOYMEbGOuyjwXKz
 oXQWrI51vaTQbzYFD_6JKfyTpP7t7CIL0f1y1.FaUm2Nio_LqjPT0ypt_A6XqEcEKuOaH.l3xq4Q
 D8TG0TyEMT2B3aFzf.clF1mfjYplPVBqfRTlLJLKeF7VzS_q_l9dCk1sj5v9FvET1.jf.aoGfLLb
 M1elctMf.wAAxrr0vsn04UsTVyViFN7PGYyQUCI8IpXInvtZXCDAtAGVilPOAt73qrTm5d4Yre8l
 VdW87xq4KnkwPqaUe3D0zHvJojFYD4Fbs9.9_3vb6GJFpKYyKctrKvBrOFZLapE6nj70pvTvM9g9
 ZVHJw.iDOfomFMjOhUhBykV8OV.N9p6ln2GSxBaRNB_.BUarSGqpAG9yZQJyX62Wt9m3z9DPMvhB
 fuE5x.78H0cGv.RdDg.1SEJs1QLlikT.2CUbnFCXx4.FEqgMcnI9lITGBo31uFgPuNalxXG2xX6C
 UoFQGB4u6YHkua16Xn_PF7OaC0l53AVsj.3Fb895nI1oGMoTAIM0wJBtlgP0kuW0UhFIP1wttQga
 euRdtD17jr.4kR.g6bS8l1TIE6lOqDcMzbGcc8DTPbSAe90DOcK29QfR7oDHaSMI1B.tipOhP_72
 Vr.OKIS3MWsQjM9Q1vq9nW3sZ6lGeGvM7k1RGeDE7Fb2cL5tOjqCRU8j.7yQ6SYDMu97aPVSoKwf
 QcTwwkFTBirrzXC18xhB6gkueZvworL8P5A0S2T.zf8_SCjTpvWQgjm6ntFIt3Olk.3385y1h.31
 ICiVmoeoz5i3bMksNMUKT5C22gerfgQBDArHTAnU7d3eYzyy75ziJAHuWNFm8uzXfqiWn1HMkzUD
 PQUwdlqnKvrE_.vxxfgk4d29wkqVJc4KsQCHBOi9BOTc1bTMHoWg1dYU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:22:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7d36ae424f480cb3fa200502c1ff140e;
          Mon, 26 Nov 2018 23:22:46 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
Message-ID: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:22:43 -0800
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

v5: Include Kees Cook's rework of the lsm command
    line interface. Stacking is not conditional.
v4: Finer granularity in the patches and other
    cleanups suggested by Kees Cook.
    Removed dead code created by the removal of SELinux
    credential blob poisoning.
v3: Add ipc blob for SARA and task blob for Landlock.
    Removing the SELinux cred blob pointer poisoning
    results selinux_is_enabled() being unused, so it and
    all it's overhead has been removed.
    Broke up the cred infrastructure patch.
v2: Reduce the patchset to what is required to support
    the proposed SARA and LandLock security modules

The SARA security module is intended to be used
in conjunction with other security modules. It requires
state to be maintained for the credential, which
in turn requires a mechanism for sharing the credential
security blob. It also uses the ipc security blob. The
module also requires mechanism for user space manipulation
of the credential information, hence an additional
subdirectory in /proc/.../attr.

The LandLock security module provides user configurable
policy in the secmark mechanism. It requires data in
the credential, file, inode and task security blobs. For
this to be used along side the existing "major" security
modules mechanism for sharing these blobs are provided.

A side effect of providing sharing of the crendential
security blob is that the TOMOYO module can be used at
the same time as the other "major" modules. The "security="
option works as before. A new "lsm=" option allows the
order of module execution to be supplied at boot time.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, SARA and LandLock.

git://github.com/cschaufler/lsm-stacking.git#blob-4.20-rc2

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst         |  13 +-
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 fs/proc/base.c                                  |  64 ++-
 fs/proc/internal.h                              |   1 +
 include/linux/cred.h                            |   1 -
 include/linux/lsm_hooks.h                       |  40 +-
 include/linux/security.h                        |  15 +-
 include/linux/selinux.h                         |  35 --
 kernel/cred.c                                   |  13 -
 security/Kconfig                                |  41 +-
 security/apparmor/Kconfig                       |  16 -
 security/apparmor/domain.c                      |   2 +-
 security/apparmor/include/cred.h                |  16 +-
 security/apparmor/include/file.h                |   5 +-
 security/apparmor/include/lib.h                 |   4 +
 security/apparmor/include/task.h                |  18 +-
 security/apparmor/lsm.c                         |  65 ++-
 security/apparmor/task.c                        |   6 +-
 security/commoncap.c                            |   9 +-
 security/loadpin/loadpin.c                      |   8 +-
 security/security.c                             | 635 +++++++++++++++++++++---
 security/selinux/Kconfig                        |  15 -
 security/selinux/Makefile                       |   2 +-
 security/selinux/exports.c                      |  23 -
 security/selinux/hooks.c                        | 345 ++++---------
 security/selinux/include/audit.h                |   3 -
 security/selinux/include/objsec.h               |  38 +-
 security/selinux/selinuxfs.c                    |   4 +-
 security/selinux/ss/services.c                  |   1 -
 security/selinux/xfrm.c                         |   4 +-
 security/smack/smack.h                          |  44 +-
 security/smack/smack_access.c                   |   4 +-
 security/smack/smack_lsm.c                      | 316 ++++--------
 security/smack/smackfs.c                        |  18 +-
 security/tomoyo/common.h                        |  22 +-
 security/tomoyo/domain.c                        |   4 +-
 security/tomoyo/securityfs_if.c                 |  15 +-
 security/tomoyo/tomoyo.c                        |  49 +-
 security/yama/yama_lsm.c                        |   8 +-
 39 files changed, 1133 insertions(+), 793 deletions(-)

