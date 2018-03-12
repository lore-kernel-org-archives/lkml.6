Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3235374-1520818700-2-15086393994411381374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520818699; b=ejr3GJyx1EtN2oVmomuaZI6g5j7gnKtPevBfihtZMIZjwXN
    Y0lTm9rrwA9aOe/ZRl57gGplznatVaEhpnOzWB0BSUFxhgBYkum5KEvmARTFfxA0
    14b3O8uksWdESx8aMSCydUt8z3Zpu24TAT3fXJJbTMt+suGU6jNaglENVevZRaRj
    2XV5KfhPFaw9D3VclIZM434uMWS9zzbFiER07fw2UgRQJ/BGTIkOpuenQJDZvo8W
    6a27bmWFOZ4NAEHmXSE1iHcFOki8RlZzUBcXq+/uaU3XCwwLoPzkKNuDgk6dFCaW
    DC3+lo6c/XDob33dCg/7K+OjbKzzBJsMh/K7U2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520818699; bh=z
    0uIlpXc1Kx7Vfq3b4YWJcSnm7mFHU8O4au/CJOiMJE=; b=gcVzCX3b7kijgPOEP
    cWzjTkcSbDXRB/iBKBB6z3MeJuYuaBeoXTjzkg8a2tJ4zc0cqz/CgaPZBsDMIYvm
    YH9HtFAEAtEqOIyxhldLTstnAoGuJgmCeDB7qMr0F3xqftepkNCKZkMKgKAB1XeB
    llXg1Vww6Y4tr2tci3hs8d3x1Dykg5A3pYYYl+n2wpHs54yYgRQc79b8p8GV+/bv
    dh5c1rGpyEFtVYPGELbClvNCqPqE070AD0gGg4uYbZFGgYtxWxdEkO9pO6Khju/j
    JqB8JU55Go+adzppXmmK5vvZseeneVe80B+xSEHGP+DSKB4perbj6Q0AAQdEx25n
    5eA9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5q3HKbD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=MMkVSlUR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5q3HKbD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=MMkVSlUR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:BNqlWo_olneHRZkHjvmDLgYeOBmMOhr0Ya_qdymfC0EpszCmW6tF7Q>
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v2] staging: vchiq_arm: Clear VLA warning
Date: Mon, 12 Mar 2018 12:37:53 +1100
Message-Id: <1520818673-14084-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  The array
here is fixed (declared with a const variable) but it appears like a VLA
to the compiler.  Also, currently we are putting 768 bytes on the
stack.  This function is only called on the error path so performance is
not critical, let's just allocate the memory instead of using the
stack.  This saves stack space and removes the VLA build warning.

kmalloc a buffer for dumping state instead of using the stack.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

v1 of this patch already merged into staging-testing branch of Greg's
staging tree.  This patch depends on v1 being removed, can re-do this
one on top of tip of staging-testing if required.

v2:
 - Use kmalloc() instead of the stack

Patch is untested.  

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f5cefda49b22..408ea73f8da7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -3455,11 +3455,15 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 		int fourcc;
 		int clientid;
 		int use_count;
-	} service_data[local_max_services];
+	} *service_data;
 
 	if (!arm_state)
 		return;
 
+	service_data = kmalloc_array(local_max_services, sizeof(*service_data), GFP_KERNEL);
+	if (!service_data)
+		return;
+
 	read_lock_bh(&arm_state->susp_res_lock);
 	vc_suspend_state = arm_state->vc_suspend_state;
 	vc_resume_state  = arm_state->vc_resume_state;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
