Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479383-2-6046963826797125244
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
    1523479382; b=GwMzw19lXvHSDbYQwg7HNatyS8+yopcCnONZ+B39GiNZ8AoAB5
    1yKZXjlgr5p1cl1KPqPTlu0AjjhrNvr7FgshJxiAOv3+/yl8O7m1Z1VaTxUDtJpq
    7gQcwQAz/JlS1l7iKDUJkZ8D0KlR8Z+N3SPN3PGJQvSXcDoivXTLRQ24kNRvTSah
    TYpLjc1VyTvmiPDtYuLNsWGmYCX7SjfxPP3lV3Zf2OdMd72NlNBZ7aTiHqx3Oid8
    QUcR9Tf0KdYmdpC0lUWp5Zt/NDTQNFiznr0tCRUWVX2G4vrtbJMoK6Padxf6+Jyk
    ZEA52CWFRfVH8Nr3ILdZgWYr/H67v3WhTjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479382; bh=4ggLvnXYklRperETonEkd+ZdV+gA27
    TbwuTqHOYveT4=; b=AJaU2G5fcvHI81qXqVJlnegoWAkfKzikRMV4fkNzgItQ7Y
    Qs8hMGRn1LaouobJ6EvkO8DdX3lavkqaSxzhUq1j4dp4HnMuTn8gnauNpRj+G2Vv
    BE75nqFVhEAcvjos4iiZCDG7wpBBE2E9+ui4VfSkXQI+qDlF9t0HshqHAqhzo0oq
    w0/KGdmMH1DXF+q7Fllka2W8OFqaNZ1lPrykWAlyCx/mLLjCUhWCBmwUBDibsbIq
    kMuQU022awsyWGFw3B+3OsXpJEvvinwjT8y+BD7PW689rXPoM2eCUeMqRYQaZNJJ
    f4Lm4Kqru7rrATJRXEQ2TREQroXivOBnTmfsbxLg==
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
X-CM-Envelope: MS4wfOBZ1M0ubZt+vDAPRG/lz/63vxoT6kqkeoB37qpqa3fMl/mHuut34yE9v4wfBfBuuXsxp4tkzx691Df9u54v6ok9AKWwGJC6p38PPwP8jEhKcG4WRqU3
    mG5WhVm2ZTZM32+pnQZ/u+P/WkjBoYpggvgJ60I2BdT4NTr5U7c4AnOEymhYo7si2/z9KIyLEZRskQqWGSwIhCEPs3PQpVZKpy6yhtmLUkhWn55Ld+Sfwu4O
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=fGhLjsSNAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=8LSgxrWD8ne5ivIBiKEA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=LYKFdyShAPKLkGq8p7WX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755940AbeDKSrh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755922AbeDKSre (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Reported-by: Jason Kridner" <jkridner@beagleboard.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 092/190] gpio: label descriptors using the device name
Date: Wed, 11 Apr 2018 20:35:38 +0200
Message-Id: <20180411183555.983850013@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>


[ Upstream commit 24e78079bf2250874e33da2e7cfbb6db72d3caf4 ]

Some GPIO lines appear named "?" in the lsgpio dump due to their
requesting drivers not passing a reasonable label.

Most typically this happens if a device tree node just defines
gpios = <...> and not foo-gpios = <...>, the former gets named
"foo" and the latter gets named "?".

However the struct device passed in is always valid so let's
just label the GPIO with dev_name() on the device if no proper
label was passed.

Cc: Reported-by: Jason Kridner <jkridner@beagleboard.org>
Reported-by: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2145,7 +2145,8 @@ struct gpio_desc *__must_check gpiod_get
 		return desc;
 	}
 
-	status = gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as label */
+	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
 
