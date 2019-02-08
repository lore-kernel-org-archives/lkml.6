Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806A217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628295;
	bh=KRUDY47BNPC6/zlmVKnaaYThVYMyitvH5zcYUnRb55o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b0zo0eWOsZGx2WRKs/6eFWIUALYIc5CRPkjvjB75vQQORiFOJv3osj7Z1XdTIf3yo
	 /vx8ImgZ2jlJcINRdm3VyrN9hfUT8EXLshm2VFvSY+gW9zTQB1njhI1BUA81ypGU/v
	 SBNLLX0Nx7Vk+qP9zqQkCauk/mSkO31/uvx8g0Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBHMSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:18:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CA42086C;
        Fri,  8 Feb 2019 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628292;
        bh=KRUDY47BNPC6/zlmVKnaaYThVYMyitvH5zcYUnRb55o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rI0B6yNtK0QBJAuPsdSWN72doL1JfDTeX7UGG7BbZDK3hwsLx4iBjNaExK82Zw8im
         01UQTOIl1eNUQvBj5l7TpiTi8MrtJ1KQ69iPhQODhIeLzqQfJYUi+zu52zZLsP5Xz8
         /wAo2vCSIAaJh/PHCkd61gRxcMA3tg3f8ctjTPa4=
Date:   Fri, 8 Feb 2019 13:18:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190208121810.GD23483@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <20190124201251.15159-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124201251.15159-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:12:46PM -0500, Sven Van Asbroeck wrote:
> +static DEFINE_IDA(fieldbus_ida);

You forget to destroy this ida structure when the module is removed.
It's a common thing to get wrong :(

thanks,

greg k-h
