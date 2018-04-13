Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637457; cv=none;
        d=google.com; s=arc-20160816;
        b=YzEmoERzd596MoD9gYm08RJOB1WwedJVaA437McGO98mzlVsjG3qfcuzsrBnoiJ5ii
         p6UMJCoIUkjATgYuL7P536QCboEHseJTSTpHdiL6VBdtUijwG/MI+v2h0pRxij93Z/IP
         bnu7RMAd31JZiA6tTQgTV04qktRsQ8ZgBXnrqFGFks0p6htIB3As8ZxY2372+9Eq1Apu
         Vc5in2Q8uoYIVElM10hOOd6tUFKj7vupVGS7yCRajjnl2Jcvjwl1XCks6x5aLnZHEPEC
         vItmnAy13W2lvexnYo5Nz1nP4j/ouWAB1OZAbEuMWdOQa9ul0bWf6hppU1zOkI0UdsML
         f1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=mrH82JEndP8IlZkjXX5r7VcIOkkdjZGMti8jOuQi3WM=;
        b=GY9KtNY3Pz0abJ6Y8+ExgMcLbrRclzH57FcQ3CrRZ60Ya4FBFLuD1RHjSMKaoxJPFu
         yPbewoH1PwN+MH5LitC5bBDUOABUkvNDQR7YekKZhOHTs8+iu/XT2pzvAuWLu6dD4bDW
         zgiYz6uU6nXMpG4hmAx4Su1+oAvm1580GNe/ZmXh254Rn2UhbCAKZF2gBZnAtoaGAzUv
         5FooXi48eowZ66RWBAolDe5jdVQcxl8ERPQxDabtby6XbEIkKy9FBvoZypOndPEfejI/
         A3sWArVeSepTK+6BwGLjxlJqMRTXmKm1nVn5zPDCRaZu1T2n79HmOh0Dt7y7URtQyqnr
         Mwag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=TIykMcQt;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=TIykMcQt;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx49yRIVh/aAHEBb1qlZ6ZAECFzMdjKtkECiMUtliAsediv7r8swXq+LYu5R5yWELzpkQWuIJoQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 00/14] Move ad7746 driver out of staging
Date: Fri, 13 Apr 2018 13:36:37 -0300
Message-Id: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649670249077582?=
X-GMAIL-MSGID: =?utf-8?q?1597649670249077582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Version 2 of the series trying to move ad7746 our of staging.

Changes in v2: (v1-> https://lkml.org/lkml/2018/3/21/406)
* Fix some issues pointed out by Jonathan
* Power down device on remove
* Add new ABI for the use case

Hernán Gonzalez (14):
  staging: iio: ad7746: Automatically swap values in readings/writings
  staging: iio: ad7746: Adjust arguments to match open parenthesis
  staging: iio: ad7746: Fix bound checkings
  staging: iio: ad7746: Fix multiple line dereference
  staging: iio: ad7746: Reorder includes alphabetically
  staging: iio: ad7746: Reorder variable declarations
  staging: iio: ad7746: Remove unused defines
  staging: iio: ad7746: Add dt-bindings
  staging: iio: ad7746: Add remove()
  staging: iio: ad7746: Add comments
  staging: iio: ad7746: Add devicetree bindings documentation
  staging: iio: ad7746: Add ABI documentation
  Move ad7746 out of staging
  staging: iio: Remove ad7746 from staging

 Documentation/ABI/testing/sysfs-bus-iio-ad7746     |  17 +++
 .../devicetree/bindings/iio/cdc/ad7746.txt         |  34 +++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/cdc/Kconfig                            |  16 ++
 drivers/iio/cdc/Makefile                           |   5 +
 drivers/{staging => }/iio/cdc/ad7746.c             | 162 ++++++++++++++++-----
 drivers/staging/iio/cdc/Kconfig                    |  10 --
 drivers/staging/iio/cdc/Makefile                   |   1 -
 .../staging => include/linux}/iio/cdc/ad7746.h     |   9 --
 10 files changed, 201 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ad7746.txt
 create mode 100644 drivers/iio/cdc/Kconfig
 create mode 100644 drivers/iio/cdc/Makefile
 rename drivers/{staging => }/iio/cdc/ad7746.c (85%)
 rename {drivers/staging => include/linux}/iio/cdc/ad7746.h (70%)

-- 
2.7.4
