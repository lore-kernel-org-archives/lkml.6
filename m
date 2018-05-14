Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AB8JxZoIzf0bsJk8maZexVlF9kApk3eiazBGqPItXQB6sWXLKit0R31PNwNTAs5R33KdKSaD4aQb
ARC-Seal: i=1; a=rsa-sha256; t=1526293044; cv=none;
        d=google.com; s=arc-20160816;
        b=0yuJDdP2szZEH9EOWNHD34KBXGuizwuf+HZ6AutXKGwJepa6zxMJLSv6XkU4ugJltj
         qZg1nFsy6NzBUUbAMpO21Jv0wrsq2DZDRjHBbBHmvr0WhCIfJXBbfWj/APnczOQd6oXA
         Zb4qbBxg6ENhiUg7xa8uDmvkhMJFeMsh7IMPR9SKz8e2Lf6BHO410xaEfbmy8TeJO2zr
         hrSOrLHaVjlnqkZxNq2Ha6H6wuAnwlhASmQWI1gkVQbNlrxs6+HOI1ip2zEnkSUIk3fV
         VD8xj2Xh4+lEdvYHfP+6zSZvfdwL9Wo15HAKXJSgX1QOQ9XktRXoQOXsntSg7dFpsJrq
         oMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=YTjdE1vzwEA9Ra2oTc4dERO4yHSDjy53YrJDx1ik+pE=;
        b=WD8R7Hg8e4D0Lu/jDOvSgs1LLWE9zdIWGy70fXOcib/H2eH3ysLeF8Enx4w1FVFLhL
         7TEatalsuGVUO8A9I9cDkSQiWd38TzAYtWoz7Yi6qJUqEWPvnsoxklbOletlrnR8OiHj
         JFmv2ukI7oCBB9JrJi4BG1rkUNhjjWp22Jd5IY0DcFDTgojrvrVUfGg8O5jvmOJWh0j2
         YOyymNMWYjV8K6utkEKmcEio0dh3isn3xywF3iigiWQiIpZde/jRP3SdiAOiBw7eBGKe
         vfXbHimUA7zOLkhCmqRuPOZwSJg92v3/GaoRENGoChmjaHXyYjxGlz7efDzB5uhpUZyk
         fysQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JYg+jNqO;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JYg+jNqO;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 12:17:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
Message-ID: <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
Subject: [FAIL bisect] Sound card probe error
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>,
	Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600434255100788752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

I experienced an issue on today's next 20180514. Found on Odroid XU3
board (Exynos5422, ARMv7, octa-core) with exynos_defconfig.

