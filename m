Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B1C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4320855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBISU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:20:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45907 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfBISU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:20:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so4074982qka.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6hq+Xb2DDfqW+2rdHiwhS/TBnov4CENJ/PKiUFB9kBo=;
        b=VZdGSEeFlt3XUAmPiwlAuWCIIr4IMoZxfAijdnXWW/HlNUadktBt+sWnn5ACXWGeak
         aFdR2Lklv5kPSzM2OOLHtha1VHUX/iBmQx9TvQVCjBGdOvISFLEWGuq+Sr6Z3B9IWcQw
         0LugHRBwBnJX2Cxt2bEQ850RHHDF6fVCcPSQnuxeQphVUkOEo3APEC6NEtwbZo1nsjSs
         6kgnJxmk38kb2dP1NCXwgQMHbEh4VYEjS1kAeUWQ0NepnXSiSotDlO3JrY67JxrXZk6q
         gjzG/3M7Mf2UAsT/FujknzaGZFPyXNsdZF+ARdWYNn2wnXed8fPuKkVrmNWOVp5Vd3WK
         P1Pg==
X-Gm-Message-State: AHQUAuYdFO8+iYtIFfFewX+a8G12vjwH3jrYyX20O85nspo72Yj+Xejt
        0wW35cPS5vqGn3CVX2dKNia3lg==
X-Google-Smtp-Source: AHgI3IYxN4zsT2m8sHIqm+qiyIhLBSu7lD4rjKvanBxNiW9lcNtylopTCfsSgWFXry6WvXCtJ4XI7Q==
X-Received: by 2002:a37:c30d:: with SMTP id a13mr18652204qkj.18.1549736424651;
        Sat, 09 Feb 2019 10:20:24 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id s13sm5737673qkl.71.2019.02.09.10.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:20:23 -0800 (PST)
