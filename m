Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405986-2-13244778505857305478
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
    1524405986; b=ie1m1fZ3BSVrd2w7W43Rzld/rJgXAtiK/lEbCfkOytabw9TBFe
    ikYVlaag77crdNtq6oNyMHFs+78k5uywDpTLyaTwo9+9nMYo7ZFQqg/cNqMGphaZ
    J3DlP+umUjacQda3ISP4IYgE2AOANNBzEm9rFN6eiDM+GFF9Uq6dgPinGkxi0pGE
    soCbvrM/SvRguwbAgC2d+K1qZtI6WI654KLLRQ5U4ACYplw0RZPl7FPHL3usuLfZ
    pN4fqR/eRw1GvBS2JLYrshCIzHiOJm0cmDr7+VTbX1Egh+2wjvLuJWgmDIajz6zw
    hvRszEmCBJ2WwtGYA1yuWmgKgNbtl0HI07Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405986; bh=gvH8iUyIr0I05u2F2Cy97z0CEmgt3Q
    W6MhZcM3ZimW4=; b=JV57JgINOj41G6lct1TZUoDnWVrxUUUpDj0C463Vb5HMaC
    W6pQDCwwXT1VsZwh5+ygw2yIah6bcftU9/qYITuwOsk3KF8KvY5WDJx+6wLVg20J
    B/5NW1XZZ7GMhB4Pw6G4ORyD9yNdzhVQAV+/hfNn+NDUwKzLsEI3eMmBLEeEN09s
    Ak07qNnvDe6wF9niLE9C28bDDyWc9q+iugvrljtDdvShTKexBoHw60TeyMNnYlqY
    c3Nj9fxE/JfVUnUjgklO0C5H+sxawtTDuF1U8X4Vfi/kvAdmbzJzTvnwM45e6bXF
    9K0H1Tqrqxw/DUtk6BeHO26JlmOPVUEaMK82nw4g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAwvLDTT4HmVS7S8IweEO6vbHQk4hb4cITDLMhIjaigr2owebEu5HnV9tG2G0sJwe4XQy5fcAvn+kWO/js3n+sXMnntsyCBFETSbc2dFgTjcSFww2Ctx
    RDP327mxB+lpO7J0nBuc1HP6WYrLWlQgE+XBpiuaf5EQ0CUkxOLtDjPo1pnSSi/KCNzWDdSIRc+2XIIu5CGRLONeF6OG/524S+DrDtgHMutV2T7IQ9QRFgyt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=woTECNfuSRCmFN8eG-YA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755114AbeDVOGX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:06:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755527AbeDVOGU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:06:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 034/164] regmap: Fix reversed bounds check in regmap_raw_write()
Date: Sun, 22 Apr 2018 15:51:41 +0200
Message-Id: <20180422135136.807527237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit f00e71091ab92eba52122332586c6ecaa9cd1a56 upstream.

We're supposed to be checking that "val_len" is not too large but
instead we check if it is smaller than the max.

The only function affected would be regmap_i2c_smbus_i2c_write() in
drivers/base/regmap/regmap-i2c.c.  Strangely that function has its own
limit check which returns an error if (count >= I2C_SMBUS_BLOCK_MAX) so
it doesn't look like it has ever been able to do anything except return
an error.

Fixes: c335931ed9d2 ("regmap: Add raw_write/read checks for max_raw_write/read sizes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/regmap/regmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1739,7 +1739,7 @@ int regmap_raw_write(struct regmap *map,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
