Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B564C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2714D23F63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2714D23F63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFVJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:38:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeFVJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:38:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D2EFACC8;
        Fri, 22 Jun 2018 09:38:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFCFDDA8D3; Fri, 22 Jun 2018 11:35:10 +0200 (CEST)
Date:   Fri, 22 Jun 2018 11:35:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Refactor count handling in
 btrfs_unpin_free_ino()
Message-ID: <20180622093510.GV24375@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Geert Uytterhoeven <geert@linux-m68k.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622071829.1356-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622071829.1356-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 09:18:29AM +0200, Geert Uytterhoeven wrote:
> With gcc 4.1.2:
> 
>     fs/btrfs/inode-map.c: In function ‘btrfs_unpin_free_ino’:
>     fs/btrfs/inode-map.c:241: warning: ‘count’ may be used uninitialized in this function
> 
> While this warning is a false-positive, it can easily be killed by
> refactoring the code.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Please review. Compile-tested only.

Reviewed-by: David Sterba <dsterba@suse.com>
