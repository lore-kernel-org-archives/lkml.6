Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F8BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69CB204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69CB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeI1Xot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:44:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49166 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Xot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:44:49 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 396F3CF29E;
        Fri, 28 Sep 2018 19:27:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <153815104962.119890.13155451003978822980@swboyd.mtv.corp.google.com>
Date:   Fri, 28 Sep 2018 19:20:03 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Content-Transfer-Encoding: 7bit
Message-Id: <820F0357-DBD1-4278-8488-8C97A4107C19@holtmann.org>
References: <20180626170654.96831-1-swboyd@chromium.org>
 <153815104962.119890.13155451003978822980@swboyd.mtv.corp.google.com>
To:     Stephen Boyd <swboyd@chromium.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

>> These three lines make up what msleep() already does, i.e. setting the
>> task to uninterruptible, sleeping for so many jiffies, and then
>> schedule() already puts the task state back to TASK_RUNNING when it
>> returns. Make things clearer by just calling msleep() instead.
>> 
>> Cc: Thierry Escande <thierry.escande@linaro.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
> 
> Marcel, can you pick this patch up?

I would do that, but unfortunately it does apply against bluetooth-next tree.

Regards

Marcel

