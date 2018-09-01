Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0B2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0B2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeIAFfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 01:35:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeIAFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 01:35:52 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03579142CA8A0;
        Fri, 31 Aug 2018 17:46:07 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:46:07 -0700 (PDT)
Message-Id: <20180831.174607.2188348299758730756.davem@davemloft.net>
To:     amsalam20@gmail.com
Cc:     dlebrun@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next] ipv6:sr: Use the right next-hop value for neighbor
 discovery in End.DX4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180825141541.960-1-amsalam20@gmail.com>
References: <20180825141541.960-1-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Aug 2018 17:46:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Sat, 25 Aug 2018 16:15:41 +0200

> This patch makes sure that "rt_gateway" has the value of
> the next-hop configured from the control plane.

You can't change the rt_gateway field of an existing route,
this will change the value for unrelated users trying to
reach the same destination.
