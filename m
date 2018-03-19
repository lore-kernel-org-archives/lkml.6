Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsq2twJ/AJlWf6+7jNjG9dl8cpG9yvxrYSBteNSSTazhA0oDfg+OUxE2wWkR3ZFptXj//EL
ARC-Seal: i=1; a=rsa-sha256; t=1521483879; cv=none;
        d=google.com; s=arc-20160816;
        b=fb7+uxQRfk2TRs2ASYTpBHvFXM0b7t7hrdm3FYM01eXx1Vdv1Ztfe7hSf5ZmYUHqkw
         F3zKoQhXL9qFtjIORq6zOwl4lvZyd2XV/qo5HCbSF6bfXXGS8TeRYS5sQPPfJoqEF2M+
         zPXbFusiYVyuztUehFRDJOAb3jXb2+J93cQwSAcpBKtzB30jjDrDQPR3mVTx4NRGUfxx
         yOo6VbeTDytVkM/LgfE4hZA5EwJBc51ieFGjB61UuvJa98AhEOZ4sffd/IkwN3iblV2q
         yrFYpuPEp6TBSnxV/VHF5jtBoC2KcB24tJQajzsB7HzTCL/3i/BvCXHQjw2LW6oKFeT7
         ATUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Ow/VO5JDVz16uZX4rvzqz6VmEpPj+og87ZGJ+aNJS0=;
        b=dkEHIYPdva7UylBmASpYFiPvCNfxV/ztNHBiB2cNHgWLRkeITb0Irf6s678CXWxswM
         esKb2bet9EhLQum0rRx+zirGUaYAlsPLmrEZ0IaHJa3b3S8ippExplqCKoRJwxmPSAxT
         ubauEZy4v6oWukVzgoC9jzQxgNly2O35VwhfFBmOP9dvfVayk5jA5+qa97Y3Y/A6kJWB
         dO0eHwAVr6uWiF8rdBT2uBmQYyudNdxZ9y3EHnLlUrPJtqmYYooIaJFZwVeqOWry69TC
         9S9wgjq7NafpwHdNwfpT7PZ7p+Jk88OncL+M/bT4I10bamrhu5tWfTP9ru3pDiskMIRq
         x9aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
	Senthilnathan Veppur <senthilnathanx.veppur@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 151/241] ALSA: hda: Add Geminilake id to SKL_PLUS
Date: Mon, 19 Mar 2018 19:06:56 +0100
Message-Id: <20180319180757.434053664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391479995544693?=
X-GMAIL-MSGID: =?utf-8?q?1595391479995544693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>


[ Upstream commit 12ee4022f67f8854061b46e5c0a7ad6258ab66c2 ]

Geminilake is Skylake family platform. So add it's id to skl_plus check.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -369,8 +369,10 @@ enum {
 #define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
 #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
 #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
-			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)
+			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
+			IS_GLK(pci)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
