Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837584-2-9668290674572724129
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
    1524837583; b=HFs2uhy+nsr+bPyCa2qIT+vvuLIwoGfDCgYIeCurEPqB5KX435
    b/+a8VRqrC4WXqZuwA3HVrpP/TJ78isw2dPwTffqToagoyKFyJWyht/GUuV0yfGY
    vvEBos4qsqzOCCsv3YhxZDrY2MlZxs47SmfT3CNmN8vhLkNMs11NTUTby0JO9IrE
    xTR42zHaeAZWvT7Q6ZS4x1MMSAIhd+sbK1CQmov5HeWRIvSrUR3FRXW96b1JtHjk
    SXaBBPdykc46Vk7W/2UKP7sCPeodhcOHugT3FHM6s8Y6Jr1d8f+yIq1Vm3vk17R/
    o9cRB6aP7M2SQEq3/BXkKD+qNUNQWACIEVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837583; bh=+QgM/GWz3ecY2KygVH1wbrlFhSjlgE
    SjCdjUB0LsR/c=; b=SrJhKr7OwvBha44n9ci5vusze/eWEmeBwGucO4NQp8zvzk
    nzXq/A8aXRectq7thT4Isdqpusq0qHYClLcg4LrpbqGDst0AqEtxTkRRDgOM/rfW
    IxHyJim5izGewsQT3JHku89cW4ZsQhU8mwYZwbG+P1YBs/Kpcy06R8lWZnbQOxNK
    9dbkTYudTx3ayLRoYiG8OfHRTR0BGhq+JcP0i+nsBurjNchGRcp0DMXLFhlx1Tcq
    ZqIaRTSd3sCLWQdpnKYLJIVYyHBxw4jGAMdhPNFYggMK6jpvPc7CBcxuzqiOff8+
    vhmmbROtG8NEz14MG1VsVGzXuBYRHg+H+eEVDJAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfIlNa/klMYonIT0UI01DyenR0lhODwsYwKQZlCh33oMu0ifSCawVY6hWPLy2D2z4a+P/4iBgJYVJ4JDtRyGyORFtcIMIHD7WVvICf8cWXiwmvmsqaXMF
    /idEAoR0p/bYsmvHxZyw8t4q3RR2GzIpIltt46FBw61FbpGz780mSrHc7r0PAJFBcyzgdfAN0qO17yTlTgxPGbFPinUNKC6FrxQerFoajPzkO9UyvqLHhhZX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=7CQSdrXTAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=vQftMIKeHZrK-3bm5lIA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758105AbeD0N6V (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758328AbeD0N6U (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1991821895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 10/24] KEYS: DNS: limit the length of option strings
Date: Fri, 27 Apr 2018 15:57:45 +0200
Message-Id: <20180427135632.006035787@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>


[ Upstream commit 9c438d7a3a52dcc2b9ed095cb87d3a5e83cf7e60 ]

Adding a dns_resolver key whose payload contains a very long option name
resulted in that string being printed in full.  This hit the WARN_ONCE()
in set_precision() during the printk(), because printk() only supports a
precision of up to 32767 bytes:

    precision 1000000 too large
    WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0

Fix it by limiting option strings (combined name + value) to a much more
reasonable 128 bytes.  The exact limit is arbitrary, but currently the
only recognized option is formatted as "dnserror=%lu" which fits well
within this limit.

Also ratelimit the printks.

Reproducer:

    perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s

This bug was found using syzkaller.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dns_resolver/dns_key.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -25,6 +25,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/ratelimit.h>
 #include <linux/kernel.h>
 #include <linux/keyctl.h>
 #include <linux/err.h>
@@ -91,9 +92,9 @@ dns_resolver_preparse(struct key_prepars
 
 			next_opt = memchr(opt, '#', end - opt) ?: end;
 			opt_len = next_opt - opt;
-			if (!opt_len) {
-				printk(KERN_WARNING
-				       "Empty option to dns_resolver key\n");
+			if (opt_len <= 0 || opt_len > 128) {
+				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n",
+						    opt_len);
 				return -EINVAL;
 			}
 
@@ -127,10 +128,8 @@ dns_resolver_preparse(struct key_prepars
 			}
 
 		bad_option_value:
-			printk(KERN_WARNING
-			       "Option '%*.*s' to dns_resolver key:"
-			       " bad/missing value\n",
-			       opt_nlen, opt_nlen, opt);
+			pr_warn_ratelimited("Option '%*.*s' to dns_resolver key: bad/missing value\n",
+					    opt_nlen, opt_nlen, opt);
 			return -EINVAL;
 		} while (opt = next_opt + 1, opt < end);
 	}
