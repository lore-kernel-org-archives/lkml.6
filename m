Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55358C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB7206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="WIJsPTM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbeLQMgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:36:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41811 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeLQMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:36:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so6071068plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvZd4QS47o0MtYrlsPolllIUJzYSe4t5Zo47uispF5s=;
        b=WIJsPTM9LyQQOrYzgX4jE7MiJb5ygXrs10N6ZF4J8Y1Z4Sjw71eQusgzmu2IIW4TRM
         VJhFrEJe7H9aQ3DhiAWRqDbRSnyg7fNdFISqd8CuSGrlq83Zd2LeNdeNcleg84a5oLpE
         RBFikn0QHlejQasPCGD/sDpDMNaT696l/dgN1kes+JqhUm+mlm4b2EHlahGAevYuO2Ud
         holm2iqZUz+s0thIijnaX/EzYpObalshOimFscXEg6WFDMkTHW2ELsbUC2pLApyTSLn/
         PZ5suBh8QlB5VYn+J5pewlFg4ZzrXs9uysPNhcuNlbB5bBQXRsg2yY/W5UXF75fndkyN
         7q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvZd4QS47o0MtYrlsPolllIUJzYSe4t5Zo47uispF5s=;
        b=hskUBD6lCIpZivHP7RgWA7IKk+PrknJoHbjuqWdkHVZ/HuXrpl37wWpDGJFbEtXqrJ
         1E9TZra4yeXaM7aopE7dvE/B1UqgaNGiScSTcYd6HlY9GeMHGgLu/VH7ezatdHm+kFHd
         WlS4+InhmDjLjAgukWzj2GV6q3qs//CzTzvb+CBxnkx1AotqHTkG3fQVMOKBdi8b5VdA
         Yi+CW4Xq70EnQOjpTDMUegSC2JTNdcj2c4wlslNTuSlIMBOF6XJ1qOQhFSLx9EQ1fTz3
         isJHHEOa5dFOm5tKT+wnOEBRgmLP+wapmc23Xo12lL4u1xhEZCAM+Gw1EYKyUEwlXL0T
         ErmQ==
X-Gm-Message-State: AA+aEWZRUAY0hiV3tIaX43euxnwOuaqzdWwxQ53gc3KHSDf8jQ74VJom
        1wRXNg86G6MyHOdc5OuzgTxEqg==
X-Google-Smtp-Source: AFSGD/VtTibbTVrLwvZa7eSMtOPO/E52osIZihmJdc38Mjqtn23XADP7YpCrAKTeFw9++OLuqvWWwg==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr12849486plo.205.1545050211762;
        Mon, 17 Dec 2018 04:36:51 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id v191sm32066029pgb.77.2018.12.17.04.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:36:50 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id F41C4300316; Mon, 17 Dec 2018 15:36:45 +0300 (+03)
Date:   Mon, 17 Dec 2018 15:36:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mike.kravetz@oracle.com, jglisse@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove __hugepage_set_anon_rmap()
Message-ID: <20181217123645.vblqlndn7qh5co5l@kshutemo-mobl1>
References: <154504875359.30235.6237926369392564851.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154504875359.30235.6237926369392564851.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:13:51PM +0300, Kirill Tkhai wrote:
> This function is identical to __page_set_anon_rmap()
> since the time, when it was introduced (8 years ago).
> The patch removes the function, and makes its users
> to use __page_set_anon_rmap() instead.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
