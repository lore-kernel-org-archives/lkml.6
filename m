Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu9zMTXbYnWl+9fNezSbIde3AC5yjWtqz2Ncf14cDXR7a/gOTs9xR49nA0+JOg0x6DW2Wqo
ARC-Seal: i=1; a=rsa-sha256; t=1520955356; cv=none;
        d=google.com; s=arc-20160816;
        b=GtZWHaIytu3yDGPEx4tlm8fEm7z9E9Jo83oU9KeKx0SDGY8xFUQWwPj38X7FtfSkjE
         LpJtQchQhQyOw6/E00CMLJwLFgRklMdDuTWxZmBkzV+cwN7jtgGa/dLJcL7gZbCQv9e8
         60BilFJS3/QwFTpEoJxOoEs/thUeKgrnLsPSLzXEHXdDv+N3zvlQBESEh3wgbuEG+RvT
         iy61umQYpAMgsawC/YW4OdrjEXgzqxkJNhySplWFjCkV/dIDUSqXc23AjvDl0JjYQIb3
         iUcxYAXy1Fv/KzQvkHNRAKbqf4KLotwCPsz6n0Y278JSDz9zh5CB+lrxppqvXTv9NHVV
         Q7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KnjJ0LmNhpI2/UYWFbwVgBJK8LCf9mb5Fhrp4oNLcgc=;
        b=wYVOG92y12VATErPGCeYdBC/AaqjqRlicvQQOwHW3lc3kvZE1qptl0u9EAgBb6lcJ7
         fUqodygjmFP8Z7ftyuFEXM4czEsyuOKjynPvmiww9KgBEdNfspRSPtZLFFS9MauT5zw1
         rffGA98HZcYp2Xgv90xFqGpThFnEOQt1Jfdj2Txpb3plSJz0CAgz9Z38XTZO5kBFzbt7
         r9nzMn1WgJAWKx8mZO614lVIRTRjVT3DQbX+dkiE2qMecaviD64ZYhOel4k1A+bQfQVy
         GUXc3FGkaAk08TN5plXh7Hd9k5rB83QdelSl+eoZBHkCOGAQukUtJVjzPCGmlQ3gXnyD
         Mw8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	James Morris <jmorris@namei.org>
Subject: [PATCH 4.14 022/140] tpm: remove unused variables
Date: Tue, 13 Mar 2018 16:23:45 +0100
Message-Id: <20180313152459.534528444@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837116260369951?=
X-GMAIL-MSGID: =?utf-8?q?1594837283947939385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 68021bf4734d15c9a9ed1c1072b9ebcfda3e39cc upstream.

The CLKRUN fix caused a few harmless compile-time warnings:

drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_pnp_remove':
drivers/char/tpm/tpm_tis.c:274:23: error: unused variable 'priv' [-Werror=unused-variable]
drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_plat_remove':
drivers/char/tpm/tpm_tis.c:324:23: error: unused variable 'priv' [-Werror=unused-variable]

This removes the variables that have now become unused.

Fixes: 6d0866cbc2d3 ("tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: James Morris <jmorris@namei.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -255,7 +255,6 @@ MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
@@ -305,7 +304,6 @@ static int tpm_tis_plat_probe(struct pla
 static int tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
