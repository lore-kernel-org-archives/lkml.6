Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402384-2-15233636159053467806
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
    1523402383; b=sl8d/SKUj+pSDHFjzYgBK7dHYP7Rbu2OYAV90FAl6zlXOn6lOD
    s+v9zPjHkxnOxB9tWrOwUcAx3kDxVOMTRJ3Vb+OqHCizZGUqbivsGittpgfdXV7i
    XGUNb7IaE0158J3v/iIu0AmuccuR/h75mZapVRdxfEdqUK3y3U9Xm+ujkp3Sqya7
    udJ6FXazqDeWq39YSktSSMxd7F8qX45PwmuyGZbGpJQeKg6MW0y8O/vHo60jwT0l
    rYZsPxfEV7E07Kmdq7DGpcLwn3qsyhapgu1QioATKQVDRVaJYbn8JEOmvmf4h/ry
    q7SmOpXoOY7HYg74A+25Te21/lVukCGKx7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402383; bh=zNUxtYfkD3Y30SPyYCdxKKWYJdMDIW
    Za7cL+7FXgdbc=; b=MI2+H13sIT4lg9Agn9M7S8CklX/ltuLDVcTCxuAQXqLKmV
    fq1a3Y1f7bN2UrXARnf9EtdnBHZyESPp3gys2wQzFueJr00lyX9JgvpGsOueiWtn
    A3WF+0IOxW2nuh9PnbDbp6fj/+OjTuw2H+D2vDNRJd5JM0Rm59fX15cr3OwGeo9R
    AKYA5KPMLdsphq9iUuk9QIMuTpJprSTtfnrllweUo1kp0ZI/bD9BeragCiO1ivS6
    k7e9jD2HgniXIGluLJtsFxfsgVUf/OkHDwPq8fzKMUCjasTyJGykPASwCdD3+eT9
    A+A05FroKZEwBIbeXtc24v/ECRDlxwM+ALV83S6w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMZ9erSJ3/Llcg4umtJr80khdbMmRODN4FztijKP860h8Sk/tcDq0b8CiOkpdF6W8VUdbwWAbQ8aZn7/wfufr/v4PIFOy+1HzlnNuhhsbpfmwtz7F5UT
    dTOvq5+5wl2AUKEYj+LFKPsIuGusRnpsYOpUB4X8ls5+LJ25CJYvr6k2ikIg3YpFXeLmBjB4rg08Mm1mq6wEF43+asImsjniOX03iQdWtv6Vs+X7jd4fQIvY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=PjuYqXk4AAAA:8 a=iP7vMvkZAAAA:8
    a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=tG9g4SPsdckd7zDvgwcA:9
    a=QEXdDO2ut3YA:10 a=SKixG8JwDLmn6dAKAxWB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeDJXT1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 19:19:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbeDJWbJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 101/168] Input: goodix - disable IRQs while suspended
Date: Wed, 11 Apr 2018 00:24:03 +0200
Message-Id: <20180410212804.549445970@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit faec44b6838312484d63e82286087cf2d5ebb891 ]

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

This fixes the i2c bus sometimes getting stuck after a suspend/resume
causing the touchscreen to sometimes not work after a suspend/resume.
This has been tested on a GPD pocked device.

BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_touch_after_resume_all_linux/
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/goodix.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend
 	int error;
 
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
 
 	wait_for_completion(&ts->firmware_loading_complete);
 
@@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int error;
 
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
 
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
