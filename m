Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+byY3PVxD/A4tPTplw4qyoCOtLDH09ooG8+sqt0pHkcdFRjgakhw85ByBIBneqH0znr+Tj
ARC-Seal: i=1; a=rsa-sha256; t=1523021928; cv=none;
        d=google.com; s=arc-20160816;
        b=SRCkVvtrf2ucjBR8qYH9YJ2wzBfHIjhxm5lF1Vs8L2KpyjEsnQ+VNd3pNlVZR+vJrV
         HiCf/G7bSqPstMD5b7xDshe49cyijiMxjGJiqrlAQDYOlEjV7l29Ce6CeOqJXxQMCjTY
         f3x1KxJvEHFGwcdZsFlkuAh9h5ye+sYCa4K85vUE7TrT4svLVYQ78fBGWM5Z3ljStHwl
         YZ7hvDiV7WMybrzSpWgRUADtYX04IzhUkTyjoCIr582mZ9dQATE+2WZCu1am4bfHTd3C
         iqK2fq3tzWDcEC8zsoZ4N4WDD9TNsxgSybocXgQYOhs1lKmmQKUjfpra8Fs5bn7HdzXa
         lMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wo4jCgA7EQqrW+DBjosEXmVGq2E7yad8M/LtUDqImMI=;
        b=MXVP1xBXkKGsDOJp5I6SUSXeiEdafk5f/x/TUefbix+BGMpE4+pvdsIf1D8iLqkhRB
         IWti9wPjVCFWuYlj/aJf4KUtsKnObSOM3cPahTZbPFrueaU1nVwZcaWQ3ONiHBLZuALL
         lAXdmdsqHF16j6V3HdhqT5/19pTV5QUvmS9y3tWlxaL+HofajhPZy8rE6kZlvsse3IkL
         ciEuyXt871a4fNeJIMvf9OQBREQJZjpQlphCX290tpjlaza1ZHmHADBbskRuUkBFWhqX
         +vPxZ3zYbOR0T5ZIcDfVEkJuPJNtJtMI+h22YaIqWm6Cqi2V5A8Y8RDSinzg0TnW8+oU
         eSxQ==
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
Subject: [PATCH 4.14 07/67] ALSA: usb-audio: Add native DSD support for TEAC UD-301
Date: Fri,  6 Apr 2018 15:23:37 +0200
Message-Id: <20180406084342.239439627@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003920407381593?=
X-GMAIL-MSGID: =?utf-8?q?1597004242105125367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1177,6 +1177,7 @@ static bool is_teac_dsd_dac(unsigned int
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
+	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
 	}
 	return false;
