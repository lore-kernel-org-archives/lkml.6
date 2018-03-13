Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsIJOqNpBoCW2vmnOkYTZLWYQ/Xy02LxigsQVDsNKuHW9RCG38triu/4YWMyTWaA968Tbce
ARC-Seal: i=1; a=rsa-sha256; t=1520955196; cv=none;
        d=google.com; s=arc-20160816;
        b=LB9wi9s6W33syuHq3QOSbX8AAsv4u3+egd46Mh9ii8imSo5oZA7/019xgUjTvXspeB
         gc79efMp0jgJ+aanPCwO2ADAHr/ID0VHBk6GyTSPbldwFWkKdUgyr4E/PoE0JHlPxCeq
         h5S/igW84JWp7sJA8aOXyj+Rp8rT4wEqg4aEA3KPGbdEOxfJVIl4qGLpcQT5aBkbs2Ew
         dsNaZPYGGr8Y4+b/NtOUn10D6AF/0rNpqpwcdsoVTFcP6taKhJSx+7yQANmDzxxuaqPt
         fdGHW05pojkrML1+KvCyruoTv0pGrEnQQycB9ZYB2/FxUSCRHaNzIpiaprio+gWKRQMs
         b3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g21fPvHdoxV1Gu0r84oNt5o+Rt+TdZnvdGTqC7QrXX0=;
        b=Kk/rrYYuIF65P7WZPLjDVP1dnFwmiM4E4+xRKnfd7jgNtdlKShXn8S+zDNrvFuqEgq
         NsGvKw+krU8/AaKwY/Mbf3mxHDfyUwHGg2XybT0KMEP8ov8tOygFDZXjyyUxT5um1c8A
         4Fz+m1wIbFvuMduF8dZtgHdvI4bVEi/Vza0+FAKxG9RMN8LxJuaR6O+hYaYEYChiFINi
         6v/TxYdO+iL7p1CU0FQ30sbkJqTsNii73ofnTq0U8HjTQ4FT7KVtz/G2X4ACofdl9RUh
         UPFjWT6cYQ6mYDrJlpQllwzRmqbbWjUL7WWPanw7rc1NTwRA4bUk0k/zt6GlB8vD4uQv
         sW8A==
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
Subject: [PATCH 4.15 121/146] tpm: remove unused variables
Date: Tue, 13 Mar 2018 16:24:48 +0100
Message-Id: <20180313152329.607168144@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837116260369951?=
X-GMAIL-MSGID: =?utf-8?q?1594837116260369951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -256,7 +256,6 @@ MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
@@ -306,7 +305,6 @@ static int tpm_tis_plat_probe(struct pla
 static int tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
