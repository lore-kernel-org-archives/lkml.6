Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522173942-2-9116051157743877602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173941; b=Ai/hU+GBEkGd/51NQLHGvSwa84TjaSUBMDXPpLU1ifEQtji
    62K4vCsNHaEJKDzx1sXqQZpJdYAMZBR/aIVlsTx1NyjxUkNdcnvIGSn7X39nccoY
    kglSw4/0OjNYo8Qb/yN/6xqp74cwxklVRsFyJi34GJN56vewiuww3iKnjPZ5RrMR
    6t8xIz+9PqfFEWvsOo21a9CSxvh8l8XS6opJLWWM+34rtDHHT2cAahvyRL6vrb9m
    YoP+BdqFf0O8luTpGFidcFBl0kyy+DxcpOkKDibM8dwNjKM3tDlYsBfjEsg+xl2j
    Wm7AJGoFrXDt5Y7ykcVmcKGYqhBNvvbZnZAnNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173941; bh=92zqMNzu+3L+l1X9lqgjOAPtcE
    PGtOE3lRHC+a/3x0E=; b=YxcIbfdMlYMcWcAg7UJDPI7RpzhBghwoAYwVwIjNAb
    4CUmaYwsP/75VTRSivltM/5PYI/7JPQQKTlnO0cAr9yCkMhb8F95jyGFWLuCJ5fF
    hnkjUOWsKy1NuB2CRFFgPnAmmW7MNlzWsv8E3B8P+83igbW0GlyHGCd0RWXp8aFG
    Yh4VyOLbhe0/T4GuNnv7MEoyOx19L4FOLNjSv1ELe5Nsgzv1TsgegOJkGz1qu4pr
    63Bk/C9SDenC7BULuW37E9naFPea5pN0KZwSklVDYRbSerrEW1m0eBWeBJL2KLwc
    FZdME7vYL0rSFW72LPAoPZh6h2WejJg0oBF6OMw9olfg==
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
X-CM-Envelope: MS4wfDKsoRA040uTRWdRMkppVlUXqS/mJTuqMYHvqODaN0UuPLcPHVj6Iy/b3TrPNfZT4sh+9BHQ8c6JCgFW8/yFlQGnEDEJadf4zka823OXemttgB1W2jBg
    gjvaLCsM/245RpVs9iPG8T4Dnw6ifQUBYB4UchaD2h22q4paUhBsOzkpwGWsN/JHmSn21rqaW6Zr3/gWEW7cCg7kjMrtjYzo2sSUYxXDUHBxWvIr5bpWBtaj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=Wcc8OrGY1w500oY2nhAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeC0Q3n (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeC0Q3j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.4 30/43] staging: ncpfs: memory corruption in ncp_read_kernel()
Date: Tue, 27 Mar 2018 18:27:34 +0200
Message-Id: <20180327162718.108104061@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4c41aa24baa4ed338241d05494f2c595c885af8f upstream.

If the server is malicious then *bytes_read could be larger than the
size of the "target" buffer.  It would lead to memory corruption when we
do the memcpy().

Reported-by: Dr Silvio Cesare of InfoSect <Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ncpfs/ncplib_kernel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -980,6 +980,10 @@ ncp_read_kernel(struct ncp_server *serve
 		goto out;
 	}
 	*bytes_read = ncp_reply_be16(server, 0);
+	if (*bytes_read > to_read) {
+		result = -EINVAL;
+		goto out;
+	}
 	source = ncp_reply_data(server, 2 + (offset & 1));
 
 	memcpy(target, source, *bytes_read);
