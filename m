Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473994-2-4076482009143244556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473994; b=osmQRqczjUCI6JkZ9WE93AVLaIFjfcL3t2kGgpkmvq/PIHc/6g
    C6tyREquvHu9zfDJaQ1rDAmPAJv+LlUlze6JzyaoLxmldEHb/ND+lPOBIbyGqr40
    Z9hdtIyGoHLO5x3dngQ+14jznS728X788EAYpGg7CdC5NTqP1A/y08SwH0M3GvdQ
    hCGsBppOMIvv7bXWqMClJfw+ArB8pYC/MUx2YxUckikWe9eocZ/CJuOGvbD4KXkU
    HfIcsZaYrEtVoODWgeL2uoYeTGddJ52xOrrMWBIt7ajeTnzaoHUnT19NpjaO/elT
    xQk8fzsvTl68x/VdWsAvdX/evRf9MSOEw0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473994; bh=NsDhpXWlZRCwFB6gY7jhM0BRfVZOtS
    /blJvsDEzIOW8=; b=Q6dtPUSX9ygvOkzNZxC134cEnjHfUr+dhILbIsN/6aSX5V
    xqinokFnKeuAhAndmnzlP2GSCx/WATujVTw4r5gD0CwBk7XoVmEBNVeNcfUoMMnE
    yuVRMX9ifUud3ld5zfc8OoxJkNLvfsO57j8TEtwlNp757WmsXRScaHH4VSTCYjJT
    y8yvdd1FTdEORauzEDnSAVq/2lMjgaUnitaTIZ8lSFiqNBg96kTHJoT9I7cO62XK
    YD/jC7vhqqYCzGDgFrxc5lI7u3LlQVSEIS/MgBXaW6H8pZ4cjOrd1QnJPrLHrexM
    tLSYmcp67BY/OsVO6S9g7cur9zzB9cE+nkkxZgsw==
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
X-CM-Envelope: MS4wfMkFj8Gl2uDVaWMP4+UQpzBCqXJrjamstlFi0YnUogV09l6ySnQGfQHPorIJe1nrcsGry5XfXUSoPQxnF0sGrFQ0pJMpgTT2RAJjdJrrJLag8xGM6aTL
    RSV/xtG1zxdZPab+OBQ+QGBuKFhYD8o5NHgpEE0Bx+g497rJiYg8cVSqasRVNzCGWFtf9vKOo8YH5Ovte5VQw51tHEKBPCm3ePSjcgqXXVvNh5np5lR4+ro2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=0GEPkuIj_VExvju2vWAA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeDKTNB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:13:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935130AbeDKTGA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 293/310] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 20:37:12 +0200
Message-Id: <20180411183635.196622963@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit a9d48205d0aedda021fc3728972a9e9934c2b9de ]

We want to use dev_valid_name() to validate tunnel names,
so better use strnlen(name, IFNAMSIZ) than strlen(name) to make
sure to not upset KASAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -993,7 +993,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
