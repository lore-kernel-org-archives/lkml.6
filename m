Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x226JV3nsRfuTL97OzJRsyBuHCYnKMbtaB40iAa5+BLqbyVi/dmUJnNV7RqxseaXs1vB5kjlp
ARC-Seal: i=1; a=rsa-sha256; t=1518214940; cv=none;
        d=google.com; s=arc-20160816;
        b=QPv217TANKlXQ1C8dR3QmEi+YbpA9YCUAD3UQmNph0ba5AA4vQUaY8tV8x6gB3+/7i
         cHOwzrGJkiyKe2+sNpvpRMN2k+cMTCHllgLmeh9tiPjTegFaXMZMs9coePqekn7lxzzz
         uUJ+xfBzoSTFyDPSULtGyhR9R26c3CGEH5S81bqV8ZuN4g/aMlS0FgKn3hew/ykReJPb
         SmBNgvHey75Dc6gQrftYfjE0r2RRMW7HjFRAng3OH6DgJFTmsidieKFkJ0GUExpJzRfr
         ma54Mb7RgM09RMpvPMWK2m5oSF0WFrmOvs/otbuXN161Gip0PhW+Ah8dM6lD0bEb5OJ9
         R9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Y+RX5sCCbBi79PSo6l7LcBrgZtUCZU0GyJif+LXkEJI=;
        b=jO0YKFYTHzjlSPTm0yRwSMCz7Zp2D7gOYGppewY/h0mgNusVulrTYXrRbO7w+lR78N
         1jJ+BmHN8tw3Tdm1H9mdYbNQgKSqEqBhdmEvVWfu9fT3zaqsdOxuPjGQJo9MLwpaokLb
         7cnTA/EXqpVAwMizAoSLKn+C3qnsYO7g8U5x1ToMrzeps+BYaKEMDCZKUAqnFqTBDsYh
         zNMJgLQ7ML7iPWYFjCj392eJzEeuhHoA1EkM/hN2ZAOHP40uNm5+TvIhH6zIiaNHissr
         N9p+bka3Kho+ljSbsZgS8oMNM8adcyZLD5drmN1VqF5QPy5CzSi+evcNOv5PFf1O7Din
         oWTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>
Subject: [patch v2 0/3] platform/x86: mlx-platform: Add support for new Mellanox systems
Date: Fri,  9 Feb 2018 23:59:29 +0000
Message-Id: <1518220772-98492-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591963749375142416?=
X-GMAIL-MSGID: =?utf-8?q?1591963749375142416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for the next new Mellanox system types: msn274x, msn201x,
qmb7, sn34, sn37. The current members of these types are:
- MSN2740 (32x100GbE Ethernet switch with cost reduction);
- MSN2010 (18x10GbE plus 4x4x25GbE);
- QMB700 (40x200GbE InfiniBand switch);
- SN3700 (32x200GbE and 16x400GbE Ethernet switch);
- SN3410 (6x400GbE plus 48x50GbE Ethernet switch).

Vadim Pasternak (3):
  platform/x86: mlx-platform: Add support for new msn274x system type
  platform/x86: mlx-platform: Add support for new  msn201x system type
  platform/x86: mlx-platform: Add support for new 200G IB and Ethernet
    systems

 drivers/platform/x86/mlx-platform.c | 325 ++++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)

-- 
2.1.4
