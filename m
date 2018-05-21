Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoAg0zlHa3GvMBgAisdFjVdCvz9+mjuBXyNr33W/VFjHG8SNLmjUR3M+DUEFJCEh6bIgMwt
ARC-Seal: i=1; a=rsa-sha256; t=1526937552; cv=none;
        d=google.com; s=arc-20160816;
        b=wSgnGBIT76d4eGXA4OzLW84f6lyNR5D8ELacJi8iXNOST6+V/YvL/pVe1kmJ6yh4yb
         kXduYtsBzfsPjll0UlbaLm4zlYQhxM/NvC7KmAsOQiI2HczqvnaUF9N1xJ9iWwRg2G8f
         0O7QrtnKU5oFvA4Mfk4X2AU1XCPHVyMz+j+S+Ynuf33sr6A/5ijCIfB5WHI/O1/+WK3X
         d4oOpgelwSwprmnjx1c5QyktKvFEE4+85BIG+3j6EbMkCoFmeJdUpBw0Xztpaqga9OZ8
         1IK5Q6DGucGKWODH202rFRoAi9QZx9sKPAc/1PmeiRCANY8fBFwZYIAzBZIge+JeYcJn
         zR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zNIe4Y4ntQRusCMCeLycdh3JXfANm3c7wG3v+tr8QAw=;
        b=U5pAJ9MB0ZdT4HLwtQEVjtnXT9sAbSqokR4zxBlHMiP/c1UrcxzWSiSdjeYdyHe9N7
         yDKK7l8InWvVjfb7pEchjGv8lCLuBr2YgeSZ3EtR2IjMJWNq4LCYieL7CH2NiKdxOYsD
         rjmFYYSGhJgSYwOZ3hQclRtCg56FV3wEpKdbrpNTX7AREDUjf4LKnWREblwCBhhmfzDH
         sPYP6K+qOBZHCVK5VRm6fBgsdhv8YSGrokiX+lP2BktnIZZ3Yb3lYOvRmNYC0lnvuj0q
         eFcDF1Jn2TIql4SnbYjzzHP/r270Zaq03FBjzXxsbgpJ83w86j+rvDP2Nz8X/juXuETc
         m6sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G/PBBlfL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G/PBBlfL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 07/95] ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist
Date: Mon, 21 May 2018 23:10:57 +0200
Message-Id: <20180521210448.854686658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109772409939861?=
X-GMAIL-MSGID: =?utf-8?q?1601110070661445945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
