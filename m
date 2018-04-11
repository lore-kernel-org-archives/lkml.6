Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477850-2-3544162454111293317
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
    1523477850; b=vs8xcCi6qmVJ1vsU744syPAxUkX7auKgu6DANLcUmAoeZqsgRd
    W/S5W0p92ScHWdyyB04Kmpad09fXb3LTGp+GxqPzJRVbCdn2s3AcGuUpmlIBJ/BC
    XacLVRy8dqhgV+v08fIPO3t0/JHkWVeh5chykgokEqn1/jXaYsj84wWvX0I7IHoq
    lnZ2S7qY8kG5p/tOOIHm4hW+JQR/wZYC3aBg67rJiAjL44LKRZayBWte8rYsaY8P
    +kLmI7uqHpGhf4eXrFLk/nllbg0D/7uFy8DDEXcmB0JKLHO4Gtq1LayxwaYCHDGU
    zit4tQ6yrZLTy5E0XRpI4DCY+gZwAqQipDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477850; bh=8MdfAWcGScj08y1BqlClp0LFtjXcyd
    fZ1co1XWJSf2I=; b=bhRWSvVer+K/HDQXLGcID2WasNcobxLX/Wlj9LtpOIYtt4
    EiONjfiYe5PUL1PAMdARnDA4GXenidTc+6KPkgwSatAxBmdBTM/jySg2l/sw/MiQ
    6HF0mWS9dva3vEBlRICpMr4XYLeYu3WqE3jJ3Zrjb6/WO3EFXzRpN5FaRYahmQa/
    KZmTMaAvWosOYQWqpqqfX5HpWr7xh4P+uUMumljE70tgB0QfssAekfNcVLxIGZN6
    cbxEbsE5jdholiCXNc5uWesZ2IXELKRjv2kXUiVD1BGi5tEMv6sAAn6F6wZPMIjR
    lEB3S7kIxf1ActaDEJHJs0lVD8q7sQWTVwFDSQIg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfMrXBwXDou9lPO8Sm0pVwvLD8dRV6BXBQrqLo3lu0IBdqkxP6Q2p2Ewrv+QUIZZcSOxjsiooh8qhTe1IWIiOMic4xE0FFW0Zx+O3U6ClRK+6R+J+RPm5
    Wa7uXIGSw89el1F0PMmGpNNA7S3KwVQST8pXkhd84v8o/pqVB2Y5WdBf1BWTbBYgLYS9oFdgn2/YemioxOQitxVa9kMcE3YXzme4EyIulGl9Htr6V4X0QWMo
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7ZN4cI0QAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=7loVob4iMjE_SrWWOpgA:9 a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbeDKURL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:17:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933142AbeDKSws (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 012/310] af_key: Fix slab-out-of-bounds in pfkey_compile_policy.
Date: Wed, 11 Apr 2018 20:32:31 +0200
Message-Id: <20180411183622.833783366@linuxfoundation.org>
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

From: Steffen Klassert <steffen.klassert@secunet.com>


[ Upstream commit d90c902449a7561f1b1d58ba5a0d11728ce8b0b2 ]

The sadb_x_sec_len is stored in the unit 'byte divided by eight'.
So we have to multiply this value by eight before we can do
size checks. Otherwise we may get a slab-out-of-bounds when
we memcpy the user sec_ctx.

Fixes: df71837d502 ("[LSM-IPSec]: Security association restriction.")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/key/af_key.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3305,7 +3305,7 @@ static struct xfrm_policy *pfkey_compile
 		p += pol->sadb_x_policy_len*8;
 		sec_ctx = (struct sadb_x_sec_ctx *)p;
 		if (len < pol->sadb_x_policy_len*8 +
-		    sec_ctx->sadb_x_sec_len) {
+		    sec_ctx->sadb_x_sec_len*8) {
 			*dir = -EINVAL;
 			goto out;
 		}
