Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268dHqsKfyFQAzNKujpD2Tzk7Dd7kbarB0SNFsCMMceNdmjzRKd4QG4RNgaYF9p1WcqAK4y
ARC-Seal: i=1; a=rsa-sha256; t=1517855026; cv=none;
        d=google.com; s=arc-20160816;
        b=cdd6ihqHGYLM+EBpzW4ARX/DL16uVW7q4qnqPhvOkqcqq6SYlNNrZuZXuYjQrEk7Gp
         vLxg6nE2LVU3fDrLuT/aMRfgDzktC9LPPKjNA8jp1ye9m4kP1YaBNfwiqe8lr/nHOYrq
         FZCmIp5slWTx+vZVa6tphxRVy4C7G3TNL+FIasgdbmrc45jaCwQhyLWWvubZyT30CVUT
         uM/iNecudr0c3GrxzQmAVSthiDXAm3NTpl9ed18L3KJd8X3Czp5QO8f5FZWARGBsJbG7
         2LruhoLU8OGbINFAU1JnuuOWY6fbbUHFffJh3t2PXD/fSPvjrfw8vzl9ITYe080fsvL6
         OVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3V0eBuu1plxw9O23BWms7s5cA/dtKSBhDCFfiEXItnc=;
        b=ip07JWKZCzM4+MvPIx+4Ek74kTafVbj6H89vkptqVBLtHlrLUAgvsdSDG27/7k3pxn
         HIULgqKy2u+N2jZNP14rPoiagJPgHSSY4hCcBa+GNgKyDAxfMuEz7AXzDKbkXlIshDpu
         dIGn5RUK/XjQ61CxhjHLohFkhReGBrYmvJKwhk0TfkGGMyHs++OiQ7QAH17r1IcalPQb
         SpqpebXUsH7PVcdsq8p0GC1Kvgzg7GfaV3hpmNx7lWb18/MaM0hU9Qba4slQ+dqTXLv1
         o8iL6vVd5wVan1+q8qC3fkKU21AjN5iobueuqRJlStspGVFZfxnEPvvhwR+eXxI2vw3f
         7AWQ==
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
Subject: [PATCH 4.14 25/64] ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:44 -0800
Message-Id: <20180205182139.593107028@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586352448084681?=
X-GMAIL-MSGID: =?utf-8?q?1591586352448084681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
