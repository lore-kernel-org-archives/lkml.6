Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161085-3-13825016360363828265
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
    1527161084; b=EUBpYJDgnVv7vOSkPlKulQR4Dpv4duaa2LCet1RDK/z8lXNim+
    p4i5rcIPK0I8mLGI6epqXMSXr3ROBTu0SoWk7OV2/ohv6xw2fHgieXMK2+ij3CrC
    RMpYgKoKca9NygxBWqpaFayFq4G+nNgBorJiPppiRC8siYADdco/CYli5Kn6+mht
    QDlDUhklF7CLw8lB4nWuXE1pfjAfgCidyFp/Zg6JEfyNBb4ZJ2zvKOE90dQ5Jcb6
    /sCNsfpe/w9X4Enh1Nf9N+wob/FyR1fCvnk4a+dYb5oD5BbTI7kGb2K/ZXwVPwYo
    SaTq6u/WvBRxJa8vjnObcJpbWkfg8gPTMEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161084; bh=c9MVv+7M1zrBdBxws6g0UC0JjKAp/D
    3UH/c8JztciQo=; b=HecrNj7lI2HnSjyhrp3DzIQv/TK7FFPsyix20QwJ3MU9sZ
    rBt+OSMe3zCLw4ioZ+tves7f6CcfoPGFPo/KIqgfhKccJyRYUjC4mb+o6VR80BHP
    ccT6EYHLcS42dIiytYqzGeUW1T+WnEk9jwbuM7exf2g9ccz4cPJXeZ5FmgBeVX7m
    7esi7W4Pbi3B31bERLEqvl9EFh99wWceEZRPk+ETJJ6JExw2QP9AaoOT7wayRSMe
    1sYjNOibi8WyF/Ay66vCFH51mYKl5kdve1v+WpA0MaGgpT1SzioYWcyKU6ffvNHV
    +3FI2bCq2vn6Px+CS8kzAVTrkDy2bK/LSEYy/Png==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=n3wg4Pt2 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=n3wg4Pt2 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfErK074jEWEpv3kNTRK1IGqwxew28RkxK+/eTBVTziNZLoUxy036f9gKJv4hrbSqBVKojZXZV6w2GHeJWpEmBVO5OInrbadsrg7DZFQr/ZIXoQuD1kOr
    ux72hQXPXK0EsGrF2bsLhLnkKC1twbjw1jyL+pgyN653sam+oSEdq7V5EmnAejT6m7J5EaOdH+okToq9R5opoKIeakKgGzUtikGRiBSXA4WBOcGxNuw3zagl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=4wj1V9UaH3AHkzC6NEoA:9
    a=KdtO2MLwL6aJPTgH:21 a=GAe7UlhCpXq27DCJ:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967440AbeEXLY2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967780AbeEXJvw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 016/165] hv_netvsc: Set tx_table to equal weight after subchannels open
Date: Thu, 24 May 2018 11:37:02 +0200
Message-Id: <20180524093622.641047740@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Commit a6fb6aa3cfa9047b62653dbcfc9bcde6e2272b41 upstream. ]

In some cases, like internal vSwitch, the host doesn't provide
send indirection table updates. This patch sets the table to be
equal weight after subchannels are all open. Otherwise, all workload
will be on one TX channel.

As tested, this patch has largely increased the throughput over
internal vSwitch.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1114,6 +1114,9 @@ void rndis_set_subchannel(struct work_st
 	netif_set_real_num_tx_queues(ndev, nvdev->num_chn);
 	netif_set_real_num_rx_queues(ndev, nvdev->num_chn);
 
+	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
+		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
+
 	rtnl_unlock();
 	return;
 
