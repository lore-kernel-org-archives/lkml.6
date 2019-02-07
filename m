Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B43E218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBGQjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:39:10 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:41017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:39:10 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.54.161]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6EOc-1gl9vO2zkG-006ilV; Thu, 07 Feb 2019 17:38:34 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/2] hwmon: pwm-fan: Add optional regulator support
Date:   Thu,  7 Feb 2019 17:37:58 +0100
Message-Id: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:/Q8ZR5u2BntDBN4A9/0VFlBKHldnkOOSqi7uJcW3SS5GnPXHHp/
 vkGsNNiHvj9WnfKqw+xG0WXLXLIIT0jFcttXiF/oq9tNU0edOZ2Z6lKEMALAbb3bH16Pt0S
 1JcgW1HR1OnnvBnFpm8cStzZMKGPjALRR+Jw5MaHBIwe/pEtwZemzIwBiOaOwfucUOY+Xsl
 BkkZ6c0sROHXor98nXFNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FhcePeQSo/Q=:sMbIj7i+0l54E0E9r1P9eh
 UUvS6+5mmEpHd4YjesZ2JcgCI5GiGAxecSEuKezu9/hKUXPNM3hFNqWgU5W0pMWkA4X8sriOW
 psehVJ5acm72kvLa/VeUHBGLvhmoddTQicxAtdSnoyu/e4+oahyOpjod4ePPRQPIFsfFpMXFm
 8YfDOfL3D9C8l+3x+qEVlOoaPBh8TpAL9xnFl2b9qWfk78sutuOEiJCoxHAsXrXpDRhxaJJcI
 ZObXw1CaxmSeQu0lBsc0uvlbAkMPXrvDjgL/0HvUKpedd90w4/o+2Vag9I4qPxxOVbJFgD/m2
 UxXVyBxqz0ta9iq290eCUee1C92k7ihpY8tf8Jfaf64RG+szhOJXVEYX0I/WnjB8MYVsjDWaq
 3UeOEldkWerZk8V91+TkW1UGI2Zp00B1ldxc2cHWt8xgpOxOhT6W+i/vrg3JYYgA3BToUT0r0
 SjICPRWcGWKmPraSU6vfTy8EpQ4XyuOL1KaXb/vUttLA4GGnNSABNzwuNkDbPkdqT8jCMlWx1
 3uEaDCoYbORxFFthz4/7Nwar6E/nXe7n7oUS/pDvlEnV5+/AqB4JRJvgVz2fTfTG9CfNE5dbS
 RvR7KbfWg4YhJ78NzGGahgcQql1OtGINQYijXGiv+aIlnOgE3RrpTe+HRwktBLrIEmhAHwuKD
 qHEmWYI14sJRy90cMPHeG8tBjQ4a8pT7KLn6roYgZR9CrrAsE66yIEYj+i972nKuzyUdLqJZJ
 Q5qZZTuQOpfc5QuL270CVckaCDC7x++tARGmFGgmcSD6/ZPKpAOF/ODfZD8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series implements the optional regulator support for the
pwm-fan driver.

Changes in V2:
- address Guenter's comments:
  - handle error case first
  - drop ENOSYS handling
  - implement more consistent bail out handling
- enable regulator before setup PWM
- make sure we disable regulator if probe fails

Stefan Wahren (2):
  dt-bindings: hwmon: Add optional regulator support to pwm-fan
  hwmon: pwm-fan: Add optional regulator support

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  3 ++
 drivers/hwmon/pwm-fan.c                            | 39 +++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.7.4

