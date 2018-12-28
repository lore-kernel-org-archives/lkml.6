Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59383C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE020879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeL1BxW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:53:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1BxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:53:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B5A4F14AD1616;
        Thu, 27 Dec 2018 17:53:20 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:53:18 -0800 (PST)
Message-Id: <20181227.175318.1933639645603959141.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     kjlu@umn.edu, pakki001@umn.edu, andrew@lunn.ch,
        vivien.didelot@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: return error code upstream
From:   David Miller <davem@davemloft.net>
In-Reply-To: <12500e65-ccc5-7545-4724-e328fa418576@gmail.com>
References: <20181226040818.73764-1-kjlu@umn.edu>
        <20181227.162236.978596547594852209.davem@davemloft.net>
        <12500e65-ccc5-7545-4724-e328fa418576@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 17:53:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 27 Dec 2018 17:06:58 -0800

> Le 12/27/18 à 4:22 PM, David Miller a écrit :
>> From: Kangjie Lu <kjlu@umn.edu>
>> Date: Tue, 25 Dec 2018 22:08:18 -0600
>> 
>>> Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
>>> return their error codes upstream.
>>>
>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> 
>> Applied with Subject line adjusted as per Florian's feedback.
>> 
> 
> Thanks, technically bcm_sf2_sw_indir_rw() cannot fail and checking its
> return value in the write (op == 0) case will always lead to returning 0
> anyway. In case this ever changes in the future, we should be more
> future proof with that change anyway.

Ok, thanks for the insight.
