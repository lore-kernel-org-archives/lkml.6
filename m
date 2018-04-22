Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TUzfzD3Y+CFHAdbquQCqWDbjC1/D6qFLBZl8oe7RJRgYxUbVxZgScNXrUd5C6DhJK8SJ5
ARC-Seal: i=1; a=rsa-sha256; t=1524406147; cv=none;
        d=google.com; s=arc-20160816;
        b=Qlo2I3OTSekORs7EjNXbqvLliEuhIv2rab6wRbNex7LOndK//ywgFFQz/08VKJNMa0
         lo9puEqvYpuNtAFPgH19qTZJ3417D9MnwRT2b6KS3KCSZ1bEOUagoERhmOwAKo8u9IOh
         6TzUOKS1GZP/Q+SLn7bAS6TVHfZhhgJA9ZeFRUnVlvGgVxhG97VekmECIfS2gOvdcOMu
         4P/gyo57Q13eBmT84LbjRTMiJJ9Vd3+i6ALb1cy2wQNDcS2ppYTcOnPpSsBf+b+OvQZm
         lFFpyf4xm1R65/EeN3NayWW7ZJLvZ9f/CKM/+GMxMr8HXeKQ7dfCU8P8bpLq9N+FwhKJ
         tn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q9CKoizeBhz5RgMnX2riaCR66cgVhYLrM1XE8hicQ1k=;
        b=BracPzEDeBcNysXywIyrVyafOe5VvjvwkiCgMbtlHeN7m2E7sKG+sVAdjY/UO3suaH
         IhPHQjrsEpqcbPG/fDnhjUAS+dXocknhCVM5pYt++qqT2Jgl49vz6iaKlRk4GkhWQ0cw
         T/0wa/tW5YYS44wwtnwD9j1AJyGCa7BdQli1UIuLFFBfNYSe2TAHFbHbs+ayL8jZRV3o
         vltW9g2N+7N5a3XRNfy4rd/9W3GpdODoR8bfijLnVaj8ggzDmCvDGlIR98cASjtKnXRM
         nGBTQhk4Z42YEPGU8PUGJPxo7D1zyEJXeRqbKhnGcU4B6cmtDyCZS656kC8ENNSlIvlj
         dZuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Wang <davidwang@zhaoxin.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 130/164] ALSA: hda - New VIA controller suppor no-snoop path
Date: Sun, 22 Apr 2018 15:53:17 +0200
Message-Id: <20180422135140.706569463@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455325045223483?=
X-GMAIL-MSGID: =?utf-8?q?1598455700930361849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Wang <davidwang@zhaoxin.com>

commit af52f9982e410edac21ca4b49563053ffc9da1eb upstream.

This patch is used to tell kernel that new VIA HDAC controller also
support no-snoop path.

[ minor coding style fix by tiwai ]

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1645,7 +1645,8 @@ static void azx_check_snoop_available(st
 		 */
 		u8 val;
 		pci_read_config_byte(chip->pci, 0x42, &val);
-		if (!(val & 0x80) && chip->pci->revision == 0x30)
+		if (!(val & 0x80) && (chip->pci->revision == 0x30 ||
+				      chip->pci->revision == 0x20))
 			snoop = false;
 	}
 
