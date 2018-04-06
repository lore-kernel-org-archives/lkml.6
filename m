Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484gOmvt68+DC5z3WNtDrCpyKbo1AfGmNhlM7vK2bz8ULPMrp+YRKgcg43IP1s8xAmCSquD
ARC-Seal: i=1; a=rsa-sha256; t=1523022203; cv=none;
        d=google.com; s=arc-20160816;
        b=Cvvhfmr/KvFKOWui/8X/xsvDNiMtMdYFFPEvzsZ/Vso1tbEk7UFxQ1C/ByqkOm2VIh
         No2L1MgyMFzUAhamktU1RfkhylxTWmCHl8lEZNm610yPaHg+edx9XrOAHhA3PLxBnmeO
         TVKhva+zqaX9nEu0VA+Plxxx9XXc7Xx962eKfSxvWrJy/hBrFvxAvE/EgfxMpR+uSL+f
         zgbTkpza6vLuspBHjp2ethMdFfa01tGLpZT84anSC4oebWboWjtxrzixU+7tA+H0k1lC
         GOf5ZUtQ8X4SMCzjO70i5doBd/UhaUml7TfycvXBH4DSr9Yt6RsPIQLi7hYej5O13mQ/
         oTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e54BxAOQJ9GQBvqJMayeiA+X2bWcXGLNJNwndZiPPZQ=;
        b=OsWmARyOeOGPqa6Psuqxs+jxfHmhPZW/7+CkWLmX0sTlVLXBvuMPe9NixfPxC3t/RE
         lZJLR/Fi34IQ3EieZtFcj+g3kcbAMvWxOxk2o8SdkLofV8/hqwHZfN3C9ra0avxWf9Th
         df/z7DeeLCjA9wumJdIG85PGVY8zvq+E6kvR2x4KCwnukl6KCCSGx30MnUFmkXyDTFRi
         EaYK6ws37LbdwzzJApdFMdZvS+d3Q9XO/pv+O/zqBHj64XibAX85E/Q8xOVxHkQ6UHBD
         2+3wjl9Pmr9w1lwICzcO+lahzVYU/THdddgSutCKhhavSY/4LEEnRCNRn706XTtMvEc/
         SiFg==
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
Subject: [PATCH 4.15 63/72] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:24:38 +0200
Message-Id: <20180406084353.682098558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003626904788009?=
X-GMAIL-MSGID: =?utf-8?q?1597004530102024667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -621,6 +621,13 @@ static const struct dmi_system_id __init
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
