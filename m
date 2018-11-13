Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD05C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447022360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5447022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbeKMS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:59:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeKMS7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:59:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3F89308FEC9;
        Tue, 13 Nov 2018 09:02:36 +0000 (UTC)
Received: from localhost (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5446519744;
        Tue, 13 Nov 2018 09:02:34 +0000 (UTC)
Date:   Tue, 13 Nov 2018 10:02:28 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH net-next v2] geneve: Use empty braces for addr6
 initializer
Message-ID: <20181113100228.6843ac40@redhat.com>
In-Reply-To: <20181113061146.12182-1-natechancellor@gmail.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
        <20181113061146.12182-1-natechancellor@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 13 Nov 2018 09:02:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 23:11:47 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> drivers/net/geneve.c:428:29: error: suggest braces around initialization
> of subobject [-Werror,-Wmissing-braces]
>                 struct in6_addr addr6 = { 0 };
>                                           ^
>                                           {}
> 
> Most initializations of structs in the kernel seem to use this format.
> 
> Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Also,

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano
