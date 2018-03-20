Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-341551-1521518881-2-3100286090267015407
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
    t=1521518880; b=cYPZQw4Stian2ydWvIAhrJGgzs2iRs7pMUUMstTVtJs0Pw3
    fBRT8Eck1pmxO2sh+AVkAloqHGY3AAkIZ2rMMBanPpnVXlA2QDlye+bKE1p60n9N
    vnuwGmjqHpmA9E+gzphmFASrRdG3hQTJw40nnHjymCMeBt5nLfQa/4HQiER1VeD4
    G14W2ugoNdim0dc/9E85tKhpDsHHnxlwXMR4E3UWLUvFnDkREK4/y0lIPGQceuKa
    WW1ANptYIroiWRidPsxs11LKdDTQ5WSjhYMr/5PmcYXGYq3XRPsH1n2B7oH6EUHd
    hq4THfaikGrDBfsL8qOiEeFcVXQwhWPs8GERxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521518880; bh=VZVEWO52wE61vwe9wyGVcP0oMY
    bln9Ad3dKCKiDsr2E=; b=qp6tbwhx+kRYqwxsfm9oZx/fwLoEnuIQ2DpGKsmjgX
    7/wDncDDK5jNoimfeeIqAhLozYg7xUSJa8DuZT4r/ERzAcB3EkHmNH7JIV/y2Gn7
    cV3m9sJDxYKV5vDpnn9Z7+jzo29XjHXjknmMWfuNAXAN2GgGhxoJNhOl3yaeMRs/
    KMcY+d0ylaixQjre9KznBZsN5nJXN2Hs6Kanazs2NrsXfgp6botRZi6vYAazFhXU
    WQI4sRhNz1NLLA2VDrAl6ISnmWwSI+goJBfEJZRjPqaA50lmKODhSZnMcOle5/dP
    gr/QqMj4ItTxGSe25JXj4tdBMjEccNmc5Biptzqc+6Yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=BS4LWqS+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mX+Ui2wy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofhsphejsedttdertdertddtnecuhfhrohhmpeffrghnihgvlhcuffhrrghkvgcuoegurhgrkhgvsegvnhgulhgvshhsmhdrtghomheqnecuffhomhgrihhnpegvnhgulhgvshhsmhdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddvhedrvddvjedrudehkedrudejieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeiieeinecuvehluhhsthgvrhfuihiivgephe
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=BS4LWqS+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mX+Ui2wy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofhsphejsedttdertdertddtnecuhfhrohhmpeffrghnihgvlhcuffhrrghkvgcuoegurhgrkhgvsegvnhgulhgvshhsmhdrtghomheqnecuffhomhgrihhnpegvnhgulhgvshhsmhdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddvhedrvddvjedrudehkedrudejieenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieeiieeinecuvehluhhsthgvrhfuihiivgephe
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCTEHp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 00:07:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41066 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTEHn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 00:07:43 -0400
X-Google-Smtp-Source: AG47ELsqnouB8xOvA0Q5UU+jadmuv1PMkr96DJXHv2q/znBzi9RD2ysqY78d57FrvSO8qYhklldBxw==
From: Daniel Drake <drake@endlessm.com>
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, chiu@endlessm.com, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] ACPI / PM: allow deeper wakeup power states with no _SxD nor _SxW
Date: Tue, 20 Mar 2018 12:07:35 +0800
Message-Id: <20180320040735.13025-1-drake@endlessm.com>
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

https://phabricator.endlessm.com/T21410
---

Notes:
    This should be considered for Linux 4.17 to give it a decent amount
    of testing time before release.
    
    v2: fix unused variable warning

 drivers/acpi/device_pm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index c4d0a1c912f0..3d96e4da2d98 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 	unsigned long long ret;
 	int d_min, d_max;
 	bool wakeup = false;
+	bool has_sxd = false;
 	acpi_status status;
 
 	/*
@@ -581,6 +582,10 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 			else
 				return -ENODATA;
 		}
+
+		if (status == AE_OK)
+			has_sxd = true;
+
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
@@ -599,7 +604,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		method[3] = 'W';
 		status = acpi_evaluate_integer(handle, method, NULL, &ret);
 		if (status == AE_NOT_FOUND) {
-			if (target_state > ACPI_STATE_S0)
+			/* No _SxW. In this case, the ACPI spec says that we
+			 * must not go into any power state deeper than the
+			 * value returned from _SxD.
+			 */
+			if (has_sxd && target_state > ACPI_STATE_S0)
 				d_max = d_min;
 		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
 			/* Fall back to D3cold if ret is not a valid state. */
-- 
2.14.1

