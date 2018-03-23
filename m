Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804053-2-9961718914022399110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804052; b=QA4O2JX92uGplEKi+Oe+vbDQ3QyJs19QrDtkt6TvTa9ePMu
    NJIPpd/bX7rgMk8jiBwY31aINkImA54ixTE55EPFHQurtbB1qx2Q7IZsj21iFOYW
    3hE9smA+PTS+RjGbWg+iL5IFZRmjAiYCeWrpNvTkZz1XP6bnkslZSfKYeDEKbPNv
    mY3jwpqi4yBPWBkgykY/kHPRdlkVqsMe8ASMktcsT/ZRRgEJaRxzDVPU4sizIb2c
    y3SOJhcDDDzlHtZC5BYinq2w+aXc3Tg+NDxqToih9PBMXdSf6Yku5nW+eEd15HrP
    VNJBSCKu/kPt0LQczRmZX0vzpC1cPOEIKcpOINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804052; bh=mGXANhpJyiBuGoGb1EJKgTSJWN
    fKIBgqDbk6Ko/9m/o=; b=BHMTOsgG+353b+XGcPCxEruMyqOmAVsN98VngCPJZY
    hLCVJBWjdd96hoRcppJLdUBZyYE0s6Gr2h7AXeux6bZbSsw9rRitFmFFc75gO1BD
    ai2wS+CgyQOBU7qUOSbPbTwDmTgLYBuJ5a7WHe5OOCYth3+eFUNWO9Omg4h5hwGg
    zbPuEboMH6MBNpS8CJia1pm9AvwJSzSX3wnNtCoGYC6z5CdvJV3l15DBqVn/YR1w
    wXktACMmXlUAdw4cLpRq4jua6pqjVF3nflGJYnw+1+vI24MeTqp49x/xyaWbv67O
    s/L8GJf2A5IO7khHqujHrxshbklfNprWGZj85n82dcCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbeCWKIi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755575AbeCWKId (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 099/177] ACPI / PMIC: xpower: Fix power_table addresses
Date: Fri, 23 Mar 2018 10:53:47 +0100
Message-Id: <20180323094209.651558835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 2bde7c32b1db162692f05c6be066b5bcd3d9fdbe ]

The power table addresses should be contiguous, but there was a hole
where 0x34 was missing. On most devices this is not a problem as
addresses above 0x34 are used for the BUC# convertors which are not
used in the DSDTs I've access to but after the BUC# convertors
there is a field named GPI1 in the DSTDs, which does get used in some
cases and ended up turning BUC6 on and off due to the wrong addresses,
resulting in turning the entire device off (or causing it to reboot).

Removing the hole in the addresses fixes this, fixing one of my
Bay Trail tablets turning off while booting the mainline kernel.

While at it add comments with the field names used in the DSDTs to
make it easier to compare the register and bits used at each address
with the datasheet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/pmic/intel_pmic_xpower.c |   50 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -28,97 +28,97 @@ static struct pmic_table power_table[] =
 		.address = 0x00,
 		.reg = 0x13,
 		.bit = 0x05,
-	},
+	}, /* ALD1 */
 	{
 		.address = 0x04,
 		.reg = 0x13,
 		.bit = 0x06,
-	},
+	}, /* ALD2 */
 	{
 		.address = 0x08,
 		.reg = 0x13,
 		.bit = 0x07,
-	},
+	}, /* ALD3 */
 	{
 		.address = 0x0c,
 		.reg = 0x12,
 		.bit = 0x03,
-	},
+	}, /* DLD1 */
 	{
 		.address = 0x10,
 		.reg = 0x12,
 		.bit = 0x04,
-	},
+	}, /* DLD2 */
 	{
 		.address = 0x14,
 		.reg = 0x12,
 		.bit = 0x05,
-	},
+	}, /* DLD3 */
 	{
 		.address = 0x18,
 		.reg = 0x12,
 		.bit = 0x06,
-	},
+	}, /* DLD4 */
 	{
 		.address = 0x1c,
 		.reg = 0x12,
 		.bit = 0x00,
-	},
+	}, /* ELD1 */
 	{
 		.address = 0x20,
 		.reg = 0x12,
 		.bit = 0x01,
-	},
+	}, /* ELD2 */
 	{
 		.address = 0x24,
 		.reg = 0x12,
 		.bit = 0x02,
-	},
+	}, /* ELD3 */
 	{
 		.address = 0x28,
 		.reg = 0x13,
 		.bit = 0x02,
-	},
+	}, /* FLD1 */
 	{
 		.address = 0x2c,
 		.reg = 0x13,
 		.bit = 0x03,
-	},
+	}, /* FLD2 */
 	{
 		.address = 0x30,
 		.reg = 0x13,
 		.bit = 0x04,
-	},
+	}, /* FLD3 */
 	{
-		.address = 0x38,
+		.address = 0x34,
 		.reg = 0x10,
 		.bit = 0x03,
-	},
+	}, /* BUC1 */
 	{
-		.address = 0x3c,
+		.address = 0x38,
 		.reg = 0x10,
 		.bit = 0x06,
-	},
+	}, /* BUC2 */
 	{
-		.address = 0x40,
+		.address = 0x3c,
 		.reg = 0x10,
 		.bit = 0x05,
-	},
+	}, /* BUC3 */
 	{
-		.address = 0x44,
+		.address = 0x40,
 		.reg = 0x10,
 		.bit = 0x04,
-	},
+	}, /* BUC4 */
 	{
-		.address = 0x48,
+		.address = 0x44,
 		.reg = 0x10,
 		.bit = 0x01,
-	},
+	}, /* BUC5 */
 	{
-		.address = 0x4c,
+		.address = 0x48,
 		.reg = 0x10,
 		.bit = 0x00
-	},
+	}, /* BUC6 */
 };
 
 /* TMP0 - TMP5 are the same, all from GPADC */
