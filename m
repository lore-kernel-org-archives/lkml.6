Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274Nop/Ur9pqarjGVNtUdPzmbqXpAGRwfJnc5vhEmuTgvoOQP6mJ4DAgjaZJSQx7b2M9F10
ARC-Seal: i=1; a=rsa-sha256; t=1517591736; cv=none;
        d=google.com; s=arc-20160816;
        b=z0pYbL4H5f8GP9PEoYO7i4JXO+u+UmCi4Fua6HucRQhDVKAFI1Os4LsKvtk/EDtQ51
         USVUPuZt+2MNj5beTg1mT7AwBu8FGIapelt6WBvtnJ+Kk/LPLDaoYQKIhVLZjfj4DUd3
         dud1fX0SkKNsc9BYWDUtqieBp1hIXxSi5uLCTB5qZl1YEhYji49pUngn9XFaHL6PG+Za
         4V7iiDOeHl5UpIKPNAdfAX0tNdjPWqsLYAB+5HG1S54Fb98N94YsOCcztRhF+Cd8u7Ms
         Hgh8CLa+4w9PjBtsn7nTPMxpMO2qCFrqiEGDBHPay+V0Dtj0RSxTdiOmQdGyBb1aogIM
         cI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1U0GtRJ/0LjRBUyHExnxQDOSIh52Z1oDYo3MBlScp5k=;
        b=wPeEDF2w5NpyXgL/xztmgw2j5ci93kCUKDic+KoHx/yiu6/ZG/lbK4Q2WW2yIss6pZ
         KPldJaYow4AR5QK5Ogzsag4zr0VNuQUggDdu5k1iYYqFZ3/dROdxo91eyqPBRoRMLLdN
         E/uR/DUKlmQSc3rrXraZwJvPvqWktij1Yy+UeNZ1sfqidTks3Dr8xz8BCKz/t3J15wF2
         wIP7gzoAhUgQDaRQTYOPU9fm+PqqkjeMO9mHSXl0X60NsO094jsQGRm3mSdS/kz8h0ze
         at8Gnq0rR75y7febCAB45oIPyZ3LvwtsRlRJE6Ar2DTkBrd7nEHFd28sFyQRQXCUWzh+
         EucA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.15 18/55] power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:58:36 +0100
Message-Id: <20180202140828.074187740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309284971476790?=
X-GMAIL-MSGID: =?utf-8?q?1591310272137310618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 348c7cf5fcbcb68838255759d4cb45d039af36d2 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/zx-reboot.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -82,3 +82,7 @@ static struct platform_driver zx_reboot_
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_DESCRIPTION("ZTE SoCs reset driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL v2");
