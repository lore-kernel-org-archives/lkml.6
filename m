Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WYasdX6N7Ze6+6LmLaicZuZDZsOEHqPI5HuyfVu4NAc3AzycA/vBzMMNtL1vLbluB4clu
ARC-Seal: i=1; a=rsa-sha256; t=1518184019; cv=none;
        d=google.com; s=arc-20160816;
        b=RDneluRvtgtophGpr0DBEr8XCXi43ChMt/gc8AkWMxN4IwQnImb/7aCujZ3hoOzm06
         X9nD241W9bnp91aTzLZ0jFoNuMat6oBRHd+PQ+/mmhHXm7BAPsvYcTx0AHofPHd8qRvO
         wbvl+HxKwSUqVHMB7cEaai35Wm+LAlb5xktk48lobjdQgcfG8fq3OwnhFxtlZ5r2XUO3
         ndfQzdllmm6f5dGqlZBMveu6RyXoNaI6roysPJ6c2K9iPdIUplYtkXSS9+RLYFdZKq1c
         3XTHmLoiiHcP98wewhOrHmA3fnRj+u+D//j8aFWnOOSaZn84VBafVUC11H+wrXhynH4x
         bFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g2/GrcEt2txFSANurkJrIOLcJycXiczkI0/yQdEdI5c=;
        b=KQasvLFwnUdZZ30W+JzGK+EgOgU+29iGp7vlrgjvJXeAk19EIZfLVyus+YjuATeWjs
         V0khdFRKHK9PKVfiVHCBs/08b4NehvgTMq48awRqJIpXoDwU/FphqxvLEZCTUvuJF35x
         MLJCoR+9GVInNz3oOO4ADzDSdhH7NLh6nIeO9DB/b+kg0NPhgDkzeIaky9C6ntD7DqsY
         t+rTkfQIMOXEvMffxexOllRmM5k9OqJBOgMWyH1Y9Y0o528hTcgMtBrc8EYBU6+GW5Tl
         a5byG9UvGI43aDdKk/5FnzZnMJAfa1iNO1+sAgfr/PzxRVlqAI3NWN6AhXWOMEpScNpV
         ffIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kristian Evensen <kristian.evensen@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 04/23] qmi_wwan: Add support for Quectel EP06
Date: Fri,  9 Feb 2018 14:40:02 +0100
Message-Id: <20180209133938.597423687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930962484755065?=
X-GMAIL-MSGID: =?utf-8?q?1591931326793879749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kristian Evensen <kristian.evensen@gmail.com>


[ Upstream commit c0b91a56a2e57a5a370655b25d677ae0ebf8a2d0 ]

The Quectel EP06 is a Cat. 6 LTE modem. It uses the same interface as
the EC20/EC25 for QMI, and requires the same "set DTR"-quirk to work.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1245,6 +1245,7 @@ static const struct usb_device_id produc
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
