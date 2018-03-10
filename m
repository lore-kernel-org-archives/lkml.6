Return-Path: <kernel-hardening-return-12349-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtwBwFO1DFT9bxA9BHeXjpwlQ5UftFfxchJKhgbACNWXZ5DBpHgUqYfUP8ufXs/fOTPh7IQ
ARC-Seal: i=1; a=rsa-sha256; t=1520640649; cv=none;
        d=google.com; s=arc-20160816;
        b=V6WEfwviFUm1JZy38U8DhfweGtQgwZJOgIr9C3CiHBMEjV762Pt21jqNxBH+GDYce+
         IPY9DwTD76R62mYFzPnzIKFv9eyzviLZ5i1XnroO7XJMUbY0vfd735s4BBfs92dTz0gN
         5V71PkmwyvCmpem71TV8SkcERsZxUn9NGc5XzVKnmwZeYra/sV8JwJSsZy5bKkUVMd5V
         Ua6Vpf7R0HBYBOK1rPJ3zxPaZ4OEFdv3Cir6UvR9/DgLxlEbWnnpEbAtcW9qjhjakBta
         s51QJYX/3QoL6LjMtEWbozFLqbcYY8sktmxNp6Xnj7UfR5Sk8gp+ikoGQAODYmyGDw3p
         3W2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=IBd9OZLge3AY6G9096e8hor2bDOooalwwRNfV7wVINs=;
        b=RB/8VJq9DWvo0mi5Mo3hc1LCsI5lxzDsRhg55JZmK9QIAOs0CLgzTXbmqcJPmAwGbf
         cg+40JkNOZEMaOw24YPNF+S0ar8rWL79FJZ/pDhQM/CNzsqcMQE9ujrb0wLsCqrNIRlT
         cJHCkudDnW4X00G1iKRNkjlkc/ZgVuqja672cC17ZI/Faf0xiLlXTLv3CizgYb1h0maV
         eVV5LcSFmav24T7g8CkRMItVpPxvhHj5lLf4v/F5jKqP6Bq3I3qXm8xSd3bKXpDHSUdQ
         ZqXdlpRZx7ScA5RUwYLC8zz+b+IHNrx527d+B3ClRrUOy/WPLmCpXjs9xIqd40toq3fe
         xpww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12349-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12349-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12349-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12349-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>,
	Nandor Han <nandor.han@ge.com>,
	Semi Malinen <semi.malinen@ge.com>,
	Patrice Chotard <patrice.chotard@st.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCH 0/4] VLA removal from the GPIO subsystem
Date: Fri,  9 Mar 2018 16:10:17 -0800
Message-Id: <20180310001021.6437-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507290189676556?=
X-GMAIL-MSGID: =?utf-8?q?1594507290189676556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

For those who haven't seen it, there's an effort to remove VLAs from the
kernel so we can turn on -Wvla in the name of security. See
https://lkml.org/lkml/2018/3/7/621 for more details and discussion.

This is a series to remove a few VLAs from the gpio subsystem. These are
compile tested only so I'd appreciate reviews and tests from
maintainers. When these get Acked, I expect these to just go through the
GPIO tree like usual.

Thanks,
Laura

Laura Abbott (4):
  gpio: Remove VLA from gpiolib
  gpio: Remove VLA from MAX3191X driver
  gpio: Remove VLA from xra1403 driver
  gpio: Remove VLA from stmpe driver

 drivers/gpio/gpio-max3191x.c |  7 +++++-
 drivers/gpio/gpio-stmpe.c    |  7 +++++-
 drivers/gpio/gpio-xra1403.c  |  8 ++++++-
 drivers/gpio/gpiolib.c       | 55 ++++++++++++++++++++++++++++++++++++++------
 4 files changed, 67 insertions(+), 10 deletions(-)

-- 
2.14.3
