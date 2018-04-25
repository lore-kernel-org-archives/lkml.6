Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524656010-2-14637768862492773441
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
    1524656010; b=NbRp1nD0ejfWv5K8xTpPZTngrqyb5oPVO3h7xp22FcTRf4SY27
    HKwF+SWGtzU4KugdIz0OdoZmi4LSztw1s5sjaVqLLjpC6RLOPxf8lN4URzCZrlOj
    jQ3svH4DJXDn7Z8lOcvHlJzgtVncbZRYINvuOheybhkTF94LphGvcnwEmosONncK
    MblAyJz9OM3P61kt+2/FxJ9EOOnA68+/rKkPzMH3jQ1ZFtCs6VlGSioEHKgOSftk
    nlvA4NkButBim5bVMo9qlS9jYUJYe2mLSD8XhhJb55ZlqD1GxbTYlvw+YAYhKLf8
    YM8AqedrqpQ8JaJ43B39+aAYoglBVo7+DJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656010; bh=tGiSdPvD9GvcfxS4JtVhpUlDaGE7AO
    GZYcaz2G5nGJ8=; b=k1T3RehAa99jHdAKk+YGUqzIK7udjktvi0EvdQ0o7ZYL/p
    QBY2Ln425DuhY561DtGKnPzbURF+cLg5biR7QdzTzyCqdGX4XtX2Y4FyJ/QMR646
    XopbRhNi1uxdrYLpd5kFgmu+kMfg6URWJdydeSDt/RltcuxdVhu3Ms81i9JL/xQn
    sgzo85MxlauriOxAbJ5hZZIpOmR70/CQ5MjfM2COSqtAE8NqJdh9nhvG6/4rrmNO
    9KFLqWe3QBOc9U8o5ASdg8h1M9pmItlUoOnU5F9x9LQRuhvlOKy2zS/vIAAsXMwm
    egkz8tX3rRTOwje/uDJa6aVaR/ZZzVx4WKoC5Tuw==
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
X-CM-Envelope: MS4wfNh/4ELW22+2vFEMUjuuBmiYQZwtWVi7QdiPbTLCAHyEp34E8snMC56jXm/0fgfLZE8MuFky6X0XCTIA+8KHxlYUKl+Od727blRjOvLVHU7wBVy9FTcD
    ymlYx0bK3kUSEJY7HYMqqiys6kyPxtDH84kKPkPbVWYI8F/GfUShD1fT+E27UrAcuYe8fFSCUTqkN/PGimgtmyvu/v9DOpgSFSxxXjGg9ErCmlq2fmOkGzzC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=50gAi1W1AAAA:8 a=2KMo9-giAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8
    a=0Z4Tsq1DKIpBsYErdw4A:9 a=QEXdDO2ut3YA:10 a=bIAsa0K8HJLRn3BBPJ--:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDYKhN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeDYKhK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 012/183] usb: musb: fix enumeration after resume
Date: Wed, 25 Apr 2018 12:33:52 +0200
Message-Id: <20180425103243.107585624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Andreas Kemnade <andreas@kemnade.info>

commit 17539f2f4f0b7fa906b508765c8ada07a1e45f52 upstream.

On dm3730 there are enumeration problems after resume.
Investigation led to the cause that the MUSB_POWER_SOFTCONN
bit is not set. If it was set before suspend (because it
was enabled via musb_pullup()), it is set in
musb_restore_context() so the pullup is enabled. But then
musb_start() is called which overwrites MUSB_POWER and
therefore disables MUSB_POWER_SOFTCONN, so no pullup is
enabled and the device is not enumerated.

So let's do a subset of what musb_start() does
in the same way as musb_suspend() does it. Platform-specific
stuff it still called as there might be some phy-related stuff
which needs to be enabled.
Also interrupts are enabled, as it was the original idea
of calling musb_start() in musb_resume() according to
Commit 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend,
enable them on resume")

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2733,7 +2733,8 @@ static int musb_resume(struct device *de
 	if ((devctl & mask) != (musb->context.devctl & mask))
 		musb->port1_status = 0;
 
-	musb_start(musb);
+	musb_enable_interrupts(musb);
+	musb_platform_enable(musb);
 
 	spin_lock_irqsave(&musb->lock, flags);
 	error = musb_run_resume_work(musb);
