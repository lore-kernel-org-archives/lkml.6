Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652916-2-7614060605989633380
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
    1524652915; b=rv45VeKZr/xHch2mUhgLo8/o6rpv1crBDmwmscAOAUEBCtVNJ+
    N2+JLt+Jf0XO+AXVenUXrr7tPCj3E6c3oBunE2eXiCmzC9xfmJkbe3GGjSKuBiYR
    zrKSYoJufkR015rxQg8nOhhWaEXK8McP/HiXP8LNh8R174NcgSodu/l+ue6WjAQ4
    zcd49fARxLHR3ouMNY9WFJskXlWvkjwdHI9yteZuwZ/GE/l+DV4jmNjpUgO0svf1
    I+/Cr1v3AYOXeGGMzplSVVDqqQQ2ZzKO575UQdZe4v5L4VFFzh+ICi1fNXmkCMoL
    fHPToVAyeYmCHVxswgK1PEjAw3XihIagnzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652915; bh=//z04BHgx0U3HCR9PbECnShP1cc77r
    GzdC0YFJcCyuY=; b=l9sO4wJnc/xiIuEFC2WyJguRAwm3L6mQ25g8kk3e46hcQs
    WsOi2elsAWtyi4XEl4Hcv3dSJG5RiemfQY0w9CxxgFFhiaH9egDfa5JUo+FNY0Wu
    gu2/jgcaRTrDfIdDQjxkzM/OVhBMMTGtE0nBZFCo1OnYDoxemwJe4Vewv9DY4o4I
    c4U0a5R5uKDTyIoXftibqSsoYr6SJ/R49BwHkxn89X2SF8dOK8tMsjCr+GFgdFNb
    bP5byeulChnmgTjIMhbR5KD8OEZ3n7pz/ObaXPt17jEafHZ1RSLDWvcqhucwMHBp
    S4lw0LqI+Y9pzPZafP9F+1MOfQPoATJwDj4zZO/w==
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
X-CM-Envelope: MS4wfFyWMMXp74TVqIa4ZDq1a5RTeu6CvgRjeSYGBUl+BREL92sr+JyukhAgOKuFMR+kMw3Rp8+pcnYS6IXjhFZ8XOooBJ79VAtEajO0L0YX5vNdEybRA9LK
    LNQjGJRuLRyWbR92vd9snQiJVqxONLkqmFEp/d/AZ/FFf9oRu3tmFFxELapiV1HpzaCXbsD8w/SIOZvTTmrQK64KTY6EktLH7IPL/wYIEL0bJbSumF+nqIDu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=LD2kUS3hAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=RSO0-gUth4KjHVd8v3gA:9 a=d9vXQEyfJzuvz1X5:21
    a=P5wNHPVNR7O_MSP-:21 a=QEXdDO2ut3YA:10 a=FTB9xuwByZgvWSGbqjUc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeDYKlt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:41:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeDYKlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 075/183] nfp: fix error return code in nfp_pci_probe()
Date: Wed, 25 Apr 2018 12:34:55 +0200
Message-Id: <20180425103245.526116779@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>


[ Upstream commit e58decc9c51eb61697aba35ba8eda33f4b80552d ]

Fix to return error code -EINVAL instead of 0 when num_vfs above
limit_vfs, as done elsewhere in this function.

Fixes: 0dc786219186 ("nfp: handle SR-IOV already enabled when driver is probing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -492,6 +492,7 @@ static int nfp_pci_probe(struct pci_dev
 		dev_err(&pdev->dev,
 			"Error: %d VFs already enabled, but loaded FW can only support %d\n",
 			pf->num_vfs, pf->limit_vfs);
+		err = -EINVAL;
 		goto err_fw_unload;
 	}
 
