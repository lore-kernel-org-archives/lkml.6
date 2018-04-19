Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3526227-1524155022-2-9308811740416468674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524155021; b=Zipry72KXg1UUB9JH9Srvxw1188hMcZdPgRreBxFy6jC6A09wD
    9KYiBwwbTT9ZNdqWZSmLXaRWiFIonja3WObCQwWcJpSdNCipyO0OC42Yp2zHjS6M
    mCCXFzb+cvgiR68DA9enmxG9KeBCCvUDBq5IuCdMPmFEIzzvhvXyv8xvksUirdxA
    3XP9oxviVuvvHEM1KLv4hqmOsMXkyCJmj7hdy/uQsxWuKlwewBhavHR8pV2Y6/Vk
    i4s/+RSwHZdseJW0SQusTNeFT0ncB6cR7FGzy65sYQeeBxC+lFSJUNZNpbkwfKhQ
    TX6CqwjklBHi2kyuXAxL8ZY6HPkCRsHlf8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524155021; bh=IUwLeTONhxb
    WLjcawikI1H7h7EHk2iUrqvqFQUA77Bc=; b=Yzge1g56+AGJLGwzX4g1HaIvmzx
    Q7qzqqr6ywUoSeiKWpz9rzXfz54192FSNKJ8+Xj7sbKuRr9+vlz1RyKUXh28+/Bi
    G7qLdKfQaT8nhd3ih9/OW5iNVYexu3oz+TMq3Ul4KEbUG3KNF/rpgcf6zoLrDXsM
    krPRwfjGRR9JJliZyrmHQDD8qOwSWS5FNKXP1P7t0SgFtlruJUMzE0dadce0Gepq
    OPs4ug2QQ077UQpzIj87+CgmCwnYbtK6f9tHPJ7GgIINL/6gZBFnncn8ueDCn2EV
    6B8+gr5/1gx1pEwyEd4sVE8+BC128REij/7WdxsJU7w/ASJg2uxv9YnI7eg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG7D1Thkr9K96GfqoW6IRQ8ui2qdoXcWTVvlvDz/YtkR1hrK5D+zJrDel9lHXkJBesTq9l6lws9IP1HYuK1EMe1Lr/aI6yNigOMinE7bdiHdqOdSe5LF
    yeXKU2qAZe4Jt2lP/Nf8XvwDwPB1kQIiuE0iphIgcbeLFukqyuDjR+COwoMMnhYCvx+mz3bBHurH8fLDSOHeQ92hGBp439PZ4w4GzXii90Ozrl617EBMighm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=LDBv8-xUAAAA:8 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8
    a=0krFTgGOLx_hOe0wlwAA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22 a=yL4RfsBhuEsimFDS2qtJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeDSQXi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 12:23:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34755 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbeDSQXh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 12:23:37 -0400
Date: Thu, 19 Apr 2018 18:23:24 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 53/61] tty: serial: simplify getting .drvdata
Message-ID: <20180419162324.f46tsdomp4vi67cb@pengutronix.de>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Wolfram,

On Thu, Apr 19, 2018 at 04:06:23PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/tty/serial/imx.c              | 18 ++++++------------

for serial/imx.c:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks Wolfram for going through this
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
