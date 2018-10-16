Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32CC208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xbXn9Aa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32CC208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJPS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJPS7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:59:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC2D2083C;
        Tue, 16 Oct 2018 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539688150;
        bh=OmIFT0kf3jNsUK7486lXVLy3M5NnVUs+H2HRj/IXsLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbXn9Aa3h3pQd5+7sO2MqKXEPOKQxvsiGDhHL+YJWGQPCLhDR99NZDKaTArh0fAuI
         5eHIjjAT8mKVhP4oEktpW9NSX2Cy+/D5o8GRWqs3cXQco+/CopLJnIKr78baIDMD8b
         xgU1/EsHTz9LaMJBj9gtluQfPe4BcQ1IdfjmHk9U=
Date:   Tue, 16 Oct 2018 13:09:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
Message-ID: <20181016110908.GA32581@kroah.com>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
 <20181016102715.GD7449@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016102715.GD7449@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:27:15AM +0100, Mark Brown wrote:
> On Tue, Oct 16, 2018 at 09:22:42AM +0200, Andrzej Hajda wrote:
> 
> > +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> 
> ...
> 
> > +	return err;
> > +}
> > +
> 
> This will need an EXPORT_SYMBOL for modules won't it?

EXPORT_SYMBOL_GPL() to be specific, as it is dealing with the driver
core.

thanks,

greg k-h