1. No sound card is probed:
[    6.717698] ALSA device list:
[    6.719303]   No soundcards found.
(expected: #0: Odroid-XU3)


2. Oops happens:
[  OK  ] Started udev Kernel Device Manager.
Unable to handle kernel paging request at virtual address c0f324ac
[   36.229430] [<c05764ac>] (platform_drv_probe) from [<c0573fd8>]
(driver_probe_device+0x2e0/0x4b4)
[   36.238258] [<c0573fd8>] (driver_probe_device) from [<c0571fb8>]
(bus_for_each_drv+0x74/0xb8)
[   36.246746] [<c0571fb8>] (bus_for_each_drv) from [<c0573bb0>]
(__device_attach+0xd4/0x168)
[   36.254974] [<c0573bb0>] (__device_attach) from [<c0572e78>]
(bus_probe_device+0x88/0x90)
[   36.263121] [<c0572e78>] (bus_probe_device) from [<c0573434>]
(deferred_probe_work_func+0x64/0x184)
[   36.272144] [<c0573434>] (deferred_probe_work_func) from
[<c0146950>] (process_one_work+0x220/0x8e8)
[   36.281236] [<c0146950>] (process_one_work) from [<c0147050>]
(worker_thread+0x38/0x584)
[   36.289293] [<c0147050>] (worker_thread) from [<c014d96c>]
(kthread+0x138/0x168)
[   36.296652] [<c014d96c>] (kthread) from [<c01010b4>]
(ret_from_fork+0x14/0x20)


3. No DRM device is probed/found.

I could not find any specific reasons of this failure (like earlier
failures... except some probe deferrals which are happening almost
alwats).

Full kernel log of issue:
http://www.krzk.eu/#/builders/1/builds/1978/steps/10/logs/serial0
Example of good boot:
http://www.krzk.eu/#/builders/1/builds/1953/steps/10/logs/serial0
\
Bisected to:
8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
commit 8c123c14bbba4add148536b6d47a9226deda2f7a
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu Apr 26 10:53:06 2018 +0200

    driver core: Respect all error codes from dev_pm_domain_attach()

    The limitation of being able to check only for -EPROBE_DEFER from
    dev_pm_domain_attach() has been removed. Hence let's respect all error
    codes and bail out accordingly.

    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 26c27c583ac4557a3982b4a6bf6b3b4ff8386449
997a872ddca1c876024cf49c3e7fc68d15cd8fed M drivers


bisect log:
git bisect start
# good: [66e1c94db3cd4e094de66a6be68c3ab6d17e0c52] Merge branch
'x86-pti-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 66e1c94db3cd4e094de66a6be68c3ab6d17e0c52
# bad: [af37b24ae6b3e7eac272417c9af591c58baa8f93] Add linux-next
specific files for 20180514
git bisect bad af37b24ae6b3e7eac272417c9af591c58baa8f93
# bad: [0e9cda8f772f6c66693629b383d33a63a8333b48] Merge
remote-tracking branch 'bluetooth/master'
git bisect bad 0e9cda8f772f6c66693629b383d33a63a8333b48
# good: [a458037d65ab42098252b52889543fb836226d33] Merge
remote-tracking branch 'jc_docs/docs-next'
git bisect good a458037d65ab42098252b52889543fb836226d33
# good: [a37fb855f6e8e9eafac046721393f68f48eb5f91] net: dsa: fix
added_by_user switchdev notification
git bisect good a37fb855f6e8e9eafac046721393f68f48eb5f91
# bad: [3ee48ebb5dfef1a167b15ab9a4168134837b6e7c] Merge
remote-tracking branch 'pm/linux-next'
git bisect bad 3ee48ebb5dfef1a167b15ab9a4168134837b6e7c
# good: [89eaaf2d19a6cfff0a16014405c2a65b5257b8a1] media: lgdt330x:
don't use an uninitialized state
git bisect good 89eaaf2d19a6cfff0a16014405c2a65b5257b8a1
# good: [89eaaf2d19a6cfff0a16014405c2a65b5257b8a1] media: lgdt330x:
don't use an uninitialized state
git bisect good 89eaaf2d19a6cfff0a16014405c2a65b5257b8a1
# good: [6d2eaece20ffe783cdbcedd7ef2d6ae51d846d33] media: xilinx:
regroup caps on querycap
git bisect good 6d2eaece20ffe783cdbcedd7ef2d6ae51d846d33
# bad: [91965db07c20058e207e8ea14a47fe0ec891896d] Merge branch
'pm-core' into linux-next
git bisect bad 91965db07c20058e207e8ea14a47fe0ec891896d
# bad: [e298050322459ccd8aaa0f7edd422f630ce4e9b4] Merge branch
'pm-domains' into linux-next
git bisect bad e298050322459ccd8aaa0f7edd422f630ce4e9b4
# good: [097b29f3e6f5ec6781e5e3048e4a285edd79c357] Merge branch
'pm-cpufreq-sched' into linux-next
git bisect good 097b29f3e6f5ec6781e5e3048e4a285edd79c357
# good: [4d73e6885c07847488201e8df4da9ed56c25e21b] amba: Respect all
error codes from dev_pm_domain_attach()
git bisect good 4d73e6885c07847488201e8df4da9ed56c25e21b
# bad: [ecbc0460e7f16aca23f6dd34527fbf751eaf1453] mmc: sdio: Respect
all error codes from dev_pm_domain_attach()
git bisect bad ecbc0460e7f16aca23f6dd34527fbf751eaf1453
# bad: [f24b7891ddbf4f1d509253d6e0bcfdcfbdadf4fd] i2c: Respect all
error codes from dev_pm_domain_attach()
git bisect bad f24b7891ddbf4f1d509253d6e0bcfdcfbdadf4fd
# bad: [8c123c14bbba4add148536b6d47a9226deda2f7a] driver core: Respect
all error codes from dev_pm_domain_attach()
git bisect bad 8c123c14bbba4add148536b6d47a9226deda2f7a
# first bad commit: [8c123c14bbba4add148536b6d47a9226deda2f7a] driver
core: Respect all error codes from dev_pm_domain_attach()

Let me know if you need any more data.

Best regards,
Krzysztof
