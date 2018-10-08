Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99108C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316312077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316312077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJHLQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:16:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHLQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:16:31 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6F7D142404AC;
        Sun,  7 Oct 2018 21:06:51 -0700 (PDT)
Date:   Sun, 07 Oct 2018 21:06:50 -0700 (PDT)
Message-Id: <20181007.210650.2268784399135289310.davem@davemloft.net>
To:     esyr@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ubraun@linux.ibm.com, kgraul@linux.ibm.com, hwippel@linux.ibm.com,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH net v2 0/2] net/smc: userspace breakage fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181007145726.GA16173@asgard.redhat.com>
References: <20181007145726.GA16173@asgard.redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Oct 2018 21:06:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Sun, 7 Oct 2018 16:57:26 +0200

> These two patches correct some userspace-affecting issues introduced
> during 4.19 development cycle, specifically:
>  * New structure "struct smcd_diag_dmbinfo" has been defined in a way
>    that would lead to different layout of the structure on most 32-bit
>    ABIs in comparison with layout on 64-bit ABIs;
>  * One of the commits renamed an UAPI-exposed field name.
> 
> Changes since v1:
>  * Managed not to forget to add --cover-letter.
>  * Commit ID format in commit message has been changed in accordance
>    with Sergei Shtylyov's recommendations.

Series applied and queued up for -stable.
