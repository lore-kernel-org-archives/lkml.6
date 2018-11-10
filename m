Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25ADC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FE72080D
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FE72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeKJWsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:48:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50822 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbeKJWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:48:39 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLSvB-0003w0-Mg; Sat, 10 Nov 2018 13:03:29 +0000
Date:   Sat, 10 Nov 2018 13:03:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] sysv: return 'err' instead of 0 in
 __sysv_write_inode
Message-ID: <20181110130329.GE32577@ZenIV.linux.org.uk>
References: <1541823204-45068-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541823204-45068-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 04:13:24AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/sysv/inode.c: In function '__sysv_write_inode':
> fs/sysv/inode.c:239:6: warning:
>  variable 'err' set but not used [-Wunused-but-set-variable]
> 
> __sysv_write_inode should return 'err' instead of 0
> 
> Fixes: 05459ca81ac3 ("repair sysv_write_inode(), switch sysv to simple_fsync()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
