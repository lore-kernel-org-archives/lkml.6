Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D97C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmhE+XN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC20E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeISNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:05:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33957 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeISNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:05:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so2237276plo.1;
        Wed, 19 Sep 2018 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jCSoodXHl+YXOm4gEA48F1tlCCCKNaTt4RxP2Wgpd2M=;
        b=JmhE+XN9m02DL9ZBGtyV9wYbHsxuvqDeYfkuXwULhZ3ZkTQirnE9Ir6igRuxmJK/fI
         wssk7bbsjT4bFgeyiAYm3uK3Jit4E5EO6m5JBVldXA38BYv85XhuHmjNhc/kmKn/b6rQ
         jf1G3hnMQuLeJQvB01XFZOJ0axpiUi7qn3u0PcGwCPbc8AA3K9R11spoQEzTvswfzLXi
         8L8Ru9AzcNo71B0OM7xkTd1wJRZG0NIhzi/+EFaO30J3X6RHrgbSoC5vPtnPn25VbR5X
         5XksQUo5J4lW/wuv8OP7xCu1ztYTFaEt+Nyf3W+87EszWdZff4RxG9wJ9Tor6dgksOww
         leaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jCSoodXHl+YXOm4gEA48F1tlCCCKNaTt4RxP2Wgpd2M=;
        b=patTm7B4l5UdKX1pMSvtHUXQ/r5vtk1mxUPwNLsdtvqGqE3JUJNDkR3AR/uSWkpCDJ
         ZKGQvFkvn8qe39oYkkYT2pYlIfvEWHxUjGonst6bGLxPuOppo9RlJe/mbdQiEr6EClSk
         Hywx+/3jVummA6uYwvPWbQY+7y7bk+nwEmmVfD3G9fJfTHbrKhyDiItgvUNZYV0LBcH3
         no96UrKpoO07EoKyeDMo1DGF1i6lMuHGRn4Op4h+SEECu/ueu7MJDEzC+BwTwkVkKPPF
         1gPvFhtV+nKe15YCVcMuy+TQu7hfnyDi4cy5tbE22Bk4x63t3zFFGNda52UzMPnVbcse
         5QNA==
X-Gm-Message-State: APzg51DkfV92UBErzzRrZgLNATom4Ej7hduhCfM60rpd2bGZ6flWQLA3
        KSdEf+JdkF8J3ZiqHZ8AWH+fYpE0
X-Google-Smtp-Source: ANB0VdYYdaIxXhqAm+i3fbMqXytrdOI4QmQhMFo0vJtlQL8H5a0ArcVvr/FzeSgeq8bvSTOGRgIn8w==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3-v6mr32552091plb.245.1537342160261;
        Wed, 19 Sep 2018 00:29:20 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id h12-v6sm25822896pfo.135.2018.09.19.00.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 00:29:18 -0700 (PDT)
Date:   Wed, 19 Sep 2018 16:29:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix missing zero pages for memory tracking
Message-ID: <20180919072916.GA1180@jagdpanzerIV>
References: <20180919051846.234615-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919051846.234615-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/19/18 14:18), Minchan Kim wrote:
> We need to count zero filled pages as well as other pages in zram.

A nit,

	'ZRAM_FLAG_SHIFT + 1' covers all ZRAM_SAME pages, not only
zero filled pages.

	-ss
