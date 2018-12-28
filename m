Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B13C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E2E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jcoCH8Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeL1WB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:01:59 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:38170 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeL1WB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:01:58 -0500
Received: by mail-pl1-f176.google.com with SMTP id e5so10490851plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+CLxjrFzg/MMvOE212jR8ZOodqO4zvllFPfDPf/Q9zI=;
        b=jcoCH8KcTQoFnurkAz0AO6/4SZVajXOD2db8/0U+9YP7OdapLOKpDcoqDWWihxLIMg
         VDIDp0GB86Xh8m9ceiMMxalCotHzDZAlTm9+vyOJZoLDXx0IGkL7yQ1OPYWs6MsvqGKt
         IkQ60niAROT8slQJ9BKcp/BNeabGpraBQGR3igbOcU3K3N2DXD/p9ogsV6gjSlXT/fPY
         24dev2J9pIMqytc9m7GSf29lh6UEiZXJyZc8fJe2c7s17VMPJ0VDNyE1rQPNnNmUW233
         5OM1Cxf41CRQqWkN/NGa1qqKfJQJYx580SHcU89BCNCEnmAwetN+jHsaLCtszO+0t8Gb
         xkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+CLxjrFzg/MMvOE212jR8ZOodqO4zvllFPfDPf/Q9zI=;
        b=hg2Z0K/iOKPPtk/DPy8hmYyBL/KCgTMAPyTAr873PsztQyAs1EAwVgzC4zWqJe0jxH
         s3rwZZ/Ra83HtNAqTeATyxmKccQV70f7HqwRqf+4WbV+WikljNWI6+cKFi67drMrFuG2
         RclEq/xFc6DzOY169czK2fyqs1ZZ99LvZwjbjUpHUICZB5ca591FA7BVWVtNIqIVEq3J
         UQlAnVvEaOhSpGKAKH1VcN+V0ZRyagCzDSh/StNKBsXH9Yk1+EHmaKIVSXUqlyNBWwSo
         mcf3e04aaWCMYTpvqdxf/H5LLNrWysc+xRauqNyrMfzBx/THyONGg6zqB2AJaGgd5GGl
         Bd1w==
X-Gm-Message-State: AJcUukcnfh9g8vjh2cKdV0MTUG1i4mnx9Agb/7lXICZBjSet89UCVoH+
        79/UCGuZC75Ym/X0GrFQbGCG5JsCqk0=
X-Google-Smtp-Source: ALg8bN41YURwAkgoe4zUoTOVyxONodSdyNKYkZXBZDtH229W1S59g8Dypq6Ept62Y1kKZFWMpz1jxg==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr29416785plb.244.1546034517076;
        Fri, 28 Dec 2018 14:01:57 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id e23sm61891835pfh.68.2018.12.28.14.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:01:55 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 93B073000D9; Sat, 29 Dec 2018 01:01:52 +0300 (+03)
Date:   Sat, 29 Dec 2018 01:01:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, darrick.wong@oracle.com,
        hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
        josef@toxicpanda.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: KASAN: use-after-free Read in filemap_fault
Message-ID: <20181228220152.wkeslziuovnunvwk@kshutemo-mobl1>
References: <000000000000b57d19057e1b383d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b57d19057e1b383d@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:51:04PM -0800, syzbot wrote:
> Allocated by task 8196:

...

> Freed by task 8197:

Hm. VMA allocated by one process (I don't see threads in the test case)
gets freed by another one. Looks fishy to me.

-- 
 Kirill A. Shutemov
