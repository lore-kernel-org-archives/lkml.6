Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406145-2-11663778536834434721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406145; b=qUez8uNwgLd51xXF1PiZHoSO1Ue4sFz2XtvfLunHtWZ72zZ6Sc
    JV18NEz4kJHnygrCc6csjh6ItIrEQ1aT2dxOfwMTYZtL5t901t+PotbQOsAAJ+6C
    jZTbhi3V7LxmSKiSsxvwK4ahegAnhjy2fkBh8pU2o5yKMLvzVWqVrrGlFEsO5Y1W
    kSkxYdgfQbyM437/G7L9AFHq9ZtgqIUgQvYVxRycbK4ed7CQanbOHotoOuhgUbPw
    FnfVqQXYpZo0V6ttLBxD6YAM48dpeSkGtdGQMjtdumfRXjWSUnokDOzRh53YMeor
    O8hxxCo1OZ/uQl77l6VCTm75+Zjodqm3ONQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406145; bh=habjXjICvik3xCAEUh9zYq87giO0kh
    X4lavLeywX5O0=; b=tgp22apkQEjSg2B8arsiFTJJPPwzCqnbaLcnBOUqBoiKyQ
    97xFFha/t6GqpzHljA9Bwjx3FOidsQOzXb+j6rFphQABhZh9+bHNU0da7v3ViI02
    P7kv/2FdMuASrfWf02uGGd2DJEW/R3LZiv+20uJioltpurghs/wMrvJ/t2MoGp8Y
    kR4Ct+fqR+eyhk7qYhGvVMvUWGyVM4+mLxKA8PHZtI8tsliuCq62JrlTGLV86swS
    zq64xiJ0E2ai4JTTEVHm8SyedMvYdN98XGXCK3Dw9QQDXmG8tPi3yBqbxaRGuJl1
    oy2g1Bz52gpvIHe8dldqRVMBN4/zy3TBqIbtsvaQ==
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
X-CM-Envelope: MS4wfAsSN61bxeaXW3Q4aCV1NkBMMDn1yfKCDXOibPN5mjz+WCwV2BkqqyTxjDDzHEkqqWe5jpitPGN0bw0iV7S8+yRhMDCHd+YFgCG5gO2dJvfkt4FS1H3P
    DX9KM5uOAhQO7UXKmqG4NDw7PIz1i9QDBuVgK67uRum4v8TKOwl38QU1OECBfa0Ky5sPbBbdK+M7u8WHcY38DFAPktMkcY2nWqX6Wqm1skCqTF56afCFJ3sa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=69EAbJreAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=e5mUnYsNAAAA:8 a=ukycaKeIWTm5uVsn-hoA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756043AbeDVOJA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756037AbeDVOI5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:08:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nico Sneck <nicosneck@hotmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 126/164] drm/radeon: add PX quirk for Asus K73TK
Date: Sun, 22 Apr 2018 15:53:13 +0200
Message-Id: <20180422135140.552553989@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nico Sneck <nicosneck@hotmail.com>

commit b1550359d1eb392ee54f7cf47cffcfe0a602f6a7 upstream.

With this the dGPU turns on correctly.

Signed-off-by: Nico Sneck <nicosneck@hotmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_device.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -139,6 +139,10 @@ static struct radeon_px_quirk radeon_px_
 	 * https://bugs.freedesktop.org/show_bug.cgi?id=101491
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
+	/* Asus K73TK laptop with AMD A6-3420M APU and Radeon 7670m GPU
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=51381#c52
+	 */
+	{ PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2123, RADEON_PX_QUIRK_DISABLE_PX },
 	{ 0, 0, 0, 0, 0 },
 };
 
