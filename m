Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036976; cv=none;
        d=google.com; s=arc-20160816;
        b=KWVm9+hjrQhxtmiM3w80Dxh+DBnKIAv7aytSvcsn2uwu6FbLourxHqUieVfkkkx4P7
         mgJQ5d5jy2fSW9tckF88I0WTwRsya3e3wTL9xQjbCssnEy4y9sVomepL7/N0Wb90n8bl
         kav5poyRhqRFZEW8hpRMTO6yyplpN7XU2K9HgIEZba3tzTi4uzicoYNT43w/fnDbLuMh
         iYn7Feknz2c1GBhShX+zGoPHOm0xfopuuB87kXTkEeaSnGbWuEZnTySNVv7KlGGzOo+w
         jSLFvjlgHBPqLQdzg49qnbIOnQ/pTnHc5CPBUFyxQa4B6V72kh8hO36litm8Qs/gU27g
         G0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=eDLacnyz2Sx4d3x3swArJATYhMnSB+WxXyrGozFdY0o=;
        b=An2FkvoDmL1xXVlh+4fWPcAygzze0zGbShli4jLRDU4cTMHkDv7+LAmykUunLiaz47
         I4i4zZqLw9LtWnukQ4I719Z5DCCwF35EoQzuQyqu8YSM3NTCH1jngGYtqdkTcp0skR5A
         J2g17wuY2DgBfPGKjgg3uHEH6mwpB2Rbj6sOMLnToMMExaqTK35ex2vfJ/ikeGCN0bcd
         Oqcd146hPRQMZRFQwLUuuQBpJw+i0PfCZxyhtuWveI3a6lEvRgpxSVa+dHm09MWMc1CX
         FM+t0NYICsGmeWaw5cG3o8cIiEXw/Yrl2jXgZO68r+nGyVJHvDgD95nyu/wz1blrPXY0
         QKMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LM86dHfH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LM86dHfH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpt623jSFn9DeA1jeCezeiO4EF9GXGLTEproplwtQPiKrVUypSGViB8LOWw1NDlgJp8B7qJng==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH 7/8] nvmem: core: describe add missing dev function parameter
Date: Fri, 11 May 2018 12:07:02 +0100
Message-Id: <20180511110703.4924-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165748806704824?=
X-GMAIL-MSGID: =?utf-8?q?1600165748806704824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document dev parameter which not described in devm_nvmem_unregister
and devm_nvmem_register functions.

Fix below warnings when kernel is compiled with W=1
drivers/nvmem/core.c:579: warning: Function parameter or member
 'dev' not described in 'devm_nvmem_register'
nvmem/core.c:615: warning: Function parameter or member 'dev'
 not described in 'devm_nvmem_unregister'

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b1c95ef78544..36361044ddbe 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -569,6 +569,7 @@ static void devm_nvmem_release(struct device *dev, void *res)
  * nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
  *
+ * @dev: Device that uses the nvmem device.
  * @config: nvmem device configuration with which nvmem device is created.
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer to nvmem_device
@@ -607,6 +608,7 @@ static int devm_nvmem_match(struct device *dev, void *res, void *data)
  * devm_nvmem_unregister() - Unregister previously registered managed nvmem
  * device.
  *
+ * @dev: Device that uses the nvmem device.
  * @nvmem: Pointer to previously registered nvmem device.
  *
  * Return: Will be an negative on error or a zero on success.
-- 
2.16.2
