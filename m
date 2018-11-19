Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6176C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A436A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A436A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeKSPKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:10:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53258 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKSPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:10:11 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gObTF-0007wG-Kq; Mon, 19 Nov 2018 04:47:37 +0000
Date:   Mon, 19 Nov 2018 04:47:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mszeredi@redhat.com, amir73il@gmail.com, neilb@suse.com,
        bfields@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, matt.helsley@gmail.com
Subject: Re: [PATCH -next] exportfs: fix 'passing zero to ERR_PTR()' warning
Message-ID: <20181119044737.GL32577@ZenIV.linux.org.uk>
References: <20181119033241.20264-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119033241.20264-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:32:41AM +0800, YueHaibing wrote:
> Fix a static code checker warning:
>   fs/exportfs/expfs.c:171 reconnect_one() warn: passing zero to 'ERR_PTR'
> 
> The error path for lookup_one_len_unlocked failure
> should set err to PTR_ERR.
> 
> Fixes: bbf7a8a3562f ("exportfs: move most of reconnect_path to helper function")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
