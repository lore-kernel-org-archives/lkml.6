Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706B8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH/hfe/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeK0Sil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbeK0Sil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:38:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC85320873;
        Tue, 27 Nov 2018 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543304502;
        bh=+eNxRqYI+isdgQgxfJ5WbHXO1nFPNcp0khafq4VGx60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH/hfe/1m3t34niv/MKaBXWr2VsXqQlDsNamtjnu/JxvwZTFmAYfNLeh5cpU4aSg+
         zXZLaL1giRFcz1dLc9jy26hJGhYi90bMJfBkG6lyeEm/WkpOhZ7RbiW5Ny2G/ylOV1
         6gCMkGu4MS+20FFPySYIGDNQtzAx/9ZE1R1lgSvs=
Date:   Tue, 27 Nov 2018 08:41:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: hx8837: add a HiMax HX8837 display controller
 driver
Message-ID: <20181127074140.GB13965@kroah.com>
References: <20181112023929.650002-1-lkundrak@v3.sk>
 <20181112023929.650002-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112023929.650002-2-lkundrak@v3.sk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:39:29AM +0100, Lubomir Rintel wrote:
> HiMax HX8837 is a display controller used on OLPC platforms. It controls
> backlight and is able to capture and freeze a frame when the LCD controller
> (and the rest of the plaform) is powered off.
> 
> This driver is based on the same code as drivers/staging/olpc_dcon.
> I modernized it to use managed GPIO, device-tree bindings, sysfs attribtue
> groups, essentially fixing the staging driver's TODO.

You are creating custom sysfs files, with no Documentation/ABI/ update
for us to know what those files are or how they are used :(

Why do you need custom sysfs files in the first place?  Isn't there
already an api for this type of device in the kernel?

thanks,

greg k-h
