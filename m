Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3571199-1526631844-2-5008773870587131942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631843; b=m/oeso36VSmnMpiH8x0bVLL87R6RcbHUOh+fBLHfZhPLc2BZap
    /LHYiHZKOJevigeB2wd0QbCe7dcOIa4bwnSpKpkS9yJHVoPSCTQkczHKzbcrAJLA
    VEh62HnP7RLpC2Ln/mysID4TYFj5g+ebgGu5tV4xDnkUQjRygeKkevLyPIu/RSA/
    dzG87qv3+F+OEFHaFBSj04VOfBhLK4aVdrGjmmfBXYQWECSPft/VUGAtYbWx4Wkh
    SdRzbaG6WO18nq7Itz+2f6ELfotWjEP2wEqvMIxb3wtwub1kqcJwGFvfFc7mldvT
    63CODuBy+LXkn7k0mBR/5HOI/8AC5GtN1TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631843; bh=H108iyybya3pvbmsSJ9JYRIle+TsEH
    0tAybxpU9hJWo=; b=IjtRKNa+Z2CzPgSmBLPuUvQ6FugkRk3Lc035byKPsk6gOM
    w0q/NMiKVCME934+zjio9BeHnuIQN9UAaPOjREPIL46tX+7BBiZdaZ672PdEaD1U
    jODxFhiRzVqB7tyfnMyBJGFyDgrmbuPDHUwXyA0TJDSItVlLTKdx1P0HqbZolr7o
    1o4LYWLqtF0LHhOIMDXpYHpGOhgqo5wiuUv2TLFfH+H2q2bX+RovaIxrVdq39QJ+
    SweJJmWt2cIwWIWzmcalyeF9DhM7z8EFj7pT9+tl301tNGlQ5fiq9ebqdgBaQMWz
    ZNZywRO+QivbtZc0z15dkXVVvLDnukHh1prQELOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=L/DBnzdU x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=L/DBnzdU x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPAwr+hBO5J3PJKnBPTXaYA72T5CrBJYFkghLqWKvsFh9UJBR0mLRhz9lDqCHBXgjefhnx2SxYMPl2psQSWOSHOtNBOe2qK+wgqTAyNXCbitoM/HqlqO
    enDQLYvPVlJEAk5O21n4X+S4v8zcdN14fO/Q3i67Afz83EOfNGe0BEix/2F5gMqVF3y8EIplOGIUzTB3XGfsaZCVN7URpiwng272ObWh8dsgBQ5d4ZQSCWMB
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=HSIkpTvyAAAA:8 a=7ZN4cI0QAAAA:8 a=1EsaE_6oAAAA:8 a=ag1SF4gXAAAA:8
    a=WFF-jGa1TUzVerVRpCMA:9 a=QEXdDO2ut3YA:10 a=nEgUQDT1tczs5vzW8NB_:22
    a=Dl0WHwQvj8hGZljrFLtM:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeERIWo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753809AbeERIWg (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:22:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 28/33] xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)
Date: Fri, 18 May 2018 10:16:07 +0200
Message-Id: <20180518081536.206131271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
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
@@ -1197,6 +1197,7 @@ static struct xfrm_state *xfrm_state_clo
 
 	if (orig->aead) {
 		x->aead = xfrm_algo_aead_clone(orig->aead);
+		x->geniv = orig->geniv;
 		if (!x->aead)
 			goto error;
 	}
