Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464106-2-11028389281519853880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464105; b=JNfadFL6HMg7405wlCkm/T5ufSiPdJSXZy7DmsUPip25F5u+22
    ZAWchoQFUfOFqpfx4YcdSdiBO7SZb/hfgaoxtauUrsxwM3kZFS8o6C+LI59mFC1s
    bLVPVPnn8jxCea3CCBmzwoBIqPQQQpnW5hV0OdXBNXq4TNDYc3evw52xvHXJj3re
    zxLqEikNsplmDxriSy92K1KYj7oTIv2lXdYp0+jJCxI9jbvSZXTZqGlry4N9Q1tD
    oLiH/M7HmV+Jc4zmMEXAzzxBOXoxSyYAwZWi7s1bJktmfXyOT1jhoEYBdKndeSCl
    WUNgjIiTtLke6A1pTed4B74JdDzb+u48T8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464105;
    bh=DHnbvot2LHewsLnm68xCz8bTN1a1lVcWBh253lE31fI=; b=J6zXxBImz0oD
    WiUhWifNm6rvlNyKR6zY3kP8SOuQJjAWmqVSUCAH+SkHvXQXLrRyPUKutwCuQQpQ
    1xVgvFYPz44LKPUeExsOXQCq8oLeXJpZQ3lJNoWX9lzoGWUsS3db1kgw1qx2Q6pn
    o2F7mSIx9B9rbQgSJ9z+O1a/JQd86hemfE+ayWLvJWPv0p+2o+6Z7MWPt26AbpiK
    LqAgtVly7K6NrHbJJFkysFiequFjHrxJrSafc6npsGpCyd60YZr92ffuDfqZx2SF
    5vIc3S5gN+GmiBVGGtnmWrQu8a8gtcXRBAilmhQBsSkEHsBSWdB/KpMiyMV/sqzA
    mPvYeoi5MQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgcZlGThHfcEHMwM4UqpdscfFO2o0SR9SW6SPQy5L3NilVOmAF7fYRJ1gI0oPu1uxZy6wOx3xu/e77nn1SoZHeWVUrAbshB08IxdLen5QgYyi5t3QbO
    j+npj28FNg31FyCm8dTudK84YrHMOBZk1eMr8M+J5BIgZr9jrqkZOShG444GYdUgUXNQhZV+dWvNUKyuxG46viU9JHpirjk0rdVGUj6oBiiLpmpr101r/AGa
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=z1H5ADGQAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=BQOtGlQSKHZKi5BaR78A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeDKQ0k (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754271AbeDKQ0i (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/24] Lock down module params that specify hardware
 parameters (eg. ioport)
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:36 +0100
Message-ID: <152346399627.4030.8043878470312297727.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provided an annotation for module parameters that specify hardware
parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
dma buffers and other types).

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/params.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index cc9108c2a1fd..2c08c4aa376b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -108,13 +108,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp,
+			       const char *doing)
 {
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_warn("Setting dangerous option %s - tainting kernel\n",
 			kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    kernel_is_locked_down("Command line-specified device addresses, irqs and dma channels"))
+		return false;
+	return true;
 }
 
 static int parse_one(char *param,
@@ -144,8 +150,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i], doing))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -553,6 +561,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 	return count;
 }
 
+#ifdef CONFIG_MODULES
+#define mod_name(mod) (mod)->name
+#else
+#define mod_name(mod) "unknown"
+#endif
+
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
@@ -565,8 +579,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;

