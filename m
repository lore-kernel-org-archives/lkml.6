Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C44C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEB32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEB32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIFVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:11:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeIFVLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:11:16 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxxF9-00034t-Cd; Thu, 06 Sep 2018 18:34:55 +0200
Date:   Thu, 6 Sep 2018 18:34:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rick Ratzel <rick.ratzel@ni.com>
cc:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "udknight@gmail.com" <udknight@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Cartwright <julia.cartwright@ni.com>
Subject: Re: Ensuring wall_to_monotonic is not positive breaks use case
In-Reply-To: <CY4PR04MB0296FED0A64321B49AA527C69B020@CY4PR04MB0296.namprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1809061605570.1570@nanos.tec.linutronix.de>
References: <CY4PR04MB0296FED0A64321B49AA527C69B020@CY4PR04MB0296.namprd04.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick,

On Wed, 5 Sep 2018, Rick Ratzel wrote:

> We're looking for suggestions on how best to proceed with a new change
> that ideally both supports the use case described above, as well as
> addresses the symptoms brought up in the initial commit (negative boot
> time causes get_expiry() to overflow time_t, and show_stat() uses
> "unsigned long" to print negative btime).  Any thoughts on this would be
> greatly appreciated.

Those symptoms are just the tip of the iceberg. For sure it screws up
everything around boot time and a lot of things use boottime nowadays.

So reverting this is not really an option.

Chosing a PTP grandmaster which populates random time is a really great
idea. Why has this industry the tendency to turn everything into a
trainwreck?

Thanks,

	tglx
