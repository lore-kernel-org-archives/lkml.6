Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991E920818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991E920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeKFNwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:52:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeKFNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:52:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D0AD714A6B351;
        Mon,  5 Nov 2018 20:28:52 -0800 (PST)
Date:   Mon, 05 Nov 2018 20:28:49 -0800 (PST)
Message-Id: <20181105.202849.1012263715606612557.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     firoz.khan@linaro.org, sparclinux@vger.kernel.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
References: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
        <20181101.133315.47887636039827313.davem@davemloft.net>
        <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 20:28:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Nov 2018 11:48:43 +0100

> However, for all of those, I want the /format/ of the tables to be consistent
> so we can create the tooling around it to find and fix the issues. The work
> that Firoz is doing for now just makes sure that the /contents/ of the tables
> don't change at all, which is hard enough to do (the current version gets
> it all right afaict, but the previous versions missed some details).

Ok, agreed.
