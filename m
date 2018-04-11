Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479420-2-10605228504959981892
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
    1523479419; b=ZjXPFMRh9e/JbnCYS3R2uwyQldpdyMEp6xM0nmec5xkWEnGvam
    OOT4kk7UUyEHtE2D3v5s6IQOT4wJ1o/4aeXDnvrIvgMhIpDpQnlzkCAyjSGoVj/R
    nFeWRYAxEPLjNdqMDVDrqtL2awJJkX3mhyqUHwDGF8velEf6sNTSlfy9IP98vFbw
    +3b/W7WxQl1szn37uaR9hCOxL0QYBcpBMZXj9tDgrD41BSdU7cfvqTkcz6uIh6JV
    /3RkCpVlLVvq9I48JjJU+tCML4Tbp9Gd4TLjS6Vo6mk4nbUwYy2L6eid7J62CaXu
    mDyT3vvbd3/PJaiLC+PClZLDJSoB7FzNve8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479419; bh=nbbCTwv5TiJFFGHKmIg233VLsbI1xD
    +wJnEN1PyCjII=; b=PSOxpnABOPuTjDKbSNxk6WKj0tSfE9AsKBS+xbzyvhlbVP
    +aZcoOIDZwIi5Qh1GP9xGfpX/LP49IlaO9toCOwKOywsFZkFcEQjv6QFHmjnbgXu
    kG38eOxl+bBCiWYhidCGprPwAXhYA81tHaXBiPyEfYKIOfWGqSbuKffCPNVsB64i
    5KRb19666L1dfNhjZ25uBqrAGH9ba3BG3Xxrhrm6ySCLqY1+s/ljGB21x04jWxZa
    e8rmobugYf082kK523dOBjMbOKQF3zyAKoroUcWBuNrMj0nqz82e+JwOQYEVPjAB
    K+6CZDznO/UXVPA31mMubWNkleJx4c3IWXa707tw==
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
X-CM-Envelope: MS4wfMip074boWQ07I4GrZAqgynpHyG3SnYkS/O7WLmeyS6BSbeAFz4e53XKhXAg1Cyb6BXQGJjsKxiSEDYJBXOKzc/mf2g8AZfKg9j58PKeXiDnG9djUiUL
    FctnZo+s8CrClJuBr+rHPBVTnSNJlbPo9hIEqPIt3XhwsEnLqFdT/yhyg+aZ2qXbXKOZmCvIVswo1R6A14EVVOtHmB+NXSX0L7JUtBJze9MlPkRt9QPT2zFw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tBb2bbeoAAAA:8 a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=fWKlrDiykeHFxDw9_GIA:9 a=HKZ6qAVqU7D9Uhjt:21 a=IMCvk_XUfX2MPB_8:21
    a=QEXdDO2ut3YA:10 a=gup2V7nj8fQA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeDKUnI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:43:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755889AbeDKSrb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 091/190] vfb: fix video mode and line_length being set when loaded
Date: Wed, 11 Apr 2018 20:35:37 +0200
Message-Id: <20180411183555.936507819@linuxfoundation.org>
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

From: "Pieter \\\"PoroCYon\\\" Sluys" <pcy@national.shitposting.agency>


[ Upstream commit 7b9faf5df0ac495a1a3d7cdb64921c179f9008ac ]

Currently, when loading the vfb module, the newly created fbdev
has a line_length of 0, and its video mode would be PSEUDOCOLOR
regardless of color depth. (The former could be worked around by
calling the FBIOPUT_VSCREENINFO ioctl with having the FBACTIVIATE_FORCE
flag set.) This patch automatically sets the line_length correctly,
and the video mode is derived from the bit depth now as well.

Thanks to Geert Uytterhoeven for confirming the bug and helping me with
the patch.

Output of `fbset -i' before the patch:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 0                    <-- note this
    Accelerator : No

After:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 5464
    Accelerator : No

Signed-off-by: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
[b.zolnierkie: minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/vfb.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -291,8 +291,23 @@ static int vfb_check_var(struct fb_var_s
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+	case 1:
+		info->fix.visual = FB_VISUAL_MONO01;
+		break;
+	case 8:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 24:
+	case 32:
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
 	info->fix.line_length = get_line_length(info->var.xres_virtual,
 						info->var.bits_per_pixel);
+
 	return 0;
 }
 
@@ -525,6 +540,8 @@ static int vfb_probe(struct platform_dev
 		goto err2;
 	platform_set_drvdata(dev, info);
 
+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\n",
 		videomemorysize >> 10);
 	return 0;
