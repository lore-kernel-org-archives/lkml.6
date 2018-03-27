Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+eeRxMMjXxHTReLUjuecwhK7NQZgVAIwqKEQvVft2yxtcYL22Xl+AP9a0y1Wujj7PMvmba
ARC-Seal: i=1; a=rsa-sha256; t=1522140098; cv=none;
        d=google.com; s=arc-20160816;
        b=nHI97XiLz8fLjTjbAsCF6gfFeSQkDQlWmEP1SdOJniUA/9EnNjbPuEar4woY2d1rH1
         L8K/qVEGz+G5iGQEIwxiarP+HFdAilpzoK8HRvG3GkwxoNKIWbzsmvnEqN11m9JzTK5G
         KuBl6jIjTi8mz1WEWENfrCm35GzmaglJ+rya2tIGPtBoRa1IjkwbXNDitBKpdxXYPbh9
         eZVHu9Xt/aAna8vnFz7OYgC6UFGkffNR2ohf0kIeNnw24GyDYSKZTICgUY9wEociR0ji
         HkEomjTou2VjqhOZs2JKV0NrgusGcTjoT883PNhiEEMFZ7+E+OgyC9Y8JbISCFLvqJ+B
         XfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CtfUJp6nC/ZFnNAtmxBfoZrNas/wuu+4N8yRy6xuV1g=;
        b=rikTO6NMI20GymrhfP5hCoqgltzeXONZu1eq0EGZTqsDqSTjWWhZ+wkiwKWvapAAFt
         2gQrCvejEa0kVdqc2L9ZVl1OvPvwljQnXPVqLVh8nRvG+ckInbUAMhriGCQdExG6IHVX
         d0wJO3lfyCYNUpbITwXoKebU/qvJa8XbWTrmk7tZpwB7DhGBrA8VpO4GXlbE8QZrIs2S
         fl/sSm3cWMx4WkCRJFRZL+CtHG0GCoUDT2HTBggwkFdWPQnvz1IIgv0fG1Uad57KOsjV
         fRLSRftOkq4+sF8e+fqM3Ur9E9YSHQzKenPNgPB/NAg/vuABSXqfgznyZjfWG4xGFAI2
         2/4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 20/23] staging: rtl8723bs: Replace NULL pointer comparison with '!'.
Date: Tue, 27 Mar 2018 01:41:12 -0700
Message-Id: <20180327084115.16129-20-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:hod5TIP3QmdXynetD6gQ2S4hY+282QAu60DVZapMGa8AtDKP3Wy
 c2jhFrTu/McU69SZ3Yss6Oks765ZubjHon3zE4jx2+VpTXq1JINfbJ5uZUi0A/fFxoB559b
 ixTTg2O4YK4NgUuffGd5tgXTZfr/9innu+AyxaNy0ewgZTeA50YkkW49zSzLtsHK/qm/m7W
 spQ/igwiYxf0Vjkghll8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:++i3qnh70tk=:2sZq0Ght+wQlaJuT/Fu8n5
 7RX5WlB+4NpZA22LeMQK0lFVYDzgoL/7fR7wHoVWFLp+n82V5r+fI6RXfXmNQElHCQQ+RoQfu
 gD99THfGqNXL9Xb0euD1jeSsZ4zvTmGMqDjtjKZmgtf7iVQu5ktqOua02WEGMKYXa5SsWvA92
 Fexg4iWsGtstlstMIq3LoEa2CKXp32CZwdbZ0S4imvObK8l6xrZLe6ayVxqWn7RwIkJs5hNS3
 ZAhJkzsMacMxA+iTp6MVn/QQXVZ+HDaPzstu/yOjvKw8AJZqov80NB8lyov0jQYYDh+FptXRi
 HcCQ8RbE2xW6/YJMkuYej6fqLiq9PctzwLWDFSWHbK6DZGodwdfxiV9VKTjOkkxkNjM2jvMOE
 vEKYaIizhcNML6zHcOLCknNkZPHPPApsl/pZZp3McqvCBmUrmwtcsyzbk88huAaa56XydDVZf
 0lv6MLtVqb7rfpUhnQPr/rLN3atKp2qiK/6lZmfWmabg37wpd67cjpvNRFXCgHV8UZwxRQTG8
 TBvbEpNvfgJ09GSFbtW/MxikXnSEsNSw09FWi98WvLU5TFny9hDTqB95c26r5y/p7TjXzItym
 C2KEeoqd/OKERM4Ez4NnT7vKOMTTHJ0V6pw4FAViThIZYMjw2IC+ow4IZTC+QBD6XCZss7gRu
 43LA7LYN+mf9GdGsbOWoTEuUGhbSEIr1N8lh5ASpU9uovBQFjYluy3P/KM3I1EG54RXEsJgM2
 8EDibWxqw7ngPfBJrexykKmfu2QJn2C/yQwSQQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079576521015075?=
X-GMAIL-MSGID: =?utf-8?q?1596079576521015075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace the comparison of 'precvbuf' to 'NULL' with '!precvbuf'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 038481655858..7a294102b63b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -259,7 +259,7 @@ static void rtl8723bs_recv_tasklet(void *priv)
 
 	do {
 		precvbuf = rtw_dequeue_recvbuf(recv_buf_queue);
-		if (NULL == precvbuf)
+		if (!precvbuf)
 			break;
 
 		ptr = precvbuf->pdata;
-- 
2.16.3
