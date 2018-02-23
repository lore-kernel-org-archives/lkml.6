Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22482Wtp6CgnVEh45A7YY+zsgW0rDBmXgsDQ7GM2cCKjL2usD15hU3oMECc18t/a4hTHTU8H
ARC-Seal: i=1; a=rsa-sha256; t=1519411869; cv=none;
        d=google.com; s=arc-20160816;
        b=qrnwueOuIPg2gRlw+hXuM80F+2Axor9MvD9nvmG/Z9g+Rc++8onMdbEbKsEvDSTxpW
         luXgzklAzwminzPSpl2dN+BN3fBIK7QCMvjR7POzOaFAzU4Smmq5JUAOCYw761vwRwVY
         nSAEXhPBaAh4WpkX7e7MWXmGq9GlJrlT39LpJ5YR4VafzGxYne9gLTG6T3jEITmIVXkZ
         Z27+j5X9bA4Tt3q6u/uVZUlPbbZYy1DGCuR0ads47ytCDNeWM0Cuh7lwByOsrB19UXWA
         u1Quq0LJGHd0Rl90fJhSG3P1fyOXXtmeT1uK6CV5UKExfA0XGJcqo6HrZKMihnzU8xek
         ocog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fWKVPvs/W0W2yUTjIe/tXtrI1ziwpFaW0DteS8GDAGk=;
        b=XWb2aijOctuhQBFJ2MchhF3ntFTKR4LngDxnjTFpf5YYMtFlMf1WKVo8rvJB7m1tMB
         3xlwZPEGnkrt2b7DEE/IKU075RY7OGpqk3X9lDu6rwmO9Js6QlPrOfQsHdTDXWzxTafH
         kShm5yjHlN/BGIzxDKhkSV8eQfRKdBvI0b9NnT8LSDs2xcFm0pfts3u5IbsAarOPCGEz
         T7Goda6bTn/Af29Rqkpv2IGnfrQxdtxAnb1x3smpsdGPRte0WBrVY6Z157DRb9r+rBlr
         4YO9ETzwqNNrl3E4Cpj6BIpCEXpxVBV/Y23htD4LoDXQcFxgQp2LQ0eDSEC+P27RNtco
         UoVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 045/159] ASoC: ux500: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:25:53 +0100
Message-Id: <20180223170748.829839341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217561163131306?=
X-GMAIL-MSGID: =?utf-8?q?1593218821178919554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1783c9d7cb7bc3181b9271665959b87280d98d8e upstream.

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/ux500/mop500.c    |    4 ++++
 sound/soc/ux500/ux500_pcm.c |    5 +++++
 2 files changed, 9 insertions(+)

--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -163,3 +163,7 @@ static struct platform_driver snd_soc_mo
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -165,3 +165,8 @@ int ux500_pcm_unregister_platform(struct
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
