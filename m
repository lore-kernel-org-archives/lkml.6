Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326738-2-15187990256620283038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326738; b=Kuy0GMuzaTk8FtDOB6Lb7SArY9rzbXXrN268D+mt25n8DDT
    0NpgaCAyj0zVq/kZe0T4zGzYB7Ll2eO6LooB/PB6Vkh4WWkbfl6FSxsflfuo5KsW
    r6dRpEAVBhVe74wy4ErjV9Dixhzbdpc9tTndwTKFFHloZ6Nvh2lzptrTz9nos178
    DTVACcKIUNrEvDnzE1yjezwLlSc3W5nceCy6C6jj5L2EzxkDPnMwNzx8ddMVUe7E
    pR7Fh29s/L5Qznx+S1wRt8EAZOEJoBJF7UcizaVntkBe7xGV8FhUnvqd3uHahUkG
    nFbqfQQC2Q/bPJGU1YVWgTjUrYkHLBzRZX+W3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326738; bh=9DLcXuT16yH2EIQWPqm
    Mmet6f7slr4cNkbI5KJjT4tc=; b=QsxLDhWN9Rr6LGB09F4NUtFSRbWlC/FjxeK
    1oQ2ipXHYfyc5WG1xuAeMiwAQ0+SPUMEv0zw1G35u0BNs6MxzgYd7BTCHnWLQW5C
    fkHNnSkayhWX62IvXtWNuPz1b7N40uohAhg4VD3h4ews2dwVWZ+JMg4NZGNcBLZH
    omM/mUb2hXbT38DNZ++Ia0+x3Chi8iC0pH8ee/yNRDljsVcw2BAuxOskmhQpxVQb
    q2KSWuos/cdkn3736Lwy8yH+GfFUu1ibLLvBAQmuWwnfGUqB2V4EAFBnB5r8/ky8
    rmAEnIgq+4uUTczBsQkIIBm40LqvgNX0b6vP+z9zEaPACf12aqQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeBKFYE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:24:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41315 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752442AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.286657411@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 01/79] Input: adxl34x - do not treat FIFO_MODE() as
 boolean
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1dbc080c9ef6bcfba652ef0d6ae919b8c7c85a1d upstream.

FIFO_MODE() is a macro expression with a '<<' operator, which gcc points
out could be misread as a '<':

drivers/input/misc/adxl34x.c: In function 'adxl34x_probe':
drivers/input/misc/adxl34x.c:799:36: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]

While utility of this warning is being disputed (Chief Penguin: "This
warning is clearly pure garbage.") FIFO_MODE() extracts range of values,
with 0 being FIFO_BYPASS, and not something that is logically boolean.

This converts the test to an explicit comparison with FIFO_BYPASS,
making it clearer to gcc and the reader what is intended.

Fixes: e27c729219ad ("Input: add driver for ADXL345/346 Digital Accelerometers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/misc/adxl34x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -797,7 +797,7 @@ struct adxl34x *adxl34x_probe(struct dev
 
 	if (pdata->watermark) {
 		ac->int_mask |= WATERMARK;
-		if (!FIFO_MODE(pdata->fifo_mode))
+		if (FIFO_MODE(pdata->fifo_mode) == FIFO_BYPASS)
 			ac->pdata.fifo_mode |= FIFO_STREAM;
 	} else {
 		ac->int_mask |= DATA_READY;
