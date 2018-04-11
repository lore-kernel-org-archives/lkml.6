Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480185-2-15125580189022896385
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
    1523480185; b=IuPkl2YRPksIWpMahB0/3qMHs0yj+agpJCp1jPwqIcLrAkVVD2
    3gmCkzqQw04pSwxIq5lBF+IMRKS5r3k1RUrBmn+Yof81pnwcQC3gu2V1Gl9PTcqa
    az402wOWq61GFfX9JTP3iTzzIW+DRZc/CFzhLSLYrsg9odTrBTnFbuTN2M8DkpDs
    4GtsxMFlfH8JlYvKqYQrsiat6igwy0+5bF79+tYHzdInTSFSTFoDD6pOkmtCjGAf
    c5uoAKE2L4v2kIZdnPgUIcolyqhhjPpeNPMfyhnMt71OIFvhUrjqO2Vv6iPzpsFm
    CP2HGN5eiY1zwGYIHS4PWaLkaGGCqebd0iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480185; bh=CNYyiGZvO86ATDHpFGLPTePyS+DOlu
    0g42wnZsLiwZ8=; b=SvbHzb0JDJXevjWNLfBPA66nw1wY4CUlmSqDqNXVdyYj59
    ErSai+GS1dMHYpyBKIZPaFODeSnZSz8FQe3X2GQA5cHAs7sir6Un0KaM8sQFRvoz
    RR9rx5XzX2P2K9TW817I9bMIp8MHrITfWYKDj1GZ6H15t2dBTpiIcmMAn7LGEk81
    ijDa90rZqTgAz413U9E73+YpzeRm6p782NtK1xIscknT1Va7SBYenfPgVBPRNv9K
    ohMdYq/xeIXm5s0HbCjUf2T2B1pzp28LhCfOVh7s3SF4s7ubbMXxPJuCYYB9XHsj
    TUg6IKt5A8VeoW7sZEcKeJm3tkZw8OT9iJEL9b/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFGsoU2KFN21h6yCYn2jqBmRf3D18Wg9csx+Ay7ZlJRakzn9uveC78Ew63Lz0zWR0XsFXddTH7GJYomGoWMLJS3eu2y38ea4vg7VgxjvT064omPTo4ZO
    3Ex1e3fgA0yN01TfC9s6yilSTXEmHYlIu27sPpP4pgLM5XTfuLhKDT1vg+OXLeDo6jWZ8CIUrzjn3F+GrFLN0VsqDVSaJ2gRn52p9vOtT4vfCblMKcq98YrT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7ZN4cI0QAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=7loVob4iMjE_SrWWOpgA:9 a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbeDKSoi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeDKSob (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 007/190] af_key: Fix slab-out-of-bounds in pfkey_compile_policy.
Date: Wed, 11 Apr 2018 20:34:13 +0200
Message-Id: <20180411183550.488023537@linuxfoundation.org>
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

From: Steffen Klassert <steffen.klassert@secunet.com>


[ Upstream commit d90c902449a7561f1b1d58ba5a0d11728ce8b0b2 ]

The sadb_x_sec_len is stored in the unit 'byte divided by eight'.
So we have to multiply this value by eight before we can do
size checks. Otherwise we may get a slab-out-of-bounds when
we memcpy the user sec_ctx.

Fixes: df71837d502 ("[LSM-IPSec]: Security association restriction.")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/key/af_key.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3305,7 +3305,7 @@ static struct xfrm_policy *pfkey_compile
 		p += pol->sadb_x_policy_len*8;
 		sec_ctx = (struct sadb_x_sec_ctx *)p;
 		if (len < pol->sadb_x_policy_len*8 +
-		    sec_ctx->sadb_x_sec_len) {
+		    sec_ctx->sadb_x_sec_len*8) {
 			*dir = -EINVAL;
 			goto out;
 		}
