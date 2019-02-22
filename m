Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F922075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfBVNqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:46:36 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:46:35 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.42.136]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZkxd-1gZ8G10C19-00WmTV; Fri, 22 Feb 2019 14:46:06 +0100
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
Subject: [PATCH V3 0/2] hwmon: pwm-fan: Add optional regulator support
Date:   Fri, 22 Feb 2019 14:45:22 +0100
Message-Id: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:bUysODDqCtcQbPs5My9qxzgP5et+M1x5YjqVtWmpNXeQUTuMJkE
 GaraqT17I8gnpZigFIwPJE1ga91+Oif4W/hcIoejkCWoIHZqbynMHS2tOgQmoO6OmJxH07S
 r5BUg7/D7vFW9oKmqVdznzO1D0A8fWNOf+SUDrtvLPFtda8XNsMIKzisd+TUs3Cx/dUnsre
 pRwA3yh7rvnoMVDAMiRhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UxnJ4xNeq7A=:hz8G4+egwr2fVJfWrK+xI5
 f3UhT8FxCmd4kRg/QMS9AZxwswvqcNtG6tzc3/H68khb/vKKfaZO8GztapjiNGuJqb0Gnbbr0
 /nPgYiFPeh+bBgSukE0SOA6LbcbYzzJSwMrwRPjaP5cRv2sig+C9NZdGdxVxQI2oGCk0dlEur
 N17zoDZSnmsYhZYSsHMmsSIK8cnLyxSNL7Aat9OywDiJNwOJWZB+0ZZlI8jBk0pPkHYK6DQXE
 IRdunZN8Gvm6RqftCsAFjmPhTDWeQp/7i4ICnnbgyi8SYLWa+qgKv4Oot8mUPVjNy/VKWvXOT
 oVGB4EnI+hxKmjGdLFV608zBaqLax17tXneC1wRver8eOBg7hfWGmRYGntMFWoeIFPpp7whe4
 UAhkvfdSPGM9yPfMVDsjM3enAhOScOXaxJfAxHtxmKUHja3IpCcFd327LoWMhgaBKOEl7C/PZ
 VYBIcN0SVoNjVz3vJgJd0qMzloH3gtugXlZibT3lUJnMxBQj0Tlgr/4Yaj11edMdfB0SscOei
 s6fHCjQpboRtlfHF9cKvxw5reNTyhIejuiRIoCWc4UZq75gH6dw7s9q4HxmgAsMUnrndKYj5p
 xJNyxG0a2XQ723lvrAM3WitWK3DVZt4UIVwO8XLw1v4R+xYOhu3JXKA78/H6cGiV3rIJiEObX
 rSCiFSxKkMwkrUz4i2x5H5LU7KRS5skbeJ0/nLg9t55DwOjw9z3SZkS4/TIlidj53vWQ+yF6i
 KTpC2p+ibdNP7CquXju+Ikd2pktgvvezY2L3hFUpjtj59sXUlxi4m+tcPeE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series implements the optional regulator support for the
pwm-fan driver.

Changes in V3:
- simplify error case in probing code
- return regulator error code in pm callbacks

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
 drivers/hwmon/pwm-fan.c                            | 43 +++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.7.4

