Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221885-2-5310326241140561293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221885; b=WVD7ff2Ee6cg2iFhsyHT6/JzbPe4UaFybFvmu8a69uSWuPG
    y3+c1JlBxwvMnzkphuCb3ndvJoYN6saan6aiD6nmez+cfA338JURvw2ZLz30ZaNd
    hRPFLgQF7qhCzDloSkUOAjKMqHk8LZGCTurHLd/kbo8R2yJSDvCwK4mGWoEjarnK
    qgPtbQHM1jRWyD+5zr0JEloc7DdW9f/0l8yRRJ4ald06TfXagcdiEOHNoPY70bz7
    UOm1GrbAi6e0+B8VUZut6R8Bp0iQWhaE1bfdkL5CDOZ6sAkV24wZJSW9z6v1mgm/
    nmOtdlg8WxCPv/ei6FH2HnKWUfiemiRC8oVERBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221885; bh=rZMMTBKuTmGXU7SHaC/eNUThsV
    LCA4Vvie1L3QC9Qp4=; b=JflYj4dUIla9Or6oYu5zRomSRnU+nAKRo+PWJn6IyT
    h9tppEOAiqtptUQ1y5S1w0ZLYhbxY5qisBVlTi4DqRGA11zhT/hj1mmXKRB78KCh
    MmJ/GF/XPO5fiZ38OTcGt8o4MYWx+aMWVDx+1rwFQYz7PJVh3Cv8W3pSod+s+u12
    IwpIMXsj5s1Iu2DA5X/DUSspFP2nrnCwd8ugQMWl3Qejvrp/L6FtmZ8/r4gltffU
    9MRZCsZoI/RRt2Gbg0IpensZBcYNiOkSGgmvvblMz88+V3TDQ8am6py45MSGMg6C
    9YV4jh4Tl8twbmw2px2etLIM6ry/i3xSFo1KeFNzj4xA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeCPRhu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:37:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbeCPP0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 3.18 25/25] fixup: sctp: verify size of a new chunk in _sctp_make_chunk()
Date: Fri, 16 Mar 2018 16:23:12 +0100
Message-Id: <20180316152233.769905388@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ben writes:
> > +	int chunklen;
> > +
> > +	chunklen = sizeof(*chunk_hdr) + paylen;
> 
> I think this length still needs to be rounded up (with WORD_ROUND here,
> instead of SCTP_PAD4 upstream).

So here's a fix for this problem.


Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sctp/sm_make_chunk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1369,7 +1369,7 @@ static struct sctp_chunk *_sctp_make_chu
 	struct sock *sk;
 	int chunklen;
 
-	chunklen = sizeof(*chunk_hdr) + paylen;
+	chunklen = WORD_ROUND(sizeof(*chunk_hdr) + paylen);
 	if (chunklen > SCTP_MAX_CHUNK_LEN)
 		goto nodata;
 
