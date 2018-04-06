Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48w5SbtUVnq54FCeMLN01sZx0rDZIXqWTZDY/SFx5bdD2SmQRxInj6/abvA+3k2IUvx3Xu1
ARC-Seal: i=1; a=rsa-sha256; t=1523021556; cv=none;
        d=google.com; s=arc-20160816;
        b=pKpuVlUaJ7+5YQcfZDps0CbZaVE+QM9XTKigQTyMKezFM9yqiTePQCxqrU79g5EcqY
         m2osuD64sBw79U93zNLn4qGhvDNfEpVlGWuO8YQP0wkt+THHilwrr9dZvxD6Yl7pbudC
         v60nK/NF3Xr2D+omxEEH9L37v4K6LoyvBa4drwd6cRNypJPltmDAtYAcBKa0hP8aqCJs
         BIIObVhezxKej91+PuKgMUCIWqxYZk7pDNLpXVbDPpyozMTDV/n1SfFuvugQlk9Ol/s6
         p1CRtNxLryCdXiYpcOgr1Qv7evOBdnMUlPTzui8aiMqzth8XeNp2JWVEBysmZC+xvpmm
         7boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J67orCTRZiCMyKGaLW8YDzILdjNAZPsBRLsa9jnUM2o=;
        b=DjXhaIZ0t9iYgvJLjutdBslVOITu9PnCTVGXZuv3IJr1wcvimn6g3wq38UsT+AUfzI
         NHA0SGncajwz5cEd5CUXlEHs6XtIoHlLTt755EfSAIGPfD3LTBj8KNZhVfkuEIfqEcqZ
         55ks2UkEfoOSmHvmfqfCsIEVGJ9iaN69R+XaU2NBTucWUBDcWXXihJcXTdhqfRqJ033v
         URi0Zvhxrjo4PHotdr8vs5JCqkPiR0hWXfZR/C1BQP9aYxJgol873AWdYmUw8rzmNlfS
         uQb0YcL6NW7Co2Nolpb1UT+cZOtbYW5DTCBIysceCWZrnDY3+FZ6RviiEYOkGkzmu0pi
         qIMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Wassenberg <dennis.wassenberg@secunet.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 55/72] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:23:56 +0200
Message-Id: <20180406084309.885524951@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003626904788009?=
X-GMAIL-MSGID: =?utf-8?q?1597003852244438534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit b56af54ac78c54a519d82813836f305d7f76ef27 upstream.

Reset i8042 before probing because of insufficient BIOS initialisation of
the i8042 serial controller. This makes Synaptics touchpad detection
possible. Without resetting the Synaptics touchpad is not detected because
there are always NACK messages from AUX port.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -693,6 +693,13 @@ static const struct dmi_system_id __init
 		},
 	},
 	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+	},
+	{
 		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
