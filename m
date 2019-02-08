Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573AAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293F020823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBHQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:38:17 -0500
Received: from mail.us.es ([193.147.175.20]:34156 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfBHQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:38:17 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5480E127C7C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:38:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 45488DA863
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:38:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 39D5ADA86A; Fri,  8 Feb 2019 17:38:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EED22DA796;
        Fri,  8 Feb 2019 17:38:12 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 08 Feb 2019 17:38:12 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CBC3A4265A4C;
        Fri,  8 Feb 2019 17:38:12 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:38:12 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH net-next] ethtool: Remove unnecessary null check in
 ethtool_rx_flow_rule_create
Message-ID: <20190208163812.jjdqgghcwadazliu@salvia>
References: <20190208044652.32166-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208044652.32166-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:46:53PM -0700, Nathan Chancellor wrote:
> net/core/ethtool.c:3023:19: warning: address of array
> 'ext_m_spec->h_dest' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>                 if (ext_m_spec->h_dest) {
>                 ~~  ~~~~~~~~~~~~^~~~~~
> 
> h_dest is an array, it can't be null so remove this check.
> 
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
> Link: https://github.com/ClangBuiltLinux/linux/issues/353
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks!
