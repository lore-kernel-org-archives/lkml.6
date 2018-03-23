Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805074-2-4698705926888189124
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
    t=1521805073; b=a1Q2MbMx3Zggbyo0XHSsH6LuC73LWkGL9m6AGilW8RJiJIL
    8y/1G0K/bp2vxJmaM+dr7IeKgJhMU01p4iAExsHdTDYJhp/muBsCEjAFqcglGcI8
    v3t3kijfZQeAopZCAD9Vtvz+y+qQFetzi/aAVVu1j9Fm6UY+hUOx+pgy4ln6Z5Kf
    vxVXkTDmIC6C8AR9Riy1wCOpnb/0tW36HaSBHfSvxIEwKLsarx4Ye6oLbZd1n+m+
    TxmJG0mfCdpgv6ezqiac2HRhXh1w6COE0Jc88BcfJ2gtuBuo9ob9P3pRcvkcSksN
    ILvC+wrgRZ2PwD5EJJcbVq/UXeK4E1kbvzGzMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805073; bh=eTYqsyhQG4RI3K3W5w661591K9
    qddFmKlF1l8EbHxpQ=; b=m0XPNquagsoHJ2OIxrCg2aLvbspNL91vBntGK7AkIq
    ZdyTS19Ecds289BVlwbswt865hCr2lxwMj7CIK+hytHARnEUn4jP3ijwiK/8kJ+t
    aj++mzbxmtxnXVvk1lZVoY5uYGMQ/+llUijUXsF1jCSuyyey5t/HCTjb1LMF+Rn8
    I9AUf5vrWB+thU+vXGes1u3Kr3UcA0jQ4D9IkPUudipt8eQrJ+84/JH5URsvf4AL
    VAcCxaGIsKFBeUdf1UwJci9hOzYLKM59MEXypT0A8KdvEL8FdV0nFhsVjQCOMLKB
    9v1zy6Mg2ypdjoLTXfNVDJQKSBNJUdTtEqTDWuSUnltg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCWLhh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:37:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754384AbeCWKEv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicole Faerber <nicole.faerber@dpin.de>,
        Viacheslav Ostroukh <v.dev@ostroukh.me>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 024/177] ASoC: Intel: Atom: update Thinkpad 10 quirk
Date: Fri, 23 Mar 2018 10:52:32 +0100
Message-Id: <20180323094206.250314243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


[ Upstream commit beb5989a8c6c6867b4e873cca2a66d31f977368f ]

There are multiple skews of the same Lenovo audio hardware
based on the Realtek RT5670 codec.

Manufacturer: LENOVO
        Product Name: 20C1CTO1WW
        Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C3001VHH
	Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C10024GE
	Version: ThinkPad Tablet B

Manufacturer: LENOVO
	Product Name: 20359
	Version: Lenovo Miix 2 10

For all these devices, the same quirk is used to force
the machine driver to be based on RT5670 instead of RT5640
as indicated by the BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Tested-by: Nicole Faerber <nicole.faerber@dpin.de>
Tested-by: Viacheslav Ostroukh <v.dev@ostroukh.me>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -420,7 +420,21 @@ static const struct dmi_system_id byt_ta
 		.callback = byt_thinkpad10_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
 		},
 	},
 	{ }
