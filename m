Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3278320870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3278320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeJ3HdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:33:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41754 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbeJ3HdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:33:14 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E9B413ADD5DB;
        Mon, 29 Oct 2018 15:42:29 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:42:26 -0700 (PDT)
Message-Id: <20181029.154226.179933039670602298.davem@davemloft.net>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <097fb051-25e3-cdb6-570b-22c2e9f83861@linux.intel.com>
References: <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
        <20181029183258.GL21857@kernel.org>
        <097fb051-25e3-cdb6-570b-22c2e9f83861@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 15:42:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>
Date: Mon, 29 Oct 2018 18:32:40 -0400

> -				  struct annotation_options *annotation_options __maybe_unused)
> + struct annotation_options *annotation_options __maybe_unused,
> +				  atomic_t *nr_rb_read __maybe_unused)
>  {

What is going on with the indentations of this patch?
