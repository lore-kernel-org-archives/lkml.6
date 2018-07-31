Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4B204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC4B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbeGaXGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:06:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbeGaXGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AC108790A;
        Tue, 31 Jul 2018 21:23:55 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA3651102E2A;
        Tue, 31 Jul 2018 21:23:54 +0000 (UTC)
Date:   Tue, 31 Jul 2018 16:23:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: Fix spectre v1 gadget in netlink_create()
Message-ID: <20180731212353.kydep424ncpoht75@treble>
References: <20180731211316.12971-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731211316.12971-1-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 21:23:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 21:23:55 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:13:16PM +0000, Jeremy Cline wrote:
> 'protocol' is a user-controlled value, so sanitize it after the bounds
> check to avoid using it for speculative out-of-bounds access to arrays
> indexed by it.
> 
> This addresses the following accesses detected with the help of smatch:
> 
> * net/netlink/af_netlink.c:654 __netlink_create() warn: potential
>   spectre issue 'nlk_cb_mutex_keys' [w]
> 
> * net/netlink/af_netlink.c:654 __netlink_create() warn: potential
>   spectre issue 'nlk_cb_mutex_key_strings' [w]
> 
> * net/netlink/af_netlink.c:685 netlink_create() warn: potential spectre
>   issue 'nl_table' [w] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
