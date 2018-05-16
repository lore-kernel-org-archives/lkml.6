Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470748; cv=none;
        d=google.com; s=arc-20160816;
        b=H1YBmL1HMDdsQqfFTVilbTxwFzkN/PGnUC/rwxR4bIwbnai5KGahrU17uRzIcH8gWn
         okEpx7qJyJ5EkKotGHZuZp4MWVrPrfdN8J1cGplswONbLqlHtxIk+Maq8YFr1XlpIkfm
         oln7Mfx/m29AQFzyaFDM4sxLb3yNLw22TTv3NpHIJssfq2411WvHLQ/qF+mkv4ZDR8SP
         UqjPs7cc9rpGxSxIkBfI4UJvmXsr4PySq9KcKz7TbeuAE1mP0q17PjaGuBfgjfd7Ch9B
         HzM3LptCNMZyM/YSE0UF2FrQcE+ECMX8lHupMXCPPMeERbywsoT2Yd+XLYpuNEGC/4KB
         klLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=moYLAVtMFoh82H2cpoliO/zAjiUEYEFvmH6s+GcNs6o=;
        b=yOZ4MjeVXirIce3oBwhBbtSCOE6JwYUcHNrH2Wt7RWGtlQQn114qs+PRY4BPunDW/D
         ByJ9R1W+UkEAoT/3nzrUxXI4+FgPsYfUYH3UXTX723V8riilAIodkHWSj7i2ovIEwH6c
         8RDF11lHy40QoEz9WUbwmA5dtsPTDZXDH+QmMfFEgvB4nYM8yYBNb8Jfy9T+52QXwST5
         r62Af4K4JAyyxielDF1JifDGhEPOEZYs7k7YYiDWvNPqUz38mtpD+AHVBiyYBg2NGYqM
         9zoaorvqG/PKoWcn0lyfOUI+OtgEHxdCU+AfyTuuEpIpWy8X+QlPdLEBTi0MTkBpyVVs
         Wz8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TSyMG8oP;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TSyMG8oP;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoHAErLAoyzght0uAtT3IqantQcMMDXiABeO9Bto2iydNGfhy9McZyEUkTf2nJ2pwrcsj7Mnw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] slimbus: fixes and some helpers
Date: Wed, 16 May 2018 12:36:35 +0100
Message-Id: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620592089405427?=
X-GMAIL-MSGID: =?utf-8?q?1600620592089405427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Here is set of patches for slimbus, there are 5 fixes and
two helper functions.
Most of these issues were found while testing QCOM NGD SLIMBus
controller with WCD9335 codec.

thanks,
Srini

Srinivas Kandagatla (7):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: core: add need_tid flag to slim_msg_txn
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: add slim_prepare_txn() helper function
  slimbus: messaging: initialize completion correctly

 drivers/slimbus/core.c      | 39 +++++++++++++++++++
 drivers/slimbus/messaging.c | 92 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/qcom-ctrl.c |  7 +++-
 drivers/slimbus/slimbus.h   |  3 ++
 include/linux/slimbus.h     | 14 ++++---
 5 files changed, 118 insertions(+), 37 deletions(-)

-- 
2.16.2
