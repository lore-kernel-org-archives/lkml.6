Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527164608-2-10781460837121671861
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
    1527164607; b=RpMlpEpVNRWlcrnpDOCRfEV/LOm0pUXS6iUgtnyafuJHlm0ELx
    Y+6foi5K/CQ+/9la29hmkTMZnUk/o4Hek7B3LV5hSUsFqXUm6PTOYfVSHaYSzeCa
    FlweJRs8j9DvJv5fcUfKOk1o1K19wp4mXCn+tCyLgA2zwL5sg0J7ALOrPgpJhy65
    SXaD0L1gfhUI+1BiOYdN2lnXlSdEu2bGrqlp8pO01G5KFKsgekf5BfbwZBVEXKFf
    eYRR1aFT1GuaCFKC0rD8dWobYN2AclxQrz74mSySO39i1bs2QNghElyP9QkDfk0k
    VMLz96Vz0d5HxpmBckjb4jXhJP6YERwIDNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164607; bh=tF4jM6f6D6WXlyIJTyI/DLVcFUIy/O
    4MDnDeVQDCteM=; b=TKmFx1KvKoUtvIkTkkL1eOKRUbcfnqIpepI4KG14escIA5
    CNC0JJQAul0XJtHt4fFWZVHLKS2tRDfTB73vNoUclMv1pcS/6kb+gIFMW47Dbu5M
    i1UMGMsLYeL9O1qY9TWK9p+a2APx3Dx6MmFSK5XqjKxDYoVjEudFJ0xWG+VfhwW2
    7zgCcW/Ar7RKcJs5JrjAsh34ez1AnXQSEu/k3CLN3etlBBQh0qdKJn+5I2cCoA9+
    S+m2YiAo6FAiktYUFblliXaPXveuEIJ/gdYW6bTK1/H2F7HU6FGPJn41zH138AJL
    Y47l1cnD3CSmvzQqv6jPVAait/HxgYaJr3NekqRQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ZdH5B5c6 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=ZdH5B5c6 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfI/Q46qddVSZcF/8coylc/yU+GG2Yjf4C8KqgkSojmCBnEbnYODZJjajO40qFhTgXUJV7Z+Ki/1p6I74Z0UjLl8LfPcs7H8d9g7riDgtfvel1hZueE8I
    k8r6jnW6N7PBiC541p/nNOSprcmyk7sQGlpaPPx62PbF6OIdk5xkue5uU4knYnwntRd6erQmafknkwREF9vCMxbtTdaQGUVcDkd9fwuUxZj83MkA3jWDje7h
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=brYE-qls9YapW1p9bzMA:9 a=QEXdDO2ut3YA:10 a=h8Bt5HTj68qkN2fS7gvA:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966087AbeEXJk5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965759AbeEXJkw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:40:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 11/45] sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
Date: Thu, 24 May 2018 11:38:19 +0200
Message-Id: <20180524093121.914402632@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 46e16d4b956867013e0bbd7f2bad206f4aa55752 ]

When processing a duplicate cookie-echo chunk, for case 'D', sctp will
not process the param from this chunk. It means old asoc has nothing
to be updated, and the new temp asoc doesn't have the complete info.

So there's no reason to use the new asoc when creating the cookie-ack
chunk. Otherwise, like when auth is enabled for cookie-ack, the chunk
can not be set with auth, and it will definitely be dropped by peer.

This issue is there since very beginning, and we fix it by using the
old asoc instead.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_statefuns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1959,7 +1959,7 @@ static sctp_disposition_t sctp_sf_do_dup
 		}
 	}
 
-	repl = sctp_make_cookie_ack(new_asoc, chunk);
+	repl = sctp_make_cookie_ack(asoc, chunk);
 	if (!repl)
 		goto nomem;
 
