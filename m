Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281306-2-9586220390855635298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281305; b=iZPHP8bJvWz+Sykv2eREWv1sH5ffVzu3pR7hv4vp0zAzB9rcJ2
    swCciykPLbJAzMOn+bNUXGuWbCMbw3hyT/NMsgyRzzHhLjsEVuZ7n49LTZKOJAie
    W+VzZbSN3p+Mif/KXTtV264fVUknaJaFy2t7HzN9Vu37cjQJCA3GGhKGZjHlnlUF
    xq8BXZoOU8eeoIHP7PzL+HNaoQwAns2FhDJ+eO55cXZ4Uq8XF5jNzQ6zPI+dFj3d
    IV+oQcczdmykk5J0Uv4nkxFGiIebaKNz97f6HFOA2AHo8/CDQJr8SpzSocVc4LQs
    2WLwMN0W+Nk42MTahZLiWcwYNNMxzXEdLQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281305; bh=xd0OCqXUvadRJ7UbDrbKlorJR6H6bp
    ieRDKUywcMWBg=; b=QuCVt0o/yqRFh4ZJJjD9lD4nE9U1sfuhBEJNmGqrhNQ3iu
    RocB0oCdO8thSxI5dCAPd9UfZoMIlhpeVCENy2OAZGjaroxTYwndTKUWHc6DdeK+
    WP8GT7aPEWshDoPmE98V63v9PUZYpnJRNCSox1rSQKd64Aw+I0jxxJqKiAyvDEc7
    6dmavgWteYNlE8OeZHYqeOUpx6WGXV1p/RNAxeLPsnOA4GwfCdgka0IMp5dzt5mm
    NE0xw+LIiIoaEeJfdV7XoWTSZ0Y+oxMenF10If+Tqsu+tQcfJIdWk/V2jKuto4IN
    tiM/ePFKg1GnByg8kh0rbtJq7T4ZCBlIUWr+PclA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Ib9nyfQY x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Ib9nyfQY x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEAw8dO2k2+/C04/un9gZtYas/xSNbCArOSr0/CQnThwQg6seK3P11y08TILCwvxCdsbHb3a1uz0jnElz7mGXveJRnZWj9Zcd/HBVNNVdNaZdBHk0Cd/
    Dkz6pBmdf+mWoGmo+rj/hfjPBgxd2pxRkxvG5thIx5kG0/PKbzmOWvmk+s7wPZOnDAwMJXaFMtuACpeiXruadCUJdkMJpj5463bBfdK6CPZvnMld3NKK6ciW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=tkUzE5cn9Rhtpyxa_UAA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeENHAx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeENHAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 39/72] mtd: rawnand: marvell: pass ms delay to wait_op
Date: Mon, 14 May 2018 08:48:56 +0200
Message-Id: <20180514064824.850524187@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

commit b76401fc4ba720f0f38f7b1f9d54d5c2308bc18d upstream.

marvell_nfc_wait_op() expects the delay to be expressed in milliseconds
but nand_sdr_timings uses picoseconds. Use PSEC_TO_MSEC when passing
tPROG_max to marvell_nfc_wait_op().

Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/marvell_nand.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -1070,7 +1070,7 @@ static int marvell_nfc_hw_ecc_hmg_do_wri
 		return ret;
 
 	ret = marvell_nfc_wait_op(chip,
-				  chip->data_interface.timings.sdr.tPROG_max);
+				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
 	return ret;
 }
 
@@ -1490,7 +1490,7 @@ static int marvell_nfc_hw_ecc_bch_write_
 	}
 
 	ret = marvell_nfc_wait_op(chip,
-				  chip->data_interface.timings.sdr.tPROG_max);
+				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
 
 	marvell_nfc_disable_hw_ecc(chip);
 
