Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2322533-1523985232-2-16138744745895485321
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
    1523985232; b=QQ5sjji5La/BdPH4r4Lnh60MWp741PNTwFfEM5zE8Xyq/e5jVT
    +zHwR02n7VKOha6wteTgwmw1Ea0tFW8yb8rSsrwAWO/uMD2E13Yemdz9kaXXjsrX
    TWfNpxSyPU9sh4WElgdRHW3gRyDB40IvoqCIpS/7cwJwJaxgi5S97Rfd0lZwbWwU
    +hlwTkKE8dgGiExenBHH4pIZBRvOyTS06YGDxWjOB1YqELv5u/t74Y1gruAQ7oL0
    jT/2NLbOeWBQr3RgLg7HUZeCKOhv0tkEQhgJjGwG9hcmM22+KkSSA0bnXyrjeq6d
    PivqZ6ZX1qjxLI5sTqeqK+Z29/UsaVEGrL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523985232; bh=Kw5cA1gWJrlkO1yIoR1V4brWJ0Rbxc
    HYvp4TcqcsCBI=; b=HWfhKkKfDzzfXB9MXYvKoQHtFWRTMnIYRlPRRsW5EhTrMw
    /r3ui1qEhZDUjhChcVJpNgkV+pfjxlMqdVGV7Y1SgvV6GQ7y+MC1cKHku8+leRMe
    VPe+qmxNctOhScPPur0XkRpFmAaMkpXrUFk2ohQHxPJHr3kFMeLNdyDkujJtxIP1
    kQj2L2C5WEuz8PPVl4wTTBdXPOfTe3F5dyMfhupXV2vYiClHRnyZEdSURxPW1HPq
    l5CWe2UubG19KZTVQExTW34Osg7ROHm+tN4Wh7c/qXR/pbL7JETOHK6ZMLuoEPa6
    knbClSTh0HLeYYIlDLFmnEjggCdm3hWb4TnNqW+w==
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
X-CM-Envelope: MS4wfLCSn79UsXPHY4ltJXOTqW8ivjRsBeOHaejrQ43/QDYTt5n1/VB90WFBxGL3i6K+68IEO67q9sgtnsM+oOu/YIvqS7PMjvsnYyb/v6G0foKEnhI5vw1y
    YZw1chK61crUZkXkLIOiUPWd4xw8FAApY2ynbgGd65EQuUmgxoUAEoDC1C+VrHCLLcru9S0CZCd90DotIuVv7r8LXFNRKB9bPkNdJAm4uDPCM5qnVY6t8qUr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=W9Vlj8rbMZGcbZkZfA0A:9 a=qAZo0XIR_tESxwM7:21 a=iSRJnVIyQ0gLf8gE:21
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeDQQAC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:00:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQP77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 11:59:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Gardner <rob.gardner@oracle.com>,
        Jonathan Helman <jonathan.helman@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 10/68] [PATCH] sparc64: Properly range check DAX completion index
Date: Tue, 17 Apr 2018 17:57:23 +0200
Message-Id: <20180417155749.752137992@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Gardner <rob.gardner@oracle.com>


[ Upstream commit 49d7006d9f01d435661d03bbea3db4c33935b3d8 ]

Each Oracle DAX CCB has a corresponding completion area, and the required
number of areas must fit within a previously allocated array of completion
areas beginning at the requested index.  Since the completion area index
is specified by a file offset, a user can pass arbitrary values, including
negative numbers. So the index must be thoroughly range checked to prevent
access to addresses outside the bounds of the allocated completion
area array.  The index cannot be negative, and it cannot exceed the
total array size, less the number of CCBs requested. The old code did
not check for negative values and was off by one on the upper bound.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sbus/char/oradax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -880,7 +880,7 @@ static int dax_ccb_exec(struct dax_ctx *
 	dax_dbg("args: ccb_buf_len=%ld, idx=%d", count, idx);
 
 	/* for given index and length, verify ca_buf range exists */
-	if (idx + nccbs >= DAX_CA_ELEMS) {
+	if (idx < 0 || idx > (DAX_CA_ELEMS - nccbs)) {
 		ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
 		return 0;
 	}
