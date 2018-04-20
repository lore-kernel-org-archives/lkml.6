Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524242375; cv=none;
        d=google.com; s=arc-20160816;
        b=ZQfWKDNuWMM5CUO2TmAFm+t4Dnb0gsNznO3KOJpyaLbagjp21XIHRTnKZH/uShxc33
         fBYyZNqtHUv4lXK0mjApFguMA6YtIYoH+yuaYoFxP/6kWVNWwN6ZX/piPgujEmagxnJQ
         FIZZRiN+OhQxH3QnkT/sIPgbwARVWQeCr/aO5MiexT2MVhstxEyZAG+4NZNV1pe3eRBe
         lvv5GtPyPPrRhdJcfEYn/OmnPggo2weo/EXqFLzQpvAKhYf7qJmO/jBrf7T7r0MhciNL
         9+GGXNmXkXhwYWOGzXFB5NqiJi4PuTFDnWgK1aLc4pMPd56Cf9ccuP137licKj8S3+zl
         HTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=wKO8hpOnuzNchLA5vRjgNr2Z7wplgGRDNcTlfZ7RGRg=;
        b=Kze3epBSWJwYPh6rHcvFpzHiJIOU0YibW7DSnakHuYVIdlbgQyI98Tx424mAaoI2rr
         9M0BC2NE+7nlxORZywhCXtgBovV/VAFIAKuAp+yRAQqzAr5ozzf47LuTX9FvjVnTI3rY
         sG/WqCUsZv4SiCwwryyKHrBbRZstLO9ulJyanKSKh1Cvza8IHg/GKqVfbs0r6PR8XoG+
         FOWoK7Dj5gDivkOr2VGqT4VjzyHp9aNCtclCc3HNs/NFc2+QRHtPb8dv6fxQRdbVZqI4
         0RxZp+AaLwrNAdr6gUQbmxbH8WL/f/hRA21y5x6D74KMtpG6zrdUi+2NtpLPClN1+YS7
         KhZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=hsEL0mpP;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=hsEL0mpP;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx49lhQvwEL4dgWLvm9rd1piPFjrcce+SGWRXMpkFFKB6fifqSStwpAZctJcPwwTvSwX/bNzPOQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] platform: add two helpers for early_platform code
Date: Fri, 20 Apr 2018 18:39:22 +0200
Message-Id: <20180420163924.5227-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598283973578441604?=
X-GMAIL-MSGID: =?utf-8?q?1598283973578441604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'm using the early_platform infrastructure for converting the davinci
timer support to a real platform_driver. I noticed that it would be
nice to have these two helpers for more code brevity.

Bartosz Golaszewski (2):
  platform: provide early_platform_add_device()
  platform: provide early_platform_driver_register_probe_all()

 include/linux/platform_device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.17.0
