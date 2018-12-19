Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE526218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545227018;
	bh=X+zUKJTdF5JfWe+q9HUcnyOmU7hEGqlfE1pygy7oAk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aqc1RZieAUaniQEzYgryZnjuhLvnklj2RAyXU0Bt8UBAq2nrucrJO78t9E+2t2Mk6
	 UZFBai4vF5lGMx3BhwJcqdLvTLY9C/YTERTcxaC/cTNU8qlU2mSq9R+gu46zjMOYkC
	 x0Jgv7V+bSUsrv8bQfbkVyDYZvZA6G1vYEJwuJUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeLSNni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLSNnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:43:37 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889A721841;
        Wed, 19 Dec 2018 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545227016;
        bh=X+zUKJTdF5JfWe+q9HUcnyOmU7hEGqlfE1pygy7oAk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPF6lETtyALiIU2lcbNQJ/wh5UYj0SjRNHBZCpXHVB3PpheI1cO1CPBFVT6TWXtp7
         S7ajOMUlW4Eow25gRrCd7SKdzVHfr7k6ovoTjUJEIJkXechBQ5QTx37Mox/acHfx3l
         0faqPLdnNHEsZXWpNLIhsbbpivLWCz7YaUmF10aI=
Date:   Wed, 19 Dec 2018 08:43:35 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 45/73] net: phy: micrel: add toggling phy
 reset if PHY is not attached
Message-ID: <20181219134335.GK2746@sasha-vm>
References: <20181213042838.75160-1-sashal@kernel.org>
 <20181213042838.75160-45-sashal@kernel.org>
 <OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:44:41AM +0000, Yoshihiro Shimoda wrote:
>Hi,
>
>> From: Sasha Levin <sashal@kernel.org>, Sent: Thursday, December 13, 2018 1:28 PM
>>
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> [ Upstream commit 8c85f4b81296a530b8af2796c110fa482ac42d4f ]
>
>Since this upstream commit are reverted by the following commit,
>we should not backport it.
>
>---
>commit 7b566f70e1bf65b189b66eb3de6f431c30f7dff2
>Author: David S. Miller <davem@davemloft.net>
>Date:   Tue Dec 4 08:47:44 2018 -0800
>
>    phy: Revert toggling reset changes.
>
>    This reverts:
>
>    ef1b5bf506b1 ("net: phy: Fix not to call phy_resume() if PHY is not attached
>    8c85f4b81296 ("net: phy: micrel: add toggling phy reset if PHY is not  attac
>
>    Andrew Lunn informs me that there are alternative efforts
>    underway to fix this more properly.
>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>---

I've dropped this commit, thank you!

--
Thanks,
Sasha
