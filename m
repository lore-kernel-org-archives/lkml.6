Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7268B2089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t4rcTt62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268B2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGPSVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:21:46 -0400
Received: from sonic308-15.consmr.mail.gq1.yahoo.com ([98.137.68.39]:45269
        "EHLO sonic308-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbeGPSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531763595; bh=BqEmp6lNho3OT2kAFjgDnmzg5F/F/DOGszRyfkOizu4=; h=To:Cc:From:Subject:Date:From:Subject; b=t4rcTt62LNAGm54xCiEado66VRys7yGCMMObBtmA3S2ZphiTS6NvEgvcmVVNSX8WWSgInR+G/p0xlJlNZaXV7LqCqu/iiu+DbvpcdWnBQN/2hL7LY/jkOFJAwnKZczWQkebXUkYrUxIDv71A54aamRK0MDOKMQSspAT+wRbPNJDQ9Fn5hZekQYCtF95QFpn3gx2EjpT8OLIOLY1lZWqkJtVg2sjs4RH67Q45IbO0S78hyggl6KfpPj0zy0eYEjqH61C6d/DhofxTH0cXhsR0F6NnG3IgpKi7AY7xI4gMW/9joC971k6zBQE7GTI4bN1ot5Z4cpijhLzT6XPDCvUv6A==
X-YMail-OSG: lL83zB8VM1kl0etlOYWWrzz8ihLhCvUwBn1ppB3oTzW1TLs3XImwV4vwD.xQnf0
 jAZsaxAY9S3U8kJVhKK4y5oT1VjTPFEhx2Kd_x9McKqXqMoFdw7nuG5Cb8AUE3JvCXc18OOL8U94
 yLjIjUTpsT6zbf50qnH.JfLLVfHJ0oMc7CQcT2OSOwfhlmpv8vpEPWO2cqo_1XOZ8VU_hsEjXJuR
 tB6Gf.r4GMEepNxT0iYPPM9jh6QSOmdzZuREafDJYMVcnE9gO4Dm2aNLLatbycnnfLVK9G6uBA5h
 ZhzroXNBejmGgv.0fgNbHMAltxSkwAILd.M9_3Ta3TR5qtng7BGKsMzOoVekp2YueX6GVAn6efgP
 oF6J9y6YuqDA_c5LyNpM7YKbR3tkZgxZF0ZGBT_h443r8O.rw9qBElT40DLfW2AbcDDNXxN4Uvj8
 yW_bliBVXQCiUX4FAq43ZXIZrGNpRGRb7Y_oJdZ7lQA9McJAzi5oe1kJsVw5pljYE4dw0KHWbQ1_
 6Xoo2hGT50URU518M8fBLGS21Op0Kqt_ZAhSvKRyXPDLm9yKGAneoK3ADxxwKWut0iKqZ1B8LFO1
 ELMLitCpwP3ZO12yeMsR0d8QFURd6p4oaBvGKwhJsN7cGTn0V5xVBzISAM7bR1NvABEBrwkDx5C3
 72XSfSm1YjJWrTYCISvKiS1N0YAczOjTII3sY3ClEqbA.V7C1LzHdEQ51Ij4TbdenGwa.I9GjwdN
 4SlIwJp_lSi8159ApoNLcuDltUHFLSejZzwuXhyQD8t7DcFPbQO1BgYpancrLRJwCMmR8wuMlDUW
 4eZzDZ6r8CXRaZXWwYXTrU7HrTawkfPZ0sOPfZ31v_Klfe0H_fdyvwZvFAnv3cWa0uwV8CiMPYaL
 c1vcBj5EGuNlsH.Xhu8bSQSF2O8D5WLqn5sDeSiVjUwZ0HgJEJ9J6U73JmxTKJV5OpT.L1Lf7XpS
 Boz_NIXhHu0y.7kJeE5ROMwXxbA6Toz_ayGoaP7XxWaN29LoFqhJyfJCdX7RdFRcmPKp3fk.6zDY
 VpSqQLFfME7EwcEwPdw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 17:53:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6920eca4f583262f3ce6b6c9eb2cf759;
          Mon, 16 Jul 2018 17:53:12 +0000 (UTC)
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v1 00/22] LSM: Full security module stacking
Message-ID: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 10:53:09 -0700
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

LSM: Full security module stacking

I'm calling this v1 not because it's the first version
I've put out but because it's the first version I'm getting
serious external pressure to get upstream. 

The blob management part (through "LSM: Sharing of security blobs")
is ready for prime-time. These changes move the management of
security blobs out of the security modules and into the security
module infrastructure. With this change the proposed S.A.R.A,
LandLock and PTAGS security modules could co-exist with any of
the existing "major" security modules. The changes reduce some
code duplication. 

Beyond the blob management there's a bit of clean-up.
Mounting filesystems had to be changed so that options 
a security module doesn't recognize won't be considered
a fatal error. The mount infrastructure is somewhat
more complex than one might assume. 

