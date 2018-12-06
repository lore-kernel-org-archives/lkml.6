Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C773620700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108275;
	bh=lGgrtTEHhINdyGocI25ALP/3PLxdDFclxtd2aPYFO0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nrncf2eKP90Kxkdns0Pd9VILaOQUrp7SRWsCBjNIsjjtClgpzidb14AT83Sg32u3T
	 nkwkkC1uQM2SJkmx3o0NwVnHHQOLPeS6br6wNt56afYc5X4dam3bOR7BDNEg+zgzv9
	 NFjkYRMCbpayeFsasqMK7UtzdyWTJQQ2wW0//ldY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C773620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLFO5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLFO5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:57:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7B020700;
        Thu,  6 Dec 2018 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544108271;
        bh=lGgrtTEHhINdyGocI25ALP/3PLxdDFclxtd2aPYFO0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEeGrw7toNGVHhXdabWngTqKjG0Pom/jV7YR84PKqYhUmJRp4Nkkffc73i3UMjW2m
         YzPI9GwMxgk4u5yGE9KMcB3DokKufJTtfNoyZBRaXbtgSr0S16c8pH8xRtkCunL/FK
         3O7Vot5BsX08haEAIXzVeuY8GGhpKl/WaEkFgBvw=
Date:   Thu, 6 Dec 2018 15:57:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: base: remove need for a temporary string
 for the node name
Message-ID: <20181206145748.GA8360@kroah.com>
References: <20181129180844.31138-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129180844.31138-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:08:44PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the node name is being formatting into a temporary string
> node_name, however, kobject_init_and_add allows one to format up
> a node name, so use that instead. This removes the need for the
> node_name string and also cleans up the following warning:
> 
> Fixes clang warning:
> warning: format string is not a string literal (potentially
> insecure) [-Wformat-security]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/swnode.c | 5 +----

I don't know where this file comes from.  It's not in my
driver-core-next branch, who is creating it?

thanks,

greg k-h
