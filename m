Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406756-2-9357094934210697780
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
    1524406755; b=mbGxv2MvDk+pPfC8aGOQEUeMVmeBPzdYzpv/CrGTvj+aifa0mR
    RnDaqSHHUzUZfAEZ6wJi0bAbDmOgE19L1cxSA33VVN8OMZ19ye3bZlg+3zVW1kj6
    4Qg6+0Qfy6mjHt0K4ubCUULlkVs9n4GJJDXShGloJgD3l4Gme9FKTSenPVt6neRx
    8e2/NWR3j/zYxS7LPZZOwK636O+Nosv/m0zXANE0iP/HSv6r5oYRzhQ3BClZX+Zf
    KqsV/tBPhvwih2DWz8Ux+bpTr69CZrOJufMJWg8ny5z7eaqbTp0FCVfefuMTsH6t
    Hc6dHu9dbwpWl0let0m9FWPym5yfrpPotjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406755; bh=ZBwvVzSvlsY/ate4wU9NcOBG2+yCN0
    S5vsoqeTzSvMc=; b=QAREJVSRK4svoNH5w6pwz6DcwExRy/q7wQ1DBidOGH86BJ
    gjQeWrV8vKTGGmoPSpvyOrn85gVveWDuh70ecaSobVgqE7b+roB+ctpWy6Hd5L7K
    aC/aYRDR1RYGeYGMmMe93C2W8AMAYEwzvzNJnijoy96eE/DgLzlVJ1nE0rK6hV8f
    2v6W2CwEE8bEIVHmC9Y8tOUmNzOjpyzZCSRmm/Uu3qZuuRVJcbt3kJSee82JI8Mn
    E+ExcBii3DQ8bjJcyeLjIlnJWEipkX+p2Z00Ufd3cr1KKjnhdW1XhoYMjWCpF1di
    vJrvBMchcq7b0zHUGfa7V5/9WyUMBlCg/tMNlWKA==
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
X-CM-Envelope: MS4wfCGUoYINysUade2G3RNGSdaRBd+WunaU4nQS0ogT1gArqqmFximhwhWht/Lr3DiacUeUyaO2pMFT8VF9H4+YVhPlxWt/McdFcuTvB+nc/R9koMoped6E
    a0K+bH2QeIue+zjBtbV4j0FIR9JHtjnMbrIVw04pW1RqX3a9QvxSxyS1QDRw70umDjBpNqY1sb3LS/ESNko4euTEiv80YAKLnFzFagl9MMEGSEB/sDUqFPpB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=2omkdW4LyD52m0Bg1P4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeDVOTK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:19:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeDVOTJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:19:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 4.4 72/97] vfio/pci: Virtualize Maximum Payload Size
Date: Sun, 22 Apr 2018 15:53:50 +0200
Message-Id: <20180422135309.188437852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Alex Williamson <alex.williamson@redhat.com>

commit 523184972b282cd9ca17a76f6ca4742394856818 upstream.

With virtual PCI-Express chipsets, we now see userspace/guest drivers
trying to match the physical MPS setting to a virtual downstream port.
Of course a lone physical device surrounded by virtual interconnects
cannot make a correct decision for a proper MPS setting.  Instead,
let's virtualize the MPS control register so that writes through to
hardware are disallowed.  Userspace drivers like QEMU assume they can
write anything to the device and we'll filter out anything dangerous.
Since mismatched MPS can lead to AER and other faults, let's add it
to the kernel side rather than relying on userspace virtualization to
handle it.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/pci/vfio_pci_config.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -799,11 +799,13 @@ static int __init init_pci_cap_exp_perm(
 
 	/*
 	 * Allow writes to device control fields, except devctl_phantom,
-	 * which could confuse IOMMU, and the ARI bit in devctl2, which
+	 * which could confuse IOMMU, MPS, which can break communication
+	 * with other physical devices, and the ARI bit in devctl2, which
 	 * is set at probe time.  FLR gets virtualized via our writefn.
 	 */
 	p_setw(perm, PCI_EXP_DEVCTL,
-	       PCI_EXP_DEVCTL_BCR_FLR, ~PCI_EXP_DEVCTL_PHANTOM);
+	       PCI_EXP_DEVCTL_BCR_FLR | PCI_EXP_DEVCTL_PAYLOAD,
+	       ~PCI_EXP_DEVCTL_PHANTOM);
 	p_setw(perm, PCI_EXP_DEVCTL2, NO_VIRT, ~PCI_EXP_DEVCTL2_ARI);
 	return 0;
 }
