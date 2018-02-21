Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218372-2-8539040575723853037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218372; b=PBlD9VoERCDxhWFXiPBy0cfbFHr7xDS3nHsnb4s5LHxLKkR
    mtAhTjqzJ+76cva4TV1xgCujwEDZx69cunRBYfvgep0UPCBCLvcUoLGVXlD1+/lG
    Wwgq2pX+BSxQsKEpSzyJZZMVJoG4DyyMmRuwx6jN1QtfPvpgLWlxAh7s0RFrrI9Y
    WsG/Y3K2B8gNdhlUCeaoQWq/r6NyKSM4pCLNn5/59NrwXfAgAC+MnzYFzYifyK6E
    PEQgNkki81MuqsuyKIRfAsHUSXbFkUjuoou1CzS3IIMs+nIoUgCBDwnEaobZhCNV
    xJtyBcpZHAsW2JNPfHn1WOOqipoPYqXXmqZn83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218372; bh=r2FQZrorKEWgtD4Twu8l5NQv1n
    D+GEiskfpeRyoDhOk=; b=bBIwaAxwciVwjZbwVMG2s4V9SUEmWMsmeQsWTJcKx2
    2FPti11AK12JQF5nt43NMW+BhexBYY7JXeQ0AV82OKRpmFCaosmaDTuev9M4iD4s
    5GkarKEttR/FKaKKsqXKPICqUWpo2a1Z3vP/5qQy3QIOOLUPWhc3Ru/1Fg5OQolb
    Qe0dgnfSXVKN0iC9XsLgU3GbB8o3uCPf9gpQ725Z7VAz0kbBcbMuEp5APOdLG4D+
    pmP9pjnjvS9yNjV8GIQFKMTzhmiEPNRd4FxsRaYMccWJ7aE6ZuB2WIgExKMHCgGi
    7BPZr5BvV/rAAcbKArgl5ei+ynA/mDGU+A10Zsfmo3XQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964966AbeBUNGJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:06:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964913AbeBUNGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:06:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 4.15 015/163] PM / devfreq: Propagate error from devfreq_add_device()
Date: Wed, 21 Feb 2018 13:47:24 +0100
Message-Id: <20180221124530.952810375@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d1bf2d30728f310f72296b54f0651ecdb09cbb12 upstream.

Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
rather than statically returning ENOMEM. This makes it slightly faster
to pinpoint the cause of a returned error.

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -737,7 +737,7 @@ struct devfreq *devm_devfreq_add_device(
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
