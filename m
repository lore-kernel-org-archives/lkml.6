Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9589AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A8720647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0+xviZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A8720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGZP3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:29:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45865 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:29:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so3155565oic.12;
        Thu, 26 Jul 2018 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=Iiop/PoqdOOuPg/DkETk9KNNqwPcixnHu+J0ibYzAxM=;
        b=k0+xviZHyFzHlYmKX2f6JjJ/DM/gQbYnUKzp+65i4huftbx5oa2b//0EuzSYrwzZow
         cHgHFUjLgHKy+QVk/T9BbgteWZHThcr0Kqx55tC8VzkglXgtzpD8n8Umf3wRsXRBux1E
         xggcc9lskS4WQ0GHHVmLNwr5vdrD06Ee271O40e0HM/lCr/FFt1MWkkdM7NIhgVz7Tzv
         Qt82D1JRIsqMFoRzRsxEoEpq1XGIRMzAcZVkPEAx+9dIMB1bbZzj0mOHfgqK1UGGF9Mp
         niu+LjsxkJi14+dslCp6yf8ILzkhWApSfJ6qJJhW3JJmOOcrWfY5aulc1pC2dzbBBdcC
         mPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=Iiop/PoqdOOuPg/DkETk9KNNqwPcixnHu+J0ibYzAxM=;
        b=YRTfFg9atpm7yJIVgbsS1tSvKRKhkvPF6Ua/8LkcgODeZJalkBUo3gIr7Do2uGhvkc
         BrjmPj3lpbkw79r8bptRVNVo2j5k+OaxTb0iwnUobiB18xjlmHdXY+oOmYvnJ+adqBx6
         Pj41T+Ekm4JadbmhXo/zI1Vh9cgaqaf6qL6dS1q1LNB35aEhALmO7fOjroqq38O8TG7z
         308jD68C9dHur2R64sr8JTHMAZ6i/+mxZPOE/A9L0caZo16GK4oFQ0QQbhZBQev3XGe8
         HjK2w5P3Mp8S5WMpzxLA/AJKC+tXw/iaBfI9r5k70Z/xkO26j0ccbqoeDeYjlbrMGJm1
         ubvA==
X-Gm-Message-State: AOUpUlHxV+/NezFsKKAXcOYQqC1uDI9db+LgHqJgyzqKIgBunn8I5vlo
        ZhPILvPG3V6k+8rbY7KDCK1j5bpOiSbQ3B7/aC3tgP3N
X-Google-Smtp-Source: AAOMgpfwWmrf7RYBLgaw+BbnjdJSe1m01UOMY2dKOFEUgFXpkIX1Do7G6Hw/X3ZhszcgTjIfhBjdNiku8a0kbKRBHRE=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr2294106oie.233.1532614340395;
 Thu, 26 Jul 2018 07:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 07:12:20
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jul 2018 16:12:20 +0200
X-Google-Sender-Auth: 6g9uKNgBTD-jOVrPoKbKqy42_JI
Message-ID: <CAJZ5v0jq73sRO77qRBcDqCH4rojnBNK+mTs9UJ3RQyNLW3x2zw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc7

with top-most commit bafaf056e0734f7bca7d27716bb3c672e87bb0b1

 cpufreq: qcom-kryo: add NULL entry to the end of_device_id array

on top of commit d72e90f33aa4709ebecc5005562f52335e106a60

 Linux 4.18-rc6

to receive a power management fix for 4.18-rc7.

This fixes up the recently introduced cpufreq driver for Qualcomm
Kryo processors by adding a terminating NULL entry to its table of
device IDs (YueHaibing).

Thanks!


---------------

YueHaibing (1):
      cpufreq: qcom-kryo: add NULL entry to the end of_device_id array

---------------

 drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
 1 file changed, 1 insertion(+)
