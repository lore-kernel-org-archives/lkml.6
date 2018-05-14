Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrLXtccT20eQlEEUuyT40i8mWsjk7jw3WYr8ua5gEW6A49hhjPIfA0cgIBx9044moqbJBZA
ARC-Seal: i=1; a=rsa-sha256; t=1526281066; cv=none;
        d=google.com; s=arc-20160816;
        b=VXu2cNmm9C0a9sAILL9jUctUnuGF5nL+HjqURcZvrvPRsU5/WTaFgtxsJGDPsU1Sw6
         cVSp6b/EsaRupQWod2lS3T1gIq1qStGk7Qk/RNy7p52tYQxZ9nH79KABcwOOsZc5Bok4
         mzQYiROZlPIkHTo7sPubtZBGlVGSiYcfSs/hqNyGIMnyLCdAWJsnW0QyBroyBJSLHu3a
         ggn5Y14/U6yRBnuQwEwGmU5YtpVx8R6w53Mb7z4+vmlKE7ZT+26pwgCdENpJKLlYSdIP
         7OWJkCViyNQ3P8MvP7m4HwlkXPT8zrDioO2YpHk3wsjNf4D3sv3CoB7JAOsGYV/a08TG
         erBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3CBqBELHbPPrLbkl1UyYHCodFT6ZovjtoPzVLJP9Bk4=;
        b=bMvXzG1TUlr1KOHWbWxzP5wl1xKmOGp3/icNdWDDM5GKZkVRalNCnU4vjXgtAIEDiX
         U5+/f9A1Pk0hm/Pr8O58t9Oa5SiDpWO0M+ve+V1nNFzjoO3or8VEgRtHnQPDYuKjqwXR
         ziRJOIb+Z4VEfj042Svdmd5V6jpUTjzv/VGWwQwdx1O/eHRbloZ0gZy5MCpqUQMM7Qsd
         IQdZI7Ax4fG5Gyp2JaEtCTKr64WTVR9G6fE1MqWthVz1uKHq0KIe1/69maAOKP92x7z5
         vQskhLXVABw+giVZnPVKGhVke6i9bDW0mK7vtaB97h/mGIpNm8Kfiuf1zsVCmLyUOH5G
         1Rlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gs5sgQBw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gs5sgQBw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 34/62] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Mon, 14 May 2018 08:48:50 +0200
Message-Id: <20180514064818.242565817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421236759746459?=
X-GMAIL-MSGID: =?utf-8?q?1600421695836857011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1179,7 +1179,7 @@ static void kvaser_usb_rx_can_msg(const
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
