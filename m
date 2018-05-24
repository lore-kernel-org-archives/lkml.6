Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155531-2-1657296871078937781
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
    1527155531; b=eAHzIOkrDMEpiRuB6Vfm3YI1qQJxXUrPAkutQNIY3dZ1bxLK6z
    jGaAWEb5dosmVaRNSKnpCu1f6kjrKsFyI3NDay8kL73mI79q8NLlvTNjWPWSIHym
    dPHx6OhKOswHsjFlz9UUZxZG7y7+WTVI+HiOECFV3by0t2RgoEIpPEn8utVA3+ki
    j1/ZZhgF7ydHSKrWpaukCiuVaySMbbp/VTjcSUVQtudanPxqx2L0jWugAGrImd7+
    mQqq9GXzCphxy40pbiy2CxBX9YGljz1YPII8B9UNKTESSX2Tsii1P3XHYK2h6jpc
    fQcUFJin3/E0pyykwctx8dn+A8SERbzDxVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155531; bh=F2I0tiLSuw+ce+zW8wahDtdr1Eqf8y
    rUrO4prj34rZU=; b=IiuqC+w5NPkDnOEOpYde2mXeN1/4c3wRVG2Dt7ryv5/Eqd
    /6ormpggOSge8MAjQ9cHHtkNxSNtk5xyHysekd9EgCq+nSGX14Th6KitJX2nbvoZ
    8GQuGaOduYtKTiufRlIE4sRCSQyuYytY3EaAF0CTGcRJh2ZJca5AX2+aWOys7l/T
    DH5mhrIrvbmwT81agw+dORKi4BQha04kmLszwonyHTFl8hskr3gabcAcShp6PrJr
    YywMiW8689AkKvaES+sz0uDKWHMejf5/gZ+wiVIg32NGzg85BoUH8BUkWdkRCZkQ
    v48bnzZLtgechEy4ZkL89uBS+e2KyHnmCrnbMRJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RKK1SEaL x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RKK1SEaL x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMZBjgw1661Bz80TwDiLp3FcAx/HQeDtIAQTAmLDpwxttZPoJfNiKsKlOxi0s4hhUJWEBIjKA4wrCPLuutEwQsW/viL5IHfnNtrFltJdxKf9VJxh5Ieq
    aPEkXtBwlfUFAt3pZNGBe1/5fPPM4qMPHuSpTdpZ9bq00OAgfozEzyuKpIt9o89/iPObbL+8j2jU5FRuwvQ9PuFRKTMxLRYAcVW66A3l+YdcfxGTCIVa6qI9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=XVdAVTEBGy9c5nRlt7QA:9
    a=cDgNphkIKA4B4Q_u:21 a=VoDLklwhu_RMAfzC:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967815AbeEXJwH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967380AbeEXJwD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 020/165] hv_netvsc: Use the num_online_cpus() for channel limit
Date: Thu, 24 May 2018 11:37:06 +0200
Message-Id: <20180524093622.799862232@linuxfoundation.org>
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

[ Commit 25a39f7f975c3c26a0052fbf9b59201c06744332 upstream. ]

Since we no longer localize channel/CPU affiliation within one NUMA
node, num_online_cpus() is used as the number of channel cap, instead of
the number of processors in a NUMA node.

This patch allows a bigger range for tuning the number of channels.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1221,7 +1221,6 @@ struct netvsc_device *rndis_filter_devic
 	struct ndis_recv_scale_cap rsscap;
 	u32 rsscap_size = sizeof(struct ndis_recv_scale_cap);
 	u32 mtu, size;
-	const struct cpumask *node_cpu_mask;
 	u32 num_possible_rss_qs;
 	int i, ret;
 
@@ -1290,14 +1289,8 @@ struct netvsc_device *rndis_filter_devic
 	if (ret || rsscap.num_recv_que < 2)
 		goto out;
 
-	/*
-	 * We will limit the VRSS channels to the number CPUs in the NUMA node
-	 * the primary channel is currently bound to.
-	 *
-	 * This also guarantees that num_possible_rss_qs <= num_online_cpus
-	 */
-	node_cpu_mask = cpumask_of_node(cpu_to_node(dev->channel->target_cpu));
-	num_possible_rss_qs = min_t(u32, cpumask_weight(node_cpu_mask),
+	/* This guarantees that num_possible_rss_qs <= num_online_cpus */
+	num_possible_rss_qs = min_t(u32, num_online_cpus(),
 				    rsscap.num_recv_que);
 
 	net_device->max_chn = min_t(u32, VRSS_CHANNEL_MAX, num_possible_rss_qs);
