Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325417-2-4858204950071076301
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
    t=1518325416; b=cAG49YYkEdVI2qfY8fmSRGk8ZgqXLGQsi02R81r1SYHn//G
    t8Q/Qf4rJqmbos50qFSem9USA7B5gfyYmBks2BT2dYNqkNXkBighORG62suKBRg0
    KdAs6y8xgTNkDR6Sgej6O0D6cIOXSCbF7nWdxj/z3xav4pq+uGlWwvXND9PmMvej
    VT72LBPEdBJlbek1EPkndnFQR0xw+EzAgKVYAyt1M2A1QCXonO0vTPla41T+/zSq
    kqX8G2gsrLVL7gJ86r2FUEwluEO2/ZSjU5oTB1C/Y6ceU0ZGIVWjS3+qxh9S2iyz
    VJaUgcwy/Z3A3ClkCcKFC5cLCrc+d+IRwROttQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325416; bh=4mUN4hQc+4WReZAMb70
    hMA1aYF4aEJkfF7HLf/Ggt8Y=; b=SoGDPWCgtR9V4G5rrCkKePM82wG6ZcJ7rq4
    jukpgUf9vwPUBe6QVt44mCzS3FC+91ulVIFwInClluIdQ4ZD7ySHMA97ruhR4b+v
    zrJ5pwMQMjP2QjdzAayLTx3JqL49lSelo3vyKTn4Qh54Ef5YnaC/1BPWTcurCyUs
    INF1h6PmMauI5cDZC8za5VSTcPAR31ticwtlSrSvfVSovmxnNath3XoHuQhQoAcB
    iA4+Cr/yv4mC9y7zdCaSHrimCkl3EaCcN8j73jvUjnFvlCW4CgT0n9lHD7M5U/A8
    lVY2qTYWzgugHcba0U4Tq1onU4/9ppIEdVg1v9O04MkTzf4iGSQ==
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
        id S1750739AbeBKFCI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:02:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41651 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752764AbeBKEdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:55 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.915707353@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 003/136] Input: adxl34x - do not treat FIFO_MODE() as
 boolean
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -796,7 +796,7 @@ struct adxl34x *adxl34x_probe(struct dev
 
 	if (pdata->watermark) {
 		ac->int_mask |= WATERMARK;
-		if (!FIFO_MODE(pdata->fifo_mode))
+		if (FIFO_MODE(pdata->fifo_mode) == FIFO_BYPASS)
 			ac->pdata.fifo_mode |= FIFO_STREAM;
 	} else {
 		ac->int_mask |= DATA_READY;
