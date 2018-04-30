Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936261-1525120378-2-3200493552598341083
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
    1525120377; b=OlukQu08GzsjSY1vm98OPzL/XHKv+mndLHjD3FrmP02Ca91F1t
    gdhPfG0qNwWEbQJuqmp5q6il66MaxYjQGPTSApOpoeFRee4RPg9gr6Ng55Qnc3K/
    WqaBn0JIWyBqurHXtbPkJT3beX6zk/gn/PFl63AN/rTs0QdSZf1nYSrgEd6NBUrM
    S/yC4asQXBMh4X0S0VliFoJ243aI/gPoPPNabSLrdE53EyCJX45ppE6KYEeKzRXf
    pG/EJOizkxPKJcj7NiVrFMvL3defay2NT80bWdbo/ZFJ9YeE/pqzK31nxfYNFYGR
    /XZxY4l38K/ifembXwnpgt9PHCfC+j67WXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525120377; bh=+H6hkA9OcBCtDPpiEwUAI5O13kLS07
    qUFcTrFT1E9PY=; b=FgwUxSnNbmnJIO2EeKxHx+d0CHTChN6O3FWDpfd3VMMHUB
    yr1y+bCgPayWzkdic0M3cr1ZHlxkQHYeI0LbgTISCZlb7zeV8WW7SztoujEQztWH
    6np1RZWcgG2ekKytTkxFq7GAHssCbkMFvwLCU2/1F2p/ae/C5XltzYH3h6fs5mG0
    4H91UzKC5JGxiXDEFoDXFqAaVHGJ1AxfCw/eGZoUlzOBNmZ9z7g+2J6v/Fn71AA7
    WGSnUElrZIs0gyuBCccaGXsQlMh8YMbsCzH5ZA04U3aqZvzlJPbS+eRuRIhJvf6Q
    LN+b3M/1LlSHS2WrjbJyA0l3yo186o6jRx5zlhRw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfEwBttx8xhgzYgqIxDfwVYq+HqMqtfdCg7dp06zGd3FzjE/COXk/D1ba2JhLMHJ0RTHD0TtjkAmhW2WKjHKxUcQx1SJDo35Mx2C5BIurUpqqyxhhie37
    tyNwRyEvHCGaMnO7KiK8Z36SovfTDMqnCjSWqwVDN5N5SXX7goPEXrAYOYAXrFKfzu4l+ocJsLy4CpaG218uSla4ue/pT1q+NLGQ4i2ACmais2CxXg8iY5oi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=oz-YgeFpkdcU0Ois4_sA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeD3T0F (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755465AbeD3T0B (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005D622DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com,
        syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com,
        syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com,
        syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Subject: [PATCH 4.4 33/44] kobject: dont use WARN for registration failures
Date: Mon, 30 Apr 2018 12:24:44 -0700
Message-Id: <20180430190947.658962823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
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

From: Dmitry Vyukov <dvyukov@google.com>

commit 3e14c6abbfb5c94506edda9d8e2c145d79375798 upstream.

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -234,14 +234,12 @@ static int kobject_add_internal(struct k
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
