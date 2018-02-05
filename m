Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855183-2-9012336073273088149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855183; b=mANYflX3ZqPMywymlS2ZpJqLKXDwnrCnH5XtNKVYT3BcC6c
    YzE1ZKNwtPmzCk0mtB0w2rE34p0AS2Vmhqs7UB66ff7u+7fqyOabdlWFU/zYVqSz
    JHtAfxN6Rx0SCaCGpb3qDa9mcwT4DjowkQ/egkjT+QY75RrN0l5bQNJpPheiq+0u
    w9Myqp4xaA58/DTyV8z8sBvSjb6n+dn6pwUsI48DiNIBDohUs+ucfdr/LjqVn1wO
    DWDDlNfjxBlk/gY0KoUjUnWDU/NQNFwDTfmtht3PRoYQEgBX2nC2TNykcFPfocJB
    d/tVamf9d3tycm81ItUQOhzZVh4ql3U42pdWSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855183; bh=9y+zbcBY7nXBwxKiM6EzwS751u
    1S59xjvSnhMSkXMrE=; b=g+tK+y50x3YtUq7Y1g5Z8ifWSXZHUXb+44QVZyt6J9
    UqQOap/6vlICe+cUZ1k2+YixzUX7X2FvkQT1QZcqyxt1rcxH8P56L+s9Gl8xciCN
    ncTjE4jP9hPhRzB6egThUDdGIlQ5ifrwUP/yYRqucLEltwL3dKfV0KQJ5O6e5pQu
    MAJzlWU+lKzAsNrV5S+WxTbK3NDMEn6OZ9D5hEeVCmMS6TOhwicnAt40xfYnjtgZ
    hjGomQkdBz9URkmQoOj76+NMTJc3hFmW4hDbbdUXu/T6ldyVFQgG8O1+DR6EC42T
    J+lx6MDzUO75T1+NYWmdSiDtoxHID0qhzXBhy8DMKFaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeBES0K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:26:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753842AbeBES0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:26:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 4.15 60/60] fpga: region: release of_parse_phandle nodes after use
Date: Mon,  5 Feb 2018 10:23:33 -0800
Message-Id: <20180205182217.215908210@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 0f5eb1545907edeea7672a9c1652c4231150ff22 upstream.

Both fpga_region_get_manager() and fpga_region_get_bridges() call
of_parse_phandle(), but nothing calls of_node_put() on the returned
struct device_node pointers.  Make sure to do that to stop their
reference counters getting out of whack.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/fpga/fpga-region.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -147,6 +147,7 @@ static struct fpga_manager *fpga_region_
 			mgr_node = of_parse_phandle(np, "fpga-mgr", 0);
 			if (mgr_node) {
 				mgr = of_fpga_mgr_get(mgr_node);
+				of_node_put(mgr_node);
 				of_node_put(np);
 				return mgr;
 			}
@@ -192,10 +193,13 @@ static int fpga_region_get_bridges(struc
 		parent_br = region_np->parent;
 
 	/* If overlay has a list of bridges, use it. */
-	if (of_parse_phandle(overlay, "fpga-bridges", 0))
+	br = of_parse_phandle(overlay, "fpga-bridges", 0);
+	if (br) {
+		of_node_put(br);
 		np = overlay;
-	else
+	} else {
 		np = region_np;
+	}
 
 	for (i = 0; ; i++) {
 		br = of_parse_phandle(np, "fpga-bridges", i);
@@ -203,12 +207,15 @@ static int fpga_region_get_bridges(struc
 			break;
 
 		/* If parent bridge is in list, skip it. */
-		if (br == parent_br)
+		if (br == parent_br) {
+			of_node_put(br);
 			continue;
+		}
 
 		/* If node is a bridge, get it and add to list */
 		ret = fpga_bridge_get_to_list(br, region->info,
 					      &region->bridge_list);
+		of_node_put(br);
 
 		/* If any of the bridges are in use, give up */
 		if (ret == -EBUSY) {
