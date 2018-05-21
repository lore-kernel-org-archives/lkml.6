Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqWgEzTsjp07kXLNnfnYhGbcprpSkM47VC82tdLpOphyr/rYFbY8ZSu4C2mzA4duTaEWwry
ARC-Seal: i=1; a=rsa-sha256; t=1526937812; cv=none;
        d=google.com; s=arc-20160816;
        b=MdFDv9D45BhFaLwAJHqwA1kHMUK3TeBk1JbbAQLoOF3fiUvYHowjLuyf7Z14+EPAD8
         Ptq0tLlB/xbESzEppwNNMMr5oamIerV9IkHbQF3/22gX/wUzg7FfVlxVqKfiveTMDKzw
         FQs/6rieHvmmw/1G8Ghc/Ya/gBZ9DHYT6gVYmkfxHcpxPOS5/uRNDouNSLEAFXfjlnda
         gFloVVeyfAKZnt76/FUYwdPICwz5jTWH193WaMAdkyCugMz+ZOnRPeRJvhTzi1q6r6Yx
         2SmjKo79iWN1BhrFnszMwzZkmWRt7pSrotzhjeWX37kPNY5r6yIr2kd9p3pgnxwWTvJ0
         OR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Hiy7TRGkPAC169D+JfLnUsqRwMQU2OwK3r7ggR87GlM=;
        b=e0SSmE/fxcp69N1mnllvtd0Q5wm6fP2SRuWf/7WWmzuDDB4Nm3rlBBRw70FGpiRvaT
         UwDFw6TWcS4lmdqyIb7Y3+neAt1rSP8yNGt7fOi57mr7LHmwxcwT99feuyqGkxmOLgL1
         BEyqN+xHThS8TnnkUOwKY7ys+fRKjzjdw9E2nEOjUOjmsYdd9DwPKq7IY9VG8MC0wcGo
         o9XSh8noT3i4MJEEDAfAbOijJOYQiZUUhnpqUxRGQ49BrYG0uR3TjmuGC2SdwDUUO5hr
         NMofGRaGhqjkfM/UQPSXA9mAaAVcN51kSLIJTuNehkN7cQ98DFg0Em5OfI0tZZpyNROn
         u0iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iijOfl+4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iijOfl+4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 009/110] ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist
Date: Mon, 21 May 2018 23:11:06 +0200
Message-Id: <20180521210504.743182997@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109772409939861?=
X-GMAIL-MSGID: =?utf-8?q?1601110343672951647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit c8beccc19b92f5172994c0732db689c08f4f98e5 upstream.

Power-saving is causing loud plops on the Lenovo C50 All in one, add it
to the blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1572975
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2208,6 +2208,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
