Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676396-2-391572992553318083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676396; b=aMthdYMaDs6gBvXi8QvzVawFnVucLDLiRZTKlpbHStLn2pT
    h9BHbnaYaB/KAd889BPjQmK7L/zzGh4Mw1J3CN5iJdiG2IaHN+pXhwiF+sITAyk7
    yLHZ8ftyU5f+BmTNSADXCgxhBQUdtX+nUxML80OaVP2XP1juPzMvfpk4Xq8TeDZO
    T+nDx5R0DGLvf0h4Nct5RTAjEBGMGn4igH8NDsdVb4etl7Vk6cJFnUU4uzlka+CA
    FDeNim9AQWW97HuxLalxOUDodOJB6BLKvEeK4ospay+dt8WIaAgZF8T5yAwWU+lU
    ZLvEy/0aL38ctf+OI2m4DRnCxCiQc4ARqXefc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676396; bh=6jStXJ81kVKmmH1ueHG3qnSAkH
    K6wJq3KaorKnAcRIE=; b=WR03C21lcaE3M/we7BSDDJxa3BqSw+41rIWyqCgXUZ
    tWL8SEAVJQ42xqBbN2PnhIGi/lq9Va2O5PaTFK2oRsvdHM91qsB4f6Es998Q8Tuz
    yveYnAiAczWnqg3ZTIB+I0Kly2DCU6kO4OBuMjybrq92RXYvUSt01t4Z0vCdIf0l
    iaWTVP7lxbLUAvOyIYNvNvB22o9gxYEpW5DQQf7a+Fy6YMbZGFw3Q6l+2eL9IenX
    nAihRo4m5kHOm/iuDt5DoS7igmnjTAu+FoOF/EGbws6fB9SF6xnMEo6qdoMFHXEv
    qt1FuOkHJliF1qnjh24xnTg+0OfjR5Rqfnn8YKARsHwQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeBZURI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZURG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 20/22] usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path
Date: Mon, 26 Feb 2018 21:16:20 +0100
Message-Id: <20180226201559.616888894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 17aa31f13cad25daa19d3f923323f552e87bc874 upstream.

This fixes an issue that a gadget driver (usb_f_fs) is possible to
stop rx transactions after the usb-dmac is used because the following
functions missed to set/check the "running" flag.
 - usbhsf_dma_prepare_pop_with_usb_dmac()
 - usbhsf_dma_pop_done_with_usb_dmac()

So, if next transaction uses pio, the usbhsf_prepare_pop() can not
start the transaction because the "running" flag is 0.

Fixes: 8355b2b3082d ("usb: renesas_usbhs: fix the behavior of some usbhs_pkt_handle")
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/renesas_usbhs/fifo.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -999,6 +999,10 @@ static int usbhsf_dma_prepare_pop_with_u
 	if ((uintptr_t)pkt->buf & (USBHS_USB_DMAC_XFER_SIZE - 1))
 		goto usbhsf_pio_prepare_pop;
 
+	/* return at this time if the pipe is running */
+	if (usbhs_pipe_is_running(pipe))
+		return 0;
+
 	usbhs_pipe_config_change_bfre(pipe, 1);
 
 	ret = usbhsf_fifo_select(pipe, fifo, 0);
@@ -1189,6 +1193,7 @@ static int usbhsf_dma_pop_done_with_usb_
 	usbhsf_fifo_clear(pipe, fifo);
 	pkt->actual = usbhs_dma_calc_received_size(pkt, chan, rcv_len);
 
+	usbhs_pipe_running(pipe, 0);
 	usbhsf_dma_stop(pipe, fifo);
 	usbhsf_dma_unmap(pkt);
 	usbhsf_fifo_unselect(pipe, pipe->fifo);
