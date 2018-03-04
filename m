Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELuAd1FEuSfEtYKAYz5MR+VwPwxfGSY06Dk52gnSczBkUTrDqYbPqkn9Dwq3thnXpyAZVhft
ARC-Seal: i=1; a=rsa-sha256; t=1520128191; cv=none;
        d=google.com; s=arc-20160816;
        b=GwhMhW7fVQ0gjOYj8SCF5anwOSAfcjI0MHeJV3Uj2wJujO6Flu3+Zirct062tD+JUh
         nCxVGkLXE8hyvoU44YZXWN+yBMRKovATm/tmVHK3nBD6/wXnz+uKW89TROdeZn9ock0N
         0IiIqBn4TyuLcbBqjUQ5JCv1boWPkcdKgRR5R27h1PYGQq7G8AwJRTv7hKHOrOPUc71N
         j1Fd0LQwrbZMs1EqXhSOPseuWbWTSKoYMfJ9CfVTCwx2diz5OxrPUBwkoLGrFLtWapPy
         VaJoCaPhHIbGn1CNEAFUYy3yirYaHt5J+MnC3helSPOrVYFJxEN4Kq+la+8HeGJ9PD2v
         EnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=inV+wxq/WJlk7VobsjPukh3b8sV0dm8bQFRobKPDvYI=;
        b=sHbhIxNcR21s6lExiIj5sfkevicWTW7IkBs2Lg31egVWgqnD3Ybp/3nohJzJ6yqdgZ
         fpcd4QCQrAuD/7H9S7+nOFUT75JCRWAir8xT+HcJASggnASk+pP4UQQRbDH2305shOYQ
         7x34l//vNnlmjjYGyBy1S7hSquDKewdzB1Doyyy3Wyr6FPmYD1Xvgiq7ORwViXqeD76B
         Nw7fJU8XOJ+MyIIErDpvsipW5B3lhtZG14Vao0Q51A3eY9wmkUiNZvbgKNwey7Gj4Jrx
         znZbJXoiEVjaiHVGR2jCk7mH+XhhdrZAnNf+tIUQl7heE+8IBUVQJJCO1T3zbxXW1DWj
         n/1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=JfszT+Hh;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=JfszT+Hh;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 00/12] staging cleanups
Date: Sat,  3 Mar 2018 20:49:30 -0500
Message-Id: <20180304014942.18727-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969938494708923?=
X-GMAIL-MSGID: =?utf-8?q?1593969938494708923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Here is another patch series that inches the driver closer to moving out
of staging. The most interesting changes are the last two in the series.
One gets the proximity sensor working and the other one removes the
unnecessary in_proximity0_calibscale_available sysfs attribute from two
of the supported devices. The rest of the patches are not that
interesting and either reduce duplicate code, add error handling, or
other minor cosmetic changes.

Brian Masney (12):
  staging: iio: tsl2x7x: remove power functions from
    tsl2X7X_platform_data
  staging: iio: tsl2x7x: add common function for clearing interrupts
  staging: iio: tsl2x7x: add common function for reading chip status
  staging: iio: tsl2x7x: add common function for writing to the control
    register
  staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
  staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
  staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from
    checkpatch
  staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
  staging: iio: tsl2x7x: add missing error checks
  staging: iio: tsl2x7x: make logging consistent and correct newlines
  staging: iio: tsl2x7x: remove unnecessary sysfs attribute
  staging: iio: tsl2x7x: make proximity sensor function correctly

 drivers/staging/iio/light/tsl2x7x.c | 346 ++++++++++++++++++------------------
 drivers/staging/iio/light/tsl2x7x.h |   6 +-
 2 files changed, 179 insertions(+), 173 deletions(-)

-- 
2.14.3
