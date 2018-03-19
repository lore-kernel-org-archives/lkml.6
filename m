Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2207741-1521444594-2-6208841054555603056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521444593; b=hj1idnoup7mkD03VH1qd/sU/LPA2hW2yuRaOPmsGYY/BlIc
    b5o2TscBamSFYYc364rKDX7B9GrfEx0VZDVPhHn+HfOT83alN6RouijbBnKJKJD7
    +HhAkVknvGvwSPa1e0D97+c6Pr8Hg8Drpa9Nz8Zll9NIBEHLn33yN3aboipIDwm+
    1qe5zaNPo3hYEcXoAuh8i3XJUMf2EyNjYYsz0DupMdSt38kYgJfBlUrbLmpPT87u
    eLtwTmsic49zYskVKO+cpa2G72gd88MKKJjYd9+/9LpEdtc7fXuioWLHcbr+bips
    dUM4YX3vJjh/IoTJDYjEeEY7w3li4+oBrOOVoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521444593; bh=3acWOIhv8hZDWlRGv+9RxjbPUf
    KdV4+6Of/z33uv+3g=; b=Acl/6H1iNu4pJRYh5JbjVdF6/1KsAZX5cPA/h1ALN2
    PSIjohsJYj8lhcN3ZwRxdkJ4uGYAkQSgVcgUjw85t4v0XrxRewTzOFpUCRcxuG0y
    Qxw1mU+st4/M48Ayem8qywdepoeNT3+lZO0m4auYG9gdGTnz7O7E3VxL+vAkAlEn
    gvEvUn2tjPILgqypR5n7vlsMD0h+eEwwQzWK1UJbnf1SEuVtFYUE8mN7FpTislie
    7IkkzW2ZAxQdeCDBle+sNwPPAE6/ykJ2KxFEVKK04njJqRH2O1lq+CBw00gdKmx8
    611ReFM0PovfCHDBTdFnSS9H5HNASzXcJsfhWAzIiuOw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=Z+OsGFCi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoshhpjeestddtredtredttdenucfhrhhomhepffgrnhhivghlucffrhgrkhgvuceoughrrghkvgesvghnughlvghsshhmrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddvhedrvddvjedrudehkedrudejieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeiheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ROsyKxIK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=Z+OsGFCi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoshhpjeestddtredtredttdenucfhrhhomhepffgrnhhivghlucffrhgrkhgvuceoughrrghkvgesvghnughlvghsshhmrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddvhedrvddvjedrudehkedrudejieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeiheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ROsyKxIK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbeCSH3t (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:29:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37185 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeCSH3s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Mar 2018 03:29:48 -0400
X-Google-Smtp-Source: AG47ELtv651Jsb4IfYl0WPU2R0ma6U8ZLICuxXbnler9tBDb/lw51WZ9Jh7iE8nrnobCO7ZHqoymyQ==
From: Daniel Drake <drake@endlessm.com>
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, chiu@endlessm.com, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH] ACPI / PM: allow deeper wakeup power states with no _SxD nor _SxW
Date: Mon, 19 Mar 2018 15:29:41 +0800
Message-Id: <20180319072941.22767-1-drake@endlessm.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

acpi_dev_pm_get_state() is used to determine the range of allowable
device power states when going into S3 suspend. This is implemented
by executing the _S3D and _S3W ACPI methods.

Linux follows the ACPI spec behaviour in that when _S3D is implemented
and _S3W is not, Linux will not go into a power state deeper than the one
returned by _S3D for a wakeup-enabled device.

However, this same logic is being applied to the case when neither
_S3D nor _S3W are present, and the result is that this function
decides that the device must stay in D0 (fully on) state.

This is breaking USB wakeups on Asus V222GA and Acer XC-830. _S3D and
_S3W are not present, so the USB controller is left in the D0 running
state during S3, and hence it is unable to generate a PME# wake event.

The ACPI spec is unclear on which power states are permissable for
wakeup-enabled devices when both _S3D and _S3W are missing.
However, USB wakeups work fine on these platforms under Windows, where
device manager shows that they are using D3 device state for the USB
controller in S3.

I assume that the "max = min" clamping done by the code here is
specifically written for the _S3D but no _S3W case. By making the
code true to those conditions, avoiding them on these platforms,
the controller will be put into D3 state and USB wakeups start working.

Additionally I feel that this change makes the code more directly
mirror the wording of the ACPI spec and it's associated lack of clarity.

Thanks to Mathias Nyman for pointing us in the right direction.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: http://lkml.kernel.org/r/CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com
---
 drivers/acpi/device_pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index c4d0a1c912f0..b945e37bcac0 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 	unsigned long long ret;
 	int d_min, d_max;
 	bool wakeup = false;
+	acpi_status sxd_status;
 	acpi_status status;
 
 	/*
@@ -565,8 +566,8 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		 * provided if AE_NOT_FOUND is returned.
 		 */
 		ret = d_min;
-		status = acpi_evaluate_integer(handle, method, NULL, &ret);
-		if ((ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		sxd_status = acpi_evaluate_integer(handle, method, NULL, &ret);
+		if ((ACPI_FAILURE(sxd_status) && sxd_status != AE_NOT_FOUND)
 		    || ret > ACPI_STATE_D3_COLD)
 			return -ENODATA;
 
@@ -599,7 +600,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		method[3] = 'W';
 		status = acpi_evaluate_integer(handle, method, NULL, &ret);
 		if (status == AE_NOT_FOUND) {
-			if (target_state > ACPI_STATE_S0)
+			/* No _SxW. In this case, the ACPI spec says that we
+			 * must not go into any power state deeper than the
+			 * value returned from _SxD.
+			 */
+			if (sxd_status == AE_OK && target_state > ACPI_STATE_S0)
 				d_max = d_min;
 		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
 			/* Fall back to D3cold if ret is not a valid state. */
-- 
2.14.1

