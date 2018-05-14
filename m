Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJu0Du/PIcuzuHGedTyskS2sD3wH03c/yUUkWULMBEtxQ9K2rMM/nFxHwELngd6SzEJyo3
ARC-Seal: i=1; a=rsa-sha256; t=1526280760; cv=none;
        d=google.com; s=arc-20160816;
        b=e7hHeydyi5J0v38wjyidPNrMPPlxpBfZFvlo4oVhiAvmax1XlZ9J6x2uOv6xDFcrft
         naVv2Fnb1zjZPlaA4sIbcvz0pBbcA7my1kkkEhW1pzaAgXhpeNTIATBDCd+UaeTzJsdx
         qYJpNucGny6gLIsDOhDUZPts1mP3w3ub23c5yT2N33lnn8LFNn3gAJ0kQlbwQu1U4lYw
         aX1+txJSMRz8EgF+ZpLcN5DT32w5txrFBjZbulIZRK3vL75xxZmlgfeGT0tUTUJucfa6
         hkRSuaNZ4ttFs3xQ74xR/Mpz0xtvPR2uTcEBPW1d0yPxqS778iNJlbmeP4ANV88Ns/eN
         zf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dvc/5EEZUeO5ZpnUe/j3qnPdfjeMvalPNcifJKO9vSE=;
        b=kVErAOmRny56O/yWi/OsRvBR183WC5lJADTF8ZNSU0JvYWMFvixFgrVKHR3EVXA3lh
         wG6G5dlBpeRUrQ7gBveJqMXX9736QrxT0pSW2fb74yqdKTpw8F41CjJXALiSZTizuNxu
         C77xFc6AURdO+xmkLwWfdm8+teiPh/GSi+9QyXWyiEoh1LZKaxwY9bY0x+YgFvmS7jWW
         cO47GBBuIOQ1pgrRTCHtjDQDAYgVZ0ugCATmSf7Ub6d3FtJSdIkFR308Yq8zHjEwFg9q
         rbElb2Sge72zPV/eUhbSHe/9TjhWRB7ocUgcuf4uuQd1IKM572zaIiUOyPs1P/kAEunj
         8aPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X3xtPfnA;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X3xtPfnA;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 47/56] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Mon, 14 May 2018 08:48:52 +0200
Message-Id: <20180514064759.179348714@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421236759746459?=
X-GMAIL-MSGID: =?utf-8?q?1600421375007614836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <extja@kvaser.com>

commit 6ee00865ffe4e8c8ba4a68d26db53c7ec09bbb89 upstream.

Increase rx_dropped, if alloc_can_skb() fails, not tx_dropped.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1175,7 +1175,7 @@ static void kvaser_usb_rx_can_msg(const
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
