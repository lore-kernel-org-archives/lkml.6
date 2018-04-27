Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524838184-2-7388071875406906613
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
    1524838183; b=Ks8R7jTvIK09+WMBzW9jrvMovrCdhUHSaY7IawiQrXj7H/xIc/
    mcDKJ54NTbGiETqJqJWH4BQ5cEH+FK/LUyfnQco8MyLOiIP7vtvJybp+r6SFZoOX
    fhewkp0saSbR4A93cymrF/NkM2QtubIaeQFgk7QS0wtrFY5j03h7E8LXJ1Porusf
    lR4Q2Xunro6QxS5wcyjNWoPNUxsYuhp+rk8l6tSuowQRpit+B/XoB3pS4dZV9rK6
    m0rdMM/9Kv5FOPO3nsMY4AC0EeVYFOgGNUkMMUFv+HnWb59GCQJhZw7JcWUlQExL
    L7RO7mpPmLonVw8IovwgWe05NRey1KMn2BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838183; bh=J9NaCfWMEwZSlM/EOV7al3z9T0ViHE
    zL0Hl+SXIStQ0=; b=kNGqvwwMX62Dx592qlo0VBicL/rvxBlpehK12x7bzB/sVV
    M03jT5RwNQh13iTLzbjQ16qJtflfFdO7IqzY11En+ni/gCGsS9aBW89DbXBuJcRq
    JfTEMv2DfSUCcWjfbTLuw0Lm+kMt5t2a3Le2F/VMTtAzZtlMi5ALuQQsnB8CX/uU
    GHWANwSgR7yzpLKt0+Ct3oACv3tIx9QnTWv27UdPqXXewyh4hQ4xnMNSb2+p+QN7
    IcvaA/zUcRExc+ZCup0abuj+FkkgNYAqbJDpjauU6uWCbWEYtQNQCxUv83ANiKUs
    3Ed1D81TMbDS/QEebOsltBtGfx+A+YbAqWzIrqyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfM+cQmHg4QMWpLGiF7k4lGTn2aE0hfz15kza0mN0Izm7vnIIPMPQMZzMzyI23ZOJR93Q+Ij9oKgrJt4grZRyRYDX1qxQ6JM2h3MHEozKKbT0GwUtWEg6
    3RjwJGb/E1+0jxbdmT9jVqhzJZmdM29J+3bhj4XDx1zBmJZ+3RGyzNTRbWdumonrpZtv6dzHgNN/86xbOGN+gaQnYxuSlQRlI412+3TkI4gyqJvekVHSeqTt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
    a=xGxtC_rEuJLaDEg9WskA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934690AbeD0OJd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934679AbeD0OJ2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C4621864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 80/80] ACPI / video: Only default only_lcd to true on Win8-ready _desktops_
Date: Fri, 27 Apr 2018 15:59:13 +0200
Message-Id: <20180427135737.079225306@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 53fa1f6e8a5958da698a31edf366ffe90596b490 upstream.

Commit 5928c281524f (ACPI / video: Default lcd_only to true on Win8-ready
and newer machines) made only_lcd default to true on all machines where
acpi_osi_is_win8() returns true, including laptops.

The purpose of this is to avoid the bogus / non-working acpi backlight
interface which many newer BIOS-es define on desktop machines.

But this is causing a regression on some laptops, specifically on the
Dell XPS 13 2013 model, which does not have the LCD flag set for its
fully functional ACPI backlight interface.

Rather then DMI quirking our way out of this, this commits changes the
logic for setting only_lcd to true, to only do this on machines with
a desktop (or server) dmi chassis-type.

Note that we cannot simply only check the chassis-type and not register
the backlight interface based on that as there are some laptops and
tablets which have their chassis-type set to "3" aka desktop. Hopefully
the combination of checking the LCD flag, but only on devices with
a desktop(ish) chassis-type will avoid the needs for DMI quirks for this,
or at least limit the amount of DMI quirks which we need to a minimum.

Fixes: 5928c281524f (ACPI / video: Default lcd_only to true on Win8-ready and newer machines)
Reported-and-tested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_video.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2123,6 +2123,25 @@ static int __init intel_opregion_present
 	return opregion;
 }
 
+static bool dmi_is_desktop(void)
+{
+	const char *chassis_type;
+
+	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
+	if (!chassis_type)
+		return false;
+
+	if (!strcmp(chassis_type, "3") || /*  3: Desktop */
+	    !strcmp(chassis_type, "4") || /*  4: Low Profile Desktop */
+	    !strcmp(chassis_type, "5") || /*  5: Pizza Box */
+	    !strcmp(chassis_type, "6") || /*  6: Mini Tower */
+	    !strcmp(chassis_type, "7") || /*  7: Tower */
+	    !strcmp(chassis_type, "11"))  /* 11: Main Server Chassis */
+		return true;
+
+	return false;
+}
+
 int acpi_video_register(void)
 {
 	int ret = 0;
@@ -2143,8 +2162,12 @@ int acpi_video_register(void)
 	 * win8 ready (where we also prefer the native backlight driver, so
 	 * normally the acpi_video code should not register there anyways).
 	 */
-	if (only_lcd == -1)
-		only_lcd = acpi_osi_is_win8();
+	if (only_lcd == -1) {
+		if (dmi_is_desktop() && acpi_osi_is_win8())
+			only_lcd = true;
+		else
+			only_lcd = false;
+	}
 
 	dmi_check_system(video_dmi_table);
 
