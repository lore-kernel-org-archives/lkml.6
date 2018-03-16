Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214667-2-7228654671233042106
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
    t=1521214667; b=FNGlb2Vz0xbrNcHSMm++LWhY047TUvRqyGG8tQ0e8iVDnPv
    Q01nnhe/trI+3h/dHj8/OtHsJtrScKApvXw4dSlxuMwQn63ebt/xVJHr6WDoZYYg
    PUaxfY7+AORvtmUTsvmNA7tg5uLP9tE8MKtxi2Ry1WeeuYueQG98U+ayCIxDKS7M
    XvQAFvrt7f+nX0JkE6bTJdIllFNnyycZsa73xJx3IELV2cPu1v4661o43tKkAKp7
    MyyQRnfPILm564TAN+XwN606Hmp5gwcz2dQkFCTPkwH8LYjUPxbEMQSu3n4bkc12
    IkUeJzSaoJtydaDGUvoWrXDEctHxDTjqK1lM5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214667; bh=c572ila3mRh1CLsisacPs0b4Xq
    C/BlxEaHYYcpe022A=; b=skrAM6LUqz7VUiA7t4inqB0snG2teqMp+gzPc9i76C
    Zzb0IJR1B80ArN6jt+DNN0ap/L7fFpxM7e8pmQ5xQ79x8YuC5E2GoATYBf7Z9mwR
    qDHQ/+gn/QH6v6vFcsCnKYtS1ptDhHTCK8xasdeMkCX2YZCJGBqdtrtzDgFI2d8j
    cPUinC9VbIsM6R2tq8enh1HVpeTyblhk/hzlSzeMoRyCf026RhzZqhrpiQd+dCgE
    FzNc3z5k6uX8e/cIOfGq0As+GwTadQlpcyHu2GlL1Wepq0rHthZEgVzXVsePIp0f
    mcpsVu+Cesphn3JTXnAaefXQ7jkvr7yFJUTxUcBHogtQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S934154AbeCPPhl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:37:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbeCPPhk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:37:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 081/109] bnxt_en: Dont print "Link speed -1 no longer supported" messages.
Date: Fri, 16 Mar 2018 16:23:50 +0100
Message-Id: <20180316152334.368119526@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Michael Chan <michael.chan@broadcom.com>


[ Upstream commit a8168b6cee6e9334dfebb4b9108e8d73794f6088 ]

On some dual port NICs, the 2 ports have to be configured with compatible
link speeds.  Under some conditions, a port's configured speed may no
longer be supported.  The firmware will send a message to the driver
when this happens.

Improve this logic that prints out the warning by only printing it if
we can determine the link speed that is no longer supported.  If the
speed is unknown or it is in autoneg mode, skip the warning message.

Reported-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1698,12 +1698,16 @@ static int bnxt_async_event_process(stru
 
 		if (BNXT_VF(bp))
 			goto async_event_process_exit;
-		if (data1 & 0x20000) {
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED) &&
+		    (data1 & 0x20000)) {
 			u16 fw_speed = link_info->force_link_speed;
 			u32 speed = bnxt_fw_to_ethtool_speed(fw_speed);
 
-			netdev_warn(bp->dev, "Link speed %d no longer supported\n",
-				    speed);
+			if (speed != SPEED_UNKNOWN)
+				netdev_warn(bp->dev, "Link speed %d no longer supported\n",
+					    speed);
 		}
 		set_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT, &bp->sp_event);
 		/* fall thru */
