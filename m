Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41CC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97F21479
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D97F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJCMSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:18:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54664 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:18:31 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E8A4F141FD11A;
        Tue,  2 Oct 2018 22:31:42 -0700 (PDT)
Date:   Tue, 02 Oct 2018 22:31:42 -0700 (PDT)
Message-Id: <20181002.223142.1012441865811000690.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     ganeshgr@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] cxgb4: Use proper enum in IEEE_FAUX_SYNC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181001034738.29475-1-natechancellor@gmail.com>
References: <20181001034738.29475-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 22:31:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Sun, 30 Sep 2018 20:47:38 -0700

> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:390:4: warning: implicit
> conversion from enumeration type 'enum cxgb4_dcb_state' to different
> enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
>                         IEEE_FAUX_SYNC(dev, dcb);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h:70:10: note: expanded
> from macro 'IEEE_FAUX_SYNC'
>                                             CXGB4_DCB_STATE_FW_ALLSYNCED);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use the equivalent value of the expected type to silence Clang while
> resulting in no functional change.
> 
> CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to net-next.
