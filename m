Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsObINscjBhp0soNEZ0GPEH/3R5T4XUVRbHeVqGTYCpFExZ1avTonqMpf93cDhywxYVsFBn
ARC-Seal: i=1; a=rsa-sha256; t=1521483865; cv=none;
        d=google.com; s=arc-20160816;
        b=KKm/Ymg816rGyePCqnFkAWijzN6JHyYli21xqMdT9ztQQllOst8BbZdA2REYt6LEIL
         WKsFv/4gjbRrV2wme/jXUUEwRXJO8A+/q5gTS4dGOLpvUnyNtnPEqIpcPYPX7k3/kthv
         d3BVRno9LWXq1s2PvbbogI2BDN5Twf0lAbmresFDlNMnk7ArKa2LWp1bu1QghvLJf4ll
         XeZwHJVHqCLkxG96CGyg5XL7Xz9ztZR7QWd98133rzl1bDxs6am60TfndENEvsV0mhsV
         8EfyNHi22rEnEByM7x18fCO+D9W3912+VztVc2thu3X5gYE9S+zA2smQTJ9xqqjHJuwM
         hNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GzcUhbO/kD4huPYPGGdo2mdnK02ZQU4imrIs92cNvYQ=;
        b=e7Z4D3OTCgu2K5yc/vNMtwjhXk3zJNN8E/kudVSibxlY3bU9yL/WQq2XijEfhBoQv5
         Ke8FSF0mPIhjdN8juqQA9sJ/QtnpivmWefeFVu6X4XGv589GmZw3KIQ6B1H5YW3LuX9P
         kaVC+52tHELHmOaBRVBomrLU12DFHs+DkuwsRsj8nVK+t3E6IdKkCqNtoIn/Hfna1IQb
         fjZ9uAzhRusPW9S3OPCqtI1apYLgFHW0985lH7Yyjt0ivSBF/W8lh/MHCk3rtVj1n9Z9
         QjYC/qNTAGgmneZNxQg+cJ0nGTPt27WGzgIWwB4/dk/NB4M703UN/Qz8RyNE/y0m1Xhw
         RMYw==
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
Subject: [PATCH 4.9 099/241] net/faraday: Add missing include of of.h
Date: Mon, 19 Mar 2018 19:06:04 +0100
Message-Id: <20180319180755.301772104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390548552931804?=
X-GMAIL-MSGID: =?utf-8?q?1595391465931826199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
