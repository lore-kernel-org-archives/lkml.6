Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B1C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF992082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK4P6wLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF992082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJ1W6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 18:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeJ1W6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 18:58:09 -0400
Received: from localhost (unknown [178.225.204.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC362082B;
        Sun, 28 Oct 2018 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540736004;
        bh=vOjnZb2eCl0WdgHZjtLrLM7jxxWbRq17pH89ah59/tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mK4P6wLEtAlYqfVbbQcSEGw0OXQ/jhCzUToVsTyEvUx1EeZMZOTAeOhId9p/87iz8
         iWiRxODhFhQHAngfHEQxHo2OBR649AfktV8Jm5hznLGbm0qfblUnLZ+ROI6QeICVKy
         7vR08fJXSSMZ8gX7L+UVXeEIi0BWr8UJSrXrcYIE=
Date:   Sun, 28 Oct 2018 15:13:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Which SPDX Identifier for files without explicit GPL version
Message-ID: <20181028141319.GA13215@kroah.com>
References: <406c69c1-43fd-f821-b74b-a1399ed636e9@gmail.com>
 <20181028112728.GD8826@kroah.com>
 <f1aa3ce0-7e68-ce7e-e2a3-a978bcc36e03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1aa3ce0-7e68-ce7e-e2a3-a978bcc36e03@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 02:22:40PM +0100, Michael Straube wrote:
> On 10/28/18 12:27 PM, Greg Kroah-Hartman wrote:
> > On Sun, Oct 28, 2018 at 11:04:06AM +0100, Michael Straube wrote:
> > > Hi,
> > > 
> > > which GPL version should be used in SPDX Identifiers for files that
> > > are GPL licensed but do not mention any version? It is not clear to
> > > me after reading license-rules.rst.
> > > 
> > > For example:
> > > 
> > > /******************************************************************************
> > >   * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
> > >   *
> > >   * This program is distributed in the hope that it will be useful, but WITHOUT
> > >   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > >   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > >   * more details.
> > >   *
> > >   * The full GNU General Public License is included in this distribution in the
> > >   * file called LICENSE.
> > 
> > Perhaps look up what version of the GPL that was originally contained in
> > the tarball that this driver was bundled with?  I think that should be
> > on their website somewhere...
> > 
> > If not, it's v1, not a good thing, but all we have to go on.  Also, try
> > emailing:
> > 
> > >   * Contact Information:
> > >   * wlanfae <wlanfae@realtek.com>
> > 
> > That address :)
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Ah, there is a file 'license' in the root directory of this driver (rtl8192e)
> that I overlooked. It contains GPLv2. So v2 applies to all files with the above
> shortened boiler plate?

Yes.  So add a SPDX line to the file and delete the boiler plate text so
we don't have this question again in the future.  Then delete that opy
of the GPL so we don't have files we don't need :)

thanks,

greg k-h
