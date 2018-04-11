Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473256-2-16313343210855944650
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473255; b=wIpt+dEX6R1ucL1TWg8LuI/W1+YUHN2zqTlJblT5+Y6beuAV1p
    kH2yBPM7JdrWDmz8MVE4cXzQoakyMuQyuDX8K5kcuiZwJfe/xXYZBDy4+r9psOQc
    78KWYrVPkiinjPDcaJSvf/R2CCEFj6Yi0jrBRVV9LWhjAgLaTL8d55UOP4Wr+BvI
    /lAAwpVaPerlcnGuG/yQ1wElgpxzgdkkTy6DLBP/XgWoLQlXESXXrB7PXl87SWVl
    t9l3O32iXlsw40JXq9mMFn5DNpKkoLMFC9Ok2ymyNbENi5wMzXpq7W7m7uZ+4pIh
    yYddTIDmGi5nQR7ief4+kV1AwvgqOTXcKFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473255; bh=Mhc/rPJKhCKkIs0kN/j5AGz4L6h1Gk
    kB9B+j8dJLFpM=; b=GCMqqqiR1aooT1G4LKfTNrHBBKBAjjkOU0N1+qu8I8dOO1
    caD0XE7xdM+teW3DSsqDCt0QigWKYYSuzVekGlD4HGNw+moB8xR31K4UN8LWBX0G
    XZLiNi/5beqyLkkaHpEgLcJ65XPjhuVS1WlVVruGeTcyEfuSbtwFPhsCbxAmrDy1
    P3eIbPvVLcpSubd/igM8D2yx7tmAngb38kFE67moR25sKzbIBONJ2qfM2BZc+uY0
    5acYXwKpMhbMDfPkxlT4hOrscqoLmpP5lkqjM8eSvnja1ZtQmB+5RaUA7/Y+HSbf
    qDZSdWVuVGWM169mhum2BY9rX96ThJL9/WTLHFFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJVErHdGni9m1kAPeHyaKIHOlNEhhNV1Lv5oqkAP9BJRCrU01BV1lNPMXIcLAZe7/JZMOlpaXOziWo7JU4ITVgRpb2nyVGLfWTcoK8ZXUnol7kn40gyS
    UZE6BM/MUzMmHSO4g8JRXQhrUi7ZPM6c5uw/0n9loa8u+xs5Q4jihYxst9VUiwm/cFvnJaL64n0xjQhD2eqvckzGQ12sq0H8Kcmm9leGCmvQhwDpf4nt2Sfy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=iCkbH6iyzJDqi2tHSMQA:9 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756811AbeDKTAv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:00:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756806AbeDKTAu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:00:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Firo Yang <firogm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 148/310] hdlcdrv: Fix divide by zero in hdlcdrv_ioctl
Date: Wed, 11 Apr 2018 20:34:47 +0200
Message-Id: <20180411183628.803315174@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Firo Yang <firogm@gmail.com>


[ Upstream commit fb3ce90b7d7761b6f7f28f0ff5c456ef6b5229a1 ]

syszkaller fuzzer triggered a divide by zero, when set calibration
through ioctl().

To fix it, test 'bitrate' if it is negative or 0, just return -EINVAL.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Firo Yang <firogm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/hdlcdrv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -576,6 +576,8 @@ static int hdlcdrv_ioctl(struct net_devi
 	case HDLCDRVCTL_CALIBRATE:
 		if(!capable(CAP_SYS_RAWIO))
 			return -EPERM;
+		if (s->par.bitrate <= 0)
+			return -EINVAL;
 		if (bi.data.calibrate > INT_MAX / s->par.bitrate)
 			return -EINVAL;
 		s->hdlctx.calibrate = bi.data.calibrate * s->par.bitrate / 16;
