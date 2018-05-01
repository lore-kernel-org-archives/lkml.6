Return-Path: <ingo.flaschberger@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525183836; cv=none;
        d=google.com; s=arc-20160816;
        b=J+ifI3jnWR4WHFz0hzsXdFI9i0Xd0Kp6Cx5zVlNAFN2AbZgi3hFtQacVvigrK31jev
         0EZYkOuz8Q0Ny1g4h+kFZJ9OKkKLwHR92PBdmzotFQ8TrrBzuZwKisjr6SkWsX+1T56n
         HzUEuTE/MbPdWdM4qrnirQoUv1PhP0wYkn1pY39YKky0Hxdkk/O6gPIYdG0uSJJyqO62
         UXMD/OFsW3pxQXpij242d8Rn+kCBeMEdhqlSjS8Z8JKyV8TIRuSAy7NhlFlrw0tyAQrP
         WUjkfDsOpOBTGyUPMwDl88fLYu5PTxs9GWv6WnvVQctTKYcGYPDw1yjd2aXEXE63dVbV
         2f3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:to:dkim-signature
         :arc-authentication-results;
        bh=13MQcFiv0AWfmNEIg+64ei445suodT5Kf8iqo8LAGlY=;
        b=AauMkD6ODqCSr5AvJoqdmbn1xz6vYanqrAo+BpaGEJKnKqfszsjuZ+s8IN1UXSaLZ2
         zheGnNYSIpwtPMywwpAMclaq7NPjZ/2rz0qv7vLc6ZyAtuUBNlGjQ3xtq1eUeys+aIH2
         g9wL+wo0HRVcRBurkxdFF+AMncvgRk2aiaXgF0yc4zI/19iugy3Zd1wuXSiZ7OYRRycr
         05lanKKtWJdigE9yUVZAiPrK8TWjkwB0Mm2bMg1y6vRb9wnvmFXdDPOSCWlH9BKTwE/l
         oSBu2ISQqjTGtVq5avegE87SePhqcLPzxFQbGTCm6k7DEw74Mhr2LmkUdnNPmkfpqxHN
         dQjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ne0afZgW;
       spf=pass (google.com: domain of ingo.flaschberger@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ingo.flaschberger@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ne0afZgW;
       spf=pass (google.com: domain of ingo.flaschberger@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ingo.flaschberger@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp3QHBpr2rGP6aFi77/GZAA4N1Hy2a4FmYrpGWJRDT5lWUJgI621T96l8jM9UwGI4SgmyFhgQ==
To: linux-kernel@vger.kernel.org, zbr@ioremap.net, gregkh@linuxfoundation.org
From: Ingo Flaschberger <ingo.flaschberger@gmail.com>
Subject: [PATCH] 1wire: family module autoload fails because of upper/lower
 case mismatch.
Message-ID: <629ce39b-e3ad-1a4a-be11-7eb3da064ce6@gmail.com>
Date: Tue, 1 May 2018 16:10:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-AT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599271166540841953?=
X-GMAIL-MSGID: =?utf-8?q?1599271166540841953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

1wire family module autoload fails because of upper/lower
  case mismatch.

Signed-off-by: Ingo Flaschberger <ingo.flaschberger@gmail.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Cc: stable <stable@vger.kernel.org>

---
  drivers/w1/w1.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index ab0931e..aa458f2 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -741,7 +741,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 
 	/* slave modules need to be loaded in a context with unlocked mutex */
 	mutex_unlock(&dev->mutex);
-	request_module("w1-family-0x%02x", rn->family);
+	request_module("w1-family-0x%02X", rn->family);
 	mutex_lock(&dev->mutex);
 
 	spin_lock(&w1_flock);
-- 
2.7.4
