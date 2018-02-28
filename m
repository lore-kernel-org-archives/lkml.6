Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837641-2-2983270327408560674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837641; b=K53RUqSnqRDN+AqjMbxT+AeTrv2v0FwE+lXx4o97mvTiP6S
    CnlyySAFO5SqZCQzVv3QEtWWT/wWhSdLi3GPu08VE4UmO/Hi0JPFEM45inWk2o7o
    S6iPItYtEpTxsjgJLVaYIa7xy8frdA3os7MrNSrqn0xy7b2JKAYKqw66Nii0fXfB
    mRekoewm0erDK+NrSIIQ1/PIGS5+yOzB63DNLECWIbcdd7baBkIqHekz/186p9Aj
    KJukFQ7Anag1IKq+69viFN7rj3eBiEPnRVzfE5/BjyWcxEB4mUH6dVOZFSnYV+Tf
    imfqPoPVdYa3V3Vgm71ZCzjAxu8tIqGuRwy0Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837641; bh=3kmHUTpScgCENsonuwr
    T42RxJbNzZScqyw16IGEYO0o=; b=XpHFiAHB40ppECYNaG7qYSYzU0Nl2PsoV8P
    uvYr1Ms2Sx0DUCK8nvb5xDnrYQzhEXAmPcsLcBzJbEb1OvlhqV2mqdCZdrzDa0ug
    sv2wzduTRl3I7VGPDs/7xNRS2kLXJkROLjcOi7id0KuniDqMDwSFxeU+LqbRM1pt
    MqGqKAFy+KWgzFDZVZclwu/KPBnxVpJT9vVIXDApVzPVCS1KiMiaBGKwlDIGD/By
    BBOt+wZxADd3twsFpD6suG+0nnXRYbDsEglJBOAfwDOZ+o72/fGJxbV7fx3L2XXl
    4joAi2gMu+FrDq7iB8i3ZReREuJKZmqlFDY2a4fxbLUKubofczQ==
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
        id S932634AbeB1PvM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34318 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752904AbeB1PuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Jan Engelhardt" <jengelh@inai.de>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.309829329@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 139/254] crypto: n2 - cure use after free
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

From: Jan Engelhardt <jengelh@inai.de>

commit 203f45003a3d03eea8fa28d74cfc74c354416fdb upstream.

queue_cache_init is first called for the Control Word Queue
(n2_crypto_probe). At that time, queue_cache[0] is NULL and a new
kmem_cache will be allocated. If the subsequent n2_register_algs call
fails, the kmem_cache will be released in queue_cache_destroy, but
queue_cache_init[0] is not set back to NULL.

So when the Module Arithmetic Unit gets probed next (n2_mau_probe),
queue_cache_init will not allocate a kmem_cache again, but leave it
as its bogus value, causing a BUG() to trigger when queue_cache[0] is
eventually passed to kmem_cache_zalloc:

	n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7
	n2_crypto: Registered NCS HVAPI version 2.0
	called queue_cache_init
	n2_crypto: md5 alg registration failed
	n2cp f028687c: /virtual-devices@100/n2cp@7: Unable to register algorithms.
	called queue_cache_destroy
	n2cp: probe of f028687c failed with error -22
	n2_crypto: Found NCP at /virtual-devices@100/ncp@6
	n2_crypto: Registered NCS HVAPI version 2.0
	called queue_cache_init
	kernel BUG at mm/slab.c:2993!
	Call Trace:
	 [0000000000604488] kmem_cache_alloc+0x1a8/0x1e0
                  (inlined) kmem_cache_zalloc
                  (inlined) new_queue
                  (inlined) spu_queue_setup
                  (inlined) handle_exec_unit
	 [0000000010c61eb4] spu_mdesc_scan+0x1f4/0x460 [n2_crypto]
	 [0000000010c62b80] n2_mau_probe+0x100/0x220 [n2_crypto]
	 [000000000084b174] platform_drv_probe+0x34/0xc0

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/crypto/n2_core.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1644,6 +1644,7 @@ static int queue_cache_init(void)
 					  CWQ_ENTRY_SIZE, 0, NULL);
 	if (!queue_cache[HV_NCS_QTYPE_CWQ - 1]) {
 		kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
+		queue_cache[HV_NCS_QTYPE_MAU - 1] = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -1653,6 +1654,8 @@ static void queue_cache_destroy(void)
 {
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_CWQ - 1]);
+	queue_cache[HV_NCS_QTYPE_MAU - 1] = NULL;
+	queue_cache[HV_NCS_QTYPE_CWQ - 1] = NULL;
 }
 
 static int spu_queue_register(struct spu_queue *p, unsigned long q_type)
