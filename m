Return-Path: <kernel-hardening-return-12633-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuGecJyBYyMipnapoUm8CPjCzY4LPA4sel7QMyQeBQCI1B4o48LO2kYX0r1agcvXYA/Bkyi
ARC-Seal: i=1; a=rsa-sha256; t=1521136866; cv=none;
        d=google.com; s=arc-20160816;
        b=a9/VFCni2Hbsqva5JVFPTQBLLiWKwPtUOAMK5nn45kv2qiLo2rS2FumMNZki/zPmga
         9vyPDcpotK5fM4OhKOWZ10ubM9esDECvT9pbWpNj+vTMYYmFHumIT4w/ADrNZMZo9ZqC
         zhOvWwbjuAREGh16YZbSYBIvWPm645tnPQjwATgAQOXqJs4wcBkU2w+kwhE28rX5FdM4
         9t2NKtvW6mvU0stIiEONJzCBDSJNOgNDcIM/GVk4iwNVPs7JErIfK5EL2Y34Az8/qS1r
         YQdjXz0jm4LKoDDAnRVfBxmM5wmcgIYgy0upQaK6atb6ZKAXqn4VxuS3L9F2cLpSKYIS
         Aaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ARVqQK62NPyJDWoWTi8LtLfxj0dIKiyp3Xj/DoxULB0=;
        b=Hjz2vikMWFF31wn33tqC6iTwcaKhqDvmMwv2BgnQjxnOqvojGb654hykpqdW428QJ3
         Bo2otn8AjXtnVy/w8KyFzolNtHZDRtH8Kk6qnteX7RSzAvjUjRq3qjJl6wz0e2SuL7rx
         /fLFRv7EUeEH3WvDEu2MssdbijakxIXElNVfPjV1FosuMlI3mWyEtUc+54Ikd5Fb/aZ9
         TS2wx2YgprZR3u4QASMkqVHqc7rdLIujxS6VR7dLx58u088WcQMMhamspsUIadVX0fcL
         0vaSHO5GazRoo65u9tqJuwzocBmYd+Kgal6/REJZPb+MdCq6rVCcljnJWu/LlRFfXsp8
         i2QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12633-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12633-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12633-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12633-gregkh=linuxfoundation.org@lists.openwall.com;
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
	Patrice Chotard <patrice.chotard@st.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCHv2 0/4] VLA removal from the gpio subsystem
Date: Thu, 15 Mar 2018 11:00:26 -0700
Message-Id: <20180315180030.20001-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027610743770412?=
X-GMAIL-MSGID: =?utf-8?q?1595027610743770412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is v2 of the series to remove VLAs from the kernel. This is mostly
to collect some of the feedback I've gotten so far, more detailed
descriptions are in the individual patches.

Thanks,
Laura

Laura Abbott (4):
  gpio: Remove VLA from gpiolib
  gpio: Remove VLA from MAX3191X driver
  gpio: Remove VLA from xra1403 driver
  gpio: Remove VLA from stmpe driver

 drivers/gpio/gpio-max3191x.c  |  7 +++-
 drivers/gpio/gpio-stmpe.c     |  7 +++-
 drivers/gpio/gpio-xra1403.c   |  8 ++++-
 drivers/gpio/gpiolib.c        | 78 ++++++++++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.h        |  2 +-
 include/linux/gpio/consumer.h |  8 +++--
 6 files changed, 87 insertions(+), 23 deletions(-)

-- 
2.14.3
