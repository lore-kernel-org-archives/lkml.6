Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164612-2-14660949439013179502
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
    1527164611; b=AkuPA2ud6zO6oFs64YYPA7WFsbuIZR2AfCMoodqXyHtkrlxDRu
    QJsbpHx/XfLufuJ1nEZ1xCVigSXR+qX94j3ShSSiUGE972pU55mg347XDwh8iDf8
    Ishur8Ac5+VVFFh5i9ImmtfFcCE+PGIxd+rf6hIsfJW44t6edcVlF0Da3ZU3W5FY
    tqLu8eHhxjxvt3ccILxahm2CxSzTUNMgRGEs1o1fPrc9jJTl0q5VAtQlkU5MSiG+
    CM5HTqb9mdwVO/LXduVuubXFbDOm3eNVsLYx3ESl2LBU+/WdOhfC7JX+oJZ+/IQR
    BkDV5WGvmWvqNLsdnjRjsuOLisgTWG06bNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164611; bh=4I1uMbaGpvblguNvHsOe0TzDMuI7cN
    AFRzoSqaHAGbs=; b=e3hj0bVPmy0aA02TyFCObSwwGW6ma7V8jzWQpIPkxbQH5K
    s2xssBxc/vAMJfupUNBhQeIGe0W2zdtArEGP5tuPFYsAxkRZVjrfdvwShQG5GGWH
    nkiu1puEzUOzudk0UOjDMkw8QSOUrJwb095SaVaVGG9VPgc9Q0viAsCTm6qiPP5u
    R7uqYj/GwdgqAYgPba2Oi4cM8LuDUK3Iv9q0KHkwCPULlOPJEHXjmOP9DM/CvbKu
    D7+myQklLF7gDBnpP5tMRJ5yOwBJV6fMnK/qMcH1qbyKJa1jCuBgofzdly8tsIiR
    j5wHxU9w/wJ8HSsvlHiCH1wkWoEP3UZU9IRj8ynQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=onRMZgUO x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=onRMZgUO x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGOEbAR1TabMFOKtdz9aUy2o1uQBYBIgbKNfgE/O9Mmf09Ol1G/0Dxcwnky8w2s/lQTl/+N2FdGtRENkRznXZk7VT5T9Wcwn+7xpA1+seHJq89STb743
    L2aEW7h4dkG6wPAgKvP+N8ZGP2+8PR4YA8zKhrhrn1ymIiDP0lsx2PsbSQUYOXGVjSu3bY1BBHqQ69XxbaEko4IXYWK5xC3lxMUTTp3DN9fs+wd7NbVKKKIN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=W4yg_sfPvy4A:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=s47jRAohAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=TDQuQJ2OXxYTQ_uShOsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Kj7115exjCjJ0w_vcVhc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965999AbeEXJkz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966058AbeEXJku (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:40:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Slava Kardakov <ojab@ojab.ru>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 10/45] r8169: fix powering up RTL8168h
Date: Thu, 24 May 2018 11:38:18 +0200
Message-Id: <20180524093121.774651295@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 3148dedfe79e422f448a10250d3e2cdf8b7ee617 ]

Since commit a92a08499b1f "r8169: improve runtime pm in general and
suspend unused ports" interfaces w/o link are runtime-suspended after
10s. On systems where drivers take longer to load this can lead to the
situation that the interface is runtime-suspended already when it's
initially brought up.
This shouldn't be a problem because rtl_open() resumes MAC/PHY.
However with at least one chip version the interface doesn't properly
come up, as reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=199549

The vendor driver uses a delay to give certain chip versions some
time to resume before starting the PHY configuration. So let's do
the same. I don't know which chip versions may be affected,
therefore apply this delay always.

This patch was reported to fix the issue for RTL8168h.
I was able to reproduce the issue on an Asus H310I-Plus which also
uses a RTL8168h. Also in my case the patch fixed the issue.

Reported-by: Slava Kardakov <ojab@ojab.ru>
Tested-by: Slava Kardakov <ojab@ojab.ru>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4764,6 +4764,9 @@ static void rtl_pll_power_down(struct rt
 static void rtl_pll_power_up(struct rtl8169_private *tp)
 {
 	rtl_generic_op(tp, tp->pll_power_ops.up);
+
+	/* give MAC/PHY some time to resume */
+	msleep(20);
 }
 
 static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
