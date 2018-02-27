Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199706-1519728115-2-14981936365445939315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519728115; b=gRPxQFDrtBjjg0o9ttO6PhZ4vi34S0OPhQqYLCZnyn21kHo
    Ki/qylt+FS2Jme/C6Xq2B3O8BsAQ2zs98yk23A7fWBEBxixBH+72V8hbctxBxbzh
    87NgOfYZg42qqeSkzv6lX0ySpZhGwHFOa53mfoKL69UUDXUrl1WBVwOL3Div45t0
    ZCFw4G5Kwmq+DUPSevNwf2RIQG+o8lTjyFRcoFtxwv1z9WDkr0IhcUylCRxTfJnW
    nF4VLuAsmrkL1Wgpq4JwIy5X/uKMr5fzDSbOvsA448qhZARCLmFXjRFVIerqaQYq
    js1WCBYLWLvItQnyT6vGz0tbBnpnLXL1bkM8c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519728115; bh=+j4bfFqKYWSwB7GFXIHNd2WGI+svyzWHlj3yVJCvYo0=; b=t
    i4DS2qI8oqpYh2lZFMtwZkSf564n2sm3T8m4Tj2swNFSxd90+ccL/TfTpXPyX9N4
    +PRzqyLziNprY5XsVJylN/sW/5PwodK/DxKcWRgT8mRYlOQ0HJc2MxfmbNPo0Ct+
    +0gI4igsVtBLHzL+kAbNFT0W53PyZYMt5+yp5D/v3OIneq1UAF1dsiIlYaVdMi77
    zdrUHmeVMHF/8YVpIK0/K+UM7XW6gCSiiPw6Q/TNvIdPBsbA2/mjzrcSemqBX+96
    PuqRXA2pg7C6Jn2Hp77nQpgY2RDqQbJH9gTSGqoROEh170FusxptW4vQSXNSo2xr
    FNNmacwqO2LFh4A4Uiguw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=l4PaEu/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=l4PaEu/n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeB0Klw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:41:52 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9077 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeB0Klv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 05:41:51 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <gregkh@linuxfoundation.org>, <mgautam@codeaurora.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        "# v4 . 12+" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Fix lock-up on ID change during system suspend/resume
Date: Tue, 27 Feb 2018 12:41:41 +0200
Message-ID: <1519728101-15324-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To reproduce the lock up do the following
- connect otg host adapter and a USB device to the dual-role port
so that it is in host mode.
- suspend to mem.
- disconnect otg adapter.
- resume the system.

If we call dwc3_host_exit() before tasks are thawed
xhci_plat_remove() seems to lock up at the second usb_remove_hcd() call.

To work around this we queue the _dwc3_set_mode() work on
the system_freezable_wq.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: <stable@vger.kernel.org> # v4.12+
Suggested-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f1d838a..e94bf91 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -175,7 +175,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	queue_work(system_power_efficient_wq, &dwc->drd_work);
+	queue_work(system_freezable_wq, &dwc->drd_work);
 }
 
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
