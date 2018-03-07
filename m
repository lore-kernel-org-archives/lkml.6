Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453152-2-12674624191440642376
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
    t=1520453151; b=gCO8H9e4ipOSvnIfKfb5Kj+3RK7kPg0X4eeEXFiOv4rUgJZ
    KTP/lfnBSgpS4qZL0XstBR9jma56VtSJyzRHCHANDq/cC42485an5iTw3QE29/QP
    G/8+4Sczbks18joxlrqrd/OckGX8mGXtbHiXUOnEL+QFK5PIPPAhd9ltSHnF/GDp
    TU34wji3tVaAoMKl0OTNsP1A3vfKZl5GOqi2pdXTjlOPYAu9Bq7TAmunrQ4QFThe
    iXODf5v40k3hh7e8yatpRPwsNjC2ns6Cro1Jz+asrs7aaMuvJgD2wNXuPqIoKTa5
    QXetimP86wxasVY8yK/EXiQQ6qHreor4l/Qy1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453151; bh=pI9eTdcnJM+I8RGjA63yVM8cD+
    iuJ0MwOVfIvOwV46k=; b=v25f2HhafKdByXyyGtPrx3xFDDgip3fDcueGWWI4r+
    5N5Swjhn/wGBF/nMmPdPcd/CQXtDd8ciYsaZGTv+R3+QQ0JUC1Dt90lSG8J3Mvre
    wkPKin2N48IiQOzFUClF0gik7RboLDSVQlpzri6leExEwnx3u0B9UwV2LZwnSlJ1
    VS88SHhMjRQXmWFvMhWTShFWvnbvd//glK8bNZpaellFFP0TV0b7KgphWlfi04wl
    aQ/NmRxT/IjnRVPliD/yVuJ3aV+oKepUCU1+NWtTzvB+i5cLJoPGK+7NFN/WBx1u
    ZnpQD9UuU4a2CfO+RjBOzVR3sWPqIEUZH9zMfr7U7YRw==
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
        id S965484AbeCGTqM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965465AbeCGTqG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 016/110] mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
Date: Wed,  7 Mar 2018 11:37:59 -0800
Message-Id: <20180307191041.821628597@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 325501d9360eb42c7c51e6daa0d733844c1e790b upstream.

The hs_timing_cfg[] array is indexed using a value derived from the
"mshcN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc-k3.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -135,6 +135,9 @@ static int dw_mci_hi6220_parse_dt(struct
 	if (priv->ctrl_id < 0)
 		priv->ctrl_id = 0;
 
+	if (priv->ctrl_id >= TIMING_MODE)
+		return -EINVAL;
+
 	host->priv = priv;
 	return 0;
 }
