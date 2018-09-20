Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7920FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C01B20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C01B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeITJzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:55:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:55:05 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E946510903027;
        Wed, 19 Sep 2018 21:13:45 -0700 (PDT)
Date:   Wed, 19 Sep 2018 21:13:45 -0700 (PDT)
Message-Id: <20180919.211345.499002396520654228.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 00/12] net: mvpp2: improve the interrupt usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 21:13:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 19 Sep 2018 11:26:59 +0200

> This series aims to improve the interrupts descriptions and usage in the
> Marvell PPv2 driver.
> 
> - Before the series interrupts were named after their s/w usage,
>   which in fact can be configured. The series rename all those
>   interrupts and add a description of the ones left over.
> 
> - In PPv2 the interrupts are mapped to vectors. Those vectors were
>   directly mapped to a given CPU, and per-cpu accesses were done. While
>   this worked on our cases, the registers accesses mapped to the vectors
>   are not actually linked to a given CPU. They instead are linked to
>   what is called a "s/w thread". The series modify this so that the s/w
>   threads are used instead of the CPU numbers, by adding an indirection.
>   This means we now can have systems with more CPUs than s/w threads.
> 
> This is based on today's net-next, and was tested on various boards
> using both versions of the PPv2 engine.
> 
> Two more patches will be coming, to update the device trees describing a
> PPv2 engine. The patches are ready, but will go through a different
> tree. I'll send them once this series will be accepted. This is not an
> issue as the PPv2 driver keeps the dt bindings backward compatibility.

Series applied, thanks Antoine.
