Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481630-2-1070824649504437434
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
    1523481629; b=HxCFvtI8H0pLExxSOYd29MNCjtnDV1yhvnKXG8LS3r3K/YhyMa
    JrQscB3bMqn5Bcu4f7xo0+U0cwFRGzJQuGnZkUb3GpskPpTQYO7WcMdDkDdlgwsz
    kh9nZa7Cfitt9v8xo/qWghxL70fROEfOvZx68J4dNSIVFHRhLpy9Ih/wgCiB9FUC
    JnMehHx2RF40NJesvk3xkLZnRJLLR6dEHcRV2YokGltSqwTpJoxsyYggPxip0Rzx
    I09G52wlyUZRjpMS3OGRqXfDIy2TAlPUw+GjvXDn/LTByPGZI/OLQZhQmr2y778M
    52Z8DDBcr9LPRQEk/xvsbaX3Z6JUhUi3mwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481629; bh=6IURkv3IzaWCrY6D2IQAw/hWi+f+aY
    uUbXDt/RdCDV4=; b=BGSZ6GjSjA6gcBZASy9U131FwbceM3abn87QQjRXx33Kpe
    PMq+hO6t1wYIkFWkG/nS/7Y/isJMW5EP+1ijcMj94l0JFiQh6BSgGDsG96/GssrW
    qajmWbSaZvCSR6dN/mhI9L4uMtZN/Quiuw/1kw6jlJWozfbz/1Ok4pcJbVqNIPf6
    gtSkyBV8z/UysXirz8GAs7xKmBhE97t6z8lST0iPJ4sY3YHF+zLA7FqMwqJlqceA
    rrAOE+FmhCT/8XmJ0uXLQZuS+wZ3RLdcytY87pA4XSuzVR620sIbOXpY8VRnzxnV
    zbUy5h/QkJ8ZtLoSk3LPsjBEcKSO2QPfoY2kg3pw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfGzuIg4t1qOWb3KqEDsNxetUPSxjGxRR00l9EBPqWeSfteABq6QWYsln3p2KzrgZxLcHWOOtHrJv3C8SgV042uH2lFcn9j2DjWOR55iWI4h+YcJl2xEd
    4AmjA6+SrMZUo9omQnlscJ/VeMIh0K2HDqQ4yA1wJopIbxNK67U2UP/2p8eHvLSX4OIpeCnDksgKnAO1UityeuJk8CNja4OlXVDIvVKklme7dSoc8KaD6k05
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=xKBjqWDVSTWkfMpGLd4A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeDKSjb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeDKSj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 040/121] libceph: NULL deref on crush_decode() error path
Date: Wed, 11 Apr 2018 20:35:43 +0200
Message-Id: <20180411183458.881604029@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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
@@ -270,6 +270,7 @@ static struct crush_map *crush_decode(vo
 		u32 yes;
 		struct crush_rule *r;
 
+		err = -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
