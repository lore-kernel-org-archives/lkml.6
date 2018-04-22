Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/GI7jTHNNqdyeNeIyu3zXaW3Z8pqxC2H54ciLxNhAHDv30+wMltFNE1ndwnx1OG/I2EVvy
ARC-Seal: i=1; a=rsa-sha256; t=1524406721; cv=none;
        d=google.com; s=arc-20160816;
        b=vJ3XAncUHAdRqTIXI/RL3xvGGpAQsN0APQSRlRALqo3V5WO7EOMLsx5JGKzS6fArn0
         Dxbnw1X9ydfY/DmK+RmTEs4S8ALrPJslNrulymg6Lc8MGrqICnNzOyNuinuSZOE8P3RA
         9UNrSII3j60q0flhVJm4mVP9PXYakMFpDTguD4W9We06qlyueUAFPsPRRO8b6Viae4QQ
         08m6vnymMb7GXApYaPdc5S3jnqWEXPXjRJ7dmLVdF7cvRGgLgnoHe/1E+E+i4XVjfDJ2
         NS0lhscu5g43nE9Jqxh1sip2dGrYgjciK4PAE3bquorAZySUQwIKB4766Ht0sTejilQY
         n2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XM2IfrgxVPzqzeM7H+D7DDdn97FLGkknUncHTuq8NKk=;
        b=bYCIuwjxgHc9oVvKtK8vj1iqdeWHRPw0SjdcuFA1XNyVeBWPjZZwAO+yXdAcnjfAri
         1KaQX57DLffJ5m+XCwObYBaMxwJKSNTzWLru2+25YVDGzb1NHEyEapp1L+fo/OtPRZIj
         aJAnPyGr8zLVjEfN8fOW0Jk6uzDg00LwTfBuTDtZeLOpt3lW2zP9Mrm10C6RzYfODVt7
         0M1fqyATN1s0Z2xACjHRPOCU6jrLvJzRo09DkAurY2IDqLygsqH5oXK4cwTCzyG4dWjy
         5ohalG6KxnsHnJlHXQOU+z5xU3JXfe40eu+7fmktkEt/dMTar1/n0YaKuxpWzLTxu/U7
         ujXw==
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
Subject: [PATCH 4.4 80/97] ALSA: hda - New VIA controller suppor no-snoop path
Date: Sun, 22 Apr 2018 15:53:58 +0200
Message-Id: <20180422135309.591024273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455325045223483?=
X-GMAIL-MSGID: =?utf-8?q?1598456302588779417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1549,7 +1549,8 @@ static void azx_check_snoop_available(st
 		 */
 		u8 val;
 		pci_read_config_byte(chip->pci, 0x42, &val);
-		if (!(val & 0x80) && chip->pci->revision == 0x30)
+		if (!(val & 0x80) && (chip->pci->revision == 0x30 ||
+				      chip->pci->revision == 0x20))
 			snoop = false;
 	}
 
