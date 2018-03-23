Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804092-2-2658952076152318604
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
    t=1521804092; b=JSZe6Td2VTEi8Y1fxBFImJ1kUhOeT9BhNSwbb40CGFOSapH
    xtvT3bRTiDM2NdPXHj7vrH0nUnanZ0+CcPDO6z6wa2z6LD6QoC0lrg8DGIzqGbpI
    ESny1FwDc6Jbh2Nfi5VY6uJJgL0asEw7hZamL7b2YIAGXFc33t4flHPOENSNnnXi
    jqqJ+q6epVVKhihUb81sp2BcN+8DdX8wU2+6anIhbdckwBHWQZqesO4LiO//nSn/
    SqdcNLiVI2WC0fuXCPWHKsz2CR2sMjWufJIiQc8X7k9Ru/g38qd47dhsdZogQnG3
    0Pg6U11s8D2/JxX1CPXM7ALEGSN51qH6OeWE2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804092; bh=YhwoWhq5UBpvNd9aGU0Q+61o1Y
    65klClgbbocHHMnNk=; b=gibnfdNOqYJ5mOhzxL/momD3BFVPaKXobVsRFF5pgT
    dg9GxqoQIsx5fm2FKVb+iCXdX29t0iStHTJg4D8Y56MpkFEQHTrffdRvsKczBS2U
    93mTEhcVOuJyAORzkrGeFheIlwEYMglKTzqeWrCdU/rOowg/Tpm8tzxeiz+qitMD
    h8AhZEfiA/3Z3xzk6UfkPKpnunDTaKxIy6tH8OHesU5T126Yi1k7cXC/v2k3I9Sh
    LtBRSupMCfpcfpQr7VvmkPZBbhaw26wOLLGISVjbSsmh8OQcpnoD1BsXd+1A68kG
    aISGp2oYHqqBBW5xS35q4M6+78emItNA79hiATzSMclw==
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
        id S1752410AbeCWLVQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:21:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755552AbeCWKI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 089/177] staging: wilc1000: fix unchecked return value
Date: Fri, 23 Mar 2018 10:53:37 +0100
Message-Id: <20180323094209.219296838@linuxfoundation.org>
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


[ Upstream commit 9e96652756ad647b7bcc03cb99ffc9756d7b5f93 ]

Function dev_alloc_skb() will return a NULL pointer if there is no
enough memory. However, in function WILC_WFI_mon_xmit(), its return
value is used without validation. This may result in a bad memory access
bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wilc1000/linux_mon.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -197,6 +197,8 @@ static netdev_tx_t WILC_WFI_mon_xmit(str
 
 	if (skb->data[0] == 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6)))) {
 		skb2 = dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr));
+		if (!skb2)
+			return -ENOMEM;
 
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
 
