Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5g5Ys28Rr8mnlRWTEJRtgy35f4COmdvOjKpVB5CXB49O8acrvua1AgX1NVMAAqfXf0NNT
ARC-Seal: i=1; a=rsa-sha256; t=1519410947; cv=none;
        d=google.com; s=arc-20160816;
        b=lJBCwVNDKTn8AFPUEJWljrHIZbH/0b4iFEjHl8/Zh+Ri5KUFwn4vdUYcaEtP/0RMKy
         tOVTjcPhv0zTL8FIhdsUzf2TqGyCDRpHfmhceSySRP+ag90Rn8Klu2f+2K2cnyb6CGfl
         TpuoONcbycSi8X+TPqvaVLarouP7TFrweekUwUy4nnP5sIXBlyS6YjCet0KJF99aRRe8
         EDiCCegmuSCLDF55e1c1AM3XUXfy6nmHWgNPZwwxpHwGDjXMTkKvbazbnWxSP9WOKoap
         IjIhHe6DZoBfAlJs0YHd8Lllboihrh1oTVf+KxQedSPVmOrDwv2lDMX5DwtM4SjpVWRK
         vdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VyQkwHweMUuNzE3yp5bNVvuGD4+542j8CmnhtkdXN8M=;
        b=n0OqCQiNB53NKRutfgXdIICehehPVbLbI+NTlDaRhL+rCV2WulPnH7XpB+z+JaTPEP
         /PsIbWAA6COfK+wBipSM2/TTktA4MmVZwfG4gw+V6rbT9jVnsEsdm54GaLs5WRwQ+Kq6
         o5QHaUoeaQl1PEcUHDzfvw9Lzj6U7bq3zuO75GX9EOQBj4D9BI/KmD3ys3xR/S4x6jIe
         mG39LuXtUJffp7Tm/W4OR7v7gLl2UZzePVo8MCCN3+CevUQTK0Iji0miZ3KYxMuVXCnZ
         WhhvFZgmxlzuNje19s/r7aExYyDOyEPktRQqPs9sK05y0oI1dr4CKpH/UcCb7lhQtYQC
         K7rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Darren Hart <dvhart@infradead.org>,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.4 066/193] platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
Date: Fri, 23 Feb 2018 19:24:59 +0100
Message-Id: <20180223170336.309656182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217854160762387?=
X-GMAIL-MSGID: =?utf-8?q?1593217854160762387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit b4aca383f9afb5f84b05de272656e6d4a919d995 upstream.

Fix:

  drivers/platform/x86/intel_mid_thermal.c:424:12: warning: ‘mid_thermal_resume’
  defined but not used [-Wunused-function]
   static int mid_thermal_resume(struct device *dev)
              ^
  drivers/platform/x86/intel_mid_thermal.c:436:12: warning: ‘mid_thermal_suspend’
  defined but not used [-Wunused-function]
   static int mid_thermal_suspend(struct device *dev)
              ^

which I see during randbuilds here.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_mid_thermal.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/platform/x86/intel_mid_thermal.c
+++ b/drivers/platform/x86/intel_mid_thermal.c
@@ -415,6 +415,7 @@ static struct thermal_device_info *initi
 	return td_info;
 }
 
+#ifdef CONFIG_PM_SLEEP
 /**
  * mid_thermal_resume - resume routine
  * @dev: device structure
@@ -442,6 +443,7 @@ static int mid_thermal_suspend(struct de
 	 */
 	return configure_adc(0);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(mid_thermal_pm,
 			 mid_thermal_suspend, mid_thermal_resume);
