Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832516-2-2588488382000628088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832516; b=jjJGuS+nb/zqCCxyBd3uB4kfvG6DNE3vH0ChhmZ/uffi/jE
    LuAq4QfWMFi28xtvikpMGQrOrQS/yedEWNAVaRVbmi0QNu/ElNwNZm9X9Cb3vrBE
    j0SqmtONFJ/iTI54KRcqJwHfSxnaFpY+EUVsfZkhZmlCxJkx5u2hyGMdEcgY1qcG
    kd2Vuy2bFXHJWa/71hZUtL51dEcpGoorFl/Ye4r+akEaaqaZTe/T8jCJipuKFeWg
    MIA+e0DE3hMxNYPnxyzAGOQzHzDKTEnDiaRmldTP6j7+yi1rrlymdh+/ssWjOlub
    Jjl7YgaTt/cQQx5uhAAIrDVQnlGErxkoPoHrWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832516; bh=3c8cPLxBQQ39wJ9+ilF
    PCPaio+tJc1W3mAFORlAOMPg=; b=qV2h2vI8SamPeGeudhQlJP+QpIe4pP1H5IW
    B02xNd/1yKnNUXQa5aGPaFp5YebBNvw0ARhCNJnNczJdRdS5QEogRVTWmNKFxXsq
    o9CSZbxUT8ELVhO11OUw3xEtNjRe3jMYipSJ9CbOE42ttb+mBl/37BHPDFfn30ci
    F1oVhKA+2HnKMXj/qmaMKsDpYMmUBY7KsMTUMFeX4KJ6e7JCMq5ppC4NjpaCme9T
    I3imoqudBr7xHxhTTayENfmJnkKbpuoEeBWtVGccLg/c6ZVQsucSN2rYJgKIvivz
    bTKWzo66T4tSAT7UTud15UpxPVXIUihKOqe82hYam65QL7qCRzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbeB1Pi6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:38:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33258 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752722AbeB1PWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Sebastian Sjoholm" <ssjoholm@mac.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.371004891@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 013/254] USB: serial: option: add Quectel BG96 id
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Sjoholm <ssjoholm@mac.com>

commit c654b21ede93845863597de9ad774fd30db5f2ab upstream.

Quectel BG96 is an Qualcomm MDM9206 based IoT modem, supporting both
CAT-M and NB-IoT. Tested hardware is BG96 mounted on Quectel
development board (EVB). The USB id is added to option.c to allow
DIAG,GPS,AT and modem communication with the BG96.

Signed-off-by: Sebastian Sjoholm <ssjoholm@mac.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -242,6 +242,7 @@ static void option_instat_callback(struc
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_BG96			0x0296
 
 #define SIERRA_VENDOR_ID			0x1199
 
@@ -1204,6 +1205,8 @@ static const struct usb_device_id option
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC25),
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
+	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
+	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
