Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuype59/JDHVG1Pkmq2VdhXAtR/Kl4PSzKF7HFGZUDho0//VjlSp4+OqxZC4K/jISyE3Z9m
ARC-Seal: i=1; a=rsa-sha256; t=1521482990; cv=none;
        d=google.com; s=arc-20160816;
        b=I/cDnGibXfF3SY/j3QiyjjYsBMblD7F8/Ecb0Hc/EjuueeR41bazzEKQjB5Q2kDYDe
         +CJ6dzGNtfPFFFNtdEPpN8bTI2EGRStKmgnXUrRsrEKWmVd1QwofVuMVmyNxSXmA0P8q
         ee3QL2Gjg75taO8JT3XhkYEdjhYf2dSwku+TEu9wumrDlOxHZwaJJG5JgPJUxym/qQE8
         PwxGlznHjWtPMpo8cbFs3htt6V8Xl+nWM8PCmdcMN+wjXLqMBwtFbzFJCz/5zF+y44ek
         YqqBDRnkRU555EhKPutU1j51WOlXosLakM9G268iF8d9nfno08gOA72z8vhQe0KIJr6F
         H8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nM6ep+H01brZSZE4hG6bFzq+Rl6+pMNHxFa0HRJHDMc=;
        b=Yi9boYbl1cmSzbYAUdweHcQ2t4DpQ6ibxRZXLvHm+DCI+FB71GijXfq1ZX0EtQlZg6
         zj0cOwIQB42fkKYNcoiPlgeGtoMbEKQbmyyRNQJR36TEuAS1C+3FyKEJpSyllL0/8VNQ
         m+yR0qbyslJ0HTyualB/2Jz39tJoIFh9rnhOHUJoEvQ6KCE86yIya18q/Vv/9WpyQytL
         m0s8rt00u26jh1p9vaLZVctWsBrqDxOHpSCbU9+7e/1XhHn0YiKNkJyCIEwnKgFk7VFy
         ANRZA7dHFk1QK1lcIXZM//omXOTmHtVCwoIjctPfFeWrVpliD4x98BYRsBWNKgWzI12O
         zbdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 27/68] net/faraday: Add missing include of of.h
Date: Mon, 19 Mar 2018 19:06:05 +0100
Message-Id: <20180319171831.628837862@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390548552931804?=
X-GMAIL-MSGID: =?utf-8?q?1595390548552931804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit d39004ab136ebb6949a7dda9d24376f3d6209295 ]

Breaking the include loop netdevice.h, dsa.h, devlink.h broke this
driver, it depends on includes brought in by these headers. Adding
linux/of.h fixes it.

Fixes: ed0e39e97d34 ("net: break include loop netdevice.h, dsa.h, devlink.h")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/faraday/ftgmac100.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <net/ip.h>
