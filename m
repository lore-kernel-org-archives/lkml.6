Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB13C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F320666
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAHvstf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8F320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDCIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:08:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45571 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:08:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so7437621plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 18:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WaMCluLNaIkK+r8dhO5tQmM/Rkwr/DfCvLUkKFPCcKI=;
        b=fAHvstf5IhNB860jQc8W8qlF2SzjhzM4Sq8JVqO+ZsfvJNxh/UuPwZ45HNwYST588V
         YHJ8K0RvTTfE9dQgAXrIAtLkXiASy6A/o5q0F1R1YQX9uIf9N8Zl/aEr4ADESQ+8NPFy
         Et5RMMZvDnLUnqFuvwQBJtxYxkBhNbqmPMGEDq64vthm2HpKoYeayYhNGnNCEqI7B/ks
         gN+V+rYXLcAoqI0JUC/zZ53ZUDIdXrQB7La+mOwZUwlnfX62dXGgSu+YhXL1yOvH1v1K
         E1DV9HXY3klF2wPAqunHH/aTBi+1UYMuzOEi6Gktv5IjMsr+kXrOHWQN1w3j8jt8vSgM
         7dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WaMCluLNaIkK+r8dhO5tQmM/Rkwr/DfCvLUkKFPCcKI=;
        b=HXhhuLmFyhQnHoy1nabwsTaUgQeat5rAB93yZGimM6QQx4bShgcZqKrDbh5+WIq72p
         kkkBamcbldjfwtZ8JhXCPx2Ej22LLwe3iPHN4FsWCmcDegrsyNcYXciDbaU1cD4JmB8G
         X2N8/QYl4Cvyrh5jNG9DcW9GvIMN8yMB7dkucvggtWbDCD7rKt9H3LGcO+NlJmb2junX
         ldHqwCUxfkgXCQsVGGpyaoufPUCkVwMJ4iAGY37DalO3NxvpCI+0EJL+3VDkyX0jc2+G
         cvo6sppdAIc4McSKsefQWYLlELFkz2RLv3eY7Ov3da0b5tHVygfdd4rispAhGhlTiDch
         aHLg==
X-Gm-Message-State: AA+aEWZJIYFYjAou6ueA2RRQNc3WEBkakPXYq5TQQsgfG1kCCRPFEag6
        Au/fJ6wdfiKkYuk3YLfNdFc=
X-Google-Smtp-Source: AFSGD/Udxy5eiCr2ZFRlS/w5JY9lNpyGKuWbAt0F7XpyrzmyTBsbtcNjeuTP+2QIzLEUCvDtLGrSfA==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3mr17059883plz.124.1543889311090;
        Mon, 03 Dec 2018 18:08:31 -0800 (PST)
Received: from localhost ([175.223.44.178])
        by smtp.gmail.com with ESMTPSA id u6sm17842590pgr.79.2018.12.03.18.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 18:08:30 -0800 (PST)
Date:   Tue, 4 Dec 2018 11:08:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v4 0/7] zram idle page writeback
Message-ID: <20181204020827.GB7580@jagdpanzerIV>
References: <20181203024045.153534-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203024045.153534-1-minchan@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 11:40), Minchan Kim wrote:
> 
> Minchan Kim (7):
>   zram: fix lockdep warning of free block handling
>   zram: fix double free backing device
>   zram: refactoring flags and writeback stuff
>   zram: introduce ZRAM_IDLE flag
>   zram: support idle/huge page writeback
>   zram: add bd_stat statistics
>   zram: writeback throttle

Looks good to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
