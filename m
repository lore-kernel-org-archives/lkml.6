Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522172494-2-6303606049813036993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172493; b=kFbMQH5MxSClf9S53gktF1XGcQl0AzvKBx2Ac3qVZ1AxoyE
    0l2TchMSZ5/S1vZN8BWzKMqtlCfRIU01yi7llYoZMjz4ddcEJD8Y3BKGDF/Drs/C
    lDd8R637aPNpyFtafmBPtfSrc2/rEORaUVrFw93oGYnhtRav+scgQ3CNvbd7HQEI
    MCKPd06VpHMZyQ+4G0S+pLO48bbnpnRkGXlLg6ICwreTFf3AHjMsekY9txGVz5ow
    /bkqUQ1EMwmXVGyDCVbELo16ik+HVF+wakffijfHIUU8c5XX21+mePu+dovAAgtX
    hRP82zLNKrtC1eBKHeW85jOIsAH02fnVdz4/l+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172493; bh=jxopGOv3CfJLD34Uhlt9wM6qZN
    aRetKY8+e8+IJ82/w=; b=rKSq+Jq993zdgNBVKtG8qXb0rLXUiXw5hIGE668ItY
    QiuFm/Pbd9anTGKUlaLpoiWMC07PZMV+l3Sw0vl4FAmxmbh8/DuH2PO/5EvpHTOc
    pPr4FZiTeXv7STohGwOXGMSSYbtUx0aMO05+WxJN2XPkSnbx/vrCNBO3KYDeiprK
    thC701cn+WlB58t7OFD7Ay1qdWZho3kTQ68Yi0ArpFAQTD8t9xazhkn4S/W4DVwF
    gvX8N5TkqR8rZbZ31q066UXh1d9BjLLTYi/L6BXuFKYIM6jWJRMzgn5hGEGG5h/O
    SvF+DW+IT+TX4CzI1MCNVcuYxIklDodEpKyEVRreibOw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEsq2mcsrIiWg2JvGoPmMOnmqBiUF+Wv3eIaGILBUFW5aNlUdyTn3elSbozsYSvW0d9BRHXL9K8vB83aDbx6g7w6fvMgkfl18Z7I16s5MRTR5pPmTbtq
    eoNUp5IwJ1UwQ2VwuEg9eVMtdEN/rpWk13juEMEejPy7YshhjCfI7eIbGy+42gNDHqd4jEPtwfwGuewkkUSPlDfRxTNf+afj4V9tWtDj+raEthQMuUrwOaTc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=ag1SF4gXAAAA:8 a=ZOyOa5k0IZLutefqA4YA:9
    a=22AN8RtJdsEif1uG:21 a=qpj-8RqjrLBITV5f:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeC0Qd6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:33:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbeC0Qd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:33:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 012/101] ALSA: hda - Force polling mode on CFL for fixing codec communication
Date: Tue, 27 Mar 2018 18:26:44 +0200
Message-Id: <20180327162750.746050409@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit a8d7bde23e7130686b76624b099f3e22dd38aef7 upstream.

We've observed too long probe time with Coffee Lake (CFL) machines,
and the likely cause is some communication problem between the
HD-audio controller and the codec chips.  While the controller expects
an IRQ wakeup for each codec response, it seems sometimes missing, and
it takes one second for the controller driver to time out and read the
response in the polling mode.

Although we aren't sure about the real culprit yet, in this patch, we
put a workaround by forcing the polling mode as default for CFL
machines; the polling mode itself isn't too heavy, and much better
than other workarounds initially suggested (e.g. disabling
power-save), at least.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199007
Fixes: e79b0006c45c ("ALSA: hda - Add Coffelake PCI ID")
Reported-and-tested-by: Hui Wang <hui.wang@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -375,6 +375,7 @@ enum {
 					((pci)->device == 0x160c))
 
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -1744,6 +1745,10 @@ static int azx_create(struct snd_card *c
 	else
 		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
+	/* Workaround for a communication error on CFL (bko#199007) */
+	if (IS_CFL(pci))
+		chip->polling_mode = 1;
+
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
 		kfree(hda);
