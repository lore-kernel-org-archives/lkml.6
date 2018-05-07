Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZpZn2KG4scMgZ5Q/pSym/DY2Z7wjosN7GB3ImvzFHWq0IbsWNzk8kpZj3ryEkdK6GyTPhTe
ARC-Seal: i=1; a=rsa-sha256; t=1525685763; cv=none;
        d=google.com; s=arc-20160816;
        b=wYFEozIRKa3I/88rkuXKYphEE1xG4P3q22dn86xOhxFqTXtaRUYyDK4vNasb0fh2NN
         UJmSYLIeP9xnPFChNY3EDxGBR9dD127ZP9M4ShrkBeDEoy1SCFajGK8EXVwdYkqpW9ha
         nSo778lg95vsRE4m76c6nZ2YHnryiiIqI2SfNGjU28gNGnbE+3XjpGD1hY79y5ynxNE7
         NlFx2naUJccVBqzv0uN46CBQWGM96PQQpqye+LYxnlw4pTlBCJVT5I2c5QogF58HWJSX
         D6C0ZWlafYSvUQSft2mf3My4Yw/268Zgqfod2+YEDJL3uBYDnG6/9il1mYVP12+7kj4c
         nU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HWnfxzxKw2rIcdwzDr4PHWTtWnxYHqGXcfo7S8rlst0=;
        b=BrfSjcTAfjGMN6wnnm//8kf7uZpekqd5gRz3K6K07jxt7zjjazznNhY2ORAT13KTBg
         9MZXfvtQyZCNb90fbCtAIqVatk+vhTS4xaiqj5+cQnj+JYB7kJ1ApYZeAzu3USGS9XDw
         XW+a6uMgBUxhJWGNQsJSHOo12tNqbyX6rSNBwsfOkroUs8zd0C1uIsKGqy8BvB5tNLZH
         DGupuJfM80THltZ3izL5xl2EY64Ma7XZAg9RNqmPIqlt3WTfyNkTTs/7jdxvZ2Eiw2ub
         uJjFhmgalZ+SBFMafDf+u37k1Q+00gVTUxmtgXLqRkg7/GFFI0R6A5lNqdCboDCw9+xL
         qu/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-wireless@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	linux-iio@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 00/18] Fix some build warnings/errors with Sphinx
Date: Mon,  7 May 2018 06:35:36 -0300
Message-Id: <cover.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797475301602798?=
X-GMAIL-MSGID: =?utf-8?q?1599797475301602798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I decided to give a try with Sphinx last stable version
(1.17.4), and noticed several issues. The worse one was
with the networking book: a non-standard footnote there
with [*] instead of a number causes it to break PDF building.

So, I took some spare time to address some warnings all over
the tree, and moved a few text documents to a book. I with
I had more time to move the other ones and to solve other
warnings.

Mauro Carvalho Chehab (18):
  docs: can.rst: fix a footnote reference
  docs: fix location of request_firmware & friends
  docs: */index.rst: Add newer documents to their respective index.rst
  docs: admin-guide: add bcache documentation
  docs: core-api: add cachetlb documentation
  docs: core-api: add cgroup-v2 documentation
  docs: core-api: add circular-buffers documentation
  docs: driver-api: add clk documentation
  net: mac80211.h: fix a bad comment line
  rcu: rcupdate.h: get rid of Sphinx warnings at rcu_pointer_handoff()
  docs: crypto_engine.rst: Fix two parse warnings
  time: timer.c: adjust a kernel-doc comment
  wait: wait.h: Get rid of a kernel-doc/Sphinx warnings
  fbdev: modedb.c: fix a kernel-doc markup
  iio: iio.h: use nested struct support on kernel-doc markup
  mtd: rawnand.h: use nested union kernel-doc markups
  docs: uio-howto.rst: use a code block to solve a warning
  w1: w1_io.c: fix a kernel-doc warning

 Documentation/00-INDEX                        | 10 -------
 .../{bcache.txt => admin-guide/bcache.rst}    |  0
 .../cgroup-v2.rst}                            |  0
 Documentation/admin-guide/index.rst           |  2 ++
 .../admin-guide/kernel-parameters.txt         |  2 +-
 .../{cachetlb.txt => core-api/cachetlb.rst}   |  0
 .../circular-buffers.rst}                     |  0
 Documentation/core-api/index.rst              |  2 ++
 Documentation/crypto/crypto_engine.rst        |  8 +++---
 Documentation/crypto/index.rst                |  1 +
 Documentation/dell_rbu.txt                    |  4 +--
 Documentation/{clk.txt => driver-api/clk.rst} |  0
 .../firmware/fallback-mechanisms.rst          |  2 +-
 .../driver-api/firmware/request_firmware.rst  | 17 +++++++-----
 Documentation/driver-api/index.rst            |  2 ++
 Documentation/driver-api/infrastructure.rst   |  2 +-
 Documentation/driver-api/uio-howto.rst        |  3 ++-
 Documentation/memory-barriers.txt             |  4 +--
 Documentation/networking/can.rst              |  4 +--
 .../power/suspend-and-cpuhotplug.txt          |  2 +-
 Documentation/process/index.rst               |  1 +
 Documentation/security/index.rst              |  2 ++
 .../translations/ko_KR/memory-barriers.txt    |  4 +--
 drivers/video/fbdev/core/modedb.c             | 22 ++++++++--------
 drivers/w1/w1_io.c                            |  1 +
 include/linux/iio/iio.h                       | 24 ++++++++---------
 include/linux/mtd/rawnand.h                   | 26 +++++++++++++------
 include/linux/rcupdate.h                      |  5 ++--
 include/linux/wait.h                          |  2 +-
 include/net/mac80211.h                        |  2 +-
 kernel/time/timer.c                           | 14 +++++-----
 31 files changed, 93 insertions(+), 75 deletions(-)
 rename Documentation/{bcache.txt => admin-guide/bcache.rst} (100%)
 rename Documentation/{cgroup-v2.txt => admin-guide/cgroup-v2.rst} (100%)
 rename Documentation/{cachetlb.txt => core-api/cachetlb.rst} (100%)
 rename Documentation/{circular-buffers.txt => core-api/circular-buffers.rst} (100%)
 rename Documentation/{clk.txt => driver-api/clk.rst} (100%)

-- 
2.17.0
