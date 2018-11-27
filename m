Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4966C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0pXHHliD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE00E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeK0Syz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeK0Syz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:54:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333A22086B;
        Tue, 27 Nov 2018 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543305473;
        bh=o35oHGV69DSYkHg75RAri72f02SGEgtAVQpNKQwIvfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pXHHliDBlwW/8ASDeO3zEH1aVWkzzyMj2hzOARAyLNH39NChmtrPd2yUk5rgZjQZ
         3F/agyABRGUZdNB9jO3a3l7ROxhyU64r80BJqWtBXfnNFx0vy/kkJEIZpdSlog1prP
         Vi+1F2A08G9qH2Slu+oYUDx3w+leG2d33lL5dc2g=
Date:   Tue, 27 Nov 2018 08:57:50 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "r.weclawski@gmail.com" <r.weclawski@gmail.com>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "santhameena13@gmail.com" <santhameena13@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "jananis37@gmail.com" <jananis37@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8188eu: Fix off-by-one in core/rtw_mlme_ext.c
Message-ID: <20181127075750.GA929@kroah.com>
References: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 07:29:07AM +0000, Yang Xiao wrote:
> From: Young_X <YangX92@hotmail.com>

Please use your "full" name like you did in your from: line of your
email

> 
>     The error at line 3267 was the result of an off-by-one error in
>     a for loop in line 3253.
>     If condition in line 3254 never satisfies, then the value of
>     pstat->aid is NUM_STA+1. This will lead to out-of-bound access
>     in line 3267.

Why is this indented?  No need for that.

Can you fix that up and resend?

thanks,

greg k-h
