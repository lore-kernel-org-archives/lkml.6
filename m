Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481705-2-13677813557848075221
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
    1523481704; b=H4ZlNMLeKCd27+7RN02Zun9zZdHYSByUhzyUNYia87qjTeaA7I
    MZK/Va4ijf9YMkbEQJHY5uTuIDIYO+wr9+srTG0vN+hIJk8ggspMWwFYQZ1nSlSX
    Rsk5fmE/n66UrR3i2NTek/DfC9B6j3o4vVaTJNUpycz4pjWZx72mwUrb8m0Ma4C2
    WD8f0fy82O0nGfo+LJdO4DjRxdkza9HeZIYt3wwdZcBjm8dB4zxH2iaNonRngsL/
    KIK6bvgskRYip6HDosJgi3N6hvL1hW7dZwPnLB/0/vS5g9dn84CrGv/KqtWCgBL0
    IvHyvWGAnXpvEmD0hPSpLoOncRRHaKekTJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481704; bh=+dOUuM1aUbxhni+Lcm1bScKDt1QphX
    0vWcyRHRTIr48=; b=E3MvoARM+hBmG/uKQuMQf2fMUNKFZNMq2tFchr3owVrCpO
    fl7Y9aDX0tQZNfvzWyDFp9eZCt2qwiyo9TggL2m2FTlsbK+9KDeP32MuahF0n/9w
    aiiIJawrLzMJrEkfibNOv5cRBsor2BLffNlRMZGEFP5aEcUTpr2QKG8mHYgLKeD5
    FmXYf3wLlFnNDi67JxnAEBbdD9fl9kUqhxU1nrcN7Ht2Vmp17MzfTOn/t+MqvWqg
    vqBBE4uo8myleEsSVzB16DKuz4I7YB6mgS4bh9UZsekVW1mCNWMmbHadE4iP1zeo
    8me90Bg70PvERb47kTk4waUukJXu5MmH/8aNN2sw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJkLNpYdp1DDhrXYVdGml4bc7+LbcHQailVxoabCuSu/XGOWG8jDrT11BdKnCbIwXTdQvmn/cyMU9XjUqw7WnOF9f5wQFBnZ1mYaADYpO1a77pl9kZev
    GzGvsdGG/E7QchtSokey3MbaCsa/Djh9azHt16OHi6onSN52LKDt2SCxAzZMEakQquMrhk/mF78BB2O9YIZ43T5fs8uYC7RRh7Ljm9JDDfITULZHCFoNuLtN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=HSIkpTvyAAAA:8 a=YjUGpS9dAAAA:8 a=7ZN4cI0QAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=hCrulFPZOlHjl7DSuTMA:9 a=JacOF_Woh285DjFo:21
    a=6ILXRhg44cHUNsJ1:21 a=QEXdDO2ut3YA:10 a=nEgUQDT1tczs5vzW8NB_:22
    a=-8Mv319iI4o1NKE2ltNx:22 a=Dl0WHwQvj8hGZljrFLtM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbeDKSjQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeDKSjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Richard Guy Briggs <rgb@tricolour.ca>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 035/121] xfrm: fix state migration copy replay sequence numbers
Date: Wed, 11 Apr 2018 20:35:38 +0200
Message-Id: <20180411183458.243729907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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
 
