Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2244Q3ZNcjHS9EE/Np43BeW5tTaM/3xlHZ+BIL8qMU+uA0z4gj6UPmKF/1z28pFoayiT1tMr
ARC-Seal: i=1; a=rsa-sha256; t=1519411028; cv=none;
        d=google.com; s=arc-20160816;
        b=jV7b41mB8lFct6Q+nfuJYv0DKeCkbHP9gygm5XcQO+r8i3byPvb36Bt1Fwr6Hdd3qc
         rnuJphcvft+Z3NlrmXCQZ4VOhfbW0JtSPXVq7MKwJ1do/6xhygaC5AkZXNi0NyRl8f9s
         kUfpwG9//IxRbEEr9m8GgDmikuRNLClCGVMUlbYuyenX5UU93lw2EONvzTZDjndhy96w
         l4YZePl/SVQ4wl5zWYDDvDA8InHRLfwFzxoOo5dgMW3ke5v04Dp83cN5wrHPw0cN2gR9
         8NIvU6fyA8GA8CDQfxVqrzSFmXFxPZpxFHpXgqGwMaZ4J9Fw6CuKTS4uMtYdeFsR4Gpv
         Utvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z1dF7lHH7V5uHRoXrFxswuR3y42g/h/tigIdn49nVYo=;
        b=x92/VhOuWzOCDC06Gk6eMrUunY1sGMBA/hGUnmXyqtB/9QqP/F9w+QkgB6KdAKY2RE
         s3I2uea9X93pOI9hRCH6yhuuADCsfaNAhFYr5SJP8a3C/FwvtjzsiVpGl6UD1TZlYJ4c
         tFAlm2ekDgd20CZy5EXt0mdH2xS6lDq39ZReuRlN524XymnwN3N2YZ2UCMFYI5aZWe7m
         AaU9x9jzBBx6jtRhGJRZw0K55+mwy2i8fHMcito9P4liMb6dhDWfZielJzp/k3+o+tmT
         Vm2j6b4704ot2p5icxML2Xc38V8Ak42/l1lF+kuEUWACDtm6Y5zl9mEOnjJsjanf4LGZ
         L+Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4.4 096/193] video: Use bool instead int pointer for get_opt_bool() argument
Date: Fri, 23 Feb 2018 19:25:29 +0100
Message-Id: <20180223170341.017478741@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217939420300046?=
X-GMAIL-MSGID: =?utf-8?q?1593217939420300046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

commit 206fc20598157ce15597822cf01b94377e30075b upstream.

As the function name already indicates that get_opt_bool() parses
for a bool. It is not a surprise that compiler is complaining
about it when -Werror=incompatible-pointer-types is used:

drivers/video/fbdev/intelfb/intelfbdrv.c: In function ‘intelfb_setup’:
drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argument 3 of ‘get_opt_bool’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   if (get_opt_bool(this_opt, "accel", &accel))

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/intelfb/intelfbdrv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -302,7 +302,7 @@ static __inline__ int get_opt_int(const
 }
 
 static __inline__ int get_opt_bool(const char *this_opt, const char *name,
-				   int *ret)
+				   bool *ret)
 {
 	if (!ret)
 		return 0;
