Return-Path: <ingo.flaschberger@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523817508; cv=none;
        d=google.com; s=arc-20160816;
        b=iLdtErZ6d/0FeyqUidBIi7YDmW4W5o5su803Hj5y/IsztqqW7O2UGHTGtoxVq8XJye
         A4ETAArnDqd2xR+IYDjA/N2yQt/Tce/XnJpYPDbMrKK48/fTKnB/UaIRZVXVwLckjjt0
         gk2MFgcQnuvVofdRVlWbYMPrOSR2kCu2cyY8MdFNs6YGpjQk7m0kNfRBDSSX8znHAeMd
         5YPusAw6/fUBYrjp6C9eKhW9XnVWeCqF5wdLgReG73CKSfQq+nJV4EuoraCoJdQMGn1Y
         wciMdh2JeBzjC+sPTQQcSjjFcjAd1MPZWocjwxM3lDOxRvO25dGLU0S0aISriG9KxK+3
         onoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:to:resent-user-agent:resent-message-id
         :resent-date:resent-to:resent-from:dkim-signature
         :arc-authentication-results;
        bh=13MQcFiv0AWfmNEIg+64ei445suodT5Kf8iqo8LAGlY=;
        b=lsgudXRfLLMKQS7PdNYTCg1C6GC2i2PCNzb+Q9UTn/IyiBTb2TxKIgNxcdtFeD4bGc
         FehVwKm9/ZDh8Ml6oYu6umFP9M6LV2tKJDINiNMUEPDJER4sebNBfFI25iUvzfd//Imc
         uWIT2afMoRVQAfzLXf4DZy7Ytkd3TlrJMJXKeCHltHFYTp6JCtrcSGWkPiXN1Zts4AoC
         NnG/bBhW8NG/kcnRB7REkwsoiz6kydmtkBaCAvIgkXqoamWzKduiEUHeQPFieaWq/unz
         6123U1Gs27osk9v/z6Sxb26zJf9xZpyJiiFxULYMivz5MipfE28C69VhpJ1g6s8RV/92
         Izmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=paHMn7qe;
       spf=pass (google.com: domain of ingo.flaschberger@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ingo.flaschberger@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=paHMn7qe;
       spf=pass (google.com: domain of ingo.flaschberger@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ingo.flaschberger@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49atiDhRo3G1XbZ96mF2v4ErhcjCPHQm/AMq1+QArhcx2w1jHgNd6LiL/amZGh1r/+q6kV2zA==
Resent-From: Ingo Flaschberger <ingo.flaschberger@gmail.com>
Resent-To: gregkh@linuxfoundation.org
Resent-Date: Sun, 15 Apr 2018 20:38:26 +0200
Resent-Message-ID: <48d658d7-8ce5-760b-040e-618be60ec808@gmail.com>
Resent-User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.7.0
To: Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
From: Ingo Flaschberger <ingo.flaschberger@gmail.com>
Subject: [PATCH] 1wire: family module autoload fails because of upper/lower,
 case mismatch.
Message-ID: <46d6cf85-d9db-7355-ae85-0b4206384fc7@gmail.com>
Date: Thu, 12 Apr 2018 02:20:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-AT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597647829539753113?=
X-GMAIL-MSGID: =?utf-8?q?1597838467261992680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

1wire family module autoload fails because of upper/lower
  case mismatch.

Signed-off-by: Ingo Flaschberger <ingo.flaschberger@gmail.com>

---
  drivers/w1/w1.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index ab0931e..aa458f2 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -741,7 +741,7 @@ int w1_attach_slave_device(struct w1_master *dev, 
struct w1_reg_num *rn)

         /* slave modules need to be loaded in a context with unlocked 
mutex */
         mutex_unlock(&dev->mutex);
-       request_module("w1-family-0x%02x", rn->family);
+       request_module("w1-family-0x%02X", rn->family);
         mutex_lock(&dev->mutex);

         spin_lock(&w1_flock);
-- 
2.7.4
