Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527158346-2-6523382810219046246
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
    1527158346; b=JM4VvmmQnOQrfE2EmQaYJZAy6kSV/Er+VBBwFnf7wmBgutNdTZ
    IxX6AuFDi3FAAP5sKW0V4ODTxId8M+JWNf4+e02Q3StO/6XVbOBC1cR9nrXG4ptr
    VgFAihBMZOisQtMXQVZ6q49WfAX9RcRQNSG9c+aFPk7rEjocVPpjckU+7gpLRcIq
    6Zi7cpTfn8+3M+D/lc/Xhe6DjkMpHu/UAx9h7xuKFEbho0Q+TWM8iMexyA+WgwEw
    dM8rApM+6VoFZomYhzhhTZTFz6G8my+zxi1BthfOIWCjOGKJZfM+MjjLAslyhaJd
    aSNozi1dQmTTzJpLttL1mV0zfm9iKshSiW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158346; bh=WzV3M7dDkMNK7DbVh0gd5xwxBLyG1e
    8+nyVZo5ohnkQ=; b=D4m52SvgYmc3AosTxSB7EeGRCEZvFe4sQZfAaftv3LXyGv
    aH2WquEO2sWQujTypHpUyvlpmQ5w5xf3B41/NhmeasbkzsBxUF09+KiXBIRnjhhy
    QzGkXuz/k/cIlREHIS0nTgSpqC9qfdPoF1vXWCzXNrSOqzSM3XetP59D/k5L+kx8
    5OAtYk72S8o/o0AjSou9kAvTvFptMWA/S9fFrnAw/wLyI9RZbdh08y8qGPlsyYQC
    nSieilbaacwa2LAqJqIt/GxfbNleoKKcaTwSkxDhsfuNRoa3Z4v6RYKsV8vEhdkb
    fzLO1NZgcG+io1ItgzZxKisOYxp2S9YNEIIfQxSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SfLKC2V4 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SfLKC2V4 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEcUyjZWpropUCx1tNfqMSSSXyiFXYqDB/I/Urv5uiinfEo5ngbr8PK7XWb3PRhNpQwFfZJdB40eXehDt5eDesMgjvc5MnaPDsWdEjI7tMXYlUWTPKdM
    Omd4RxSeSVXFf+I0vsVqIIEuvqGZFLqH+iG8TGuGVwgQuDEmiXimnMY30OYt2w4SSgIataiIa902CuzJNwXMt8IK8JKF9V2U71/Ozp6sRGZhqRb3jw0P7XBl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=BBm5OF4ZUQfd-yT5yLgA:9
    a=UqDUjc8VJaClsVhj:21 a=kC4X-mr0MRRBHH3J:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030755AbeEXJ7Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030750AbeEXJ7V (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 014/161] net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
Date: Thu, 24 May 2018 11:37:19 +0200
Message-Id: <20180524093020.106555710@linuxfoundation.org>
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

[ Upstream commit 43a5e00f38fe8933a1c716bfe5b30e97f749d94b ]

When we let the kernel pick up a rule location with RX_CLS_LOC_ANY, we
would be able to overwrite the last rules because of a number of issues.

The IPv4 code path would not be checking that rule_index is within
bounds, and it would also only be allowed to pick up rules from range
0..126 instead of the full 0..127 range. This would lead us to allow
overwriting the last rule when we let the kernel pick-up the location.

Fixes: 3306145866b6 ("net: dsa: bcm_sf2: Move IPv4 CFP processing to specific functions")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2_cfp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -354,10 +354,13 @@ static int bcm_sf2_cfp_ipv4_rule_set(str
 	/* Locate the first rule available */
 	if (fs->location == RX_CLS_LOC_ANY)
 		rule_index = find_first_zero_bit(priv->cfp.used,
-						 bcm_sf2_cfp_rule_size(priv));
+						 priv->num_cfp_rules);
 	else
 		rule_index = fs->location;
 
+	if (rule_index > bcm_sf2_cfp_rule_size(priv))
+		return -ENOSPC;
+
 	layout = &udf_tcpip4_layout;
 	/* We only use one UDF slice for now */
 	slice_num = bcm_sf2_get_slice_number(layout, 0);
