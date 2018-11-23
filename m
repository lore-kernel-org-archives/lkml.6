Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CB820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CB820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409320AbeKWVGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:06:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394114AbeKWVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:06:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2CA83263AE8
To:     stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: kernelci.org automated boot bisection reports
Cc:     kernelci@groups.io, kernel@collabora.com,
        Mark Brown <broonie@kernel.org>
Message-ID: <49681fa7-cd31-89e5-5986-ebe8691ead9a@collabora.com>
Date:   Fri, 23 Nov 2018 10:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tl;dr automatic bisection reports are enabled for mainline and stable

In case you're not already familiar with it, the kernelci.org project
is a community effort to build and test upstream kernel trees on a
variety of hardware platforms.  Reports are mostly sent to the
kernel-build-reports mailing list[1] and all the results can be seen
on https://kernelci.org.

When a boot test regression is detected on mainline or stable
branches, a bisection is automatically run.  Starting from today, an
email report will be automatically sent to a list of recipients based
on the commit the bisection has found (author, trailers, maintainers
and lists associated with the code changed by the commit).  Until
now, the results were manually curated and only reported more widely
when they seemed valid.  Some automated checks are now used, they
have been showing good results for a while with no false positives.

There shouldn't be many bisection reports yet, typically one or two
every month.  As we'll start bisecting other trees such as linux-next
and other test results than just plain boots, the volume may start
increasing gradually over the coming months.

Please let us know if you would like the report format to be changed
when you get one, or if you have any suggestions at all.

Hope this helps!

Guillaume

[1] https://lists.linaro.org/mailman/listinfo/kernel-build-reports
