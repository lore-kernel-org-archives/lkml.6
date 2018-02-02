Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591168-3-5838996125486291435
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
    t=1517591168; b=GB53ljV/k2xfatI77p7cHnMB1ewBsalCAamgmkDba2uwetK
    3hJArLONZFyB7GKp0a+CyjYAyGb0E46YeQbn4JKzQfa+DE13taPrnndNjJraS2mR
    mNNfjxGJfXHqSCvFBpzdamIYPf9kg6JAVAhqPbx4OuU8ZU5V3FklCbRmAbTZkWty
    lvFMMAFO5TB4ZtRWS138vnzGENsnEsOUSiz5Nvzt0d0DX0iVvsy/teMhegnwhmTL
    q8O/Q48pYe2aNJm5HxVLJJ5x6vPjixDeCQL2E3r8tId9r0CSnjmsY+Cd7Gm3luBW
    UQXXQ4N6jN+qIoc1rQNyo7EWrmlfZYBGY4eDWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591168; bh=gXbTSgM9i01TGn4VNRWbSvCcRQ
    gTYC2AYil/nCQUkI8=; b=TQioKkPV+rh6hTYPFb/bI8MXTv2G5NUAK/7vHz0LDn
    dyKnhr/QJMskI9Y2pOol46F9gw6c5ReLBa7GJCk86nn+ZUfkLYT9nLwTxsNGJoNc
    UCXiAB+76Y9TicGLH2Yh598DPrGJpF0LB8bkDxgp1xg2ryeiAg6WE8wuo8NfxGkE
    5MkJPHcSgzlxm+eQzhPAQ9hB7LIvD0RFl0W3BYT84dUJaDsBK0NvC8dpcLRTXRqK
    uUqz7+2rDEL84qP4uCr3X17jDKWeGVrT2EL+lqabacpYb1YTMRWP5CCWjNo5nO06
    aZbj9xxuh9S/3msiOd9tvMhkK/tVntszhLaT10yw/tEQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeBBRGD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeBBRFw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 69/86] staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID
Date: Fri,  2 Feb 2018 17:58:29 +0100
Message-Id: <20180202140829.065497605@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>


[ Upstream commit b77992d2df9e47144354d1b25328b180afa33442 ]

When not associated with an AP, wifi device drivers should respond to the
SIOCGIWESSID ioctl with a zero-length string for the SSID, which is the
behavior expected by dhcpcd.

Currently, this driver returns an error code (-1) from the ioctl call,
which causes dhcpcd to assume that the device is not a wireless interface
and therefore it fails to work correctly with it thereafter.

This problem was reported and tested at
https://github.com/lwfinger/rtl8188eu/issues/234.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1397,19 +1397,13 @@ static int rtw_wx_get_essid(struct net_d
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
 		len = pcur_bss->Ssid.SsidLength;
-
-		wrqu->essid.length = len;
-
 		memcpy(extra, pcur_bss->Ssid.Ssid, len);
-
-		wrqu->essid.flags = 1;
 	} else {
-		ret = -1;
-		goto exit;
+		len = 0;
+		*extra = 0;
 	}
-
-exit:
-
+	wrqu->essid.length = len;
+	wrqu->essid.flags = 1;
 
 	return ret;
 }
