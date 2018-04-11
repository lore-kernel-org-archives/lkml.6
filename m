Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523480004-2-14496559161394144976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480003; b=dqMV7z1kn+BmM8NfLtOrQAmVxFadXt4mG9Qemw41vNucy1bv+J
    wr2eYvoMyNJmLs2UUTCMVeYOdlIYR7rszvemqkPdxh1d6WsUR6x9LOkU+Vz2F2lI
    7k6BnZPFHPaeuA2gV41mvH286IL+dtFk/WRVkwZYNCt8Hr2iUp+llcoNYm8qgq9h
    mboHE1ufs6TNUWfFBQ3bgjj6cn8OJoxBeH0YbnXfnXA2V4UwVQi5/9roNbEHw+OI
    3tn6Uo2BvkQXx+VyfbIWcVRtUHm5ssxEHpVAbN8oP7rgDy71OeGAtxbqzEQ8iXuI
    hZufFnEkSCwBVTy8tn1t8RL5zt7/BGg+ULKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480003; bh=XZQN/ajyel52xkQjt/8JuH6mEZ2rk2
    BLTYLGclGdZKM=; b=dDYN/CxEQU1S8XEq0h5kQkVK5q48nBVTXuKzKLMssBYJHV
    BPplXGaDTlVPVqg12luB5k+hyE2WEK6sSz0mxXapKjPPWVfc8QhsJvSGN1f2jbEz
    ZjhCmeESi2jEHOtAN4Zu4ZFV2aIzQ30C/ZuXtZMmVUvT/CeoT6m3L8E9116gDg1C
    w7GxBun2r5fXsQ8hyNttVA5w7TT3a3ot1RlXSxI6YLGjIRAN9/FeKzBSTWnRYz5n
    cNSnftHUzTqt6pTFf5MEl1aX+/IbfZpjAVJJDhapUzrBFmUqD6D1zNKlctCdgK1l
    2eNGBeI9vOG4t1gsTyYFtfZ+G7mMwTLV3FmiPBbA==
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
X-CM-Envelope: MS4wfMHn6YjgOVkOZbhmv+afuZl8sN04r9/I5sf4ZqFATlp70MMfPVuWz4c2f1LTi54flOT6u5OxdqSSU84uLdXxRnxvPfD7j3jfGI+NVwTwRji9S4J/8xtz
    PX2h6fqVWWG6UGu1B98sku5HDJrf0Le7VqyDATfaRzE12IP6wL7OVYcvnsJfr57edSoawGzAM+G++vw6OQl2QD8YvtH8gN41vAPw5pbtmE5oqJR6WawpOkWX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=SMg-zceUvSRekMsZMH0A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=ST-jHhOKWsTCqRlWije3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeDKSpU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755493AbeDKSpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 043/190] usb: chipidea: properly handle host or gadget initialization failure
Date: Wed, 11 Apr 2018 20:34:49 +0200
Message-Id: <20180411183552.643037052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <jszhang@marvell.com>


[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error != -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/core.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -851,7 +851,7 @@ static inline void ci_role_destroy(struc
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
 
@@ -951,27 +951,35 @@ static int ci_hdrc_probe(struct platform
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
 		ret = ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret = -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
 
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
 		ret = ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret = %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
 
@@ -1036,7 +1044,12 @@ static int ci_hdrc_probe(struct platform
 
 	ci_extcon_unregister(ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
 
