Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227EOs+yEeLXp1iLJw7hpVir1PXl+58NxcZzK/5lwmCwv2jIq1c+OZjQsjPRxOAx0yEqjY5q
ARC-Seal: i=1; a=rsa-sha256; t=1517855216; cv=none;
        d=google.com; s=arc-20160816;
        b=lGoFqh/X7k9CBc4QHjxx6CIHiHZy+ike3+bOdPu7dMNRZyuBgc8dWvLGlnezY8snUg
         mOzrLU0JFZA1T4598OzxTku94dqDrxtW4RZULyX22Njv0kKaH4Dm3WtOEC5circHmrjT
         F/V8pJ25pJ/Ssk0QcA+rCiDBqiLSqaKkhl1RpZPQJN2LQbVOgPw/dqloHs5t5xN52t1U
         6CdnVG0als+UJA52/+ZUHdpUWFXi2jBCp4eOvXXzKJygLZ5DC6P7rv425c8k7MPljk1c
         064ZVrCHv/gsPVb3bQX5oKcXkW/iLZkW1jUjMcemm7JpiEiy7oid+RjyIAU11jD4IjDQ
         Psfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rUnzaXbFQ+okJ34RrskJhY63HIJRr+sS2YdbexPt7Uw=;
        b=k8FL/S2BWcSOrMXgiG34w23/Se/oDvy0q0IYoMRhJ7pZqW7eXWo2zvO5eFpq91ra8k
         M0YZ3GaOgHc3OQAu/qBiQ4iLXfWgLombdO5Z/fyqXyciHFpfnHDwjg4lnUQ8fkRXKI/P
         PWKB6DqScS8YHJjXZ7bKsPFkCVhmnEAqTMWTcGuX6/D7pgVmo+SCjbSM8MlHkaVNx4wv
         InEeVzdGUIwFCUH7T7Dr/ucrCOxC24f2a7HFK2Y5iBuvIFapUbbyOs+fg4urgFHwDR9m
         vpIKeRjKE0EpEfnhVkXe7WWlj0Li/kbVs5IKUYeXLI4UITmtn85L16FP6rNyZmlbXQuo
         UXYA==
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
Subject: [PATCH 3.18 36/36] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:24:04 -0800
Message-Id: <20180205182353.256658352@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586352448084681?=
X-GMAIL-MSGID: =?utf-8?q?1591586551287067434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -67,3 +67,7 @@ static struct spi_driver pcm512x_spi_dri
 };
 
 module_spi_driver(pcm512x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC PCM512x codec driver - SPI");
+MODULE_AUTHOR("Mark Brown <broonie@kernel.org>");
+MODULE_LICENSE("GPL v2");
