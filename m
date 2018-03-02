Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtMAhOZd9CC3wtHIaK7HfIYmXjaBRNDHfxA/YLB1PDPqpMX8Tq83kI7DuwTd9n8MozWJYgU
ARC-Seal: i=1; a=rsa-sha256; t=1519981243; cv=none;
        d=google.com; s=arc-20160816;
        b=XWZSIVNGOD17fER0Y3Hs4ADYgVEnPnpIrBGW9d49vi5oiJLBVwCbsERR/oDGkybMbD
         br4Z9ARpo3zAHDFv2IUPAIl1ZwrN4roHc0CobMopJCljlJr4wAFujGGKOTH5x2+2XjsH
         x4ZiprZjqCUILko74xcIiE6Ln/MIVym4bhVMS30JRBkSxlNSiBGkyUAFgZGRfXy8jmg6
         7xLjp+I+d9r64pk17rPHJhL/eZaXaKWh2cTdUny4MBiED9hFsBTTSRz3ZZGjRAEQ5cFw
         Ndr9XiiIgmeGEXwe4LZBoTCceO/Pv5tvlOkxWm6KdKcMqEKBtWVBNIE13VKhYWU2DKNu
         xQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sAcnLdRzJjLTR66Sjwl30qdnb4FfATnwtpxB6KUp4eY=;
        b=xKEVx5SAyocwOpNCM72fcEp8Z31PYriYCZivtDZ5KsKbUQxDKHEt6RcEfHOaH6ScT5
         maDsNc66hSQXnHZwCMB7Rq9zlz58ZoeaRb3Ctd5n+qskXnfrdXwcwe1FWOHhsVPgWaH9
         PmGFfFAOh7CqIsJ2d3/krc4wHz7+4KV2vrvVWRwEjt7d3aRacsG2mneLxBV4zAKVvdTe
         lS9lgl579TIAW/amHVqgTXdLxgjK11XbdeSuKFd1mTmTqbtFE2ii3rVQR3IehHkzp4+I
         5L7/pwXxtByYxI1Ohz9uA+G+Ni64LxX/QsJyV4x/DI9l15IPOSi7x1sVj6FPFF5AsXcJ
         Ot5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 034/115] ip6_gre: remove the incorrect mtu limit for ipgre tap
Date: Fri,  2 Mar 2018 09:50:37 +0100
Message-Id: <20180302084505.256139802@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815852245420601?=
X-GMAIL-MSGID: =?utf-8?q?1593815852245420601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 2c52129a7d74d017320804c6928de770815c5f4a ]

The same fix as the patch "ip_gre: remove the incorrect mtu limit for
ipgre tap" is also needed for ip6_gre.

Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1335,6 +1335,7 @@ static void ip6gre_tap_setup(struct net_
 
 	ether_setup(dev);
 
+	dev->max_mtu = 0;
 	dev->netdev_ops = &ip6gre_tap_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ip6gre_dev_free;
