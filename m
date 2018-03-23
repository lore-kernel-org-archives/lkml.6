Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803667-2-15761518692433510933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803667; b=odTAJwhvmsco0zpgcn/91ybfaqyhmM2MKzJTU4lJrvRikRj
    ZaJ7p8ShCyBANbOhxbx9yJ1NJ7ra+ugMqRqoFos5Xbx+uAz3dMfpkm/AxZCfNn3P
    5dcR3GmHuYxG/lYXjRzHBIjOGThtvfgB6x/jllcJ3VN8rs8EH/rsoa6jJD0ZWDm/
    ucdRLhIKTJhgZIPrKte+lLBP4c9/rN96rxOiRGcPSgyxQbIjuqh904RKED82tvi+
    Nhj/42ZPiOsDQsbtdH5jdPWyy8muqoReUzIJM3MWDzxudoD14J8IfMkj6n8xMzCB
    i6O4dfPBbbVtWIdN6lZD/GnVnZhXSdnwgyT49CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803667; bh=c/uu34mVdH+JdNTMmCQGf/UBVa
    WEtnCeHZwnJPau55c=; b=QJOOcsCI80obg1+/AlJjYxWgD3pNZ+wUQ5EwQm3+bq
    hwUFy6whqTXk2KnmfigGLe2SRNKjSizS1DCPDuITk/jfIDtThZctbw489R0gjEc5
    0vjdGAIAieZ/nuCrA/kcMObO7MNb35F5lVl0estHRhpXM946CxECS0HktyfebGeC
    BiAJRcGaXCoVJ5TuNx+AADCPbA+IAm5KU0qwsu1qmYezz4LcJAk7NMnU+XobMiYH
    f6NOWbByCRrDML+hAU1oV3pKr11zvxM17JqySRUhpdQK8MM77fpKxz30/Ef2AVEm
    2Ae5rfDdyjmCUCcZuE+i17vfyfqKYTSrvIH7svpLBPXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeCWLON (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:14:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeCWKKW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 134/177] Bluetooth: hci_qca: Avoid setup failure on missing rampatch
Date: Fri, 23 Mar 2018 10:54:22 +0100
Message-Id: <20180323094211.122557854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>


[ Upstream commit ba8f3597900291a93604643017fff66a14546015 ]

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_qca.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -936,6 +936,9 @@ static int qca_setup(struct hci_uart *hu
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret == -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */
