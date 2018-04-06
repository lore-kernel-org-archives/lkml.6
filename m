Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IE2FRkCOHwjrNg06rO7HlTbW+j6fk62mQD5OA/GJ2abLM8LK2iWmSwYabHhI6PfUCBSeb
ARC-Seal: i=1; a=rsa-sha256; t=1523021821; cv=none;
        d=google.com; s=arc-20160816;
        b=iiHCcoTbNvlZeID5soCyDLmEd6nDFpSodUsdjSioKXp76ORJu/J+fs2VEp53e2TdJ3
         6sd10jFdN8OdaWjzzP1Jj2laWM+9wkXgoPqhgjopMrHFAmQYyzqikNh58qKL1SBDXIv1
         NnNyMAT+RVGNhmB8RDfsCDT2iKyacDwj7B/possXYAZkH/0+B+7WD29t7wEKWSyzhA01
         z2HT64FPEBSsNoabqqlwShxE7hER4kJrRQVtRBVnFH+AkeCkZDxwFXDGSQphjE8gsTv9
         7b78tOpJPCQ/qpmxl7/Ids3ca5lmSKAFDvJ8cBJY+X2eCfdyrp0EGJo/BqtOouAIbpOw
         QfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FJ4oY4SKVayKaEkQooPXfSsMrGvPhQgh52H5/VxXHhc=;
        b=My4+lz1EfjHlHc5ZQPjMGvTfTfEcjYKscthxOx9bpLKad3rt1e1BjE/c4/wP/f0rpk
         gmQ3KK7D3ASzLrMlxmbh7AQbxBtyqO5c2j4WCrKY+dd/oWIqTOU/lPv0pt4ztIddzweG
         HBmpuOEf82KorTXPNtYQF0yv31FLO0bWw3PmKslstTVAcspF88+4c0IhIycNsIGQekXZ
         k0WXoQYV6GZ1f4q9KQ8JXCdZXOglHkEkOIxSbK/Jk32/4SiN5EZJ5TfcJQhM9vVomA59
         TwHc23VBDnIUEBcVr5x+Pa7jRh3wc1ma1NvP9YykUcDE97MsZQWM+DtgEZwcvAxdphjI
         uxHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 099/102] Revert "spi: bcm-qspi: shut up warning about cfi header inclusion"
Date: Fri,  6 Apr 2018 15:24:20 +0200
Message-Id: <20180406084345.286785658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004129852937028?=
X-GMAIL-MSGID: =?utf-8?q?1597004129852937028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit c30e6636ce101fd61331092c490b9d9c55b2d143.

Florian writes:
	Sorry for noticing so late, but this appears to be bogus, there
	is no MTD_NORFLASH symbol being defined in 4.9, in fact I can't
	find this Kconfig symbol in any kernel version, so this
	effectively results in the driver no longer being selectable, so
	this sure does silence the warning.

It's not good to just disable a whole driver :(

So let's revert the patch for now, Arnd can work on a better build
fix...

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -156,7 +156,6 @@ config SPI_BCM63XX_HSSPI
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
 	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
-	depends on MTD_NORFLASH
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
