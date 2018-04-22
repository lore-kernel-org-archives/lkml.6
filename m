Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Pf80GcaVc6SMmA6c+iPWCqSKYKbYD77s9ncML1+X53yq+6CZ5qmJIR2Zozc8/cfnyxEAG
ARC-Seal: i=1; a=rsa-sha256; t=1524405789; cv=none;
        d=google.com; s=arc-20160816;
        b=01zMt00tZFQrhCMGLIjXgv0vzjYyVU/d9rK7aR/Meoj9YWfBayryYttPJAWCXYGf4E
         3xJ4mIOhyBWl95+NiZ0OwdF2sDQd2OeSoBejdOVxfuRGXcU4ejWI3IRfLnFskqK/btfU
         tSa1RQGjWzsLoQQeBTVEaHFKqIQdcuapBb3kIxDZNqcSY2ldHYAg421A03wK3elt68M0
         GLComgI7zB4fmVMB2foSMgkYByTN7LuNpkMR1/bndiABJanb8kzcmRnwD8c3waX3h9bR
         atdF5gKlVxzs4JTvFx36AffkrAWlU1DNZMcdVv9cdNuRLZkQx2OG3CguLxuEpYsnFIPI
         RIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aADj4mgvT3b35WHbYMKX446U/r0JdGLtEgi1pgiY9AI=;
        b=Ys9WXBH7blQUyAnFY7ypqqNpF39+r4F6IeGzUQ7k4hyoN8tuaaIH5cSbdddcIOiPxS
         GqmaWP9FDQI/8qh5m96TUET3ZFjDL5FytD0kkh5Om7CBm2ZUx9q8QyOBOzcieCiwABuU
         Y6EsZ2rZdo6nCgvFcy7DCgg/aUmYaFJfxNdaixYJdI+dcuzA/x7uFb+8fOevHlCG6oTm
         gqOCTg3fjOFJM+UhtCbN4Tgr6Ky8HLL9lmzFILvRriIj35mlX76A9+poFvBj4/UvY5+Y
         aYZb3L17J6yC4bS8khhzRzZrv/zK9iDnWEsCIEb9Yao90M/nKrLZjb7hrgEPu8gHYnCT
         gQjw==
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
Subject: [PATCH 4.16 160/196] ALSA: hda - New VIA controller suppor no-snoop path
Date: Sun, 22 Apr 2018 15:53:00 +0200
Message-Id: <20180422135112.503674836@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455325045223483?=
X-GMAIL-MSGID: =?utf-8?q?1598455325045223483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
