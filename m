Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C2EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCE5208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="i5LnC4zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCE5208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFUH2g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:28:36 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:46594 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754101AbeFUH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:28:35 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 03:28:34 EDT
Received: from mxback11g.mail.yandex.net (mxback11g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:90])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 427F1408156D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:21:17 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id sUs05zwisK-LGNuG0SK;
        Thu, 21 Jun 2018 10:21:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1529565676;
        bh=QDXjV6zr1stEbnLrTfBFZQqwdhRESG/s2qqiRQ5dU7c=;
        h=From:To:Subject:Date:Message-Id;
        b=i5LnC4zXGnHHDqtjh08PMdGJ0uY1Mqa7EHFP85qDRprDT05WZiyj4q1D8zTmGC3lp
         04hy002ZOC3o9HcBwfDyLqgGKa+so/jnBCcq492DmrAcJmhLbL/slVjk6sxbRmnM6W
         5RJtasRmg6OwL7oZcEGz14qf/a0t9wCDs53pWj7c=
Authentication-Results: mxback11g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web41o.yandex.ru with HTTP;
        Thu, 21 Jun 2018 10:21:16 +0300
From:   Andrey Ponomarenko <andrewponomarenko@yandex.ru>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: List of devices with poor Linux compatibility
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 21 Jun 2018 10:21:16 +0300
Message-Id: <2047231529565676@web41o.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A new open project has been created to collect the list of computer hardware devices with poor Linux compatibility based on the Linux-Hardware.org data: https://github.com/linuxhw/HWInfo

There are about 29 thousands of depersonalized hwinfo reports (https://github.com/openSUSE/hwinfo) in the repository from Linux-powered computers in various configurations. The device is included into the list of poorly supported devices if there is at least one user probe in which the driver for this device was not found. The column 'Missed' indicates the percentage of such probes. If the number is small, it means that the driver was added in newer versions of the kernel. In this case we show minimal version of the Linux kernel in which the driver was present.

Devices are divided into categories. For each category we calculate the ratio of poorly supported devices to the total number of devices tested in this category.

Everyone can contribute to this repository by uploading probes of their computers by the hw-probe tool: https://github.com/linuxhw/hw-probe

Thanks to all for attention and new computer probes!
