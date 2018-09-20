Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4ECC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72AD21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eY1gxgJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72AD21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeITFnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:43:41 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:41173 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbeITFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537401795; bh=Exw5ROEUmfrOFWgy0sP4/0zWnjaQWlK5nyPy5QJvY3w=; h=To:Cc:From:Subject:Date:From:Subject; b=eY1gxgJ7fCH4USWlHI7LW0ZpNTZGMvP/aq07zAdv7j8QUrDsKBjKPSK7Qv2PwQzSTwLH+a1MEPLLjy4DTmJ7uROSS1avJt0RnqWzTCRRpnugQX/Sns7BskTudMT6c+BuFJkF/0GrTrICs683k9xCxjlOmCD8fB5wi59YcJP4Bu5WNvtTsrLOTI/oI2Lg3E5UVZrBpaBwH1h8andLlXO+iKJGs1RzTHF6yP7R+whswdjMGVRCeq45r+pyQ2rmBXPy+pa7AniYyP+zLUsrzVmNCJXDdWsXYfYz44Z0roH7M417CqNKHAa5oN3csSauf9lTzpj7QSsofYqwRgHwAe32pQ==
X-YMail-OSG: odz_v2kVM1kuxXxMBiyWhd4Ic7FzPn.NiRzWkmDmbR9xmYY5q4Ibxpur7KRAmTn
 3AWPH50mb7GIZ85TopVsPE2OXg29ClH_2KDs2s2F0FQqVCbPF50nFVHczEzZrDSKfENhdttbNRrx
 iQNuCEY9.fL5kt1Dwvsf7ft6HgUfsFMXvyBiWWnbNqIFbM_uDX2DpUq0RCClI7TMcwGqLvxy6JOq
 .xrBhKsKT4cTHG_fzRr1p6uVwiHWUL31NfwklR93gSJTQf_Ey_tSzqoRag2EDdpmjm1JWiWsrNL1
 yR0Zr2E6NgewhllZV7X41rowYRi_LUYfE1kaLvX.4H8CD_hKH_ixoLBfzrtSjkrhRgOahPBWBiLY
 GhDGcrkqoJ1xekrWPBOAXS._xN75jhfbFlyn0l_.Zutzlw75.FR4EKcZ9MdOMF_5Mkqv.UTIrXn3
 jFiCuSbnChGS3.VsHsCu4Qvtm2wd_6o3BLa0UStCbj9t_19aVGT_M6wXOWVpLD7SJwWF5QCgates
 NZuA.HicZyiaPbqH9tG8d8rCbkat4bKkvDmptdDoSEwMDXCgf0J7CYKh.3q1ooTH6keURzHrYFdm
 YEmx6XKMmgxBqjczCEkwELz8TWavYe.2UvwvNoNvX9wRTKeKCYkSWuomyPftxCNr8eiMrANV46s5
 aREsxJZx..FlpuwbUYFCwUKDF3UYaLXj9Jh5HhrjtcF5rBNPws_lFOiGxYarc7rT0rUklONRBklJ
 9ooe6pD43Qdd_s22tY3xCkSeNRd7TfsXXlD5in8o.UMkp.W4.SAXttgiKbVfmtyvsbwlgouEoYqn
 z6bPSq0VSrOq1KonQvqVEpJRjh8Yu6Mz_JFh40fCgNUzpFS2AOV5802FRygAqmU0o5A.p1twXOvJ
 sSoImPNsSLP2jcJhmU696vrfNKTgpnQUmg9IED0hvWInZg3RaEyUTlKAqaLHjjpt56JKRDPfj9Cm
 L24gCqF2CYSxlZHITjYT3ZV5QvBv8o_8iwpGWpxHonqL2vlmik81IWStUxS9IA2CWpGPeuT.szn4
 C9IS7zNcVL0EDidaa977xFNWpskI6M3LQPaNPz.ye35jFTopoJMrSA1waAGSG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:03:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 79a76e94bc2d90ea758671617c1884f5;
          Thu, 20 Sep 2018 00:03:13 +0000 (UTC)
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v3 00/16] LSM: Module stacking in support of SARA and Landlock
Message-ID: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:03:09 -0700
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

LSM: Module stacking in support of SARA and Landlock

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
the same time as the other "major" modules.

The mechanism for configuring which security modules are
enabled has to change when stacking in enabled. Any
module that uses just the security blobs that are shared
can be selected. Additionally, one other "major" module
can be selected.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, SARA and LandLock.

git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock-v3

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 +-
 fs/proc/base.c                          |  64 ++++-
 fs/proc/internal.h                      |   1 +
 include/linux/cred.h                    |   1 -
 include/linux/lsm_hooks.h               |  24 +-
 include/linux/security.h                |  15 +-
 include/linux/selinux.h                 |  35 ---
 kernel/cred.c                           |  13 -
 security/Kconfig                        |  92 +++++++
 security/apparmor/domain.c              |   2 +-
 security/apparmor/include/cred.h        |  24 +-
 security/apparmor/include/file.h        |   9 +-
 security/apparmor/include/lib.h         |   4 +
 security/apparmor/include/task.h        |  18 +-
 security/apparmor/lsm.c                 |  68 +++--
 security/apparmor/task.c                |   6 +-
 security/security.c                     | 438 ++++++++++++++++++++++++++++++--
 security/selinux/Makefile               |   2 +-
 security/selinux/exports.c              |  23 --
 security/selinux/hooks.c                | 333 +++++++-----------------
 security/selinux/include/audit.h        |   3 -
 security/selinux/include/objsec.h       |  48 +++-
 security/selinux/selinuxfs.c            |   4 +-
 security/selinux/ss/services.c          |   1 -
 security/selinux/xfrm.c                 |   4 +-
 security/smack/smack.h                  |  55 +++-
 security/smack/smack_access.c           |   4 +-
 security/smack/smack_lsm.c              | 329 +++++++++---------------
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  31 ++-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 ++++-
 33 files changed, 1109 insertions(+), 659 deletions(-)

