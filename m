Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0FCECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539BB20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ncSeA4qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539BB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeJaWVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:21:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41546 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJaWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:21:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id p16-v6so1146198plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RdCknJewG/nMaTkTUERqrhhLawoZbTvQKgmfyLEih2E=;
        b=ncSeA4qze2DVcrW/dvK8Cv1mq48nmu9momidgmJmuzhGiOWwKQjkbVRAYQYQBvRLkC
         Ht01UvwEgzNokhdgz6lvVVQZnXfdhXwaRha7UmWCFlpJfZMSGMR0NkdVMINjjbd2Gcvq
         A9xmjaIOssF4Nj+TlMuTj1F0Nd/60T6Kp8/HkF4A/HZ8plp+5CPA5yWrP/hs9r0wKAx8
         4NvMQ4SJ0ws6pg5x9l8CWA/qpG4pvvWznxq3iuRRqTZfvNcS3n69ivH8PcE1sWMaYd0a
         lIG065HJ+S80JmYraDDkM+eh6B0+IL6vcjnDtvz7G8mflT7muc44T7tsLSPToqmjC1uc
         Gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdCknJewG/nMaTkTUERqrhhLawoZbTvQKgmfyLEih2E=;
        b=OVeJZXbAR+Jf+uKbLFxJWYPqCIL5ivTbNM9jY0BbjTmv7JRkM55nTHC74m9r3DBvhp
         mYs2zHVKbDaxX0eSPvSp6qPeJ4yzi3hm1jlhltus9xTo3llFDMUEIg9g1mfV2WAOI8aC
         AlQ+O9R71Ial4sLS1uxHAeYBHcjTBtDrufd9WMbbL0hzq5YcnXzLk4BO5zgdfwp/9pJd
         JT3G5tjjG+T+mwGmMzqEmpHkFUDNKYeZM2e537v8Wnu5n3oSS79KkQ+mLBLKQz0qmmOu
         jZ28c+8MpsH/f4mPPMwHQ+prcZjPkBhk/LY/nr2m1v+nND+L040zqrkfaw4KH6rkqW23
         Bg+Q==
X-Gm-Message-State: AGRZ1gKP+xnCWIGeT+zzBwdp0Ek2FETOhGhQkmrWxBEiH1HrSFhQvLNT
        nRJSjT6B0UUfjJUB9paVfltcZg==
X-Google-Smtp-Source: AJdET5dOrO9XKTmUWwhkY+jj/NAeNq6Vn/So+ZjIAYGLv3vVsBguy211oI7c2mGIyd0VIQxlA+SeyA==
X-Received: by 2002:a17:902:a717:: with SMTP id w23-v6mr3426086plq.24.1540992228666;
        Wed, 31 Oct 2018 06:23:48 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id e22-v6sm28576041pfi.61.2018.10.31.06.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:23:47 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 36E2E301604; Wed, 31 Oct 2018 16:23:43 +0300 (+03)
Date:   Wed, 31 Oct 2018 16:23:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm: introduce mm_[p4d|pud|pmd]_folded
Message-ID: <20181031132343.h4r55euwrhkud6w2@kshutemo-mobl1>
References: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
 <1540990801-4261-3-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540990801-4261-3-git-send-email-schwidefsky@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:59:59PM +0100, Martin Schwidefsky wrote:
> Add three architecture overrideable functions to test if the
> p4d, pud, or pmd layer of a page table is folded or not.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
