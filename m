Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA4217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867302;
	bh=8+Zfdi0LI3U38ikvTScbj/Nfv/G0afZsWPcvHMnPffE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EVimBpHc2HCHXvqrAstPIh5rooWstR48FEKjEILQETx3x08jmnJtOVVp/WVkPcpRo
	 xm4Id/U/Q0V1pycvPXE+YKCkcXi1G4fLfvHB98YMIP63TYSj1gVo32sDeVU3bAoufo
	 oQ52TP0eGohR8i5jD28qARJ1+Y77TFGZIZAZQpTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAGNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfAGMov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8FA20449;
        Mon,  7 Jan 2019 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865090;
        bh=8+Zfdi0LI3U38ikvTScbj/Nfv/G0afZsWPcvHMnPffE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZvr47R7QZJCaDNW6ULb58nnEfpVJOPDBQZYOOnScQUfZbvzeqm1nrKH/e6iULls8
         g78i/PheDNBpmTVN/HUgMwTGvGGs+8Fz8hEC4/GISF8D3c14ahy5wWjzspD7so8uaf
         lp56x2YdlDePeIkyoLCABv0dZKMM3B/tkEg5xCqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.20 145/145] tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x
Date:   Mon,  7 Jan 2019 13:33:02 +0100
Message-Id: <20190107104456.117336005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 2ba5780ce30549cf57929b01d8cba6fe656e31c5 upstream.

tpm_i2c_nuvoton calculated commands duration using TPM 1.x
values via tpm_calc_ordinal_duration() also for TPM 2.x chips.
Call tpm2_calc_ordinal_duration() for retrieving ordinal
duration for TPM 2.X chips.

Cc: stable@vger.kernel.org
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com> (For TPM 2.0)
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_i2c_nuvoton.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -369,6 +369,7 @@ static int i2c_nuvoton_send(struct tpm_c
 	struct device *dev = chip->dev.parent;
 	struct i2c_client *client = to_i2c_client(dev);
 	u32 ordinal;
+	unsigned long duration;
 	size_t count = 0;
 	int burst_count, bytes2write, retries, rc = -EIO;
 
@@ -455,10 +456,12 @@ static int i2c_nuvoton_send(struct tpm_c
 		return rc;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
-	rc = i2c_nuvoton_wait_for_data_avail(chip,
-					     tpm_calc_ordinal_duration(chip,
-								       ordinal),
-					     &priv->read_queue);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		duration = tpm2_calc_ordinal_duration(chip, ordinal);
+	else
+		duration = tpm_calc_ordinal_duration(chip, ordinal);
+
+	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
 	if (rc) {
 		dev_err(dev, "%s() timeout command duration\n", __func__);
 		i2c_nuvoton_ready(chip);


