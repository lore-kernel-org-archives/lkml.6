Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527158328-2-13304090926749790924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158327; b=UnQOt/vMwIDmAL2/7dEazOyXiCGbZiLCr5PlWwGGfNcT1XLrO+
    nyupnk23uwy10p1Wg2SK7iG1ZybdL4teoI0rTRTMp0CT/KYlHKQEBjuhtRPAbwbw
    ZzUe1IaTrZ3F3u9kufuSmFWwvmYaWQ1yoeiOOPGY3acBhJmC3ai7UXcCIOxDDGNT
    BC9tJH4y9HKW+dILSsxcPpyGKyQP7w1oBud8jOLuVWHHcP/X+iAZ6yoTr+TKIUfA
    4eGe49MN0c8Tokm6rR+pie392ZF4YbxCY+Zz+YTxTyUSdJjVmYZpH+BO3JtRISXK
    pEhBAGB580ACXd5gWskH8LNe74xiFjU5KkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158327; bh=18sQh9m0ViInMOrPOvtn0tlSHEzJAy
    PPxDfEKH3T/9s=; b=I0S7/d/zOF+nuPGPM7LeDdBPvlZXy/Nsnv/G3t46cyd8Y2
    9OForTI9G0DloH/6Nbf0IYxuxgfrYuL4ukiOzRyHYbnU2WCqaEf/4Uz3TBW+DxJa
    fWRxkNsfWS41648rK5NkUg2dpqjWRHtNozhIKjp5/QbSIPjwZcPvGg6s7JPAFo+u
    JC/vrTBNNju7AwRFD2/JPmQ9G51+v5qLPVxtTmVnBOtL80u3c528YzmC8rq7OdAS
    lykka3q2bWE672NP9QNZ3EnwJNUFWH6yjY3gHmdB8pe2JAD7v08wSBeoRTyz1UBp
    pWrwBD8k/9HTdcFJpRYtXVemtLkVzm1L4bubVTuw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sDK+Skhk x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sDK+Skhk x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMemkSmR4qyrdxk6ZszG5vKmpmKsZHysSv3AdWdmLcZBXHLJg1TL0RvPRTbl7vmn3y2RhliIYgHSWQurzcg1DPDhjUyNgxUDhL76JhABjrhF8K9a5GtZ
    uJtXEbB8OGmCdj8FeSThvdtVn9fbvnMWjrxpF8cXo92y/O4YivUJkbxkze0/HFabgW/h+1SqxlsSxNzSDxTe1NuWti8ny7m0ox3/QXFAhoMc5TtV1ZRjC+d0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=sIv80gOKzgkwMMVbQtEA:9
    a=0LAN0rNRBTOrXHJB:21 a=6Irx57h52dZr5cwW:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030769AbeEXJ7d (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030763AbeEXJ70 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 016/161] net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
Date: Thu, 24 May 2018 11:37:21 +0200
Message-Id: <20180524093020.306140545@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 6c05561c541843b2bec2189f680bed6d20afc25b ]

We had several issues that would make the programming of IPv6 rules both
inconsistent and error prone:

- the chain ID that we would be asking the hardware to put in the
  packet's Broadcom tag would be off by one, it would return one of the
  two indexes, but not the one user-space specified

- when an user specified a particular location to insert a CFP rule at,
  we would not be returning the same index, which would be confusing if
  nothing else

- finally, like IPv4, it would be possible to overflow the last entry by
  re-programming it

Fix this by swapping the usage of rule_index[0] and rule_index[1] where
relevant in order to return a consistent and correct user-space
experience.

Fixes: ba0696c22e7c ("net: dsa: bcm_sf2: Add support for IPv6 CFP rules")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2_cfp.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -565,19 +565,21 @@ static int bcm_sf2_cfp_ipv6_rule_set(str
 	 * first half because the HW search is by incrementing addresses.
 	 */
 	if (fs->location == RX_CLS_LOC_ANY)
-		rule_index[0] = find_first_zero_bit(priv->cfp.used,
-						    bcm_sf2_cfp_rule_size(priv));
+		rule_index[1] = find_first_zero_bit(priv->cfp.used,
+						    priv->num_cfp_rules);
 	else
-		rule_index[0] = fs->location;
+		rule_index[1] = fs->location;
+	if (rule_index[1] > bcm_sf2_cfp_rule_size(priv))
+		return -ENOSPC;
 
 	/* Flag it as used (cleared on error path) such that we can immediately
 	 * obtain a second one to chain from.
 	 */
-	set_bit(rule_index[0], priv->cfp.used);
+	set_bit(rule_index[1], priv->cfp.used);
 
-	rule_index[1] = find_first_zero_bit(priv->cfp.used,
-					    bcm_sf2_cfp_rule_size(priv));
-	if (rule_index[1] > bcm_sf2_cfp_rule_size(priv)) {
+	rule_index[0] = find_first_zero_bit(priv->cfp.used,
+					    priv->num_cfp_rules);
+	if (rule_index[0] > bcm_sf2_cfp_rule_size(priv)) {
 		ret = -ENOSPC;
 		goto out_err;
 	}
@@ -715,14 +717,14 @@ static int bcm_sf2_cfp_ipv6_rule_set(str
 	/* Flag the second half rule as being used now, return it as the
 	 * location, and flag it as unique while dumping rules
 	 */
-	set_bit(rule_index[1], priv->cfp.used);
+	set_bit(rule_index[0], priv->cfp.used);
 	set_bit(rule_index[1], priv->cfp.unique);
 	fs->location = rule_index[1];
 
 	return ret;
 
 out_err:
-	clear_bit(rule_index[0], priv->cfp.used);
+	clear_bit(rule_index[1], priv->cfp.used);
 	return ret;
 }
 
