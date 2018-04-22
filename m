Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405925-5-13878962818035766677
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
    1524405925; b=p2NUquxjfU4FokqvzBNERNpMpwuALff8DjV+HVlkTfLOtbVzaU
    9dGxMDxHlE+buanhZ/6blcAeGZ2C7ILr4gcuXMrUyWJvLu/P5XeGolJ3+nRoSnPc
    s/bejoL35lAYzSEblbThwCMDAisd+TBmQ2R6qL9TpHW8tL3M/6SkXHZaWG7R6+0G
    wXwduYwJi2WSLMQyhBWtHbBTRl2mSpl+i5Yl2DQ6WM49oo6bcrxT2xDyi0mTNVr5
    cUJy0Am9Y3YaQbFIuwGsE9XiVSodtYFsQ4NIL41qub7PYwcZoozUq5mYzDBAUwJo
    yvb4dONyCpHiMHcbv87gNm5+6FAZoZzBt8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405925; bh=M82CNVZoM1taRjsvoiZw1YtdgOxnog
    X0V4suDk7ih9I=; b=XjfnqJNDomQFWJ/TdOeCH/d8h0wU/LkrObp/UI/AwQJX4U
    ZzBASbYPIC/3dkT47PaHY9moyC9SxtMAwkSexWaUgFbCA4V4WqiR6zOjyrQZVwQ4
    AWt1Z+RoKgleh+DnaoSPEinkChqSlhS0aWCcJq6i1bY4d7jF9HijyKZZludAPeAR
    20NMWJHplmxr2kbffB3QKzfyvnLxEruadiBjPf5jNnQpXBlB0Q8QAV71k59aZgy+
    dgtvE9as8nxlE1qq6e7sO8btEfTUGRGjjLH5a0F42kY7XJNiow1bpV2QEjN3VkVi
    /XcnGWEupS0N38QfnUpI4EIoTntot7qXnmKziRXQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGH4kEZC3zhpYgbn+a5VEbz+HhvwEsptPpBG1ScUbtyHFbUZosjNExUBIkj+bCePifw6oDMso2iUW+Bl7+j4xbamrzaau5X1tf2qs+tu8JJE4xS0a7+F
    f9qVaH1qU/frh7cDXK76vvKi/wmiLAcTISapwIl2iqiXfzV1kHZNzv3P6bTqGizy52pkvWWXBakmkZJOaAUA1W8QAIzj8ONQFrsD8kpw7c351XLcSjcj9OvC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=u-6-l2v1QMTe7l14IOUA:9 a=0RQZN5a3oZg4dcPw:21 a=MXyhHufPFBPfhIYP:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755359AbeDVOFV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:05:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755358AbeDVOFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:05:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jason Andryuk <jandryuk@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 046/164] i2c: i801: Save register SMBSLVCMD value only once
Date: Sun, 22 Apr 2018 15:51:53 +0200
Message-Id: <20180422135137.290812387@linuxfoundation.org>
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

From: Jean Delvare <jdelvare@suse.de>

commit a086bb8317303dd74725dca933b9b29575159382 upstream.

Saving the original value of register SMBSLVCMD in
i801_enable_host_notify() doesn't work, because this function is
called not only at probe time but also at resume time. Do it in
i801_probe() instead, so that the saved value is not overwritten at
resume time.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 22e94bd6779e ("i2c: i801: store and restore the SLVCMD register at load and unload")
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@vger.kernel.org	# v4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-i801.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -965,8 +965,6 @@ static void i801_enable_host_notify(stru
 	if (!(priv->features & FEATURE_HOST_NOTIFY))
 		return;
 
-	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
-
 	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
 		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
 		       SMBSLVCMD(priv));
@@ -1614,6 +1612,10 @@ static int i801_probe(struct pci_dev *de
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	/* Remember original Host Notify setting */
+	if (priv->features & FEATURE_HOST_NOTIFY)
+		priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
