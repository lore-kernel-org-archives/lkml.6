Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116714-2-14976362823304411375
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
    1525116713; b=H8BxywyGVTudt9D959sCzrizj/hNpoM/79VSXVpo0S4Nasi1cV
    rMnz4xCQWB9QEWPRTUUSEo2p0o7n3/I8nG8KymmYCczYpj5nwVo+0T0SUutpi/g1
    uEA3YpY3FEyChK/X/t1v0QJN1g0ZSNdHUxHWn4jWq3p/RM9muPFJ5vHKlD/M/iGs
    BCDWXejrblgcVBwGC8MI2+hYAPvj5dxftvTDEZwMn1PlWzl5shCwQc3xAuVBC6NG
    V7ZDtkDyP2SeLmgvVf2zYM7VBDMR4mQlR9UGV/NqUd3BIvz3QyHKRNY/kjjXVkGP
    nv5Eh8T8g/zuG0C35JJkguvltPFkoT470vEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116713; bh=SoXlWS/OeVgTDF39EM6722OOMDUONO
    2Luey6TrXfT/A=; b=GRNDLyBPYchkspWh4eSvJ5vNuHC8gRdQlNjlkBDZFxCKIk
    t6zaGqfgF63CBHBRRRUJyuzfwIB6YGySKdct7wWdhskT9Y0LSAkp+zpsITudZFKz
    aub4teO0zhTgb5zdlsjI5Bu9FXkh5LJV3PtR61J3AgBzBrF68xpufNh/s4QQeJlL
    kMh3ooXNGAU7Axkjo5mnpRnFa1Q31N7FrkTKUHtqa5mNVqsQLYO3lJ3NW5hjxo27
    VHcq7DmbWIagWc8EzxvuKk4VCwZsQdVuSLTgcXViO+FjfaYbdNXY3ci5EjqI2uMo
    6X3qx42FrO8xRbCwUcF6lS4JcxG34OrYpLKHp6SA==
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
X-CM-Envelope: MS4wfAN9MHSFOzF7RqT4GQteE+z5wTQDXyGgPr50AvgmSOi3HrhFcm77KCpfoX8Ot0pH6oghWtGJg5OUKmVPRWJ0zZY/wURrlduPHteegv0y/mpbD/XUBi4J
    zMaO04alaO7vQ6c+R1vSUwEuHCNqJs03HzIm/9nwP3GJBFDbZth1Ejryc4I7fu38x4xmmaCdS2Uv216GLZUGkOJj2sIzWLa0GOOFrpJ3VWgJjG5kjlPnGirH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=i81JhfDT7DoPAuS5mjEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755890AbeD3Tbj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbeD3T3A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646CD235EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.16 073/113] ARM: amba: Make driver_override output consistent with other buses
Date: Mon, 30 Apr 2018 12:24:44 -0700
Message-Id: <20180430184018.294888857@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5f53624662eaac89598641cee6cd54fc192572d9 upstream.

For AMBA devices with unconfigured driver override, the
"driver_override" sysfs virtual file is empty, while it contains
"(null)" for platform and PCI devices.

Make AMBA consistent with other buses by dropping the test for a NULL
pointer.

Note that contrary to popular belief, sprintf() handles NULL pointers
fine; they are printed as "(null)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -70,9 +70,6 @@ static ssize_t driver_override_show(stru
 {
 	struct amba_device *dev = to_amba_device(_dev);
 
-	if (!dev->driver_override)
-		return 0;
-
 	return sprintf(buf, "%s\n", dev->driver_override);
 }
 
