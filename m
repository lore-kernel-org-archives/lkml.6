Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6AC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D462082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D462082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeKCQA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:00:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:00:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A33EF14525CDB;
        Fri,  2 Nov 2018 23:50:11 -0700 (PDT)
Date:   Fri, 02 Nov 2018 23:50:10 -0700 (PDT)
Message-Id: <20181102.235010.2148666995129291039.davem@davemloft.net>
To:     frieder.schrempf@kontron.de
Cc:     steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usbnet: smsc95xx: disable carrier check while
 suspending
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541022739-24678-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541022739-24678-1-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Nov 2018 23:50:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>
Date: Wed, 31 Oct 2018 22:52:19 +0100

> We need to make sure, that the carrier check polling is disabled
> while suspending. Otherwise we can end up with usbnet_read_cmd()
> being issued when only usbnet_read_cmd_nopm() is allowed. If this
> happens, read operations lock up.
> 
> Fixes: d69d169493 ("usbnet: smsc95xx: fix link detection for disabled autonegotiation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied and queued up for -stable.
