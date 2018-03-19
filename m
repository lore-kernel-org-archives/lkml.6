Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunHNA+4wVs0GjmmRvcAPTrQzIsnnPwvMfWAa7O9i4GXimxJHqwE7nqcktSVutnbGbgRgHw
ARC-Seal: i=1; a=rsa-sha256; t=1521483236; cv=none;
        d=google.com; s=arc-20160816;
        b=PxlKDrO7/5Ewz/OlCIDNbCJTZGl8AeAuHW+6jsfhRU9TaJjOo+hsz359uDOiKUHMm1
         MlvdKNmXy5clZDrxu63HYxGqykZAh4hkrjBsOsznuYcLbd+VP8fOwgd/pZzl60+b2Tdo
         3DSDHaVIsQas/gaS2QNTZXVTItK7pnHQTLb4tTlPEz6PpT4qSeOCHh2YeWOyC7TUAXX3
         sXGb5Y3vCx9ZyIjDNDaGB4t2vpIynwQhRCtaPWm6jUWbqpkMnpMocnlNyrYuoHEyqt02
         6NRFSmQ7qBVAmn9IR9Inj/mhmQF8Wc/LYzI0OP9Lud5gRu3r3W78/1qcnVIVwNp8ckQl
         0ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cnYM3sWZGEWZWpDoKvOuts2qc5dw1eYCivLJaCbEH0U=;
        b=Xh4wrA82xfgG0zZutXlgz70q5G5yPAE47dF51FiAyK0jl0ozRtOR+9R4wk4GqmYFCL
         FlMlXfGU9/w2QpFIaf/5XwRn+Nb4pgGU07vyKnGQYMydoJxrGr0VgYvxZfMva6c7VZ4n
         vYrxSG05g0b58Mj5iQzGM69QZOtnDP9vw4Y5n9RwiS5+Yo1k6mf+zPeNAZybu+tfPD13
         aAVlSg1+BrNCM/mRftGLUJVg52+Pex16t6Liki6RwKro1PnErFIVvhU4aRu8CsrmzvyC
         rBA8ZOm0Yalt1S+zmsVbtcHDUAjouszYSYS7paCUXDWQJjljnIpdbgJeXzuTsvwVEzDm
         jD4g==
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
Subject: [PATCH 4.4 050/134] net/faraday: Add missing include of of.h
Date: Mon, 19 Mar 2018 19:05:33 +0100
Message-Id: <20180319171856.587319690@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390548552931804?=
X-GMAIL-MSGID: =?utf-8?q?1595390806353080107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