If there are two possible ways to do a thing you will
find them both in the networking code. AF_UNIX, netfilter,
SO_PEERSEC and netlabel each has its own clever ways
to manipulate security information. I think I nailed
them all, but I'm not betting more than a beer on it.

SELinux and Smack have different ideas regarding how
IP packet labels should be treated. SELinux will use
CIPSO to include the multilevel security (MLS) component
of the security context, but only under certain conditions.
Smack will encode the label into the CIPSO option unless
explicitly told not to. SELinux is typically configured
to use unlabled networking. Smack uses labeled networing
by default. As a result configuring a system with these
two security modules to make IP networking useful is a
challenge. This patch set makes the combination safe, but
making it strictly useful is a challenge. 

There could be issues in the audit code, although nothing
jumped out immediately. The same goes for the integrity
subsystem. I haven't tried Infiniband or very many
filesystem types that don't com standard with Fedora or
Ubuntu.

Tested primarily on virtual machines.
	Fedora 25-27 - SELinux, Smack and the two together
	Ubuntu 17.04 - AppArmor and AppArmor + Smack

The SELinux test suite completes successfully unless
you add in Smack, in which case it fails where you would
expect it to due to the different use models for netlabel.
Smack tests work as well. AppArmor was tested by booting
Ubuntu, but not beyond.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Casey Schaufler (22):
  procfs: add smack subdir to attrs
  Smack: Abstract use of cred security blob
  SELinux: Abstract use of cred security blob
  LSM: Infrastructure management of the cred security blob
  SELinux: Abstract use of file security blob
  LSM: Infrastructure management of the file security blob
  LSM: Infrastructure management of the task security blob
  SELinux: Abstract use of inode security blob
  Smack: Abstract use of inode security blob
  LSM: Infrastructure management of the inode security
  LSM: Infrastructure management of the superblock security blob
  LSM: Infrastructure management of the sock security
  LSM: Infrastructure management of the ipc security blob
  LSM: Infrastructure management of the key security blob
  LSM: Mark security blob allocation failures as unlikely
  LSM: Sharing of security blobs
  LSM: Allow mount options from multiple security modules
  LSM: Use multiple secids in security module interfaces
  LSM: Use multiple secids in LSM interfaces
  Move common usercopy into security_getpeersec_stream
  LSM: Multiple concurrent major security modules
  Netfilter: Add a selection for Smack

 Documentation/admin-guide/LSM/index.rst   |  23 +-
 fs/btrfs/super.c                          |  10 +-
 fs/proc/base.c                            |  63 +-
 fs/proc/internal.h                        |   1 +
 include/linux/cred.h                      |   3 +-
 include/linux/lsm_hooks.h                 |  85 +-
 include/linux/security.h                  | 214 +++--
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
 net/core/filter.c                         |   4 +-
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
 net/xfrm/xfrm_state.c                     |   3 +-
 security/Kconfig                          |  80 ++
 security/Makefile                         |   1 +
 security/apparmor/audit.c                 |   4 +-
 security/apparmor/domain.c                |   2 +-
 security/apparmor/include/audit.h         |   2 +-
 security/apparmor/include/cred.h          |  24 +-
 security/apparmor/include/file.h          |   9 +-
 security/apparmor/include/lib.h           |   4 +
 security/apparmor/include/net.h           |  10 +-
 security/apparmor/include/secid.h         |   5 +-
 security/apparmor/include/task.h          |  22 +-
 security/apparmor/lsm.c                   | 135 ++-
 security/apparmor/secid.c                 |   9 +-
 security/apparmor/task.c                  |   6 +-
 security/integrity/ima/ima.h              |  10 +-
 security/integrity/ima/ima_api.c          |   5 +-
 security/integrity/ima/ima_appraise.c     |   4 +-
 security/integrity/ima/ima_main.c         |  22 +-
 security/integrity/ima/ima_policy.c       |  11 +-
 security/security.c                       | 989 ++++++++++++++++++++--
 security/selinux/hooks.c                  | 673 ++++++---------
 security/selinux/include/audit.h          |   2 +-
 security/selinux/include/objsec.h         |  87 +-
 security/selinux/include/xfrm.h           |   9 +-
 security/selinux/netlabel.c               |  33 +-
 security/selinux/selinuxfs.c              |   5 +-
 security/selinux/ss/services.c            |  13 +-
 security/selinux/xfrm.c                   |  29 +-
 security/smack/smack.h                    |  90 +-
 security/smack/smack_access.c             |   8 +-
 security/smack/smack_lsm.c                | 710 +++++++---------
 security/smack/smack_netfilter.c          |  19 +-
 security/smack/smackfs.c                  |  32 +-
 security/stacking.c                       | 119 +++
 security/tomoyo/common.h                  |  31 +-
 security/tomoyo/domain.c                  |   4 +-
 security/tomoyo/securityfs_if.c           |  15 +-
 security/tomoyo/tomoyo.c                  |  57 +-
 70 files changed, 2764 insertions(+), 1294 deletions(-)
 create mode 100644 security/stacking.c

-- 
2.17.1


