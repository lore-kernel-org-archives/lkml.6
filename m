Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161171-2-16515785637718584879
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
    1527161170; b=bfQCGshO+FUTKKAmx0ARWk68koLg/1l/6AioWGGfqy/xFWbUMy
    uBmLpW38unW3+UlldCExbHX8FR+Go3S5Og/qMyNeYBqR+wBRRnOvKoL6LkPup1+L
    GlU0Y4Uwf1XS41Id0YOTzxg/CNM9IG07q6279Ow5+WkKvp8HfbZEIE/15AulLYWn
    ddK8GD2GDFMY0pAxC8NN/1qWwDbpRnJRhGOCYpl6QpG4Y7v1K0M1eIIU/O2Tcd2M
    aJNz/Y2tc192P8w84y5Qjpcd4CvJ3xGhOSDIWHDcSdzYfciVVN1TOnxtsR1R6nR4
    Ot9JMGvTp5TEE6tSiIROAFNdeATx6yETGiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161170; bh=wtrvhOKWlDCR43FwXlOy8WJivC8PZO
    YM4Hgc7tQjoa0=; b=hm30oclJHUA7w7EntoQgdEjdJG+TkTDmGrtspZHikcKLgJ
    6ivFhWhl7Gk7Kc71BFl4wycCqh3syBjz3RXJZVn5w3blqkm+SNsxhXclGmOFGY6D
    ljKyew4uNjDTAn0eDQg/6P/T3m1OLPeINgQXX9jxS39hBNXJy1aVJwcuU0shV4wg
    2BtTKPQZIEz2tnmX+lYJpbuDrbVuL+ky8XMYoN5K07PzI+d8xVuIVtP0HKNAHupr
    85g1OQGTt+cWcHWhDcUfwZVep6nvBoL4Ob+era985oWHXkm3gA7n26f6zOUggdXI
    OZlsgbNDpNktbHS6ZR1+PyWbRgzwPaKFNhsnoUmQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=c9lhv2X9 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=c9lhv2X9 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLACAPoU1+wNHaJpPkbrgp1S0LpZXF+4PQVidOVN6jJE+EeG8qJJ0jsQluVehyrGElsd0BZO3UxGGmGcRec6meMYhYfVTrmpLJG0d2o50BE1CKMzKEJ2
    pSSm5/IpX2GgRWH1ZAoHGL7ye8fDOQMSNxTl5sEJgQMlAgNKvDIePmVurN6aJe6HqkwWIh2aJbHyMWVpalsDlTAb5wkc12AhAWuYHyrOg5bY16t24uXL0Iks
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Wyb3ZWrwXr8amsfg3uAA:9 a=QEXdDO2ut3YA:10 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967749AbeEXL0J (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967737AbeEXJvi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Mashak <mrv@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 003/165] net/sched: fix refcnt leak in the error path of tcf_vlan_init()
Date: Thu, 24 May 2018 11:36:49 +0200
Message-Id: <20180524093622.111576919@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 5a4931ae0193f8a4a97e8260fd0df1d705d83299 ]

Similarly to what was done with commit a52956dfc503 ("net sched actions:
fix refcnt leak in skbmod"), fix the error path of tcf_vlan_init() to avoid
refcnt leaks when wrong value of TCA_VLAN_PUSH_VLAN_PROTOCOL is given.

Fixes: 5026c9b1bafc ("net sched: vlan action fix late binding")
CC: Roman Mashak <mrv@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_vlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -154,6 +154,8 @@ static int tcf_vlan_init(struct net *net
 			case htons(ETH_P_8021AD):
 				break;
 			default:
+				if (exists)
+					tcf_idr_release(*a, bind);
 				return -EPROTONOSUPPORT;
 			}
 		} else {
