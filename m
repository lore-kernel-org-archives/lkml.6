Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479845-2-734756134105453880
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
    1523479845; b=ezQbbFfEe5DVWuqzFQfe8PGSw6oP/GCIZs5Y7V/pQF1sun/CWk
    m775M5E0jW8Hj9CdBoWfYwNEW9/bdIHywjAh/gr/wL3rZK4LgO1QHhMcspj1wkzg
    0OgEIst4isZh9nM/0M2nGztaEMYzk8jh07ROFVFdRer1dUlSshUlYq06KMkuJMrK
    m9Lo5Cyt2cYC7clyzngQShyiY4rNkKt/A9jfhtcnEZHEv4ubbXkNzrELv8hNvLrG
    DYg0gxM0DXyY+bUU/bKEwKugrL/UJvv+jX25vnCYwz/kZlNBmh/t3tA9bp6A0kOx
    QItP+Je7b/8mDS+suzVgyY4uGBEYiu321IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479845; bh=unVioLxNi5PgbiGC6af2HPjXM8bk7H
    ZxltYtS/D0JvI=; b=hCjr2w3tDxOIMbGgug+ewEfJmDHCVRX7I2bBxWQ9WnevJe
    gJKN24dz1a2/GyFPrjFMUWkdsuT0NS3NNCndNPoe1nh0NSRhkPvMH5wPiwKSzwzI
    9Jwn4YeXmEOzidbtIPCoNGVHeyiucAYzWVQGYEIvdzrSCkB76911dIGV1W6exlcU
    sMorwpzWicsii1LHIBGDpWSI0vnEEu6CBm4UgZhCwP08E7lbj0N2WV8Somhfjf2j
    c28WCcYzZFTVHeFlnSANtlYBL255AlWl3z00hbU9WhGNHjd0W/qHD4bwEOaspCqH
    SvxnlNpQo4EOydrYoOKqkvNuwU8LgSrv0RT1r/lw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIuKwYcV2AUV3yqNXLD17MJugBj5Ap/CLVmWsDIiY568CMwn6PUzSs1GYLTU8qnhY9u4evDMSkS4iO4R4ylwdKsJxWfPJ2rxqs9ZZ7rCMdyVUMuDCau3
    YhxnAflhu977QMdH3ZvPYe8OZqRR5EnXfdXRBLWJtPppEx57oBCD7gngeb0u/CspEZhnzH1yI08UTXgOKeaegct/dUnZs7hGtYMgkmxrALlJ3+rrw/vDhFDV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=HSIkpTvyAAAA:8 a=YjUGpS9dAAAA:8 a=7ZN4cI0QAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=hCrulFPZOlHjl7DSuTMA:9 a=8BK4byEKfsznS-7H:21
    a=6ILXRhg44cHUNsJ1:21 a=QEXdDO2ut3YA:10 a=nEgUQDT1tczs5vzW8NB_:22
    a=-8Mv319iI4o1NKE2ltNx:22 a=Dl0WHwQvj8hGZljrFLtM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeDKUu1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:50:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755608AbeDKSpu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Richard Guy Briggs <rgb@tricolour.ca>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 054/190] xfrm: fix state migration copy replay sequence numbers
Date: Wed, 11 Apr 2018 20:35:00 +0200
Message-Id: <20180411183553.484169269@linuxfoundation.org>
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

From: Antony Antony <antony@phenome.org>


[ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]

During xfrm migration copy replay and preplay sequence numbers
from the previous state.

Here is a tcpdump output showing the problem.
10.0.10.46 is running vanilla kernel, is the IKE/IPsec responder.
After the migration it sent wrong sequence number, reset to 1.
The migration is from 10.0.0.52 to 10.0.0.53.

IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7cf), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x7cf), length 136
IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d0), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x7d0), length 136

IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R]
IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R]

IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d1), length 136

NOTE: next sequence is wrong 0x1

IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x1), length 136
IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=0x43ef462d,seq=0x7d2), length 136
IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=0xca1c282d,seq=0x2), length 136

Signed-off-by: Antony Antony <antony@phenome.org>
Reviewed-by: Richard Guy Briggs <rgb@tricolour.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_state.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1208,6 +1208,8 @@ static struct xfrm_state *xfrm_state_clo
 	x->curlft.add_time = orig->curlft.add_time;
 	x->km.state = orig->km.state;
 	x->km.seq = orig->km.seq;
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
 
 	return x;
 
