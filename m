Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZra6OsFJ05LKGfqITuLIzVSGPnOmiKxmZU+amWZJyh8lG3X9Iy57jPbwB065pcd3owlBxMT
ARC-Seal: i=1; a=rsa-sha256; t=1526937267; cv=none;
        d=google.com; s=arc-20160816;
        b=ZLOF19C9AezWIWE0GLlbUxTlTuPAANnUT0GEIhZ/3YqXncPHL1C2gnhJD4kcR67eTR
         peDhKvfTQPxhl97R9RDwhpwjKdCeKNs1HVzDrx2sgqeT5d+Tm1NVuO37zqkpbe6y7vXs
         wEsDhFU9yjemnz4nJfWOEEeHys4E6mjUBKIdai2xVej9RNsULNySISirMCuTL+sJRcP6
         TY+D3lLQTvhAVMBeJnTIgPkGV2rMeE4DomuXyk6tXrGN0ZiqowZ/iFy9CP2RNn1IhnRJ
         0dxkVT2Un2PQqVMHUbZeYpz1SSmsxY1ABES/R69jJHI1lzyzBC82ajxVQoOlh1iTTMuH
         qqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=86kZReun5PXyQidnZXYi1bHoyMqWrZOwrRozX+3YgUw=;
        b=fgznykHJYxPkNMLpsjYt2JQLMROU49m7JZDTxVtvLLPOk3jnAyb3N08r2H/s8f2koT
         06AYTsIeYfEKeh1Jp3IWXuaSCgaey7UNVepgd2/FWGPeU8U/ZcSKYSTl8VMmbJTLWoDc
         CstwBfV+YcY54iFhDvKFCbwHxYbNlDBb7vTRQRW3E7IugiRvsFbOt6NgUJuWySiCSrFv
         fbL8GAIjDrQo8iPczhs7+o5DWVIc+K93VB9OvvWbIIVT14nZtkO5e1Fe10Y0MVjCtK8a
         0XCda9OtH79LIeqdzii1Td2nMg/Ba8FLcflRs3s8pZoe2yDBU1PEwtwbOvW+7BpepZGG
         sHtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yLhS7Jyb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yLhS7Jyb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 07/87] ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist
Date: Mon, 21 May 2018 23:10:43 +0200
Message-Id: <20180521210420.928304959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109772409939861?=
X-GMAIL-MSGID: =?utf-8?q?1601109772409939861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2061,6 +2061,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
