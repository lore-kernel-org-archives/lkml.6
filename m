Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836206-2-68310346576842285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836206; b=guZasV7DVkG9DwOhqwbhQAVqQTT35uWja25OVR8pqpY4XgC
    IzxRI5WshhaesuZl8+ncZj3zZd8IHLb/aizqjeZebwJqcmnIuJYF0kbFFlG632MN
    aNbySSwrSWmRbr+2u7FYQNmJ5tyNzRcjYLsCjUhxo3GCfelt97f61IWMQJ8sAxM1
    19X8uhfeh0NOjbwi03Y10IVqhgTruSvTff0I5vxD9HEif93l6NXfwlNnfkuk4qDL
    AlLrps8qREohvFJH1RkDadmbdeZQ9kb+aT9BsxcXZfc2aj7VyR6hWCLSLA+PAc1t
    n92tfNGQZy7C3S09wNaTxiVYe2txgv0Pl8By0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836206; bh=/xL9QlNMkrDfXwO00cj
    9dhoa+eIFKX0FoRFEgLRY+Tc=; b=GpbcGU21Egr4N7luKlYoyMnTjqNYYTe9G09
    XgHi+KHGAh7fQGLCTKNYk8O+Bqt2u2vqv7GXC2oZBFC14+pTnSp818BcfC/vUEUZ
    8+5IXJU+pmqRgOk8rQmIyuY11GAfGnrYafqPHwCjvIHZgfokG2t6TvLWzDyAlvvy
    3IEoHHVvbIi9kOBZLS6jmsr6riwG9DE2uXc0Hq2NjH0yq+nDiVaZN/UrUb+9TptS
    Ecsjk4fpHJxgEKYnrJJP/OqwH3KH9XwEtoteZpRvzvdrXJIPux33Vx7PZzTkLRmT
    Av2Uzh/Ng9QIV9p/QjXRBqb73kK0LJXlYvXiFjB+e4XD3pLmCeQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeB1QC6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:02:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34732 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeB1QCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:02:55 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.962213227@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 180/254] xfrm: Return error on unknown encap_type in
 init_state
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit bcfd09f7837f5240c30fd2f52ee7293516641faa upstream.

Currently esp will happily create an xfrm state with an unknown
encap type for IPv4, without setting the necessary state parameters.
This patch fixes it by returning -EINVAL.

There is a similar problem in IPv6 where if the mode is unknown
we will skip initialisation while returning zero.  However, this
is harmless as the mode has already been checked further up the
stack.  This patch removes this anomaly by aligning the IPv6
behaviour with IPv4 and treating unknown modes (which cannot
actually happen) as transport mode.

Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/esp4.c | 1 +
 net/ipv6/esp6.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -657,6 +657,7 @@ static int esp_init_state(struct xfrm_st
 
 		switch (encap->encap_type) {
 		default:
+			err = -EINVAL;
 			goto error;
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len += sizeof(struct udphdr);
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -600,13 +600,12 @@ static int esp6_init_state(struct xfrm_s
 			x->props.header_len += IPV4_BEET_PHMAXLEN +
 				               (sizeof(struct ipv6hdr) - sizeof(struct iphdr));
 		break;
+	default:
 	case XFRM_MODE_TRANSPORT:
 		break;
 	case XFRM_MODE_TUNNEL:
 		x->props.header_len += sizeof(struct ipv6hdr);
 		break;
-	default:
-		goto error;
 	}
 
 	align = ALIGN(crypto_aead_blocksize(aead), 4);
