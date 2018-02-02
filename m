Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2259X4LldXzLC+/M1pAHQ2x5pdGXk9uS3h5HH79ZDVoYooEFpcoOgx+IkKjcrFjm0FWMvTdl
ARC-Seal: i=1; a=rsa-sha256; t=1517590913; cv=none;
        d=google.com; s=arc-20160816;
        b=LVG9D/N3OzAmqyhohWamTP1WbxcK3q5hEk0lu+00HAf0MW2q1HMU7eO8eIDInpRw3w
         kZ8m4fgkRsQGbg12UqKRu4bw/8VDcnlWlN8CdJDiWN4kSLihjnx1qn5UBrq6qUQ3BiUb
         Gt8MS73Pnt49mj63B0G9/gtDvMck9wROmaaV6r09buswcqiqWEcfB+UDAjPi+yrXpUmg
         SM3jtzNP1DDhJjsXhp5znSpPsWsJuGp7i6Zy9zxtq/abyC+FZ2BpYz7oyVulzMDAOWHx
         2mpeMcxiR6NX5gSk3R9G9FijgU68mB9tNlX1Dcq+m5z1QO15jR/KZ2KvnEp8tH/4aVpC
         1Ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RXVtclRhyMu4qnU+cXZWmm/qqc+PQtwS3Ss8YH1Hg4M=;
        b=t9Y8NbbePbKhx6L3r7CkfQAVx4i61bWVl9pmhEklvqqL+CjGRuqR0+jy0PvRdQqbI6
         8pz4hfQ+/ssV7pfjS/rgXwq/0FM/dRYWmeWvc4SpDWSnJ8RIRFYpJq3KwchTuz91BvV8
         qNn5QS0gPC31Q7rqIqFarydwA6zgxHETa4hJoKNwT+JJfs4nPOktaaP0m0QFC9bnIz1n
         NJGYH6skaURSPgftAdPXuO2rqVGgZLvUCDU/PIu06UqkT7DyxBgsFx5LzqY+/peBqfZE
         fcCjYUM365jDD/CvhR/W7QibGMX0BY2ILJfQSQiKKSkt0ZRnzCtF2RvHjwv9Uv+XrobQ
         P3kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>,
	Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 55/67] usb: option: Add support for FS040U modem
Date: Fri,  2 Feb 2018 17:58:24 +0100
Message-Id: <20180202140821.366058313@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309409648037799?=
X-GMAIL-MSGID: =?utf-8?q?1591309409648037799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>

commit 69341bd15018da0a662847e210f9b2380c71e623 upstream.

FS040U modem is manufactured by omega, and sold by Fujisoft. This patch
adds ID of the modem to use option1 driver. Interface 3 is used as
qmi_wwan, so the interface is ignored.

Signed-off-by: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>
Signed-off-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -383,6 +383,9 @@ static void option_instat_callback(struc
 #define FOUR_G_SYSTEMS_PRODUCT_W14		0x9603
 #define FOUR_G_SYSTEMS_PRODUCT_W100		0x9b01
 
+/* Fujisoft products */
+#define FUJISOFT_PRODUCT_FS040U			0x9b02
+
 /* iBall 3.5G connect wireless modem */
 #define IBALL_3_5G_CONNECT			0x9605
 
@@ -1897,6 +1900,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, FOUR_G_SYSTEMS_PRODUCT_W100),
 	  .driver_info = (kernel_ulong_t)&four_g_w100_blacklist
 	},
+	{USB_DEVICE(LONGCHEER_VENDOR_ID, FUJISOFT_PRODUCT_FS040U),
+	 .driver_info = (kernel_ulong_t)&net_intf3_blacklist},
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, SPEEDUP_PRODUCT_SU9800, 0xff) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9801, 0xff),
 	  .driver_info = (kernel_ulong_t)&net_intf3_blacklist },
