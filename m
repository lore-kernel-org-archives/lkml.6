Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836762-2-1026010323366030218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836762; b=BDXaa1VBvUoBB9Xlh2YzbYhNDOK70mm90XOxOSPyFLUQ1pw
    ulgy2OUtlrrSIX+XLvHImVsu3UjUfnLieFZh1TznrfiCsCBCBNlLMG/kyo/TwMlN
    vn15MmUu3FuJWK9jFw7ts3+qASMoCHGOMrBOOpfWf7r2kGw4PnNSOQ7pltkG0WJk
    1C5ksGw3Cz0djjLFmjx8W5h5/qKAqdKUbY1c1+IoGpUNT5rlCM0f4j2Kb11box+l
    uBYNyf/L0pbzeKzDFoX5RdhGboQpBoKroMX1HMRLQo8na/LgU093P9p3iM1vddHH
    CMK2/aFfdMIVmARX79W21k9vrhlqHHK4yNfV8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836762; bh=EP+kInWZwS6IvseZsyR
    +GBJ6xEHqCywIg6MQhFWRXEA=; b=mbnmVpbEpAPb67ZhqOIuAB8+SY3WVcbFEnb
    4pbNWt2jDSopuCo1bIAuq2t0HcYVU3sbNsX2BMOBr2LGlZk5GogEoT3HImlcgCNr
    POCL1gld/4qKj3Q9PjPFw2NrQnycDHbvmSYxVGejd9TllU3AZXTs/O8YtMr9f43Z
    PIzIQHHt6Ka/l64aPZaadU/oFXleeFn1+5CxOCyKD9GbT6igFHIbyPKwoWFLf+N/
    bErl3RwB38wsfXQrQz2VBwL4vCwyCCkY9dS1Fgjkm/R0h02MGGafpzTLHz5vWfVh
    S3EWMUW9qIq2gpYQrNYssaCKM24Aj8LJioP2JZutOS+iDcapUoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeB1Qw2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:52:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34549 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752952AbeB1P6K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Santosh Shilimkar" <santosh.shilimkar@oracle.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        "=?UTF-8?q?H=C3=A5kon=20Bugge?=" <Haakon.Bugge@oracle.com>,
        "=?UTF-8?Q?H=C3=A5kon=20?=Bugge" <haakon.bugge@oracle.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.428739271@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 254/254] rds: Fix NULL pointer dereference in
 __rds_rdma_map
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Håkon Bugge <Haakon.Bugge@oracle.com>

commit f3069c6d33f6ae63a1668737bc78aaaa51bff7ca upstream.

This is a fix for syzkaller719569, where memory registration was
attempted without any underlying transport being loaded.

Analysis of the case reveals that it is the setsockopt() RDS_GET_MR
(2) and RDS_GET_MR_FOR_DEST (7) that are vulnerable.

Here is an example stack trace when the bug is hit:

BUG: unable to handle kernel NULL pointer dereference at 00000000000000c0
IP: __rds_rdma_map+0x36/0x440 [rds]
PGD 2f93d03067 P4D 2f93d03067 PUD 2f93d02067 PMD 0
Oops: 0000 [#1] SMP
Modules linked in: bridge stp llc tun rpcsec_gss_krb5 nfsv4
dns_resolver nfs fscache rds binfmt_misc sb_edac intel_powerclamp
coretemp kvm_intel kvm irqbypass crct10dif_pclmul c rc32_pclmul
ghash_clmulni_intel pcbc aesni_intel crypto_simd glue_helper cryptd
iTCO_wdt mei_me sg iTCO_vendor_support ipmi_si mei ipmi_devintf nfsd
shpchp pcspkr i2c_i801 ioatd ma ipmi_msghandler wmi lpc_ich mfd_core
auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2
mgag200 i2c_algo_bit drm_kms_helper ixgbe syscopyarea ahci sysfillrect
sysimgblt libahci mdio fb_sys_fops ttm ptp libata sd_mod mlx4_core drm
crc32c_intel pps_core megaraid_sas i2c_core dca dm_mirror
dm_region_hash dm_log dm_mod
CPU: 48 PID: 45787 Comm: repro_set2 Not tainted 4.14.2-3.el7uek.x86_64 #2
Hardware name: Oracle Corporation ORACLE SERVER X5-2L/ASM,MOBO TRAY,2U, BIOS 31110000 03/03/2017
task: ffff882f9190db00 task.stack: ffffc9002b994000
RIP: 0010:__rds_rdma_map+0x36/0x440 [rds]
RSP: 0018:ffffc9002b997df0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff882fa2182580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffc9002b997e40 RDI: ffff882fa2182580
RBP: ffffc9002b997e30 R08: 0000000000000000 R09: 0000000000000002
R10: ffff885fb29e3838 R11: 0000000000000000 R12: ffff882fa2182580
R13: ffff882fa2182580 R14: 0000000000000002 R15: 0000000020000ffc
FS:  00007fbffa20b700(0000) GS:ffff882fbfb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c0 CR3: 0000002f98a66006 CR4: 00000000001606e0
Call Trace:
 rds_get_mr+0x56/0x80 [rds]
 rds_setsockopt+0x172/0x340 [rds]
 ? __fget_light+0x25/0x60
 ? __fdget+0x13/0x20
 SyS_setsockopt+0x80/0xe0
 do_syscall_64+0x67/0x1b0
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7fbff9b117f9
RSP: 002b:00007fbffa20aed8 EFLAGS: 00000293 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000000c84a4 RCX: 00007fbff9b117f9
RDX: 0000000000000002 RSI: 0000400000000114 RDI: 000000000000109b
RBP: 00007fbffa20af10 R08: 0000000000000020 R09: 00007fbff9dd7860
R10: 0000000020000ffc R11: 0000000000000293 R12: 0000000000000000
R13: 00007fbffa20b9c0 R14: 00007fbffa20b700 R15: 0000000000000021

Code: 41 56 41 55 49 89 fd 41 54 53 48 83 ec 18 8b 87 f0 02 00 00 48
89 55 d0 48 89 4d c8 85 c0 0f 84 2d 03 00 00 48 8b 87 00 03 00 00 <48>
83 b8 c0 00 00 00 00 0f 84 25 03 00 0 0 48 8b 06 48 8b 56 08

The fix is to check the existence of an underlying transport in
__rds_rdma_map().

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/rds/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -184,7 +184,7 @@ static int __rds_rdma_map(struct rds_soc
 	long i;
 	int ret;
 
-	if (rs->rs_bound_addr == 0) {
+	if (rs->rs_bound_addr == 0 || !rs->rs_transport) {
 		ret = -ENOTCONN; /* XXX not a great errno */
 		goto out;
 	}
