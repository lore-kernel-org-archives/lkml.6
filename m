Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225XAv4tJKeV3WRhBis2ng+IXmaurVN1H92EbTIe4Or8RqfYLW7srQY+2K/5WPZafrJSHPqI
ARC-Seal: i=1; a=rsa-sha256; t=1519411597; cv=none;
        d=google.com; s=arc-20160816;
        b=Nqo0N66fINfMdA0HI/jgW0Ur1hylwFTMeWKm7WCf//VUpoF6w6MJhwoh+VC08WLu2d
         oXjgfGhe7QM576FdBddrATk05xzVsn012glNAPwRdzVlH4Oa9kAAYhcnNn9g385AiD9r
         tH8dzkR6l0xypo3GmpzDmEsnl1YW87yrF9CeatahA3zXhdA/ULJFoK82QcTaZcGIRA1G
         VSAbBramwiZF80c0YaYOgoEL9Liq4eA1QdPUEO8HUyLnBBDjbpVnRKCiIxPorx8S3Wyq
         fiFqrZNCC2/ujdQpDTvkjoASOtQr3HlkbDpq2JDanWzGgHAJWGxFGJ6fpOGTRsNXikvz
         pU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NL2MMNFO9y0EIhOPW8rnaiCmrRytHaJHWZtAdBQCIEw=;
        b=laHZvxNDMFnQ2q2klxvQlBpGL9m2nI7n5nF5VaI36Mwuqym6wJpfR/Nxwph/DMrDs+
         TKRJ6AuWufdoTeTHnu7lc+STHBgaQPWvz8NOgSsNMDchoXIry65bdMaWHdbgplgIrshw
         zWRq+yeNxX4RRVFUvxmJr8zYiGAr2BQ4sJOLtn628LQhwPUz12pWsKpEfxHm85oFvX3C
         SxkfwgE10N6J7zQuXKrqMj5IV4XZppOqYKORprhTnTetsXFt87bmgC897Wg0Z7HYe8fE
         EQdcy8ajWzW2ZZtEgKHqySgWkwF6t8xeumebBbaMz4LG4kDGKN7GWGRfMJnHDEFi7RaG
         RS7w==
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
Subject: [PATCH 4.9 098/145] platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
Date: Fri, 23 Feb 2018 19:26:44 +0100
Message-Id: <20180223170737.513014623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217854160762387?=
X-GMAIL-MSGID: =?utf-8?q?1593218535043040748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
