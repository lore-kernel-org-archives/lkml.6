Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804309-2-6519166148189703621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804309; b=qixQs+N/2FND0E7IcqJnYPEGqaxL1Wtr1MzhQJ1e73HEulp
    gGvX8nObueiAa4CddpK7hHQ+mEjS9Us+S36RyudYgsN/ze8ZHHUTqSOYbpxK58Q+
    VDUEHiJ/Dxq89+O7/2ISkhwTgctCLxw+qWcHhNGTzSR4So2FgR4uSxgXbR0qY8lk
    uEJ77tkqoKMeWAT2HhCS2wyc5qFHLsa7tPmvRUAB17zZEz+2y/PNtzLUv80Lk85a
    WdSZ6G0/TfcxOwzocjX8IqIjF4a/SEyeDdG6r1zVga50TuIl11yAPWNYgfnDe+PE
    jsdFZzj4RgA5kpFaiHy2DLStGFDf90RqJTGK0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804309; bh=aUHJbdnWpGsnvei0NyzQJQTlG7
    yXspmgXfkZmU8shAQ=; b=rm8HFiZNbjhPeuWAeRUbGJGR/GZPl+hWMFtyN0VKpV
    LD4G8XnOIvnXyimRrHMR2Pq0ZDFDMv3P7bFXPErgFepurxGrlmv8uq0DfFTlS9ZG
    W2V1tTfy1vzWoFadk2x6xkSsCOxZP8ll2AwlW9YmTmhHrSJUulzWNs4Bdb9Cnn9s
    Fa5/xwn3sES3yXrOW2fXJFVnBq8Z5zcK9nlUrrsxHY/bM/EgGFl/8t9rRm+YR0X7
    joaUfrMVFn+edq4fzXc2oORRl6VYwZGs2XINMEv1L7B+NY0wu3Ei3pZaSSqKhwNU
    zhB49lNxfBtkwNJFpsKPDFEOaKw+dBACK46CkOdVY+tw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeCWKHh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755013AbeCWKHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 064/177] qlcnic: fix unchecked return value
Date: Fri, 23 Mar 2018 10:53:12 +0100
Message-Id: <20180323094208.160442138@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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


[ Upstream commit 91ec701a553cb3de470fd471c6fefe3ad1125455 ]

Function pci_find_ext_capability() may return 0, which is an invalid
address. In function qlcnic_sriov_virtid_fn(), its return value is used
without validation. This may result in invalid memory access bugs. This
patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -128,6 +128,8 @@ static int qlcnic_sriov_virtid_fn(struct
 		return 0;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
 
