Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163847-5-214588475202819470
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
    1527163847; b=HKZX12euUI8nAF0vCEl75zngzwNkYsREBjIhgWpmsVINJmi0VM
    rVcwazYUQCf8hlL9i+uP9mZREWf3IyILgGpRa0v+MrOWR0MFq5tumj2pRCjv/qkP
    B9kB8U/+E+n/CbaTdHV6wXPYYnqeRYKweTcQwSXbzCjJrzdLysoBtBoLclVKqiXM
    5WypRtp2aTDju+OqgGW9wCfwE9it7bl60qrKxAvQjPXvKsFJDmwbAp5aryZIVkE/
    +09AMJP6exMOvy8T3TGme+n2zAYP86pe0FgvYcKpu95gif1EPaXyAjySOLSmLoyh
    5wr1s+qDsPeJvC087HlBmO7mwAC7RZ+uDzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163847; bh=EhzoPgfxy91tFrE9WVh3id0QY+PFmJ
    6FJZpdyco/STM=; b=ALw/MczMPS1Ohn0c/aM+ylzUtjCl58em+t+c6PFTdx9tXP
    PxtPwQJKTU6bOQNupgDDgFyJaxWHTAnPFrC6tEWc88UXtlWxQfMzdYMxmio7tb+4
    PcpB2BTcCqfDLBVgK2QDAGDtSkSB1Z1bP2s6EfqGNq2j9HHWwZONaXhOnRwuATig
    FjZ45xQMVY2Lx7h1m/HoKSQc4cP4LBPVL9XhkWy6TL33Mk0HPn2rPo7ir/sChOKE
    GzQG1VSDBZ7RKRiAbfDg4X6OAjULaOlglStmcOiuIDGIc/LuEe9sMp/d2Q17HQW8
    M3ya4SqNqcXdzCOeHDQEMX7oCspcBq5vhLobohxA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=usVOvFT7 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=usVOvFT7 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfM/9N4FoX7zM9Ln8iFyxft23kHJoR+gl8Hr7yKmGdNSqBgZ0Pnlx3tYXbN/PnWmwQEGGTRWd7Sftw3kLdiXF29JgG20gn7GVA14eRWIywEhAovIFbiYx
    CqUvVmug2UvYbrDZprcJRu0dBjwOkE7T9ZTWHq+10UmeRNvZjSvUzRokEZ8K4oeEhpae/qDyE7ybvCTpMH0vPgtaxSE17kb0E00mj/6vWB7+o8JFMiEuDRgK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=L1WlcYRJYCfth8W4ZAIA:9 a=QEXdDO2ut3YA:10 a=h8Bt5HTj68qkN2fS7gvA:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966531AbeEXMKG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966457AbeEXJnS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 18/92] sctp: fix the issue that the cookie-ack with auth cant get processed
Date: Thu, 24 May 2018 11:37:55 +0200
Message-Id: <20180524093200.827087772@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ce402f044e4e432c296f90eaabb8dbe8f3624391 ]

When auth is enabled for cookie-ack chunk, in sctp_inq_pop, sctp
processes auth chunk first, then continues to the next chunk in
this packet if chunk_end + chunk_hdr size < skb_tail_pointer().
Otherwise, it will go to the next packet or discard this chunk.

However, it missed the fact that cookie-ack chunk's size is equal
to chunk_hdr size, which couldn't match that check, and thus this
chunk would not get processed.

This patch fixes it by changing the check to chunk_end + chunk_hdr
size <= skb_tail_pointer().

Fixes: 26b87c788100 ("net: sctp: fix remote memory pressure from excessive queueing")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/inqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -178,7 +178,7 @@ struct sctp_chunk *sctp_inq_pop(struct s
 	skb_pull(chunk->skb, sizeof(sctp_chunkhdr_t));
 	chunk->subh.v = NULL; /* Subheader is no longer valid.  */
 
-	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <
+	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <=
 	    skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton = 0;
