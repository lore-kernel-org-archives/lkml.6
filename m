Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517902880; cv=none;
        d=google.com; s=arc-20160816;
        b=PnN5LRILhJCSZioZjSALqmtRLFBy/PN6jQlidvDon7kcBbAsfF8Ietx/JJQEzvdQDr
         y2+lbFNGzC+hw6+jqOh9LC+ZAqeJIUm5sH2XAiJiKRHtBunQwaWslqfD8ZxLKJiFnuSc
         RqMji4zU5usIsjvvSAWAEF239EYmiC/H6k4yBUQBjp0fCHCwp09Xr1a+ianULnAxq+i8
         Jui4PsNBJ3QwTQ7vylZ1S6zLQyytVEsnMyJCYqi+6sq8OT/B3LmCkKi0V9XNJJmXZokM
         bk2owDQiiv7D2Ao0BcplAQeUVpThN9RpycpoFa5tPLx8FZF0toS/fRad53XVJ6/ZZ/I6
         4GUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=DkA8xP23dko0P6AGi3dR2//3FaAir5I3tMKjjipOLf4=;
        b=WkvSrlFGHYxHWG28k0zN2IJGD+bw/aGaRnXtY5VtZ6Dfsb2kayUdQzitmbthPmXn7F
         vha3w+L0uNv/wfOEVjIHlHNpRdP+fTYe5/6YCynzenMgY6ZgPbagmryLbnroBUc+1+fP
         93ymrRGC/JyEnz1EsX+AjaDmqIB6aslv4ybiA2JcX3z4AlVpJU6McBYuxPmeknhFyxnb
         tuuJwR3baDDycZeDss82m1AMT/13LgcpDGgOmmCNIu6u3dtURXoXTD2BBHaGx6zFJ+xV
         t7htdDeP7RdJe933WxHwyVVoqApE97peneWUCfoggyWPbq6fj+9TAjUdP2nWsGhmQfZy
         XWUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tgBuxw1/;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tgBuxw1/;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2276YFiGThB0FTNVQVkI3F6VY2sSg8+QdgK4ZPV1/PtzCh/hQMUjlbmEt+cKuSTGOig6p/iVPw==
Date: Tue, 6 Feb 2018 13:11:12 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 3/3] backlight: adp8860: document sysfs attributes
Message-ID: <4a486ddca7b33844765f6773fd41e91f1fa9b2fb.1517902411.git.aishpant@gmail.com>
References: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636530950975861?=
X-GMAIL-MSGID: =?utf-8?q?1591636530950975861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for sysfs interface of adp8860 series backlight
devices by reading through code and git commits.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp8860 b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
new file mode 100644
index 000000000000..54d61c788b1b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
@@ -0,0 +1,54 @@
+sysfs interface for analog devices adp8860 backlight driver
+-----------------------------------------------------------
+
+The backlight brightness control operates at three different levels for the
+adp8860, adp8861 and adp8863 devices: daylight (level 1), office (level 2) and
+dark (level 3). By default the brightness operates at the daylight brightness
+level.
+
+What:		/sys/class/backlight/<backlight>/ambient_light_level
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RO) 13-bit conversion value for the first light sensor—high
+		byte (Bit 12 to Bit 8). The value is updated every 80 ms (when
+		the light sensor is enabled).
+
+
+What:		/sys/class/backlight/<backlight>/ambient_light_zone
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Read or write the specific level at which the backlight
+		operates. Value "0" enables automatic ambient light sensing, and
+		values "1", "2" or "3" set the control to daylight, office or
+		dark respectively.
+
+
+What:		/sys/class/backlight/<backlight>/l1_daylight_max
+What:		/sys/class/backlight/<backlight>/l2_office_max
+What:		/sys/class/backlight/<backlight>/l3_dark_max
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Maximum current setting for the backlight when brightness
+		is at one of the three levels (daylight, office or dark). This
+		is an input code between 0 and 127, which is transformed to a
+		value between 0 mA and 30 mA using linear or non-linear
+		algorithms.
+
+
+What:		/sys/class/backlight/<backlight>/l1_daylight_dim
+What:		/sys/class/backlight/<backlight>/l2_office_dim
+What:		/sys/class/backlight/<backlight>/l3_dark_dim
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Dim current setting for the backlight when brightness is at
+		one of the three levels (daylight, office or dark). This is an
+		input code between 0 and 127, which is transformed to a value
+		between 0 mA and 30 mA using linear or non-linear algorithms.
-- 
2.16.1
