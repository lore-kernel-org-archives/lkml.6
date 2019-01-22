Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86FBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27020879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548159754;
	bh=2a47g4qcVmJDSPx4VZ30qfymjWEBE3YwXuWATS5DR4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vpl/lwc1J7BBpB9rWpFak6aR6RIibhhpDkNtyj98+uZAXkFFGIOPiF3mvTvtTJDcr
	 W5qQUub/yvc1Su7iJlZLqM9k8iZ4rovJqL003RujKPpNdfR0ktjPB04BnlVI+kYL0c
	 yhppGVGBI3DF/CyfnBZ+cbt2Rh5KCJNSAcH9U3q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfAVMWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfAVMWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:22:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C404520879;
        Tue, 22 Jan 2019 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548159751;
        bh=2a47g4qcVmJDSPx4VZ30qfymjWEBE3YwXuWATS5DR4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/5oTtX+JC1vJ0Aq39acLxFZwjkFsGk/BV3sNEsZ0sBN/hwWi04h71g2kImH8F1Wj
         IptE28KzkX+cPAj2KfZRw+oubCiDN5EGMy/5iv+ro3w4RoZfUmV5fmjmaTtXRv5G4E
         moQZVb/CrooWmt7Qu1Ek4g5Fn+qRFdgXLW0WBA4A=
Date:   Tue, 22 Jan 2019 13:22:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Message-ID: <20190122122228.GA2736@kroah.com>
References: <20190108091539.16674-1-brgl@bgdev.pl>
 <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:43:47PM +0530, Sekhar Nori wrote:
> Hi Bartosz,
> 
> On 08/01/19 2:45 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Hi Sekhar,
> > 
> > now that all dependencies are in and v5.0-rc1 is tagged, please consider
> > picking up the second batch of davinci-specific changes into your tree.
> > Once that's done, please provide me with an immutable branch for me to
> > apply the last patch to my at24 tree.
> 
> You can use branch v5.1/eeprom-for-bartosz in my tree for this (commit
> e430685f4969).
> 
> > 
> > This is the second part of the effort to modernize the at24 driver and
> > remove the legacy platform data structure in favor of device properties.
> > It required getting rid of the at24 setup callback in favor of nvmem
> > lookups.
> > 
> > Re-tested with da850-evm and dm365-evm.
> 
> Applied patches 1-11 for v5.1

Feel free to take patch 12 as well :)

thanks,

greg k-h
