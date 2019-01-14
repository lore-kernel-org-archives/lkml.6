Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1005FC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50922087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mmApTXsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfANNuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:50:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfANNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:50:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so9488194pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KlHa+LpFHUiMKQScXoBgvTQj9wpZXHPiZDLKA4rMB4E=;
        b=mmApTXsznp+lJR+QHVLxoSeraYzhdSWrd5jQAAYprSSRRxUkD1YvleaR8k2jp4DBsb
         WzyAch8e/K6xtSSg/nNYUdi+Ap1kDQkqpX2h45BSy+QsPW8oVpbf5+TdjL2ACUo6R6dv
         WaI56ek386bP+8ZyR0cAmLMmCoDetulKWfLC7+PxNIfTfSDQQQxGU6Fqq8fyZCD3Ga9J
         ojjjAVQ4KvvEc8ElPY+2k4/eIhptLOK4MYYqF2T4OznoejdUzdgZ+CZY+Skg9xbyzPm5
         mFhuMdTmljckHotLtE2ejP1JUlGsxUvgXb5VyWYxhvkWddUQwubsfT0c0G+W//knJeq4
         /znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KlHa+LpFHUiMKQScXoBgvTQj9wpZXHPiZDLKA4rMB4E=;
        b=mkgJXGslgRW8SC5EC/rleqKe/KUlWsYetA2sCo7hKRAIENCsmwOLWrkRrcZtLiLY3s
         S7wk0Npk3W5Rx+PNOKpjVMfgfo9OXUqQdkNdk460Koh59gGkpqzDNp891WyS2M37M8IB
         cIAwgWFvJHpnbt172/SrFBe8+e1OudJ0s78ifJJE4GLE2XC/hLqL0KJR6dBSJX2WItuo
         Vu2LyEVlY5OjtyDun47A/lQoIV9LAIBaoCAi7Ni37SshpCOJ6aSpIgxixzK2nrdZx5EC
         NJtsudVmQtUeQHzhAfOflyzpeMyt5RCCnGM5so6m7fuPVCwBXVhB83VMyNH5PSmKroKv
         gzzw==
X-Gm-Message-State: AJcUukck9fyiODJ5fTsFwjGHqHXfru9XxW9qQ93vl1kdlWP3E2YnIzKT
        rmYBXrc1w4zF526ZfZfmwGDA4BkSPV6BYQ==
X-Google-Smtp-Source: ALg8bN6QqVP7dU9V9xu2W/78DiFhYPyHe+bRosf1b9BGHYHzL4drjYOU6/RAAvy3dzYTnp3Wv7hSLQ==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr12955696pgk.386.1547473807720;
        Mon, 14 Jan 2019 05:50:07 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id n21sm956483pfg.84.2019.01.14.05.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:50:06 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4C71D300044; Mon, 14 Jan 2019 16:50:02 +0300 (+03)
Date:   Mon, 14 Jan 2019 16:50:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Message-ID: <20190114135001.w2wpql53zitellus@kshutemo-mobl1>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:28:37PM -0800, Mike Kravetz wrote:
> Ok, I just wanted to ask the question.  I've seen application code doing
> the 'mmap sufficiently large area' then unmap to get desired alignment
> trick.  Was wondering if there was something we could do to help.

Application may want to get aligned allocation for different reasons.
It should be okay for userspace to ask for size + (alignment - PAGE_SIZE)
and then round up the address to get the alignment. We basically do the
same on kernel side.

For THP, I believe, kernel already does The Right Thing™ for most users.
User still may want to get speific range as THP (to avoid false sharing or
something). But still I believe userspace has all required tools to get it
right.

-- 
 Kirill A. Shutemov
