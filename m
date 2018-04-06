Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Z3IjrAWZJr7h9poAwyKG7+Apfe7orv3OgFNcbxpVwIQvUAD1dqqOKSuomOE8cUnDaqwQl
ARC-Seal: i=1; a=rsa-sha256; t=1523021778; cv=none;
        d=google.com; s=arc-20160816;
        b=X6fQEndjg2/prCs/WeYfk/ZOfsPWfXf7R8uRrOE6oC+1FFLpGHxZNCh7QzrSTDeCRv
         +gkoQLVVQ9q/5yVr655H0DFkWeE8ukwGD7J6Etdza4fvmK3oGozhPic4WCQJQrZCzXSq
         BSmATR+Fs8aThjrHqUnBMigLa5GNTyeWMRqoSh2/OoYnRs4q6x27Koa9LoFiSIUbn/Rp
         f4v9PauFU72B4/W7E6Jf/hfKMMuUtB+EVuoJexBquuAIDrQHdTjSHsokzXD4w8ImF0Mg
         fDqP4H+D9zsJmtzRXDuDIJIPkm4xQbYmRh0uWE88KI01P8XDjReOTezQCiqUixI1TUM+
         i80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AMA1roxV5ZeEotMnVLt7COltoBW/FnK/YA58aax3EQ0=;
        b=tWprUmrLAir0sR9j2IxqzP8GucfuAylZppjj6aExrMDNvTPAol25FD4X/h3dAUDCVY
         /B7AqLqc+iw+Wn/L7DSV82wPT6STcOYiD8qoQcw1t70jF6Lh0GGydHETjv+dhzwaFcO3
         HHZ2gV0gGz6DSGWC+ASSydSXbLjiakphKFz339hVApkYzPHgAEiuRYq5V7ZVsNsA+d9o
         n26hT0NbrnNcEpe10HlFftHTuB6nUccfQR49BlmRAb4U+ASgWN9Prfy+r/c/aeaKwtDs
         cMLJ+GrGINX5bDrvZn53mEww38IHGvpxpbNNbSWQJ8zdQNQmxm8IuTJO4lscyR6yva8P
         snPQ==
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
Subject: [PATCH 4.9 087/102] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:24:08 +0200
Message-Id: <20180406084343.744990887@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003626904788009?=
X-GMAIL-MSGID: =?utf-8?q?1597004083971882799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
