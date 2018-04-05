Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493453-1522953529-2-2002911166901882157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522953529; b=VrxxdetcH7LrB5Y0lDR4xIHdLFDILd+UFPEHcTy7C0bCTRbkcO
    B4SfXhlwwuDN08c1d85GqNB7NJGLnuqmH/ns9EBnSR/dkMYOHwUZHHL2uL4f7tG3
    4htxF6t/Guj7/OfUqno+HPOny0qJm1X0d4BQZ0vHpqPMSiUxJ1qhOnqed0uMDY7j
    QpQ2pYgXoMI01cjWDFMSEv+NPqkk3URMIgVQdRGsO608BNM7ZGMzrj9v05g2LLo8
    BoQtyK/b+aEXvxc8hFuQXSOwNlLQBdF18gAggrayTq1C2wC7xAJn9LrfaT4UCy6O
    xlzq5SlUDCrXwyC0iwMbCkG8VnUZ4CM7NLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522953529; bh=
    +HkYt9+3uSMGeBekXyjPvfS86pd0ppXplTUzbAPELDw=; b=rAuhWcLYhiXgUfSf
    QCh47U7rY4GoxRXHFaBWzFGMacAhyjKEQ8yVafn2K7azMscZq/bK9p6P3scniJ6m
    EWucGUiOTIcuobiwWnJC6RCdGNsJvPFDbFwjU4LER8rEhAGoqv0NRYuYLL78dFzK
    QN9lDotqvEuCKEuxqom8IPjCeeS3DiG4F1aIlz4tLJfvyYjytsQHUTzbDausuPgz
    124LwD/68Lr3cMw6qKqvQWBZAdo+oJlotDxZ58ftdOv1TCtI8VihD2oQa+AHqDzm
    NDRqwjSl1gRmpYHN4ra9NQBF8XkEmgg83TL2U9OHM9zqdzfjDQFyC0tcjDdgwIbz
    Q53DOA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=M9nbxq+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ErsXj5/G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=M9nbxq+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ErsXj5/G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKCSDCR46xHFXcyT2Di3zZf+xSScOPh952UCHZay0p8dZOml6gRz9MbdRIyRyXDdGqYkgL9DForxRH2r2XxWUaz3aGZoO6wU+ksNY1omY7e1KcVjlBRI
    jBYSWdc+MT+S1BK3FGbNP/gzav1+pWQoSx4GqHm6T3vrAk7fnXiLCZbra3CdUjMB/kabjfk4O5xt5UUS63ah9KMlPqBJWZEC7nIBxE6uKKARhmv0ayB59qYD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=4hmgV4NtA7EA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=OLL_FvSJAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=8aizV4YkjxcpfcbxqYwA:9 a=ilC1hCBG63GNt4Ks:21
    a=5Ugnc2BL6aUX9fzf:21 a=Ey0gUAR8-osA:10 a=7bBtgmo6PNIA:10
    a=oIrB72frpwYPwTMnlWqB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDESiq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:38:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45752 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeDESip (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 14:38:45 -0400
X-Google-Smtp-Source: AIpwx49OMnYcgk4Utalc3PWIUXj6C+D2z0z95P2EJElIdI577pzI1bh62yy0rKmbEPLu7hLy8TDdSA==
From: Jason Andryuk <jandryuk@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: benjamin.tissoires@redhat.com, andyrtr@archlinux.org,
        aduggan@synaptics.com, Jason Andryuk <jandryuk@gmail.com>,
        stable@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3 850
Date: Thu,  5 Apr 2018 14:38:24 -0400
Message-Id: <20180405183824.13333-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404225643.6b40782f@endymion>
References: <20180404225643.6b40782f@endymion>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
hangs while plugged in if Linux enables the Host Notify features of
i2c-i801.  The cold boot hang depends on how the system boots.  It does
not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
Booting unplugged is not affected.

Disabling the Host Notify feature with disable_feature=0x20 works around
the bug, so automatically do so based on DMI information.

More information can be found here:
https://www.spinics.net/lists/linux-i2c/msg33938.html

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Cc: stable@vger.kernel.org
---
v3: Switch to DMI_EXACT_MATCH and add empty element to array

 drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 692b34125866..11149ddae745 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1042,6 +1042,27 @@ static const struct pci_device_id i801_ids[] = {
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_X86 && defined CONFIG_DMI
+static const struct dmi_system_id host_notify_dmi_blacklist[] = {
+	{
+		.ident = "HP EliteBook G3 850",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME,
+					"HP EliteBook 850 G3"),
+		},
+	},
+	{}
+};
+
+static void blacklist_features(struct i801_priv *priv)
+{
+	if (dmi_check_system(host_notify_dmi_blacklist)) {
+		dev_warn(&priv->pci_dev->dev,
+			 "SMBus Host Notify disabled on this system");
+		priv->features &= ~FEATURE_HOST_NOTIFY;
+	}
+}
+
 static unsigned char apanel_addr;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
@@ -1159,6 +1180,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 #else
 static void __init input_apanel_init(void) {}
 static void i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void blacklist_features(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
@@ -1562,6 +1584,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 				   i801_feature_names[i]);
 	}
 	priv->features &= ~disable_features;
+	blacklist_features(priv);
 
 	err = pcim_enable_device(dev);
 	if (err) {
-- 
2.14.3
