Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221530-2-13812427599034021369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221529; b=rHlAoB2gaOndJkUhgp9YH3EmASCHjqYI6FqSCjH9YNFbuhn
    RFBxXRwwjOxAw2co1chnmc+0gi78Gzqx+55x0MBr0aYKo1CSYojTdMEkleXmPdkn
    +B7+FP6BsL4UupzuANK7HBALAs+d7Yuquc8Mvx3ZbrZBtZgDE7AbD2QiiR6mA8EL
    nCb1DPeJ8IfrCVxxJ3pNYmI+YG2mOQdVY1xBFIeHsx1jUuBmgaJNljwFiw9DiQH2
    rhVrEMEKFmm+PwWWGl8MbPhfW2g+DnzotigICBcOlPd5WpHQQnx7T2zB5t5NO3fv
    D8PXZ3KsL0BpgXVG5QcIfCMdgT5QsGwE0XpBkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221529; bh=ZqI5BkMA3CirPswF1qJ4je0oBp
    tSY8U09bV8V1PrzUA=; b=aLq1vlE8kZdc1cgfCgbJYI2x7R7wg277pJHG2gweAa
    REAgd2pxAN0AynOwoJvcyWB+naHrFnL5jbgnCCujKE8x6D0TzM3hnXHAnh0ySG3P
    nTIRWfXsFUMS3kQNnDy9ZC2J73pKx06oq1SUj72LguI6npb/QlScOVlgCxsZKYfU
    UKtdsasngER4aQPTX0gwmR38Tkt4dpVzMcVYOyqCzxepGVhCh54qVNWsZfCaBY/6
    TQKf1m3KqcgbJ/7IvMLkWD2JdPCzu0mErwiQjFVE0hwFIXxAYTeTSwbxou0PfBxK
    OhwpuuzK5+wkofudXjYFaJDWX7xxit5bIuv2BiJIYWXQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeCPRbw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:31:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbeCPP1f (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 25/63] ALSA: hda: add dock and led support for HP ProBook 640 G2
Date: Fri, 16 Mar 2018 16:22:57 +0100
Message-Id: <20180316152302.845495376@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
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

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit 099fd6ca0ad25bc19c5ade2ea4b25b8fadaa11b3 upstream.

This patch adds missing initialisation for HP 2013 UltraSlim Dock
Line-In/Out PINs and activates keyboard mute/micmute leds
for HP ProBook 640 G2

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -850,6 +850,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
