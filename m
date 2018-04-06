Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+dRJXV5elkWEepvr4Vj3PJPdrMYKP2XqZOa21GcQOrBnrHf+eR8as8J3W2+TASeQMGedGj
ARC-Seal: i=1; a=rsa-sha256; t=1523021991; cv=none;
        d=google.com; s=arc-20160816;
        b=geavj6O9FY1QACjv/4GthM6GBiYY9NwFGfVLs6YfettEFa/ulI6Mq4cHsPOOk4zz1g
         o4A1kS0LulJaWSFFCHkn+t4dnZai187gayOkIq6TCiwKdyD5md67jyntjfSjwVCBO8O1
         vtJIXuc3/4/v3kT+1dIrIIwyJ9Bb2UmKMZmOAFIqqIGYxd4OVNqMVR1ZMpHH5IqAeCLi
         WlAxhVyd4XZkeagFPlUs8fJpswI1g0te9zb54jlV+nf0bj3I6Vx20W3VRry7XW4owUrt
         3T0S7zSI+63A0mgM3VJW/3fFEsZ30wj6IoPqV83fuLLiaiztfIe3I5sGRj3RUccwlck8
         l1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Cf5LutxhstdE/rs44mQrVwdOZaEfnGp1hYJbITa/Sok=;
        b=EMR2itbjoLZH0RQXqPi+PLbg6RNrwZh7Zip56VYi9AuSqLR4/uUygwfys0rJzf3CFu
         9Vm8sUdfJdMZixaRU5PejTVT1ztE/J7EgKWbDgz6+62/bQVRTAIAyh+ILQZD0AKZZnLR
         kRlgK6Ptbc0q4U4ZHvK5PzAchjHkxQILPSyY3sj62966pgB1wNMzTKsgdcpg7gEttcJQ
         lrFFLivwXKncfysDqKuGByRvXg9zyg5lLFmr+t/nLhqElLgL1SbOs8ojBhSXIli8wZIo
         59bx0McHKJ31Be+OfxfWerWSUGXr8T4Ubkp7mJ0Ggi+vUVRPC+2YANu3sSUyRw7Ertd8
         /nKA==
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
Subject: [PATCH 4.14 58/67] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:24:28 +0200
Message-Id: <20180406084348.228109399@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003626904788009?=
X-GMAIL-MSGID: =?utf-8?q?1597004307367862773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
