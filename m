Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEGKBy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:01:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:55259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeEGKBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:01:47 -0400
Message-ID: <1525687297.26987.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Date: Mon, 07 May 2018 12:01:37 +0200
In-Reply-To: <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
         <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
         <1525532191.5406.15.camel@gmx.de>
         <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
         <1525672597.5064.3.camel@gmx.de>
         <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qlii2U8lsS+so9gIRGBDwpdF4rrod+KjPq/Im2QQHSdwE7Cp78d
 h64iLewWwD+4AgYjsyRci0YKyNjJyGlpJ0xC3JS9l01UQ19yowKF+TV8lqYPnYYH5u8z4Wk
 AJhJTFDrOslwZT2jXx/c6VJU8EOmUPrZeNQYsq/FVl8VnGDikRMgqFSktR3lKT2WFQU1R7/
 ZEdKCXggexQLQtMfwF7wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KdEZedLwRp0=:N7RIPoxquntQnybAV3oayW
 dQji/3N9CFQw3yFPsXd79ale4kThsh6l158VOyP+ufcMTpp00NGXqEexv8DZO2ifMIno6ZqOb
 tFF+jYpKBJbQ0VIWBA1DgYctOe6E7o5xEM5qb6Y2LW3Z62vKaYRBaW98VxFEnlgUgCjWbnGQJ
 3GBmKnxqmL9fq/b4E56KXXvQSW2BnDXsV0v5xgBYmyMHf4rj5FBKiHqcTgGBRVb1yd/lftmLF
 r4Sd2QOfIwaOVediTzu3mqt9gRcsb1KFmIhHLCMmKbd+sTvQpm/ItSkoOJx6HrLleiYTZ02Xa
 6xsJ4ZHuRE6Goh8uuQGHwekZi/087/70AI5D80/8Jv9oQtnrslfpHkSZL8QL4/r8umIlo0S9g
 BxDIrfh4qT9VfQ5oRrgKSValFLDqLM32KJYvU/kDN5FkRXT+/JH9qY/j/nTdaoGRdkrKk58I3
 U29Hhgh8ZYF7eytC3vLcnKW6efKiZoOOccBMXpnZWJNsrL4oDoqP6WfeE76rBPwSTcp0PSnIw
 cHUEac3jr7qp2j2V7/yYYmxjLsNi/YXQSgblIsIMd7OW75RJKhbLgjoiwhU1SLoj7rv+7PzWe
 6C22Ti7v4C4mZvgf9LfFR7MFv69p131hXY2P0fVmoM/sNoaaxaxIlRifxas831aGshezJfkCf
 qjIzSm17T5Bw8AM8p1yJAv9VG9+CgUcanSn8YcBGssg0iVUvUQoTMZYRbDklZQ0crs7yhAE0Q
 SrUL+Zdbf1CEjuWb/DqVKvi6zmiqAa4fGzX9ck80uwfm1i8dkSbtc0kGxksZA5W4Pq5Ts/m48
 M+E8wfB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 11:27 +0200, Paolo Valente wrote:
> 
> 
> Where is the bug?

Hm, seems potent pain-killers and C don't mix all that well.
