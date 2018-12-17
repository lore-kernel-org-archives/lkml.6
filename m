Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30592086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545034607;
	bh=kP+CYDAAQ6LBKSCAHh7s4Yx+Ha9G0XnsqeKef2V+U0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BPX/LyCSEU8yIa0Jizmfbc59UsiRRlP+XOZzDK0+4Uip4hzKH9SIIoz5Oka8kcFZq
	 Ko0bbVWEdHY2kt+uWlLy2VzoRA5i3d8zGaGJ4QH1vRf6HGjXKNcDfzOJb3Fi4ZrCRj
	 aqmD9Uxlt7gJqU8URAP9FnpPeuixaUS4fOzIAicg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeLQIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeLQIQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:16:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E3020672;
        Mon, 17 Dec 2018 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545034606;
        bh=kP+CYDAAQ6LBKSCAHh7s4Yx+Ha9G0XnsqeKef2V+U0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2e8oEfH1VGvJgJgJhhnJR0utg1/I+2s/iLsbNSqldenW4KvuAM/4pb/XcGGCfkux8
         q1wHXsPby5PKt8Zm0XG3Fp3/L+MqQGnNBmBRd3qs2fQBiJdUWlqbHtx5dmMtQxJ4Tz
         5y983TRnRcE7mQutrtAfF87PO/OESbZnZMLmWCe8=
Date:   Mon, 17 Dec 2018 09:16:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     marvin24@gmx.de, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ac100@lists.launchpad.net
Subject: Re: [PATCH 2/2] Staging: nvec: nvec: fixed check style issues
Message-ID: <20181217081640.GA16368@kroah.com>
References: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 08:57:43AM -0800, Amir Mahdi Ghorbanian wrote:
> @@ -626,7 +628,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  		break;
>  	case 2:		/* first byte after command */
>  		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -			udelay(33);
> +			usleep_range(0, 33);

Why is this a valid range to sleep for for this device?  Have you been
able to verify/test this?

thanks,

greg k-h
