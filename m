Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519419309-2-12859444266162498225
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
    t=1519419308; b=utVYeLNtR8p6uIntBXsUvZgnmL+sIIl0oQ4bkgqTIcIXiPM
    mkBiIGesryW8uAd3DGkRpkJiYybbKahltzL36YEejFQmNy2Q4srklopZ63BVkgX4
    WmRf/HOxMFRjfS2W4vtA+vZOG9yqUTkoh/rS7f8EoChZNYnq+CzHyiFyKsBsQySH
    qBvzBSso8a7drIf8RRsi24D7taVeXI09GdIy/1wFI4PfpSWgqrduCKfT2NWH1SMw
    3IaNsqSomLcN/BHNmig5u7/tNkGXKNXf60Rh4lM0wdSyxpzkX3hQsDP9XG4QuVq0
    iZeeSzE+dgMxcycKFcO6HLD8dbLtwgdfPzr0HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419308; bh=y8cOVM3WWrSkDOPO9dcVZMAouD
    cGErftsQ8DAPKJs7o=; b=bPyDH/S0TuB6fFMVusGB/R76aqT1a3wybohjV6yCkK
    Rhc2+n+Hnj4cMt06AUujAG5rojr//Jk+xX1/MjaSvszFxbL7AWTDhEOYbhSbISVC
    A+q2qj2JRInOJumkSoaxYY9BuP/t768vAJ2hiw9tmvar9HRrKz8uCgNvpyHaBWJo
    YFFs93bVLyj1b2i6YuBuv32AZ2nHyKk1ghc6PQKOIWFfMGiWmGLS89tuu63fiH8A
    2Ndsj6jGRMNawbRT/z1rn2Jn86+qR+pOQRuWtkfeKh1S45HoHy8kdgVqdOonsFQb
    8HoN7TreeQ9mGbO157VdhCQc0cTJ1MLbDF3j2RbCzitA==
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
        id S1752036AbeBWSaE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBWSaC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 3.18 02/58] PM / devfreq: Propagate error from devfreq_add_device()
Date: Fri, 23 Feb 2018 19:26:01 +0100
Message-Id: <20180223170207.084277528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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
@@ -585,7 +585,7 @@ struct devfreq *devm_devfreq_add_device(
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
