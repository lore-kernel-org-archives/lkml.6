Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+nO7mSfj/qiD9Oj8CtplA9T8Fc3kam/1NlEoT5QXDzRYr62Pfg1iyJay/P/zovlSIqgybO
ARC-Seal: i=1; a=rsa-sha256; t=1523021341; cv=none;
        d=google.com; s=arc-20160816;
        b=ELUBCxGRddHZb5gX5NfgI0aK4NR+nSt1D9W+v9RShq0IW0qNrYeZyFGpxFrQ+L/TOF
         JHUyNb2Pr72hl/l/bDb2st1f/O9x3kFK3z1LyusT5u/XxsypoxraMoMSUasaAsxkzr1R
         srhbLh89qK3/pXzixUbGu25mL5oIrao+1W+ZzYII5hUFM/mDch70Ey89G/VzqTj8iGXb
         Sva7W/eLdo1cb8baa81+Uort8gl/ak8FKcX3smCUpXA0UyVScAx9IMD5pFBFgeNtgKMH
         tfoa+qxUfIvFXzt/bEjY+mMSKcTEvQPJRY9XD2D1Mq4R3tKSvEsY09HuEcY1FUIkVYtM
         CvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EGBnDKPNX/nG/RsI0+nL5dyNRnrKNHp1gRpj8mwq2bY=;
        b=mLT4Fr8DYDHPwnBpW4o1BfEYOAPwPM550T0HSv0uVob/3LZ+MVDxSQVZIc9d1V6Kna
         8JSmvHq56Uw+HF6J9ES2GNlbW/w/NSs14jCOZhYw3hfMHAR7fSQTMLkhKdw7eLocGiUu
         WOdrNbcCC5qLmSO5QQMi8LCjF93jgAvtb+PKHdB+SZr0NYGfUen8nbGwYgnJA1HluDuB
         fGtC6mIKq9Y1HY1Y1O6CDhSP6s2WvLaxhjMgw9u//0CpPGf1t2l/Exm4mW97zy4Nfc4c
         B0zxxSdS0gCGSMOv6GtkEQD2F1xXhGWlOrS/OHgw1DGo1HpV+X+XMsEo+Rr33nJCLYdk
         4htQ==
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
Subject: [PATCH 3.18 85/93] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:23:54 +0200
Message-Id: <20180406084228.902828711@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003626904788009?=
X-GMAIL-MSGID: =?utf-8?q?1597003626904788009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -603,6 +603,13 @@ static const struct dmi_system_id __init
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
