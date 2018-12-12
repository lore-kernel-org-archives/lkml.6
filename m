Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A772084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635872;
	bh=u0aR2M616FAZqHh197QBElnT9rUi8dbCdEx0JRkc4A0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=ajLh4+ZcRvDxPzSx+a35nGXuCK0lv8NBpNtxAU3A7YTDaiZe2c9M2Bu1RaGhQlV25
	 GR3SaEiDiJnoJxP861keWZU4jfLVeXSDlt4e57rVgGZMy8j7iX+WhD9SDdogRAv70A
	 xAIOZ4o0aytfjjQyNVSWpNIU98QqZ9G5BqwKOoEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A772084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeLLRbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:31:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B9A20839;
        Wed, 12 Dec 2018 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635870;
        bh=u0aR2M616FAZqHh197QBElnT9rUi8dbCdEx0JRkc4A0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=1+43EtDPwAYOC4ftK0tmWa0wCDbBDoAt/UzGVpx9netiX/b0jBlB3SeAhPlPukE+o
         P7DJvOIQha/cF24c57exIUGyPkQ2adlJDzQTcLWzxfjIL2+/sHYBk0LhHwN+6hEkOl
         enKmFndrj4MDNMIHcraeNVAx6/sh0O5JrpjjNzHY=
Date:   Wed, 12 Dec 2018 18:27:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bin Liu <b-liu@ti.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3.18 48/54] dmaengine: cppi41: delete channel from
 pending list when stop channel
Message-ID: <20181212172749.GA8269@kroah.com>
References: <20181211151546.010073210@linuxfoundation.org>
 <20181211151548.757658735@linuxfoundation.org>
 <20181212163828.GA30432@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212163828.GA30432@uda0271908>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:28AM -0600, Bin Liu wrote:
> Hi Greg,
> 
> On Tue, Dec 11, 2018 at 04:41:36PM +0100, Greg Kroah-Hartman wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> Please drop this patch. It really should go back to v4.9 but not older.
> 
> The Fixes should instead be
> 
> 	fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")

Thanks for letting me know, I will go drop this.  It looks like it was
breaking the 4.4 and 3.18 builds :(

greg k-h
