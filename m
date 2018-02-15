Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710851-2-1784796816880799009
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710850; b=Zb9e4G0095IcJv5RcTmaxEKqIcASaPAzAg7jXZenNhIKQjw
    90k35K0waivEgqR1hXjGF4iB3ln+OUYqcHHFbFk9lSHwxtQBevezIUtlVWqGOqDq
    uYyEb5orBWfZM/PTW3ZVGPnZBphOh8frFhy3nrkHv7WAPKTllAUM1MKyNIAFu0Au
    KQfvulk+8uRlB+Cs7U8RG5ZEvwnl8hlVa/T1LoQrpY7TKP4niSxeOJwpPIe1UZHV
    5DU1RztN0NRKGmRaXCsU2DsSrv4yBz+mEBLBRWqAq6V6sGQq80Xi297AmR6kdqby
    V+rj0z5MTu2THfWHLyDv8sn5Dhp+XLYYz7igKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710850; bh=ga8aKKGSQXZK9wHSY/I6uMeIph
    qES9PnGF64dIAGLYc=; b=JggZ5wXPi+jf7m7lEpjj44v8Mdav6Pep9rHBpPHABO
    wcKEU9xvaYWeNZ8jW/lsrQnsuyq1+2EqtBxc6FItIFBHtgrtLlnXZH3IpTGoRVR1
    6wJJfb+pWGSEZjrAwnOj+BkjQz/9oikj0fM73hNTtrOumZeVcj4Rnjq1N+iAn4hs
    BLct46KhiVxq4QzUNH/U656mwiXb2hrUBIqJK7ycO6IqdhfHyQYv/RrSfphlvLGP
    hNBm7S3TcMA14R27/7m2P3KCRIsIvOxClPeaCkCQT/Rro8y0weB2HGIjN28/YOJh
    fOZt4OxjX1r8jC+daIqUuoOOojQPpUcJL6nuTOA4CitA==
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
        id S1424521AbeBOPpr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423883AbeBOPpp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Enrico Mioso <mrkiko.rs@gmail.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.15 155/202] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
Date: Thu, 15 Feb 2018 16:17:35 +0100
Message-Id: <20180215151721.040390538@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

commit 9893b905e743ded332575ca04486bd586c0772f7 upstream.

The XC2028_I2C_FLUSH only needs to be implemented on a few
devices. Others can safely ignore it.

That prevents filling the dmesg with lots of messages like:

	dib0700: stk7700ph_xc3028_callback: unknown command 2, arg 0

Fixes: 4d37ece757a8 ("[media] tuner/xc2028: Add I2C flush callback")
Reported-by: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/cxusb.c           |    2 ++
 drivers/media/usb/dvb-usb/dib0700_devices.c |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -677,6 +677,8 @@ static int dvico_bluebird_xc2028_callbac
 	case XC2028_RESET_CLK:
 		deb_info("%s: XC2028_RESET_CLK %d\n", __func__, arg);
 		break;
+	case XC2028_I2C_FLUSH:
+		break;
 	default:
 		deb_info("%s: unknown command %d, arg %d\n", __func__,
 			 command, arg);
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -430,6 +430,7 @@ static int stk7700ph_xc3028_callback(voi
 		state->dib7000p_ops.set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
