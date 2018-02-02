Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227zNaRGNNah64q5Q1WLJp9fktPc9+vqLRkhfIMIHjVXljqdId/SO/Y8KsypVa8ECDdO9ugX
ARC-Seal: i=1; a=rsa-sha256; t=1517591173; cv=none;
        d=google.com; s=arc-20160816;
        b=u8LnMm97Xsgr8keKh9x2IeeH9r4rFgUl1zMP5U45Eg2ktATcaP84zocDmsSOS9tLrk
         zK3D9kImMt9/UIVx4WnWPNKZmCWlX2iFyAok/IwGKUA8zK+w16wKwRxco2V6y9F4kD6a
         hdk1zM5coZ7sc0IT7j95GLMcWDYAg0UNPXknLv1tK/Bv18tTe2YIqQ/X1vGq9yihxmAS
         /xXj/WDQ2JP5QcaPTh5xce/alh8cM9piCS5DCIYp6SL7NT7g7NqLsKwJ3LL4uDf2zaTc
         +sRoTY1jiJla1rHa1djZ8MJblayc6H0tkkkZ/P0tsY5ByZVKJsp/54rmxV84I4Xp7Eky
         IrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IKyKgLLLSt0aRgRJFGhpNy969DkZnX+oqkC9Vpcgr2Y=;
        b=MOF7Wigco9z81v13JG+Q50P/U7k3TcfqXQvd5bHC0C091/qXloqayN9dolGbGHeM7H
         drm6kkASnYk6V1PoQX7n2FOsuZiCGrD+XXkc0fNpalfpEIYpd/Dmybi6aQK2Hrbw9/qv
         eBrF/By09fcs+eDbZVlBCY2owarLDMYEhJtB5l5KPOskSSm7SDB9+WTkjze5fyyoL4/+
         BYGPVaE68dOU7G/6Q5jkh1NXlaTS+3t+PfTe52oayH3VNsw30xCHF0x/GE+lmJJ55MdS
         V60Tki141SKXuXQBiNxGiBKu5AErcIIgg7BgQDPiuf9I9typNjPh6iG1FvcpJ+jutfsQ
         OdxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 76/86] CDC-ACM: apply quirk for card reader
Date: Fri,  2 Feb 2018 17:58:36 +0100
Message-Id: <20180202140829.643208478@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309418514762445?=
X-GMAIL-MSGID: =?utf-8?q?1591309682511151874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit df1cc78a52491f71d8170d513d0f6f114faa1bda upstream.

This devices drops random bytes from messages if you talk to it
too fast.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1706,6 +1706,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0ace, 0x1611), /* ZyDAS 56K USB MODEM - new version */
 	.driver_info = SINGLE_RX_URB, /* firmware bug */
 	},
+	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
+	.driver_info = SINGLE_RX_URB,
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
