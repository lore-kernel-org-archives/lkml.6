Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999894-1525998653-2-17499746751143629748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525998653; b=CSEGguttEuymXGK1lr/1ongxM0GUGW4rY3A99t8omI6ne6Q3OL
    abeBKpPR3gwT2FYwsE51IahNo8tBmSgoV9ngYAiZ5cQ3WYTNYpHPb5GzlauVIrhd
    CNBqU7Gd31Ck72WuE2MJa3I+fNPaVj6gxo7GCjtwYHQvGgoXgtAuyY1/3rHFwMXi
    GZJg0rPuhi4jLQRQJ5Th/GoS9CExRBBLRkEv5owYXp7BbCJ1MRrNbM/8r1Zeu1Gd
    eqEShklStOZjgdb9wRTtv9YPYEk7xHazjFYi6Jm5NGrGsPDrHPTkeoftHj9bNevS
    wyE7qYZnATaE62bmNYAHf+Fgkqjo46NaAWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:from:subject:message-id:date
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525998653; bh=0+qMp9DLeTRpagERXLcuz+gxh2/kpc
    JtXsysxxTsKrU=; b=hVrxCsAH7Q9cWDJFJm2zOS/MHVAgj5vAOoxAYO59w+0lh2
    SLKzBSz1zrUuX2JMBsvsDyApRTDyRVrfd4p7LyMiFu0jOQvlezTa0XnRDIoSIYmB
    tne6Zw/ow0x2K7UW/+jltfkyKSBhm6G3or4sA/VWs2i/FEsoIR6e2PPKyADWMpR3
    6aOCyKghe0ZTOjTIiGSs58xeJFX0HFkpbbXqDyg09yXnl7uVaKtFJsl5SSpFFXtc
    B4p18ekKPz2zrPseEYQRC1hv3z2BBe1K4XpLedRBAF2Xo7GrnIQT/uae/V5lDiFe
    5iaBymlCLS+AyJgmTu6t2p6WYg+KYAeuoMsQUozQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=eQoz3Kay x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=eQoz3Kay x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbYqDMlzuCoHOvgrvAPz/RX4mn46hV4GMk0wE1gSuyhUBLkXOCNZ7kGV3C6gBdws8fdK0WoolX0IPs4Aiob3wO41n909RU57HgGhjGFFUirlrxeeQB9
    /I8nYSnbOnLOZmuttTJcac9pZK+wn8+nlSODMyntDAmKua8GEk6sLvpn1mIXeGfqFWP0WhLO7hZy1AGF8Gyj2jeOAeBKw2rnL/QC8MvMDDoVJeWGgDPHJESv
    /3xu/p6k3FJAT+ubD9JFMw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=pSjJ2bn1Q7EA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=1jWNtKtKhyqLJ7wtyYgA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750751AbeEKAau (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 20:30:50 -0400
Received: from sonic313-17.consmr.mail.ne1.yahoo.com ([66.163.185.40]:41498
        "EHLO sonic313-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750722AbeEKAat (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 20:30:49 -0400
X-YMail-OSG: n3eouo0VM1ngCJM_YoAJ7NBWR8uRlHcWxngCNGGdVmOIQ_tBAveD1PxNvJ1T_6g
 PFDti4Sh3etdsG.kA_qR3s6hxycjmfyH07AIHRiqnFDVCdqjtgPeGVCGFvYg50OkPmY7wvzEhK9M
 wsyzZYSJTqI910ErdpkKCAf4NfSBaDqmFePbcVkYVPKL1ICRgEMVDAG2j7YEyGf0aP3KWM0YKcmF
 x3A3FozoRYl5W_mL_0mxStbe9n.of_u2.R2ZB9P73z7G6Ij5ygh.Z7tYI6JNECjNUeB4t6dE8xkv
 6poWZTe6pSprc6ujXOp3Dd3Rd4sRn7828G1xJRICX.LIX9FwUEVxVMuFsVzOzwzsebh7dCxcFHBd
 skizuu10OW6h7xLuVE4C_s9Y0krK5kAvX7upHsrs3.zZoFpBxgyyujJyTJm9cghvfg03uG8otd4J
 dRrcLuKYm_3itjPekOjSlLDpcQ.s7SzPX9aOwEgxNgtK_CQRcn96rNyIJrMmwV15fsY.zJx255_D
 muph_lh0IcVrV6TgwSYdWknJ8VlZuylBFYLTdp8aKvkb_UvnQQ7h9lchZzacuOf.FosL4.zoTbvK
 Dub5iY7IFwonE4iKFifxdJJA.ahaRMEFk6tGjBg3PTcTe2Z9CbCOC70RwvYoqigY.7jcvuRCQ8yN
 VHI4-
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 00/23] LSM: Full security module stacking
Message-ID: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Date: Thu, 10 May 2018 17:30:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Subject: [PATCH 00/23] LSM: Full security module stacking

Here it is, the whole nine yards, broken into mostly
review friendly pieces. I believe that it would make
a good deal of sense to take this in two bites, with
the infrastructure managed blobs going first and the
secid conversion coming later. I hope there will be some
debate around that.

The blob management part is pretty clean by now. I
welcome serious review on that. The secid part is more
wobbly, but I am convinced that it's the right direction
if not perhaps always the best possible implementation.
AppArmor in in the process of a major overhaul, and that
slowed me down a bit as I had to do new work to convert
it to use the new mechanisms.

I had experimented with secid "tokens" in the hope of
minimizing API changes. That doesn't work. Changing
the APIs to use a struct secids pointer in place of a
u32 is brutal to the diffstat, but reduces the amount
of active code that has to change, and really makes
data management easier.

If there are two possible ways to do a thing you will
find them both in the networking code. AF_UNIX, netfilter,
SO_PEERSEC and netlabel each has its own clever ways
to manipulate security information. I think I nailed
them all, but I'm not betting more than a beer on it.

There could be issues in the audit code, although nothing
jumped out immediately. The same goes for the integrity
subsystem. I haven't tried Infiniband or very many
filesystem types that don't com standard with Fedora or
Ubuntu.

I have fixed everything I've found. If you find something
(please look!) let me know.

Tested primarily on virtual machines.
	Fedora 25-27 - SELinux, Smack and the two together
	Ubuntu 17.04 - AppArmor and AppArmor + Smack

The SELinux test suite completes successfully unless
you add in Smack, in which case it fails where you would
expect it to due to the different use models for netlabel.
Smack tests work as well. AppArmor was tested by booting
Ubuntu, but not beyond.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 Documentation/admin-guide/LSM/index.rst   |  23 +-
 fs/btrfs/super.c                          |  10 +-
 fs/proc/base.c                            |  63 +-
 fs/proc/internal.h                        |   1 +
 include/linux/cred.h                      |   3 +-
 include/linux/lsm_hooks.h                 |  85 ++-
 include/linux/security.h                  | 211 +++++--
 include/net/flow.h                        |   5 +-
 include/net/netlabel.h                    |  16 +-
 include/net/scm.h                         |   4 +-
 include/uapi/linux/netfilter/xt_SECMARK.h |   1 +
 include/uapi/linux/prctl.h                |   4 +
 kernel/audit.c                            |  25 +-
 kernel/audit.h                            |   9 +-
 kernel/auditfilter.c                      |   4 +-
 kernel/auditsc.c                          |  44 +-
 kernel/cred.c                             |  19 +-
 kernel/fork.c                             |   3 +
 net/ipv4/cipso_ipv4.c                     |  19 +-
 net/ipv4/ip_sockglue.c                    |   6 +-
 net/netfilter/nf_conntrack_netlink.c      |  22 +-
 net/netfilter/nf_conntrack_standalone.c   |  11 +-
 net/netfilter/nfnetlink_queue.c           |  14 +-
 net/netfilter/xt_SECMARK.c                |  44 +-
 net/netlabel/netlabel_kapi.c              |  52 +-
 net/netlabel/netlabel_unlabeled.c         |  30 +-
 net/netlabel/netlabel_unlabeled.h         |   2 +-
 net/netlabel/netlabel_user.c              |   4 +-
 net/unix/af_unix.c                        |  19 +-
 net/xfrm/xfrm_policy.c                    |   5 +-
 net/xfrm/xfrm_state.c                     |   2 +-
 security/Kconfig                          |  80 +++
 security/Makefile                         |   1 +
 security/apparmor/domain.c                |   2 +-
 security/apparmor/include/cred.h          |  24 +-
 security/apparmor/include/file.h          |   9 +-
 security/apparmor/include/lib.h           |   4 +
 security/apparmor/include/net.h           |  10 +-
 security/apparmor/include/task.h          |  22 +-
 security/apparmor/lsm.c                   | 131 ++--
 security/apparmor/task.c                  |   6 +-
 security/integrity/ima/ima.h              |  10 +-
 security/integrity/ima/ima_api.c          |   5 +-
 security/integrity/ima/ima_appraise.c     |   4 +-
 security/integrity/ima/ima_main.c         |  22 +-
 security/integrity/ima/ima_policy.c       |  11 +-
 security/security.c                       | 973 +++++++++++++++++++++++++++---
 security/selinux/hooks.c                  | 658 ++++++++------------
 security/selinux/include/audit.h          |   2 +-
 security/selinux/include/objsec.h         |  87 ++-
 security/selinux/include/xfrm.h           |   9 +-
 security/selinux/netlabel.c               |  33 +-
 security/selinux/selinuxfs.c              |   5 +-
 security/selinux/ss/services.c            |  13 +-
 security/selinux/xfrm.c                   |  29 +-
 security/smack/smack.h                    |  90 ++-
 security/smack/smack_access.c             |   6 +-
 security/smack/smack_lsm.c                | 673 ++++++++++-----------
 security/smack/smack_netfilter.c          |  19 +-
 security/smack/smackfs.c                  |  32 +-
 security/tomoyo/common.h                  |  31 +-
 security/tomoyo/domain.c                  |   4 +-
 security/tomoyo/securityfs_if.c           |  15 +-
 security/tomoyo/tomoyo.c                  |  57 +-
 64 files changed, 2581 insertions(+), 1256 deletions(-)

