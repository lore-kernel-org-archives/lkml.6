Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523472837-2-16109793904449550384
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
    1523472835; b=cV9jwr+DrtNux+RP4637Wj/Y2MGGVPwlaaizlhLJn7YWPWs1y/
    6DoqymvAtZA27j4jufGKXMUfwHxijWxwKjZh/fnfC8zejr53k9cGEKO0AOuiegCl
    1qQP5hPGar0Skp5tC9wo5Bt2Lx0gV9JTgSE31JklUrWeqftunbSfNkFTTv2AW20o
    gUe+cjEdBTffSWKROrm6oYoPbivY0MSrqXtYHJtZryj1jq/eHQzIB9nDrtcGBBgm
    rItbhrX6mdXr/Ll3lw5ilxXSA1ERe8wAl4rElFeQ84+ng3sJ4/wJFxKYODYaGGIe
    aBk+7jKhYTkmuNDLmFuvAnOQ+l63b7/k4tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472835; bh=pV9tDiNyF4oFJCdT5U54PeC4Br9h8z
    R3qu1mBowI7kU=; b=jp0MFSCUY0tLkHv/WqhFq3afj49ifxZE3tOJQoNA1KSLlm
    l67o7LYuf43DIIKU7G68UbOaMikz350BW4WZVGexfi4VsZDbUHR2NQZSVFJtNcsP
    w1tJLaN8kSkxw9pkQF/RnfSenh12dhcr6WA0CUO236bEiWo6MoBWfikAdd4F3bc7
    2MU5CDqKsDNu1BGXEKobeURPO6CQuQjeaAxX4COHhyFqmlEoeiOFwsRAqUOBrwbm
    L6EdpPs1GtXg1pR3WGTom9kSLun1rhkQAqUo6/0PY14mT4f8FZoILV4P8rSIc30X
    OwUB04rUYjLamX7wG679jboWnLkEjs6QY4jWd/2A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfC8OSRAb0NmI99evpo1WhENAfU1f38ePieFXHHEL0xCymT6BArpLMtYJ9hhL37Y5sRtzin1F+vhDBZ6HYooMlbLmxK22XuhEGhktM5+8dwvGullIaxb9
    +9r1zVec52f5ef43qmmLmQNwnwHzQ/Ca+PP/VsFgIqVb5+NzVafKCWJBA2FO39LrGz6w/YBUzzmd1/yshVYeoedU/spoFFT0SZFahEF1O4yFeqfzz070r0+x
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=uP1ucDPQAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=qxTC8EC6x8ydEK2nXCcA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeDKSxs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeDKSxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 004/310] rtc: snvs: fix an incorrect check of return value
Date: Wed, 11 Apr 2018 20:32:23 +0200
Message-Id: <20180411183622.483059619@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 758929005f06f954b7e1c87a1c9fdb44157b228f ]

Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
in function snvs_rtc_probe() its return value is checked against NULL.
This patch fixes it by checking the return value with IS_ERR().

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-snvs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -257,7 +257,7 @@ static int snvs_rtc_probe(struct platfor
 		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
 	}
 
-	if (!data->regmap) {
+	if (IS_ERR(data->regmap)) {
 		dev_err(&pdev->dev, "Can't find snvs syscon\n");
 		return -ENODEV;
 	}
