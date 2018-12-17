Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE649C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873A42086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545035406;
	bh=AaI1oZgBia5YR5WLbkbv6JoOLqaWMfWN0K0WQybw9s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCKL4CwINEDWF+1u23BdPGO8V4zFa3vMglamJbSxExCc+1UEJeUJuh3O0g2O9R3nE
	 zBJ6Autkt6q+WyFAgr2FuxNTwY/brdvPGfxK9Jk4Z0DEAhcuU1H2HYOE+MckB3LiUC
	 BHrY4ccYJimGe1f9IfEWN5qUVm/NqpgELXIrk29o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeLQIaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeLQIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:30:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364AC2084D;
        Mon, 17 Dec 2018 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545035404;
        bh=AaI1oZgBia5YR5WLbkbv6JoOLqaWMfWN0K0WQybw9s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLi0CEqiHYvd6rWCRmmpLEN4P++zGPgdHVE6UWc8G2uWJH5EcSu1akEidfkUE0zB8
         kcvXs3SAuJAFNxlU5eEask6jWe2G8DxGOmIaRAwJ3Ik9QfdOg8eH7WtPlB40pr5Dhq
         Ob5wN5fYDEMTUQ+bUcG90IdBpBQG4a+NDom7wINM=
Date:   Mon, 17 Dec 2018 09:30:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyuho Choi <chlrbgh0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Wei Li <liwei213@huawei.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 009/118] scsi: ufs: Fix hynix ufs bug with quirk on
 hi36xx SoC
Message-ID: <20181217083002.GA5244@kroah.com>
References: <20181211151644.216668863@linuxfoundation.org>
 <20181211151644.599741132@linuxfoundation.org>
 <CAP2JTQJyOad9Tbc8t_K-Xp8q5EpdgeQbaDfTAJgkYUWWpw=TRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP2JTQJyOad9Tbc8t_K-Xp8q5EpdgeQbaDfTAJgkYUWWpw=TRg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:24:38PM +0900, Kyuho Choi wrote:
> Hi Greg,
> 
> About Hinyx's "hB8aL1" ufs device. For support Kirin AP series, they
> are need to apply below VS_DebugSaveConfigTime expand patch.

I am sorry, I do not understand at all.  What needs to be done on the
4.19.y stable tree?  Is a specific patch needed that is already in
Linus's tree?  If so, what is the git commit id?

thanks,

greg k-h
