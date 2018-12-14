Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98730206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeLNQH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:07:28 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49836 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:07:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 507F9185FC;
        Fri, 14 Dec 2018 17:07:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id eqeNzm4zGd3u; Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id B7D56185EE;
        Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A719E1A063;
        Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB941A062;
        Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 8F693266E;
        Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 8DE0F80D7B; Fri, 14 Dec 2018 17:07:25 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:07:25 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux@armlinux.org.uk, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181214160725.kfhatfi47dz3guts@axis.com>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
 <20181204141415.969-2-vincent.whitchurch@axis.com>
 <20181206172920.GA2728@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206172920.GA2728@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:29:20PM +0100, Jessica Yu wrote:
> Also, do you mind if I drop the module_ prefix from
> module_kallsyms_symbol_value()? I recently submitted some internal
> module kallsyms cleanups [1] and there we have the newly renamed
> kallsyms_symbol_name(), so I think it'd be nice if we kept the naming
> scheme consistent with just kallsyms_symbol_value(). I could just do
> this myself if you don't want to respin a v6.

I've sent out a v6 with this change.  I also rebased the change on top
of your cleanups in modules-next.

Thanks.
