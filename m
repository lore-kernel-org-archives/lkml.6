Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BDE2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BDE2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeI0Jku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:40:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37690 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeI0Jku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:40:50 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BAD0B145796F2;
        Wed, 26 Sep 2018 20:24:45 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:24:45 -0700 (PDT)
Message-Id: <20180926.202445.374568259168708755.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: Avoid implicit enum conversion in
 qed_iwarp_parse_rx_pkt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924214212.22522-1-natechancellor@gmail.com>
References: <20180924214212.22522-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:24:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 24 Sep 2018 14:42:12 -0700

> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1713:25: warning: implicit
> conversion from enumeration type 'enum tcp_ip_version' to different
> enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
>                 cm_info->ip_version = TCP_IPV4;
>                                     ~ ^~~~~~~~
> drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1733:25: warning: implicit
> conversion from enumeration type 'enum tcp_ip_version' to different
> enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
>                 cm_info->ip_version = TCP_IPV6;
>                                     ~ ^~~~~~~~
> 2 warnings generated.
> 
> Use the appropriate values from the expected type, qed_tcp_ip_version:
> 
> TCP_IPV4 = QED_TCP_IPV4 = 0
> TCP_IPV6 = QED_TCP_IPV6 = 1
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/125
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
