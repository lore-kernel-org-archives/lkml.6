Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479237-4-4421552752397555286
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
    1523479237; b=Ya4jUTvZay1Nu6wMpsAn7X+Vf8iFZOpXdItfVfahZzEi2Pyjgv
    AnOzurMdkS5nJq3+5zvulW+8ugKUMz5ErKdrs4ufOCMeYaOFnKqf2qjcGRwFEOiA
    hQJxvUJQEQmyDI7Uc1reyLFUiVweFCqRxFgts2HvKCJL7HJV8GHVT+FePGTQzA6s
    PQpWLdJcEAwJAmlmncFq+WVSfSr3c2hYECEV5E3jAJKTLYwkVr4xelXAN4ZfXV7i
    ed6mG+uBRDdcHOhFQvCI/Uc2CYS5XxbzVBmwWYi4KYsXlpiFBnds3xViPb5wUUaf
    7lI0T/SINCztY0sHgqs/1fKd7Sr3vyYDwz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479237; bh=FhZk7Hft1OrEdCOPXrC74lADmYlLrV
    5syyYM93uQcwI=; b=hrRknfBePoVpBC6irkNz3r0RuYyZmv3EbU6XjtG1NCNB+X
    H9T7rqcfQpgihAH/aNWgRtnllfFsuMBQeqHvyZ0/934mkND6mMGe/kpdJ4Ox6Ss1
    G9aXoHlreMuZnh2HcwwykAgKO6+2lWeQzWQze/iB8cp/p+p+aoGB4lVxsxIncVyu
    x7vv1ZvH0ThahaibDo0HPk+BqkJwRVKoFLfQd2PpJoA+3cLdFwukuWqNetybV9u6
    StNLKRsXUO1Vv+j+xXUHc1xZu6hQJR7AQ9bqDjopDVoS42ciOVJ05KzDs36+UOSb
    VRPjzTblBimKQTxv/WinBpG22QqB3oEa2p5upZ1Q==
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
X-CM-Envelope: MS4wfJML96rgQGmlzSz8LddWtoCu3GZEss1dLKKDvkz7yAEHdBfdZekgV4CgK4ncm7K1TQJJOvXPJQj+nOgQ7BtqQscd2JjIAJVuy1eU+Do1gT17nVR/ALFK
    nt/oqTUB3vPcRGHZNhM1I7FyFAQxIqyePq7Y88EkZ4Sxdp01kSS1lGGw4eZvOHDA9Qau7Qw/kROxd3vZ0z3dmCFpbRKYx6Au1jDnwS6X1ClTnSEeisoyrYoo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=xKBjqWDVSTWkfMpGLd4A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756632AbeDKUkR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:40:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756032AbeDKSsC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 068/190] libceph: NULL deref on crush_decode() error path
Date: Wed, 11 Apr 2018 20:35:14 +0200
Message-Id: <20180411183554.279688537@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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


[ Upstream commit 293dffaad8d500e1a5336eeb90d544cf40d4fbd8 ]

If there is not enough space then ceph_decode_32_safe() does a goto bad.
We need to return an error code in that situation.  The current code
returns ERR_PTR(0) which is NULL.  The callers are not expecting that
and it results in a NULL dereference.

Fixes: f24e9980eb86 ("ceph: OSD client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osdmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -295,6 +295,7 @@ static struct crush_map *crush_decode(vo
 		u32 yes;
 		struct crush_rule *r;
 
+		err = -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
