Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFED42172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFED42172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeI1Qzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:55:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:40166 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeI1Qzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:55:53 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 12BE415AF4A;
        Fri, 28 Sep 2018 19:32:46 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id w8SAWiw5004762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 19:32:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id w8SAWiwU007281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 19:32:44 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w8SAWhZX007280;
        Fri, 28 Sep 2018 19:32:43 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Mihir Mehta <mihir@cs.utexas.edu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Expand a slightly out-of-date comment
References: <20180927150046.11538-1-mihir@cs.utexas.edu>
Date:   Fri, 28 Sep 2018 19:32:43 +0900
In-Reply-To: <20180927150046.11538-1-mihir@cs.utexas.edu> (Mihir Mehta's
        message of "Thu, 27 Sep 2018 10:00:46 -0500")
Message-ID: <87sh1tewtw.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mihir Mehta <mihir@cs.utexas.edu> writes:

> The file namei.c seems to have been renamed to namei_msdos.c, so I
> decided to update the comment with the correct name, and expand it a bit
> to tell the reader what to look for.
> ---
>  fs/fat/dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index b833ffe..d954e18 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -368,7 +368,8 @@ static int fat_parse_short(struct super_block *sb,
>  	}
>  
>  	memcpy(work, de->name, sizeof(work));
> -	/* see namei.c, msdos_format_name */
> +	/* For an explanation of the special treatment of 0x05 in
> +	   filenames, see msdos_format_name in namei_msdos.c */
>  	if (work[0] == 0x05)
>  		work[0] = 0xE5;

Sorry. However, could you use

	/*
         *
         */

style comment? Otherwise, looks good.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
