Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476304-2-17108396289886213682
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
    1523476303; b=Fu8dpHUu0g3DvAG3vEvlrIf4goo89mw1RehUWFUCokHqj7wzOH
    OH+Psh7yBN1JB1qCh6TMjc9ngcG/CfD7pP4pyrsiKFGSQY9FCPNs8UekodgNbov1
    xJlEmhLsyFpBncVoWT0exJROJJcya2eSFksZdWvdwrycE9opjKm0GjurmssuZTyD
    AaRAmz7N6nx5WSKczQZhipSF9ImeXLhNJJlPHqi6sdMaHdywlZAW/QNNOzSVATgR
    QYN1dvgxpJ7er5GFfjKwtHAotUep1FpJ1aOjDVbwChS12jt3+i3C0j0+097B1BFg
    MX08zG/DVIqSJVVBMU9fsthYV9Lc6DddbC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476303; bh=lX13laBD7Yf13dSy2Vn/EQvUd+nhAO
    M+TWdsZ86eZlo=; b=FnAFDKkPck2junDISu7adCQwh8Tn4anyrcx2o+mBh1FVH8
    uieoOhvmkcbU8nY0aC60iBhAdoX4dBJ8/kYZQgo/ndDXV83PnEq892F4LcTKjBy6
    GEETH/zOhfZ9k2CoowAZ+Y97m0c3W/GEIh0iOQ0qxmET/djdhrqOex5SlPPvwxvc
    pCIsc6N08tT960tn6s1X8FbUMdPCHS+Bb3hj8PpwyzrGFeO1KoUXrc/2TTCQH2VH
    B7bvPX1WUsKOwV8aDIL41NBTyqNZaDu+LD0OvayDfExeAqJesGEaE0OtwHNuMSPO
    hM7sdW0g+y8OVP7rW5q8B7eFWEaKTjSUT2Hp3Q0w==
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
X-CM-Envelope: MS4wfG3AOOAfldx/EclbQ1LxkJ/S3dDL6r9BVkJDgJ7ODuQVkPJs9/Di8uNAaNKxwAMG/94BXr8myMce+45tJGdmcBcdX21rbmOTQFAQsBD2mLZwdvWMr3/1
    8EV2hT6+lNXX3HEZ8MboL2k1WE89pKmaJJ353TbJx3fQecdCg47RTVfxby96hTORIL54aHDF6eSNhc8b7nJnSh65tpU/35j8vFJIz/To1EsSTZUCuc7ubgp/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_Wotqz80AAAA:8 a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=5JgmG4xWlNE0LIpaGtsA:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933928AbeDKS6V (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeDKS6U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 129/310] PM / devfreq: Fix potential NULL pointer dereference in governor_store
Date: Wed, 11 Apr 2018 20:34:28 +0200
Message-Id: <20180411183628.020210084@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 63f1e05f7fe9ca509c60154d6a833abf96eecdc9 ]

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/devfreq/devfreq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -943,7 +943,8 @@ static ssize_t governor_store(struct dev
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
