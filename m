Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481459-2-8077739841829235539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481458; b=Xr7aRT4/c324t1IYqNMC1aZLk1AFIRlBJT/bXqrVETqkTSwtsE
    U7GUtJvAXlhQ5OuQwkaDWXShiTymgwjkpYINL7+UhxXeCc0sGiwnQD2xO4WuaQY4
    NSVj60eeAov40eSolUkyPfAa0/BNZXxjdJwROqYCWs70O1gkdAk24M2TBlXxTw+L
    J6l8WoCtjtqzP3dUZfrAeVb/Ne0m6C75NlxVL3vUV24OH/bNgOlM04rRZrXptGSE
    3/oQk4tdT6hL4BsBSstmUy/GadKhtO/g1584/7kSSvfi4vE2aw+RcTH9AhmJTkih
    oA30dMu2d/mDnQEM52YgqfXAwh34FwKC2f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481458; bh=tmSbG7pQ5Z3wWzom7MF4XShgr5Vx27
    iLIXOq+VYae9o=; b=xFtgN3N56sECm1dede6/46ELhjU8MBk5a1XYyl3PaKTAWi
    kWn0NecbEWZjJf/YTI0gjExGw47pEV7Y1PGM6NLDpBUPNPRSgAJIK/8W3bfpaHhy
    +HAzVxyfJgy1mvild5+DDsLnp/lozIK2a0i8sxtLCfoiLgV8KQWzqtc2lOVpVREn
    Iq20eb+7ynijv3nOZLOlPeCaWdtC3TyZ4nzP6K8cR4Nz0Ye4wawzWzdShA/R0ol0
    XFvNk4ukci5VwPAijgMazYi8JpqLEIhrSTh+BCkoCsPO5H52MDVT51ym+DsZYGSp
    ZItw0gRcBe+xrK8TxO8lPhNk4OpdEFv7ZsH/WcGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFRnxkZVaqTMjj+OKZG68gH2xhd9KtQWAabtz6yhqvcLstBcwZOKox94Vz6+EqJTCfdEbz2W3MX6c9aDpeEsXBQ+2kUfi5Y/jCMGP67clDWuFcmpTNVK
    r7hf3kSGT/T8c1tZQIK3P8WvlbhBYUV/NFHX8xWzIrO/EJOPXxNo0pCkvBjKXyp66N0d+BkVK9/ZZfN4NBm5IPL5a/0ebRu2GcsGcS8/v+wii9lDoZ7PvlSh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=voM4FWlXAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Ofto3bmoRzo_owYi2x0A:9
    a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDKSkW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbeDKSkU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Jeremy Kerr <jk@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 060/121] powerpc/spufs: Fix coredump of SPU contexts
Date: Wed, 11 Apr 2018 20:36:03 +0200
Message-Id: <20180411183459.909523887@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit 99acc9bede06bbb2662aafff51f5b9e529fa845e ]

If a process dumps core while it has SPU contexts active then we have
code to also dump information about the SPU contexts.

Unfortunately it's been broken for 3 1/2 years, and we didn't notice. In
commit 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers") the nread
variable was removed and rc used instead. That means when the loop exits
successfully, rc has the number of bytes read, but it's then used as the
return value for the function, which should return 0 on success.

So fix it by setting rc = 0 before returning in the success case.

Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -174,6 +174,8 @@ static int spufs_arch_write_note(struct
 	if (!dump_skip(cprm,
 		       roundup(cprm->written - total + sz, 4) - cprm->written))
 		goto Eio;
+
+	rc = 0;
 out:
 	free_page((unsigned long)buf);
 	return rc;
