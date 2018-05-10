Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZrq3YbUh/s8aXvqDpTUSkeLx+UWvFKjeX110HTD/IlTCe3fkNy2GFU15tTmdL0Q76kN77p7
ARC-Seal: i=1; a=rsa-sha256; t=1525982950; cv=none;
        d=google.com; s=arc-20160816;
        b=qokcxe85GpQATWUjLGA9/G1N0VQuCXRH27EV6jpGk5ur+nJdFOZloEbu1Hph+koKBH
         IAHQtsZsBGhgpQcLOgMHVqQ97VwOkJVAzVSfE6QIqg1Yuh4Sdspl+zysJvU5WxBUi5I9
         HMIu+xg+aI39HNxJy8Rzo9jD4Yw/6IbUf/DXUWLGdQIMJEgKLjYys83M/3nfrmWEt/Td
         CDumVX/8VNtBgOfCN8lmr0aQoDBOeIydlm8YcndFmI7aWP+tgMBLGbyQktVoTqd7VPZ3
         nVPQ76nGTxp3IBVzvnW21fpI2hXsW722uKFHrh9dgSbd2iNtCT/cEOFdPYDy4IBG3Rct
         0X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1/yIxWylvTrpm2FnXYBx9oRQ1Jg4PleGlia4+tRro0g=;
        b=WxpJL/lBLjJU+vcdSkogpo8tlP6EpD+PhHq7OQY1GT6Wk6x/XQVPUJjdTEjTrTzOra
         aUDGi7X0zbz5FEPvbOOAZfyTUCWEXQEAcfZVfuoWEn/Y0LoOXFPLdeUSX75qtkzqmQE3
         5ns5NDGqYLlOz/8fSZRbLU5QnDniCX5ZOPV2AMYlAwH6wDrY+fdQRTLwGp2mt0ueHO1U
         9TdMCtLyJtjMzMIVIjtqpVHYAdOoCRBksHNLw5dFTM08nr9bKK8MtKtAJzpwb0UOvQzQ
         ljFtrP65boyTLbJXQrtATvNXdDFTSkqZt0iXGNqz8e9uuARbUwcevhz6sVguIaJQKFmC
         5Gfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Oh7qt60W;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Oh7qt60W;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 11/14] ath10k: re-enable the firmware fallback mechanism for testmode
Date: Thu, 10 May 2018 13:08:47 -0700
Message-Id: <20180510200850.5958-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109098299792292?=
X-GMAIL-MSGID: =?utf-8?q?1600109098299792292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

The ath10k testmode uses request_firmware_direct() in order to avoid
producing firmware load warnings. Disabling the fallback mechanism was a
side effect of disabling warnings.

We now have a new API that allows us to avoid warnings while keeping the
fallback mechanism enabled. So use that instead.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/net/wireless/ath/ath10k/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 568810b41657..c24ee616833c 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -157,7 +157,7 @@ static int ath10k_tm_fetch_utf_firmware_api_1(struct ath10k *ar,
 		 ar->hw_params.fw.dir, ATH10K_FW_UTF_FILE);
 
 	/* load utf firmware image */
-	ret = request_firmware_direct(&fw_file->firmware, filename, ar->dev);
+	ret = firmware_request_nowarn(&fw_file->firmware, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "testmode fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.17.0
