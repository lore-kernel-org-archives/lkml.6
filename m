Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEEC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243082082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHrbjQvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243082082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeLEK7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLEK7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:59:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF2720672;
        Wed,  5 Dec 2018 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544007591;
        bh=4UCfhVE7qjH3wAFUwDyhGpdlk4DkxQMshy2TW0f5emk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHrbjQvdqG6AaUeXOqZzg5vM0OkGo1jGX/py6RbPI+Sq9BRGHZ+86zjD0r4PFjwBn
         hcnICQGdFbHWm4rbRaiOKlGHCYgR2vLrpDqGOnEg6gOxBfeJ7B1zA7dv0DIwey2a7S
         SqF+L+1VwY8rQSFzRnqYH0/rVInvBrvjv/2qAvd0=
Date:   Wed, 5 Dec 2018 11:59:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1] drivers/base/memory.c: Use DEVICE_ATTR_RO and friends
Message-ID: <20181205105949.GD16376@kroah.com>
References: <20181203111611.10633-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203111611.10633-1-david@redhat.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:16:11PM +0100, David Hildenbrand wrote:
> Let's use the easier to read (and not mess up) variants:
> - Use DEVICE_ATTR_RO
> - Use DEVICE_ATTR_WO
> - Use DEVICE_ATTR_RW
> instead of the more generic DEVICE_ATTR() we're using right now.
> 
> We have to rename most callback functions. By fixing the intendations we
> can even save some LOCs.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  drivers/base/memory.c | 79 ++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 43 deletions(-)

Thanks, I'll take this through my tree.

greg k-h
