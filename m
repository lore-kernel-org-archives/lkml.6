Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324317-2-17527614519567636972
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
    t=1518324317; b=gG3Rox2+taWXWjc/k8Z9z61vJIbI3j2d3My0Zqsx1KsGGUg
    I4rBKRkSVZJBL/Cz8vm+8kh1fN/99gN4Ur/82OMNDPMKSrgA7PeFqPnc4JZkQT7K
    Wnz8A02H3Au2ON655Q+hsIVwNGe/og8Fg5yc/h/0rjFjiJhllaj69VVYJ0PX26H0
    x3QX2dlfhI+3ZT4miXo7oinoCx0A2qdiAFFUoYYbicHv2i1s9nDJHskh5+b7jyT5
    h2tr+XPahahrucYpWgQJBbbgQk/q2WJgqr+UC8Uv4oXT6/XwNcHEj7HPzQ+tSsHJ
    PuSp27RfqTXnnRuLQjgEcz1N0G88xc4nAdmSYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324317; bh=yWFm8NVg5uoSvwAoTKi
    R2kiG7LdRuKmum8PSjH2Fo64=; b=ZNfpDeYGYX08h1kGb+8ADJAsvQYsBy4vskB
    vDyTzVYixvYPr8hO0W0H+9v2pfmnRGu6N7pppbvPbBhcuWF2J3myW8pJPHnTze3X
    ksGBR9WflXoJOGhs0wEMNxzJOUjkrPwsUINWZcdCfglkorZAxTWz2xx4NXbBjg1q
    da6OKdrWk3PpBl+iejiqVApAkn+FjEVuBe2wyLBsc+BN/xdHdgvza6xiOwGbOJtr
    bZIPMmMhrneU6jb6hj+AV5fXeqaGSIk2vdgvxgyhsaxgi251eRU5MG77WacL4oSk
    59qi0H5hYLv0gQLFPt0xzxvf1JeaU0tBQl+2yGrfOPBabfkV7PQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeBKEpN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41881 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752858AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Bernie Thompson" <bernie@plugable.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Ladislav Michl" <ladis@linux-mips.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.303564748@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/136] video: udlfb: Fix read EDID timeout
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

From: Ladislav Michl <ladis@linux-mips.org>

commit c98769475575c8a585f5b3952f4b5f90266f699b upstream.

While usb_control_msg function expects timeout in miliseconds, a value
of HZ is used. Replace it with USB_CTRL_GET_TIMEOUT and also fix error
message which looks like:
udlfb: Read EDID byte 78 failed err ffffff92
as error is either negative errno or number of bytes transferred use %d
format specifier.

Returned EDID is in second byte, so return error when less than two bytes
are received.

Fixes: 18dffdf8913a ("staging: udlfb: enhance EDID and mode handling support")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Cc: Bernie Thompson <bernie@plugable.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -769,11 +769,11 @@ static int dlfb_get_edid(struct dlfb_dat
 
 	for (i = 0; i < len; i++) {
 		ret = usb_control_msg(dev->udev,
-				    usb_rcvctrlpipe(dev->udev, 0), (0x02),
-				    (0x80 | (0x02 << 5)), i << 8, 0xA1, rbuf, 2,
-				    HZ);
-		if (ret < 1) {
-			pr_err("Read EDID byte %d failed err %x\n", i, ret);
+				      usb_rcvctrlpipe(dev->udev, 0), 0x02,
+				      (0x80 | (0x02 << 5)), i << 8, 0xA1,
+				      rbuf, 2, USB_CTRL_GET_TIMEOUT);
+		if (ret < 2) {
+			pr_err("Read EDID byte %d failed: %d\n", i, ret);
 			i--;
 			break;
 		}
