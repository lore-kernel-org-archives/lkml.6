Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803895-2-11567425548609710558
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
    t=1521803894; b=S5MepYy10wnmxl3WARMVXg2PdijDLis1RyaQsnZd2EJsJex
    KU8G+04RzYX3Q1c6nh9ZZ+CoWx/lMfwkKa2MI5Xdg+pgB8E/f1gwH9MMKKGUn84t
    4dO3FSxe6cOfPmPg798m1VyW6F4jAtQvAf7jj98jj4C0sB/XhwNSUvoYet27B6W+
    umYVL2qmKSo3CpY+dMoMJzFkNx5VuEmVs9Dmp0vMVDEy4rwmXfsvX9tMFk2Ex7rD
    2Vlngw9jCv76Xh/AzULBMUvOOGCUGsHwAf9tHtEeSy0NMmMb7oosAg0kO+22mWYE
    JpU+wPoqaAhM4Vdp43kYNpaOTOKU4AexicPWpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803894; bh=JuiymNDxU5M8ga0EDMqmFC5jCo
    fQcQ9/9X+bEmwGc0w=; b=R0NuAI2VmALuukXn1MS2iiEvNubDkHPZugdPJjOIHC
    EOq+KLOm88JMA4HKti5jIakL7hVjb0suS7Q49qog0cTeic/10gn5WACI+m7P27Ze
    urg+0DjEohbePUzbJoHdXwd03TxEL79avJyiK6uSgS8ksFgmZGVclKJJ4EVft/vk
    P4B8rXkoFBZSTeAZBVH80c+qcpOnbYaWNX0bNqBCgSkSM1Yt5Bt/YvbhwPdi7oda
    kU12xldvN9N9I1Vz1nnuJhupvdtcyEJhom/Om/K8k4lXGoFtCjowvpBKto5g8tSk
    8i07JxXzvFszEZQio0TW1yO7ylBdoOhfDRTSi1Lmai6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755726AbeCWKJP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeCWKJM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/177] platform/x86: asus-wmi: try to set als by default
Date: Fri, 23 Mar 2018 10:53:45 +0100
Message-Id: <20180323094209.568964254@linuxfoundation.org>
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

From: Oleksij Rempel <linux@rempel-privat.de>


[ Upstream commit e9b615186805e2c18a0ac76aca62c1543ecfdbb8 ]

some laptops, for example ASUS UX330UAK, have brocken als_get function
but working als_set funktion. In this case, ALS will stay turned off.

             Method (WMNB, 3, Serialized)
            {
	    ...
               If (Local0 == 0x53545344)
                {
		...
                    If (IIA0 == 0x00050001)
                    {
                        If (!ALSP)
                        {
                            Return (0x02)
                        }

                        Local0 = (GALS & 0x10)    <<<---- bug,
                                                    should be: (GALS () & 0x10)
                        If (Local0)
                        {
                            Return (0x00050001)
                        }
                        Else
                        {
                            Return (0x00050000)
                        }
                    }

             .....
                If (Local0 == 0x53564544)
                {
		...
                    If (IIA0 == 0x00050001)
                    {
                        Return (ALSC (IIA1))
                    }

                  ......
                    Method (GALS, 0, NotSerialized)
                    {
                        Local0 = Zero
                        Local0 |= 0x20
                        If (ALAE)
                        {
                            Local0 |= 0x10
                        }

                        Local1 = 0x0A
                        Local1 <<= 0x08
                        Local0 |= Local1
                        Return (Local0)
                    }

Since it works without problems on Windows I assume ASUS WMI driver for Win
never trying to get ALS state, and instead it is setting it by default to ON.

This patch will do the same. Turn ALS on by default.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |   13 +++++++++++++
 drivers/platform/x86/asus-wmi.c    |   12 ++++++++++++
 drivers/platform/x86/asus-wmi.h    |    1 +
 3 files changed, 26 insertions(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -120,6 +120,10 @@ static struct quirk_entry quirk_asus_x55
 	.xusb2pr = 0x01D9,
 };
 
+static struct quirk_entry quirk_asus_ux330uak = {
+	.wmi_force_als_set = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	quirks = dmi->driver_data;
@@ -422,6 +426,15 @@ static const struct dmi_system_id asus_q
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "ASUSTeK COMPUTER INC. UX330UAK",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX330UAK"),
+		},
+		.driver_data = &quirk_asus_ux330uak,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "ASUSTeK COMPUTER INC. X550LB",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1109,6 +1109,15 @@ static void asus_wmi_set_xusb2pr(struct
 }
 
 /*
+ * Some devices dont support or have borcken get_als method
+ * but still support set method.
+ */
+static void asus_wmi_set_als(void)
+{
+	asus_wmi_set_devstate(ASUS_WMI_DEVID_ALS_ENABLE, 1, NULL);
+}
+
+/*
  * Hwmon device
  */
 static int asus_hwmon_agfn_fan_speed_read(struct asus_wmi *asus, int fan,
@@ -2120,6 +2129,9 @@ static int asus_wmi_add(struct platform_
 			goto fail_rfkill;
 	}
 
+	if (asus->driver->quirks->wmi_force_als_set)
+		asus_wmi_set_als();
+
 	/* Some Asus desktop boards export an acpi-video backlight interface,
 	   stop this from showing up */
 	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -45,6 +45,7 @@ struct quirk_entry {
 	bool store_backlight_power;
 	bool wmi_backlight_power;
 	bool wmi_backlight_native;
+	bool wmi_force_als_set;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
