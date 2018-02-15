Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719413-2-17588084977547362285
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
    t=1518719412; b=P+zfcsGltUzfqNNtDJ4XtO1MX8QC4UssFUdPHDesb58udyh
    Wgv+K37NKyGawTIbLTstLf7/CGhuuGPSIr+qaT0TpKlj0c/ihEROpmqBbjoXwE8M
    hHvzndikwScW3AUXQlSJShEgvBU7hFm3a6T8q8Y6tjRzKoZkBPkPSbOYmtoPI1ag
    TFmoMOmShTv1AZJVt7gSpKcmavZ7pROfGj3uE+u4zp+uEPMFcpRM32V4mhCUc2dp
    SEE8rq3xPO8rWVPbUA2IzZIyOEXrLxtHyC9VeD0gMS/TwI3OUmtnL/cGJun28IGW
    NS/aIao6ZM6flbJjA8ejsOWu2hpxUNyNuQj8rjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719412; bh=lUE4hfiGP/Psx+yIx2NlkbD3Oj
    9H4vEAewcnZKBXDdw=; b=M05U4WQKc3981DMDW6wOwqSRNmijfQ9CHVuOmkv//9
    WkmTucbD3zwx/ybd+1mFq8dhOijVfiVL8MztdstwRDsk6WWoESkG4Cn1waThPlGN
    rd7BzRHXL2jED8EaTOZU9pDLCjIIbJt9Olt7Vnpi2su7QiDurCDjZXdnxPX4ZmnP
    2ZkwLs2poH+9V1G3I7Hazj1qKuX2cwhUYSCentszSYTCr08P9tcaf6aTT4Ov2/X3
    7reAbkaeXlBre+24CXVv6aXx8nt5/QPhGU+0RKS5OldUh4A3/3E1GMR13Hfows6O
    VHbKig7xYN9OH1vtcsnhW236Iuol6s0h4V2I9hoXyn/w==
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
        id S1162777AbeBOSaL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:30:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163126AbeBOPZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Enrico Mioso <mrkiko.rs@gmail.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 090/108] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
Date: Thu, 15 Feb 2018 16:17:27 +0100
Message-Id: <20180215151234.949851260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -818,6 +818,8 @@ static int dvico_bluebird_xc2028_callbac
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
@@ -431,6 +431,7 @@ static int stk7700ph_xc3028_callback(voi
 		state->dib7000p_ops.set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
