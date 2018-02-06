Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517902833; cv=none;
        d=google.com; s=arc-20160816;
        b=uliJPruRg9cTSMRglrBdQPmaa9qaqCxhwcTCf1WT1rOz7Zv75PmmdXs3scxwt07nSM
         +So8dza4cPqy6zDCW7L69/LB+QCxJohb3CaR9vSMCurygIvSMTUHVNQKa8V4ILRx6k50
         7k4Wt4MahUIvMQX4+oqEsoAvUosus8qIxi6rMNG5xEVx+cFLYngZa26T9BPx5kLSk5B3
         afga7LJVPwWakqwNrsOe+Shp3yNQSF5KZ1c+KFBOPGefi85Gb4qUlMeD/NWS4xX0ex3W
         V2LeGO98nbIMM91MYPJqGW/7w3GHpLpfasHmGLA0JbXCfYiTul47lGk7wGQlFsBYZQG5
         PH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vyFtUJFwfAj//dKdEF6adtYbiZd+eEtOYYVQbGeWTdQ=;
        b=LY2hiqxNOBgW3b9YtoE9Tm9oNDiwMcOguxoryW0vUeR7sTIDWPRrif7l0RY0JcK6Oj
         lVyK93CxK7L8HCuAAvEkadef8QzT0QYiJKuDHBrOQA6ZrEomW6ZKQWDqeYNGy/ntsA4t
         0XyrQWcXnEwxNh3rRy5JJfsJgqNJaVp/fBxzOSuP3Pvs3jTNMYsHJYtTs33AEWJGxwn1
         44MS94z+Rz1KaIHuNf2Wf6B0ARUDtUpT5RpEUkIfPAQ4Gs1BBWbYrnbeltvTjHXA44Ub
         C0Lzv+UNEQA1bN9bQd9HG8GuKIonD6pl34xoWqoN0lce8eReHLdRo4Lz20DPLeYPanBy
         LtZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bxB5V0Ov;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bxB5V0Ov;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2272GIyWfivks8NY5uDS+tMIfz+lDOplEeKnKsxRMfUKo5x3/3gFf91QqBUWo4EYCY7kMYmwyQ==
Date: Tue, 6 Feb 2018 13:10:26 +0530
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
Subject: [PATCH v2 2/3] backlight: adp5520: document sysfs attributes
Message-ID: <dfaf338847058807a8b897bd4e555b6a47efeece.1517902411.git.aishpant@gmail.com>
References: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636481965855286?=
X-GMAIL-MSGID: =?utf-8?q?1591636481965855286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for sysfs interface of adp5520/adp5501 analog devices
backlight driver by reading code and looking through git commit logs.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../ABI/testing/sysfs-class-backlight-adp5520      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp5520 b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
new file mode 100644
index 000000000000..34b6ebafa210
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
@@ -0,0 +1,31 @@
+sysfs interface for analog devices adp5520(01) backlight driver
+---------------------------------------------------------------
+
+The backlight brightness control operates at three different levels for the
+adp5520 and adp5501 devices: daylight (level 1), office (level 2) and dark
+(level 3). By default the brightness operates at the daylight brightness level.
+
+What:		/sys/class/backlight/<backlight>/daylight_max
+What:		/sys/class/backlight/<backlight>/office_max
+What:		/sys/class/backlight/<backlight>/dark_max
+Date:		Sep, 2009
+KernelVersion:	v2.6.32
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Maximum current setting for the backlight when brightness
+		is at one of the three levels (daylight, office or dark). This
+		is an input code between 0 and 127, which is transformed to a
+		value between 0 mA and 30 mA using linear or non-linear
+		algorithms.
+
+What:		/sys/class/backlight/<backlight>/daylight_dim
+What:		/sys/class/backlight/<backlight>/office_dim
+What:		/sys/class/backlight/<backlight>/dark_dim
+Date:		Sep, 2009
+KernelVersion:	v2.6.32
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Dim current setting for the backlight when brightness is at
+		one of the three levels (daylight, office or dark). This is an
+		input code between 0 and 127, which is transformed to a value
+		between 0 mA and 30 mA using linear or non-linear algorithms.
-- 
2.16.1
