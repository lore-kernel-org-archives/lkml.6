Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZqLZ6dsIghz+y07M/u+e2re0bZA9701RXcSsExCUg+bIKJwHM8muTTc7UFqNKEJYfjKgiu3
ARC-Seal: i=1; a=rsa-sha256; t=1526392275; cv=none;
        d=google.com; s=arc-20160816;
        b=H6X0875KJzhqRkJam1OnfhcZnzLdQkwLebM5rmbg1EGnu384UQGHXF1SQAdLlOOfgb
         sjiQVrkCoM2hCXugbq/hygc9yj7XMptAQExBt3nZ1SgAgISwvqw1gFuFyqKCuNQQK+Uo
         g2FeErCYN6GgePBYuvMppn5RA5qgOV6LV56AMvxRD5KUA/xPjBLD30fb2pJqWTqtiCQc
         38R5dMOk4ZV82DPooDt37vtDkZg6eM3Db7nD77v3xXzz25LlSp+3HDy2chCMBnhoRcC2
         xb5ObyWpnXUfSFdqR1clxizjmKe7sjJx4SmeiEfpVm22vyKxpOSxppoTTpO9I19PPwco
         UnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0yQ31fe6oOrjdQX8UugxKzmqtDIv18g8MuOZ9nWYOdQ=;
        b=YAwwCbSKQKUfWXLUu6u4Q+om572lpkUf+A55MRcQS5l7Mkj28cab0gRuoWOfEzvbsI
         dQ0khYZwKPfq/EQnEVafGkSQcMUrDrUqhxG8yRp5JKGEo9poYtAieNum+N8sL+5gd9rV
         KWczxNZW3s86pV01wtGCdWEfNOP72jJHz2QeGKOPWDkfkRpxk6IzUF4H0GMutZ54/2nA
         sDCLjLjUH8H8nfdKhny+AEQDOXbgPNW0Q+/4TrJdYPkS6s/AxDWVYKa2n6FugsIAz4qv
         2VFsH/i5kbuEupS0jz11NXiamCImLzvOd597rJ5rF9MGY5nFFUftoGWnjsk6wjJsJowH
         ning==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] return EINVAL error instead of BUG_ON()
Date: Tue, 15 May 2018 15:51:11 +0200
Message-Id: <20180515135114.31939-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
References: <20180504132357.31771-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538306192171209?=
X-GMAIL-MSGID: =?utf-8?q?1600538306192171209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series makes driver_register() emit an error message and
return a failure code instead of triggering a BUG_ON()

I tried to make the error message more descriptive compared to v2 by
including the error of the failed bus registration in [3/3]. I'd be
happy to include some more context if you have further suggestions.


Florian Schmaus (3):
  driver-core: return EINVAL error instead of BUG_ON()
  driver-core: record error on bus registration
  driver-core: print bus registration error value

 drivers/base/bus.c     | 2 ++
 drivers/base/driver.c  | 7 ++++++-
 include/linux/device.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.16.1
