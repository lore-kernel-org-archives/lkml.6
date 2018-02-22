Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3576481-1519283321-2-8383827000579457952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519283321; b=Nv6hwtivuG25pTEEVPqngQriZAmE2Z0764nbacaCdHlgeiB
    3Mgw/M3Z3GEtekh1u5gB4h+I65g6usOPyDPEIUPHdis50ho4G897HHJyJSMxFkxA
    ECIGGf/xAeZsJnvkh1Idz+AdKQlh/jT+uaPSO28NR2JPFPf5AwLRFCOh67RznvNw
    Eo3Pud4R+tUWgQL1wn8kgTJBaGT7lp23NjFM4g5xZ8g21+n9pODzUR5ikI9XpTrp
    0oBlDokMtTeqKfB+K//KVFkGKam/HzuWtLI5PIyAVIog0kJ4vBO/bKsUPSTfwSK7
    /k1gyysChD/D3Aym3hDtbSv572LXwsEeAcfEhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:message-id:date:sender
    :list-id; s=arctest; t=1519283321; bh=s0yGXthRmV24Qm1tAZO/8oGveZ
    TEp2zdkykm95FtIOQ=; b=LPfEFDfzKGQ5ajCAHTc0crQQnhfZLi75F1xTxuLdcF
    q13f06Z9agmYxvbIEGatNHd72PAe5HDC6/y1Xx5GGX9rTiuL9gMn/UHQr9gFZQsY
    yyuM0hmQ3VF59UpqpmEpeasduN5ueP9vCVPGQh50xmeeiMLoZURMyLk/m1/y4xja
    CpFDO4UyDhURnKag3qxX8rYdIwfqs9vGlDNNvLflf+0PYV9wbZ2vR5Qdop6UGQMe
    g2zrlaX7B4TbNQCmdZeWFiaE6skxAoxf8EDsOok6xOsUxX41zCZOQqZsT4wT2Kz2
    cF1MH9U2Dym8D/yO6QXh4Cm7BqkTXIIEW+C2KzRWqdHg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeBVHGX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 02:06:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:27119 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbeBVHGS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:18 -0500
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14, 4.9] crypto: talitos - fix Kernel Oops on hashing an empty file
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        stable@vger.kernel.org
Message-Id: <20180222070616.A15E36CBD4@po15720vm.idsi0.si.c-s.fr>
Date: Thu, 22 Feb 2018 08:06:16 +0100 (CET)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream 87a81dce53b1ea61acaeefa5191a0376a2d1d721

Performing the hash of an empty file leads to a kernel Oops

[   44.504600] Unable to handle kernel paging request for data at address 0x0000000c
[   44.512819] Faulting instruction address: 0xc02d2be8
[   44.524088] Oops: Kernel access of bad area, sig: 11 [#1]
[   44.529171] BE PREEMPT CMPC885
[   44.532232] CPU: 0 PID: 491 Comm: md5sum Not tainted 4.15.0-rc8-00211-g3a968610b6ea #81
[   44.540814] NIP:  c02d2be8 LR: c02d2984 CTR: 00000000
[   44.545812] REGS: c6813c90 TRAP: 0300   Not tainted  (4.15.0-rc8-00211-g3a968610b6ea)
[   44.554223] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48222822  XER: 20000000
[   44.560855] DAR: 0000000c DSISR: c0000000
[   44.560855] GPR00: c02d28fc c6813d40 c6828000 c646fa40 00000001 00000001 00000001 00000000
[   44.560855] GPR08: 0000004c 00000000 c000bfcc 00000000 28222822 100280d4 00000000 10020008
[   44.560855] GPR16: 00000000 00000020 00000000 00000000 10024008 00000000 c646f9f0 c6179a10
[   44.560855] GPR24: 00000000 00000001 c62f0018 c6179a10 00000000 c6367a30 c62f0000 c646f9c0
[   44.598542] NIP [c02d2be8] ahash_process_req+0x448/0x700
[   44.603751] LR [c02d2984] ahash_process_req+0x1e4/0x700
[   44.608868] Call Trace:
[   44.611329] [c6813d40] [c02d28fc] ahash_process_req+0x15c/0x700 (unreliable)
[   44.618302] [c6813d90] [c02060c4] hash_recvmsg+0x11c/0x210
[   44.623716] [c6813db0] [c0331354] ___sys_recvmsg+0x98/0x138
[   44.629226] [c6813eb0] [c03332c0] __sys_recvmsg+0x40/0x84
[   44.634562] [c6813f10] [c03336c0] SyS_socketcall+0xb8/0x1d4
[   44.640073] [c6813f40] [c000d1ac] ret_from_syscall+0x0/0x38
[   44.645530] Instruction dump:
[   44.648465] 38c00001 7f63db78 4e800421 7c791b78 54690ffe 0f090000 80ff0190 2f870000
[   44.656122] 40befe50 2f990001 409e0210 813f01bc <8129000c> b39e003a 7d29c214 913e003c

This patch fixes that Oops by checking if src is NULL.

Fixes: 6a1e8d14156d4 ("crypto: talitos - making mapping helpers more generic")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index dff88838dce7..42913116620a 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1124,6 +1124,11 @@ int talitos_sg_map(struct device *dev, struct scatterlist *src,
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 
+	if (!src) {
+		*ptr = zero_entry;
+		return 1;
+	}
+
 	to_talitos_ptr_len(ptr, len, is_sec1);
 	to_talitos_ptr_ext_set(ptr, 0, is_sec1);
 
-- 
2.13.3
