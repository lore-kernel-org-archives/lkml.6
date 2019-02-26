Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B20C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FBF21841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551191363;
	bh=nf1Wf0q7vxNMlqz95M/YOgQNPju9HwyB+Yok2j5G/Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pCLeta4dRETJlDU4PVvOn9ftpVtuD00s6jRGCAuJhqQjB9vCkfy7Hr9Ek75ooTF/w
	 q3NlDWq0PimJb83X/NuVA0kwp0CYHPtXPNNcLxxbWTnEadIDAwigVA1rNHH1/8ZqVc
	 O90upInZ+24tSENCeLsaDMUDDz2BDL+e51gMshOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBZO3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfBZO3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:29:22 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBEE20863;
        Tue, 26 Feb 2019 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551191361;
        bh=nf1Wf0q7vxNMlqz95M/YOgQNPju9HwyB+Yok2j5G/Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aogqmpbvSbNh56S2pccExd7Wv9MqVAIgD5m5UJ9oxcCSz6U0lmXE7ajnIZ4cOYFqf
         sQbPjgP2izinYua7fsD8yw73Q69UZJdDfzZEpn7QqvAml2lejit8Pz0nPi1tn4ZP++
         tHasKw5VgWxD3QRt10WJGJ0uMeAYLr9Pd5AskZbw=
Date:   Tue, 26 Feb 2019 09:29:19 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.20 129/183] net: sfp: do not probe SFP module before
 were attached
Message-ID: <20190226142919.GG10616@sasha-vm>
References: <20190225195054.748060397@linuxfoundation.org>
 <20190225195116.455060281@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190225195116.455060281@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:11:42PM +0100, Greg Kroah-Hartman wrote:
>4.20-stable review patch.  If anyone has any objections, please let me know.
>
>------------------
>
>From: Russell King <rmk+kernel@armlinux.org.uk>
>
>[ Upstream commit b5bfc21af5cb3d53f9cee0ef82eaa43762a90f81 ]
>
>When we probe a SFP module, we expect to be able to call the upstream
>device's module_insert() function so that the upstream link can be
>configured.  However, when the upstream device is delayed, we currently
>may end up probing the module before the upstream device is available,
>and lose the module_insert() call.
>
>Avoid this by holding off probing the module until the SFP bus is
>properly connected to both the SFP socket driver and the upstream
>driver.
>
>Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This one got fixed by 87454b6edc1b0143fdb3d9853285477e95af74a4 .

--
Thanks,
Sasha
