Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D2CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0549208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eSVwyCor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0549208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391689AbeIVFul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:50:41 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:42299 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725756AbeIVFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537574367; bh=yI3y1RAtSUaa5X1VvZSk6B45eg3cxiuzbkTHwex6+Dg=; h=To:Cc:From:Subject:Date:From:Subject; b=eSVwyCor/lRzgf6+0y+9BIrJSnKB/tZeNCA8eMkBsd+MsJO4lrds+pVZVL9PmB4fIgaj8o67iPuINtvSZ6wVwXtQ6kC7OTePPm94xjrCW0kuq1MPq2dNJFJ12tbr1Fdb4apAh7zdeLy3BrCNB77HzL73zf1MEMePKL34mlwT0/Ili5AeWCQJaGalIqJAyQcylbTfayHn1Oj/eFitH5bmm/txPoHdXyM44TsTKSsfzEp5TeVAbx3RJHHWkeo7LzSGIQvsk6zzzWnjU84Vzp7mwcffKtqAZ91xmFB56PNiXPdp/tyhedkVQSRMiKejkRv7Y3p5t7FvSHtXzziZND+X7A==
X-YMail-OSG: 2o2_My4VM1nj9fCc.p9RosUdWmqEZxrgtOGjHbebznsNMnV2UR.Ok56w2g4M0FW
 pnlwJdulbpztUwcUke63q1bmNnNLex.MrpGfiSZaJnLIdbLtMf0WlBW8Drb1T6tgSUZ0ucb2HiTy
 8pfNWIhV5leT15aAidyvawKG47Nhl7VflF25q0WBijcvHgLLZhW4kpBZbpFHRRzIJQj1rpK7rLEV
 p6ITsW25.HQFMDIeWe2rrDORCBu95MP3bWjm.7JIkowWH566NsPRkIsUUJnwY68h6p9_Rw54pLtz
 6BcKGsQzrYdntliXLV62oMrqNzK_fw1.lZ8z8BblyuxV_dHLoV_.Cz8IB91U1Yq9t3x5TtvSH47v
 BZ1.XWmf7ln9Nh_n2uEnEX59fokuph_6hlGcBoo5sehjzS2qmhy_TB.Dnj1ErTIr3ecZHbf9gXTn
 shNemP7mCPTu4eX4e8LzgEiV9n4B6uJ7sZmAs6xRQ5nH_tO4ny1TKTj7HBolBzYw8A5KQYPIo9Q0
 8T2oMOvXimHNKyZGzyZHSN05UUuV6WRWCwHxvaCxfYZCSNWlL0dcPQsnfU7SBXRYmVYArwaUFE3M
 d6cKTwiPahzSmdv7pfbedlCCXagEjnlt_OrkeMtxg1B166DxzWFEnVtPfAsC_yVdioLCww7rPr78
 DKGJAjzeKggDrBycgAgw6RI4_wwEVpTY2ywEf9dAvYZVpGzEytBKQ5YXmaYmyXqwNILmo5c0tmVY
 9BgMEit1X00qzcqxuwS0Su7J3rqAhub2OduCcrAnN3DQ9k21mCYM7fcqclZ8xY2xD4KDy08ByiPL
 yHkt09LgpDajycxyj55ti7y5fsgP58XAfT4Njp9i306pxLgLjbiUJ5KSgESx8OlU5IG9YYjtTh6S
 XS1lQfZK03NQ1EgDGtgDk1Q5oIKiSIbBVtW8FYWJBl14l7II5fvrJuMBpc5DQA3n8clLWhN51tXl
 pXzUXcEENo3riv_hIZzUqAjbb62Oa4S6teUV8gIgGR4Kfp2ZUXgyE6K5ydC_OR4ET9ReRsz2jwZL
 hK3lZDmS8A0qciQhgTCTBbrR5fTidLRRTS9p3nQh1oSnYriIfbHW6B2MbDlOxtw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 23:59:27 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2bea0198d08c0840eb41a19b0854a8e4;
          Fri, 21 Sep 2018 23:59:26 +0000 (UTC)
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
Subject: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
Message-ID: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 16:59:21 -0700
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
the same time as the other "major" modules.

The mechanism for configuring which security modules are
enabled has to change when stacking in enabled. Any
module that uses just the security blobs that are shared
can be selected. Additionally, one other "major" module
can be selected.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, SARA and LandLock.

git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock-v4

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
 security/smack/smack_lsm.c              | 315 ++++++++---------------
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  26 +-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 ++++-
 33 files changed, 1098 insertions(+), 651 deletions(-)

