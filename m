Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1269041-1524492857-2-2189901249672108780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524492856; b=mKvgQ31/Vi6XpkO4EVPdEpP/zXrorWEq0aVG3FNwK2n/mh138b
    QE04kn6OP0qnlFqaU1pYFU2DrUjD+o8+TA3ihODG1ZX34dOxXJFgH7Q+3KBnw6fc
    YTp7x2PPSM6uEEQZxC+HRVSH7HKU6DahJpkH/stY90BBJY0OKDQo1h+lkX4m1Gmj
    tsQddLIZWXdT8fb9eqpq4c69l35d5AAFGWc1Qfe2I6igDOJitD3nyNiaP0b44FNp
    GNNZjUfX95PiGVzKHJnWnbUCWIjvwLeBEwQek2fJt6sNL9jHpxFlWWexAAaF4Lby
    SAMYCnebALNrSuwPSe0DlyIEKFanbSpT3akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1524492856; bh=Gri2hwRd0AE8tovL+MUzzpuliPurAA9qts5/Fi55TP
    o=; b=BM4VMyqZZcl9sHx7sk2Mdfs3bWIP7k0eGEDIu9PppvOP9W6p4O1YjdASQ5
    nxeJa+R01FKnAB+9I8zPa/w84p7cHZSChIPbK5YxHv+jQXbmltD6y+lZAd+XO60q
    fUVeWLqF/Zy/icdbfmXwEgn8cNrnkxE8kgg5bceLoQlGRazH8LdKUgi1435MiMOM
    TdPaCpSuJd1JxMJ6nFH+AGtjp8OgrE1WsAgdRxchdxCYeuzOcSdVtgqFw/QZ02e3
    ah9GvSwqOCwe3FGGkcR7gbAHPT+QFbTLJkudXWPn4d4GXCKQwGnlkd+H+XfonjQX
    zUf4nMHeJkLF92KANsOh14SjKFRA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPn/wHAvYKKrXcLBgydAutU2GZ/lQHc191PAymxrnoej/6TJKiTu+UDA3gfN672WEfEqhutxLx9h0peFjUoAPu0BbkjcgjQuCXl4MOs7gRMa429LgoKF
    ZfnQO68UFxLRkQS01F18gmb3GIYPoznyJQ1/aDuC+qIVocKThBytsHBeBpB3OmFMmRr3V3NuMSSP9LwS771roqJEQ19lo6/RiTcwLz+DrixsB+xJ4WV+LR4N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=6LxprBTznkn4I3Ws_C4A:9 a=x8gzFH9gYPwA:10
    a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbeDWOOM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:14:12 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.142]:46379 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755315AbeDWOLA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:00 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleJIrShJLcpLzFFi42KJ27nUWLf45d0
  og30/eSyaF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjGl/t7EW/OWoO
  NC2n62B8SF7FyMXh5DAekaJXTvPMHcxcgA5FRLTZwd0MXJy8ApkSkyftZsFxOYUcJfonvSRDc
  QWEnCTuNz2hhHEZhOwkJh84gFYnEVAVeLb6clgcWGBKIm/JyYyg8wXEXjPKPHp8QewQcwCdRK
  9v9+yQCwQlDg58wlUXELi4IsXzBALDCROL2gEi0sI2EtMf38V7DYJAX2JxmOxEGFDie+zvkGV
  mEvcP9zFNoFRcBaSqbOQTF3AyLSKUaM4tagstUjXyFIvqSgzPaMkNzEzR9fQwFQvN7W4ODE9N
  ScxqVgvOT93EyMwRuoZGBh3MF7e4neIUZKDSUmU1/L83SghvqT8lMqMxOKM+KLSnNTiQ4wyHB
  xKErybXgDlBItS01Mr0jJzgNEKk5bg4FES4X3yHCjNW1yQmFucmQ6ROsWoy3GnraeHWYglLz8
  vVUqcdzPIDAGQoozSPLgRsMRxiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwrxXIFJ7MvBK4
  Ta+AjmACOqJD8g7IESWJCCmpBsYVq0UWuMx9WZ891/oF2+S0MIH+i+dy9nwp+PGg8x6TXe2zX
  aJb916MLbyp/6nz36y7Au/Oh4oefLL7p+TDk84vt6tIi7CKnpG7UHhf9cSFGTuYDvBGHOL5kZ
  Z2jneHxXsTBcO/EWKSCpw8fb7mpkWf2L1M70WyPnuSseFlytqa8gjvlXF+JqVKLMUZiYZazEX
  FiQB8+mFGFwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-180.messagelabs.com!1524492658!78920666!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <627b8dcdee758c2598c6cf68b0ce536d3e557ca4.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:10:58 +0100
Subject: [PATCH v8 3/6] power: supply: Add error checking of psy desc during
 registration
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently there's no error checking of this parameter in the
registration function and it's blindly added to psy class and
subsequently used as is. For example if this is NULL the call
to psy_register_thermal() will try to dereference the pointer
thus causing a kernel dump.

This commit updates the registration code to add some basic
checks on the desc pointer validity, name, and presence of
properties.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index feac7b0..a7984af 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -849,6 +849,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
+	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
+		return ERR_PTR(-EINVAL);
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
-- 
1.9.1

