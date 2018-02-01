Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3933199-1517499467-2-15004601133679489730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517499467; b=luGPi7OOhD7ML7TWJKZN3sCpm5/zBeuFkCtxXXWBcIyp29y
    iPCTQuUMcQ0NcLj+eua3hJVfh2SCMXn5bfZfTH6uwTWpO6O2kzsNJs+l+j4t3p4k
    cLSeF51qPOnHn5/xlqVtQcWyOISTr+2pdTMVhJoyyBbx2n3A7lAUYioR5GVS1hmE
    jzavBLCAz7dUIsblyrGgpmGXIzTA2j80elZJ3oUfANqsGAetNHIQUX5nStv1xvJq
    6iUFwiNcjeQZYAY1E0ncI95dPkgf0uKT0qkHSrCbb+xy+wyhJd6M6+msPVen+ceB
    lewbbV1sGFatCE7TGe6eEzES6haknF3gcXYPr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517499467; bh=PIoEMvLzBGw2hOwBdBBCjM7usb
    /qDiHGTM3VExME8gc=; b=FFYEgJDDFC11Gmy7UP5G08nk9IfsutNnsYbHb0RQsN
    zREAl1UfV9xsr/v2qKN4LdmDBCtl9F+FxT1Lh91AkszGht1RFWTYeMfxQkiz+Aba
    fiAtlq5DpRgZsX3EFcd5KCAZ1h/LJPCV5zyq11lgFLPGnkn/QbkNEtuSq/lHbQ/w
    OnD+Mt/l2ORq5g/reXT06HYO8knuVfooEvAXYwzt2a/pTuDwtRB1RiOLkYZwz9ln
    mpYWtAUq7sFWxh9RMTUsbhFCi8YvYyV0zYtW+XKhalLyiIcGdLf5jmwPGW/zXVcF
    4F+1UhlGLcHd0Xr7V6H6Y1qjHw1CaLfSGJxFroIrDW8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ARXlQ0o2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rSHK7/ic;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ARXlQ0o2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rSHK7/ic;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeBAPhl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:37:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44872 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBAPhj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 10:37:39 -0500
X-Google-Smtp-Source: AH8x225jJHmyXwvtB6sRWVeVwNs4PfTaNpBgzY7nJA8NHQxL1TODRgKP8mnByTcxreOh9t7yCd9lZA==
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
Subject: [PATCH v2] general protection fault in sock_has_perm
Date: Thu,  1 Feb 2018 07:37:04 -0800
Message-Id: <20180201153708.63506-1-salyzyn@android.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
flag") and all the associated infrastructure changes to take advantage
of a RCU grace period before freeing, there is a heightened
possibility that a security check is performed while an ill-timed
setsockopt call races in from user space.  It then is prudent to null
check sk_security, and if the case, reject the permissions.

Because of the nature of this problem, hard to duplicate, no clear
path, this patch is a simplified band-aid for stable trees lacking the
infrastructure for the series of commits leading up to providing a
suitable RCU grace period.  This adjustment is orthogonal to
infrastructure improvements that may nullify the needed check, but
could be added as good code hygiene in all trees.

general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 14233 Comm: syz-executor2 Not tainted 4.4.112-g5f6325b #28
task: ffff8801d1095f00 task.stack: ffff8800b5950000
RIP: 0010:[<ffffffff81b69b7e>]  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
RSP: 0018:ffff8800b5957ce0  EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff10016b2af9f RCX: ffffffff81b69b51
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000010
RBP: ffff8800b5957de0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 1ffff10016b2af68 R12: ffff8800b5957db8
R13: 0000000000000000 R14: ffff8800b7259f40 R15: 00000000000000d7
FS:  00007f72f5ae2700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a2fa38 CR3: 00000001d7980000 CR4: 0000000000160670
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 ffffffff81b69a1f ffff8800b5957d58 00008000b5957d30 0000000041b58ab3
 ffffffff83fc82f2 ffffffff81b69980 0000000000000246 ffff8801d1096770
 ffff8801d3165668 ffffffff8157844b ffff8801d1095f00
 ffff880000000001
Call Trace:
[<ffffffff81b6a19d>] selinux_socket_setsockopt+0x4d/0x80 security/selinux/hooks.c:4338
[<ffffffff81b4873d>] security_socket_setsockopt+0x7d/0xb0 security/security.c:1257
[<ffffffff82df1ac8>] SYSC_setsockopt net/socket.c:1757 [inline]
[<ffffffff82df1ac8>] SyS_setsockopt+0xe8/0x250 net/socket.c:1746
[<ffffffff83776499>] entry_SYSCALL_64_fastpath+0x16/0x92
Code: c2 42 9b b6 81 be 01 00 00 00 48 c7 c7 a0 cb 2b 84 e8
f7 2f 6d ff 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48 89
fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 01 00
00 41 8b 75 10 31
RIP  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
RSP <ffff8800b5957ce0>
---[ end trace 7b5aaf788fef6174 ]---

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Paul Moore <paul@linuxfoundation.org>
Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org
Cc: Eric Paris <eparis@parisplace.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: stable <stable@vger.kernel.org> # 3.18, 4.4
Cc: linux-kernel@vger.kernel.org
---
v2: return -EFAULT for null sk_security instead of 0

 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..795efa71d656 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4342,6 +4342,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
+	if (!sksec)
+		return -EFAULT;
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
-- 
2.16.0.rc1.238.g530d649a79-goog
