Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2483313-1525767104-2-17898696487687951522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525767104; b=OczuRCDUAvPhQtR7keI3VXy2zkWShZrCjwRwNA/K9FmzJseuIV
    L07W81oUuL7cZviTG/HPyyfzzvE2PmUNRZwZC8Oy9rjlXbnyAyY8R99sUx5cQ6m+
    HoWOU80AQiAyaswtRGCd0Lf9H0cmarVb2xB9xbNxnNm28+9NgnQcsgJzBFgY1nxK
    i9M04oHwqxhEr4ZQCjeX0N0JQwn3ZB8DDnko4uYeiXAEk5fGedOKPsv0qjC94oKb
    dm1jck/Ka0K7qs5MmwkjCrMvb783lUjSnJjdzaLJh9yh2y4f67Wxu1LNEAkdniqL
    PkWMWLo352eGi1c+vQL89drgvC4oo9DaSn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767104; bh=KeSeHYyJFFqlt5/QUp8LLz4N1zz6OO
    x3xXP8nfi3Zks=; b=L0luRvMc6WOmuD2Eu6XhfkhZPYUZthsGTm8BMlgY/LF9GF
    PWluoHQf+V79HkB7PJh4UwDsh1Ox92ysq9znlNf4ueAMC7IMesPfUhUVWh/uADqe
    lAxi66xOfix+wkO/F7MZ6+EzE29odhnc8xyIWtbj4a0PEnrsoTyb0NIyShX7L8hd
    uvjIj+DzfUne6F8VAcVmZ7S38Mgl4wznvp5BkPJIez8fAAizVtzotVTQI3E7w4IS
    AYloshXwsPYWhJ3FPtm8Qlk9ZbcB8EBXWdn7bWoTYSoi4oGI+tYXHUVgdGKGa+cr
    fOnSAZU7QYmRnO9qQTCh8x0wpr+a7TWcU58p6lyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FK8IkH0v x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FK8IkH0v x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEHYyQSQGTexcpxeQs5QGrQ5sQEiqrDOG+tEb9OLJNzk397OX/mKOOQa8u+5JXy9+mwy0k2XCRLtJ1USpkVQQ7bAwJSJ51HCAcoiBvDf1XZVOX8miumZ
    NU14WlyOIJbAs7jxdXXeUKyZEFFtQuy/OlL4LSiY1D7Ay1NCAWSjE0lt/Nw10/Z+yDkKPOTSIfCHjWG92GZGiGDcRgdEXyoRDWRpXoD79D3YBbPZJYYGpbIM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=UPSWH-VeF1jkfTB6omMA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeEHILk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754183AbeEHILj (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:11:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 01/52] ACPI / button: make module loadable when booted in non-ACPI mode
Date: Tue,  8 May 2018 10:09:59 +0200
Message-Id: <20180508073928.253312412@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit ac1e55b1fdb27c1b07a0a6fe519f1291ff1e7d40 upstream.

Modules such as nouveau.ko and i915.ko have a link time dependency on
acpi_lid_open(), and due to its use of acpi_bus_register_driver(),
the button.ko module that provides it is only loadable when booted in
ACPI mode. However, the ACPI button driver can be built into the core
kernel as well, in which case the dependency can always be satisfied,
and the dependent modules can be loaded regardless of whether the
system was booted in ACPI mode or not.

So let's fix this asymmetry by making the ACPI button driver loadable
as a module even if not booted in ACPI mode, so it can provide the
acpi_lid_open() symbol in the same way as when built into the kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[ rjw: Minor adjustments of comments, whitespace and names. ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/button.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -635,4 +635,26 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-module_acpi_driver(acpi_button_driver);
+static int acpi_button_register_driver(struct acpi_driver *driver)
+{
+	/*
+	 * Modules such as nouveau.ko and i915.ko have a link time dependency
+	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
+	 * capable kernels booted in non-ACPI mode if the return value of
+	 * acpi_bus_register_driver() is returned from here with ACPI disabled
+	 * when this driver is built as a module.
+	 */
+	if (acpi_disabled)
+		return 0;
+
+	return acpi_bus_register_driver(driver);
+}
+
+static void acpi_button_unregister_driver(struct acpi_driver *driver)
+{
+	if (!acpi_disabled)
+		acpi_bus_unregister_driver(driver);
+}
+
+module_driver(acpi_button_driver, acpi_button_register_driver,
+	       acpi_button_unregister_driver);
