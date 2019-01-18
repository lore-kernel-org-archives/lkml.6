Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61323C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DA52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547826946;
	bh=qUkhlJbgGuLbuL/lPsr8l8OS8S7KE2oYbF5rdX6KRSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H1vhSmxlNLK4+GM6M3NHpk/RRudoMoN4EAIFERD2ARROD2NWCZ9BFpvLY294mwxEY
	 cfHpfTCMiGb092PQn1ib5UYKilrhpsngtxeTgR+k0htlX7y25BNOmOL62zHM7S0Uhb
	 NpInAtPxkWPjTp8FYthQq/5snTOTOGzhHzL4WmSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfARPzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:55:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfARPzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:55:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7C92086D;
        Fri, 18 Jan 2019 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547826943;
        bh=qUkhlJbgGuLbuL/lPsr8l8OS8S7KE2oYbF5rdX6KRSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2hmcj4qE0NOFx+YSK+D8dtRcorwfUlGbzfE2US2aYFm6DnANKgsHqhS+Lfpo7L9L
         EnbzI2iWBy2nUBQypETT2+kgVBwO8zuVGDNjvCy0WGzn+1DupQ7KD1jOJ+Dq5XghXF
         22X+A0zV0t9G0yYmw3zdEy9tdI+dfsQvIRezexZE=
Date:   Fri, 18 Jan 2019 16:55:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2] driver core: move device->knode_class to
 device_private
Message-ID: <20190118155541.GA5544@kroah.com>
References: <20190117055719.6161-1-richardw.yang@linux.intel.com>
 <20190118023459.9972-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118023459.9972-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:34:59AM +0800, Wei Yang wrote:
> As the description of struct device_private says, it stores data which
> is private to driver core. And it already has similar fields like:
> knode_parent, knode_driver, knode_driver and knode_bus. This look it is
> more proper to put knode_class together with those fields to make it
> private to driver core.
> 
> This patch move device->knode_class to device_private to make it comply
> with code convention.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for this.  There are a number of other variables that should move
into this structure, if you want to take a look into doing that.

greg k-h
