Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591080; cv=none;
        d=google.com; s=arc-20160816;
        b=J/jNBOWHMtYb8RiIOG8x7fjh6gs7zUWwciAgzG0oj3AqOzdjlOeZ9ZqAapB9KeIQpy
         as3mjLiZgVGLahYZYV5cvaA0I/Q8G35icyqPcPnRyc7GoupeDx+vk9iwhqKK7hF0tH4E
         JgPeRkWIq3xTJ5gbt/ODOY+sV8JnXNsKOQ17HVRJu3Fu1i6C4awsqc6YQ7AX7CTL2nO+
         8aNRaUhJ2mtVcFlGb/jx0z2IEHfuu0s4FfTRHv2Z19QgN3Vb1PkO26iyWgJCfwGeHQuD
         3ySt0Dew4ik0t5V3ZWMs6MbYw8zQHvN35I+5uzNY81QQGJoqcl7CMUTxjqnYBBiGUvL+
         JmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gJOkR/HBpJGJ+7pTHTk+bzzT4HmEj1L3b2+8i5CnxuY=;
        b=q0/+Zj2Mbm2ivXFElaWlrgZM3kGA6hoxGg5MsIMP4tN2u+Z4U+PhUtKxjfdLsUh1kZ
         y3ESJXEL5cxv1N5E7QvugLjBcpuKEA97eqFkF8KDUoEu4tSv4qtNY9g5/qqoOQTza0td
         cwdwJWUcaOexn+4yjZP47sgjsr+DnE454xmZfko0dylFtD2mcMxxuiD3dOYf/joS60B9
         rd2Sq8efn+j/653U+a++jg3MbTdX8qKcZD0NywDruUIqCdAjKa2YX9apkdIgncxH6Sx8
         xUcuhNxT5yxvewsIijFTZtJ/YGTCSsbTv/JbFDhIC2vJwbPv0FMJ67rofolj0xMrmx4c
         Z+6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=PFjln1i6;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=PFjln1i6;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZrhCVsYfHxFAALUXQl+2o/gXRHHddC/yKrKNN8r8yNQzXxzgj31ePHn3zxkZ2ENGSUCTa4pDw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/11] dt-bindings: add bindings for early devices
Date: Tue, 24 Apr 2018 19:30:47 +0200
Message-Id: <20180424173051.15099-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649617124050214?=
X-GMAIL-MSGID: =?utf-8?q?1598649617124050214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple document describing the "earlydev" compatible fallback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/early.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/early.txt

diff --git a/Documentation/devicetree/bindings/early.txt b/Documentation/devicetree/bindings/early.txt
new file mode 100644
index 000000000000..51cbd8630255
--- /dev/null
+++ b/Documentation/devicetree/bindings/early.txt
@@ -0,0 +1,7 @@
+* Early device driver
+
+Certain devices must be initialized early in the boot process. An early
+device node represents such a system component.
+
+Required properties:
+- compatible: Must contain the following fallback: "earlydev"
-- 
2.17.0
