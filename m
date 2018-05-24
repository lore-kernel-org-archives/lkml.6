Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163701-2-14596742081153638912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163700; b=b+eR1XMjGbTJY3s2VKUcaGFPPaxUHBRTg0bYw62q6LNaNR9VSZ
    rWNLaKK1+0OObZSZWuW2UHTuD08H/ZQA8Y9zEcCRBNWD826vP5rKrNjwbZKE33Pt
    Vy89A04vccYS2tf1Rlh9uUAB68ZwFkxZnqFBQ6vVLoLQNUcWj4+fNSZ207fhJBqk
    RS+4C/P9uSjERhxMLeydlTFxvdKq3ZKy8M652hVYBBm6tKhdst5AmiOb5HDnkHWu
    tMVBZMNH0E2LNRs6PbQb+cv0w5lYPVjZB2/NHnftWYteKGa8fzYeKtcX64dqCkjT
    HZr+g906dfD5YAOLmXysPM72rcb4U4qOrKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163700; bh=QVj4dMIRGfx5U0YFAagM8FiFtRtDha
    hRQ9AKqwHhuSk=; b=kxh12Y9eIVDayyOjPP8BCq766kvufJDoB8ZkS4b87WVHN8
    8wSqG/Hc+37n7RRvVefFCMWAKI/z3S+QY49KwPZTFyt/l9alX51LruOyvDivP6df
    UXRR5sTXRoS9UHCh3bceiOlB/KrKBGOdX7ghI8ghzy1lF/fT6ts05WhNpzoUBgTt
    zbae2NMPXN2ygvyuijUVDZ1v8HP7aWCZ1aLJ8pJSduipAlFRBU2wmAR5mCHodJpK
    iYQ3rsRE9PlIJ6xnRCXiW6ICHBAEsEUoNjXFBVOGoxJIQxjo/y2OHMAz5T8+dbp4
    NfHuNnhMx6svWLral98vFGQX3u8SAyyyaxgnIABQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ko8TU2q/ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=ko8TU2q/ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAmiYY4ZqmICGQu6IsxlWqiqGymDdruSMNgr7NQFjcY72pYvu8aaU0/GXptnLyZohKlTVPgYwV25t+63xhQ7ROlU23DcEuZTXQaE89e/M51Ar7J8SXQ3
    65+JGXq0HTcOgHtN9UlKCdQHSu0K4tjDXf+AkqGBkARnm5U1x8ayiQCw8KxWtsMU1VJgQcX3ba1ArHiACaaFXPDgGkImHHruAfNtWD7CiFLN+j2P5A7GYXyI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=HSIkpTvyAAAA:8 a=7ZN4cI0QAAAA:8 a=1EsaE_6oAAAA:8 a=ag1SF4gXAAAA:8
    a=WFF-jGa1TUzVerVRpCMA:9 a=QEXdDO2ut3YA:10 a=nEgUQDT1tczs5vzW8NB_:22
    a=Dl0WHwQvj8hGZljrFLtM:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966526AbeEXJns (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966154AbeEXJnm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 26/92] xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)
Date: Thu, 24 May 2018 11:38:03 +0200
Message-Id: <20180524093201.478863463@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

commit 75bf50f4aaa1c78d769d854ab3d975884909e4fb upstream.

copy geniv when cloning the xfrm state.

x->geniv was not copied to the new state and migration would fail.

xfrm_do_migrate
  ..
  xfrm_state_clone()
   ..
   ..
   esp_init_aead()
   crypto_alloc_aead()
    crypto_alloc_tfm()
     crypto_find_alg() return EAGAIN and failed

Signed-off-by: Antony Antony <antony@phenome.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1159,6 +1159,7 @@ static struct xfrm_state *xfrm_state_clo
 
 	if (orig->aead) {
 		x->aead = xfrm_algo_aead_clone(orig->aead);
+		x->geniv = orig->geniv;
 		if (!x->aead)
 			goto error;
 	}
