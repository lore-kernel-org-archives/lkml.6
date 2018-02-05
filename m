Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258TrMTrRxaEW5nNfuRnHWQmo1cs2+aKJWhEU/2mpKOK8LW0kfsBEPOqflHqG1kreKcrkMa
ARC-Seal: i=1; a=rsa-sha256; t=1517855160; cv=none;
        d=google.com; s=arc-20160816;
        b=PIILYIF7uvb/r+eA4FCbL57ToZlaZY/+QeuA7iWQ2rEX0YDUB8Bhc3TEz7npSXZ5HG
         Afa0RxJ/WSkEsW09YxuATiybJXxZfVgmWKw97RSDA5FRCJPRI6FrGfWXNmwdvErz/h4n
         4vXcKIPzb1OZhnOvX+k5bL19/XfSM0whJqaLkhAT5JBdpaVW/lLSGm6xoeyNnbvG+w6a
         Ert1nzPszrUTRlxcfIjZuapOMVhUjprXfncZzS+8XErZqRAaylDY9JLe8jM34oB38CKY
         V86nVWTH3FMLjEkflY9OKfaAZFKM6m1LesGdNtVPtyRmWoefo2GVJg82hLav7fvDw2oD
         XGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FZPqMHR/5VFABVfjCqWSlWKo4b6VSKFJEOJQ+V1QZC4=;
        b=YfGkJ1oaXaePQ1qyNeYL3i1YAjFBK4aVNVdju5Zfxy42XSnX7Xsl3EyG6aTtQo5BVq
         Z4Pp/i5f4NUAEL00+RtpXAxmOnh4689zrQwIayJY1fa/nsaLUw96ZgoFC2y7sTu+d4SU
         D2hr+sFuEEtFxTxWVEWO4pSk24hCZxzgxJiUlc93TdTdpuB50SLAaI/sC3oP1elGyZk2
         E16vnw+s1MnnmkNkF5gG3yAUmZN/6zPpfeI/FkGFasTRNLzFwhYw1hY2YZMJ5kR4UkyD
         uPmfaJu4ZlB1Ocpzjn/o+YdyYJIBGzO5NvMz2wvCMXk+E9uiBR3uTO9C0iNZUxaisadx
         GHFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 21/60] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:54 -0800
Message-Id: <20180205182214.800067772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586352448084681?=
X-GMAIL-MSGID: =?utf-8?q?1591586492057135313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 0cab20cec0b663b7be8e2be5998d5a4113647f86 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm512x-spi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -70,3 +70,7 @@ static struct spi_driver pcm512x_spi_dri
 };
 
 module_spi_driver(pcm512x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - SPI");
+MODULE_AUTHOR("Mark Brown <broonie@kernel.org>");
+MODULE_LICENSE("GPL v2");
