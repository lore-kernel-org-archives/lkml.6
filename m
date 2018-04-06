Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48fleJXS3kn+q7ivbZpfD+P1BiqMAURgGLZXkzwMReIBaxk4sg/KYBW6Xq57HFknDsUiuQa
ARC-Seal: i=1; a=rsa-sha256; t=1523022076; cv=none;
        d=google.com; s=arc-20160816;
        b=zJ9lC+WZkShohIJYVLvGEvWQXbqwpYTtLiRjR0HN8c6m4rx5WuA6t8CWHL4UUFUsUP
         7Rgq4hMoCsEuEHcEdfLWmH0MaVuXL2l24fGvkIbnuYw8vbclin8CJuUQS0yWxwWd6SBL
         CbM1FyTAMo1SX7v5c6Y09y8tUlCC+AAtIVcKv79VGomkpzGgd8arayaZeIfBStx3514u
         5+ZMi/gpxbMneCusZuKMZKjIMcygFIdTQrqJ8neG+R8x7pR9oJiNXGL9c6YYqQagjJqG
         6NlVBWu6m8cn25inraQUaxJwpdSFkcMve/ytrnEWCDHREAS2bNv59jw/e/n4F52LjKWp
         y6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+XHFfu6w8byc7pxE93dQTm3vdgdU1ACunyEkQz8lmms=;
        b=bVFkhwkqTPKgJ3d0YK4da9pmYX8vIYNMKxZBxXWfkYvvDkxYHU8oT8PnSjWCMUu3vr
         yT/7ADPWWKPcCupsJKjM9TTl/l9W+e3POONuj7SauHAtFFWrFGyAwhEjdKF+lxQxZBZO
         3FRcZRRAgmQ7TkNb3SQVxGcQCh9oeIQNsA8t4JHudhKIpbYtYBRsYqZFPPBx4yi8MJSR
         VaxBQzxWFANLNClP5vLBLxzh99FmJqSlGWBEfRSMmF50vyak6VyT4Z0zoUxmOy9AEDsv
         Q/w6S+ZAehkILxo9Dozli2W+6dbN+9A1FI/lQbeNyjvOSWCn0S551RCdDXx1ALyH20Iq
         wQ8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nobutaka Okabe <nob77413@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 07/72] ALSA: usb-audio: Add native DSD support for TEAC UD-301
Date: Fri,  6 Apr 2018 15:23:42 +0200
Message-Id: <20180406084350.119501731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003920407381593?=
X-GMAIL-MSGID: =?utf-8?q?1597004396414310839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nobutaka Okabe <nob77413@gmail.com>

commit b00214865d65100163574ba250008f182cf90869 upstream.

Add native DSD support quirk for TEAC UD-301 DAC,
by adding the PID/VID 0644:804a.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1171,6 +1171,7 @@ static bool is_teac_dsd_dac(unsigned int
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
+	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
 	}
 	return false;
