Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464190-2-8666028297902920572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464189; b=sKLgo2dbxcGcfoyY65Nr4Q+truFA/juFIrEQrnJ838E7PZDwdt
    XMXAGn2w/+djYSvOwAl5hA47qLusJY/V3chL4E9z1r5ZFxviOXoL63hbTSs0Qb2U
    t6Twk39/V04g4/RGHWrLqxnRe8Wa2yYvys9BYM+4C+aXD+IjD721/SQzl7WCkIHx
    siH2/Th8O5ZI93zohbRe6qZGs6NpN8tIg67HSa/uuYmA9VL6tZNwR0EaQhCR+t+a
    JCg+X9jYLr0i+NN7S2kKyfpD1WY4pGXDXXV4AZgegu9iuoR5U9B/o4fadLpKCBSd
    4vYh4mCP5KLSakibAUiAWfKMdkMUKGRcCwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464189;
    bh=Aj59wHQo+au0udSbmmSw5nnFrvH9wvYOHByjkHB45e4=; b=p2mrMlMOhvXT
    ucxbB4r8Sh+jkmll8rIEsTXqzT0nbnUlFzHXI+186SsUT63ryjsk8m0bMxLUDphG
    paaMS4A9+olQ2kY6p4mX33O9rQrz3pqGnMcPzm0DcWKnIxNSLKhiK54OtRaJABFf
    GQhVEFJK2u1OO2E99pjVxmkUU8+uAMh1CQUN5rOWH9FMCxlxAMZdLdtiTA0PmB3k
    6hSoRx2gsC0gvHf0Qsf8mxmat21RZW27db0Pyqu0ifhJl85+H1lJ6IxyF5THZDDU
    jDhkPsnHUWW8pJgRkztbpVndjwrQ+hai8LzRcao+g7Al7Nny1xr9FcjGBAR3V7iX
    hKLA1h12HQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNi5p+QqvxkKfIifd8vHT7M+75CONWWIkLTjYoz5dMBCBkKMY0F80uB3rTvxFEsfdTwz7uW32AGA0BrqTRtMV1k9uGA5Ye1EcW63z52ur033qUomR11o
    yZJ3ZG9PEGBdtqM/AFlAKTCzc5UfN4AsrXnFmpn93JyYM2cpOPAsQgP7b/4ZP0V7Lrw5r7poWmhama5iBIcwrJNDNqh7140n860XLOPHLai1XmB6ji3Rr2QS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vTr9H3xdAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=qGYFDCcIXZnf9m6DYQkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=7PCjnrUJ-F5voXmZD6jJ:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeDKQZa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDKQZ1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:27 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/24] hibernate: Disable when the kernel is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:25 +0100
Message-ID: <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pm@vger.kernel.org
---

 kernel/power/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5454cc639a8d..629f158f5a0c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
 }
 
 /**