Date:   Sat, 9 Feb 2019 11:20:22 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: Unify the send callback behaviour
Message-ID: <20190209182022.zghnna3fa3a3x3w7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 08 19, Jarkko Sakkinen wrote:
>The send() callback should never return length as it does not in every
>driver except tpm_crb in the success case. The reason is that the main
>transmit functionality only cares about whether the transmit was
>successful or not and ignores the count completely.
>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
> drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
> drivers/char/tpm/tpm_atmel.c         | 2 +-
> drivers/char/tpm/tpm_i2c_atmel.c     | 6 +++++-
> drivers/char/tpm/tpm_i2c_infineon.c  | 2 +-
> drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 +-
> drivers/char/tpm/tpm_ibmvtpm.c       | 8 ++++----
> drivers/char/tpm/tpm_infineon.c      | 2 +-
> drivers/char/tpm/tpm_nsc.c           | 2 +-
> drivers/char/tpm/tpm_tis_core.c      | 2 +-
> drivers/char/tpm/tpm_vtpm_proxy.c    | 3 +--
> drivers/char/tpm/xen-tpmfront.c      | 2 +-
> 11 files changed, 18 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
>index 64dc560859f2..13dc614b7ebc 100644
>--- a/drivers/char/tpm/st33zp24/st33zp24.c
>+++ b/drivers/char/tpm/st33zp24/st33zp24.c
>@@ -436,7 +436,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
> 			goto out_err;
> 	}
>
>-	return len;
>+	return 0;
> out_err:
> 	st33zp24_cancel(chip);
> 	release_locality(chip);
>diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
>index 66a14526aaf4..a290b30a0c35 100644
>--- a/drivers/char/tpm/tpm_atmel.c
>+++ b/drivers/char/tpm/tpm_atmel.c
>@@ -105,7 +105,7 @@ static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
> 		iowrite8(buf[i], priv->iobase);
> 	}
>
>-	return count;
>+	return 0;
> }
>
> static void tpm_atml_cancel(struct tpm_chip *chip)
>diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
>index 4720b2442ffe..aa11c8a1df5e 100644
>--- a/drivers/char/tpm/tpm_i2c_atmel.c
>+++ b/drivers/char/tpm/tpm_i2c_atmel.c
>@@ -65,7 +65,11 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 	dev_dbg(&chip->dev,
> 		"%s(buf=%*ph len=%0zx) -> sts=%d\n", __func__,
> 		(int)min_t(size_t, 64, len), buf, len, status);
>-	return status;
>+
>+	if (status < 0)
>+		return status;
>+
>+	return 0;
> }
>
> static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
>index 3b490d9d90e7..3b4e9672ff6c 100644
>--- a/drivers/char/tpm/tpm_i2c_infineon.c
>+++ b/drivers/char/tpm/tpm_i2c_infineon.c
>@@ -588,7 +588,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 	/* go and do it */
> 	iic_tpm_write(TPM_STS(tpm_dev.locality), &sts, 1);
>
>-	return len;
>+	return 0;
> out_err:
> 	tpm_tis_i2c_ready(chip);
> 	/* The TPM needs some time to clean up here,
>diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
>index 5700cc2ddee1..315a3b4548f7 100644
>--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
>+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
>@@ -465,7 +465,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 	}
>
> 	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
>-	return len;
>+	return 0;
> }
>
> static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
>diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
>index 07b5a487d0c8..757ca45b39b8 100644
>--- a/drivers/char/tpm/tpm_ibmvtpm.c
>+++ b/drivers/char/tpm/tpm_ibmvtpm.c
>@@ -139,14 +139,14 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> }
>
> /**
>- * tpm_ibmvtpm_send - Send tpm request
>- *
>+ * tpm_ibmvtpm_send() - Send a TPM command
>  * @chip:	tpm chip struct
>  * @buf:	buffer contains data to send
>  * @count:	size of buffer
>  *
>  * Return:
>- *	Number of bytes sent or < 0 on error.
>+ *   0 on success,
>+ *   -errno on error
>  */
> static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> {
>@@ -192,7 +192,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> 		rc = 0;
> 		ibmvtpm->tpm_processing_cmd = false;
> 	} else
>-		rc = count;
>+		rc = 0;
>
> 	spin_unlock(&ibmvtpm->rtce_lock);
> 	return rc;
>diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
>index d8f10047fbba..97f6d4fe0aee 100644
>--- a/drivers/char/tpm/tpm_infineon.c
>+++ b/drivers/char/tpm/tpm_infineon.c
>@@ -354,7 +354,7 @@ static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
> 	for (i = 0; i < count; i++) {
> 		wait_and_send(chip, buf[i]);
> 	}
>-	return count;
>+	return 0;
> }
>
> static void tpm_inf_cancel(struct tpm_chip *chip)
>diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
>index 5d6cce74cd3f..9bee3c5eb4bf 100644
>--- a/drivers/char/tpm/tpm_nsc.c
>+++ b/drivers/char/tpm/tpm_nsc.c
>@@ -226,7 +226,7 @@ static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
> 	}
> 	outb(NSC_COMMAND_EOC, priv->base + NSC_COMMAND);
>
>-	return count;
>+	return 0;
> }
>
> static void tpm_nsc_cancel(struct tpm_chip *chip)
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index 60e2038652b8..b9f64684c3fb 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -481,7 +481,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> 			goto out_err;
> 		}
> 	}
>-	return len;
>+	return 0;
> out_err:
> 	tpm_tis_ready(chip);
> 	return rc;
>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>index 26a2be555288..d74f3de74ae6 100644
>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>@@ -335,7 +335,6 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
> static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
> {
> 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
>-	int rc = 0;
>
> 	if (count > sizeof(proxy_dev->buffer)) {
> 		dev_err(&chip->dev,
>@@ -366,7 +365,7 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>
> 	wake_up_interruptible(&proxy_dev->wq);
>
>-	return rc;
>+	return 0;
> }
>
> static void vtpm_proxy_tpm_op_cancel(struct tpm_chip *chip)
>diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
>index 1259e935fd58..4e2d00cb0d81 100644
>--- a/drivers/char/tpm/xen-tpmfront.c
>+++ b/drivers/char/tpm/xen-tpmfront.c
>@@ -173,7 +173,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> 		return -ETIME;
> 	}
>
>-	return count;
>+	return 0;
> }
>
> static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>-- 
>2.19.1
>

Does st33zp24_i2c_send need an update as well? It does 'return write8_reg()'.
