Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC87C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63C9204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C9204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIFRfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:35:42 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:61880 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeIFRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:35:42 -0400
X-IronPort-AV: E=Sophos;i="5.53,338,1531785600"; 
   d="scan'208";a="64591337"
Date:   Thu, 6 Sep 2018 14:00:16 +0100
From:   Wei Liu <wei.liu2@citrix.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>
Subject: Re: [PATCH] xen/manage: don't complain about an empty value in
 control/sysrq node
Message-ID: <20180906130016.3nu6zvitjci7x5ge@zion.uk.xensource.com>
References: <20180906112608.4221-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180906112608.4221-1-vkuznets@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:26:08PM +0200, Vitaly Kuznetsov wrote:
> When guest receives a sysrq request from the host it acknowledges it by
> writing '\0' to control/sysrq xenstore node. This, however, make xenstore
> watch fire again but xenbus_scanf() fails to parse empty value with "%c"
> format string:
> 
>  sysrq: SysRq : Emergency Sync
>  Emergency Sync complete
>  xen:manage: Error -34 reading sysrq code in control/sysrq
> 
> Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
> control/sysrq is totally legal.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
