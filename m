Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D322ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3341220685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Z+M5lKim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3341220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJaSqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:46:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43045 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeJaSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:46:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so3010918plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMcfQj3xu7SzJYqwIC9m31n4fvakOQVoNjyilo/BVOA=;
        b=Z+M5lKimifsG8dwdL75BqL5h8XZYG/OF6C7XeE9wJAKrDJmY+ZEkzWeCCARIGqTo86
         nqvNhWQpk2fb5g1XIPtQb9MAMleb5geXr6etQEM01SKAak8GcyIFV1ODBXEZlCEVHECm
         EBdvva3AYDi+xDMVyvN7fTwNHOCkysFnAw8CB/oyTzzoSLKzITcYT6nbToeLF9yhkfov
         KD6urpUSklwXCXqOwozSxybTCpKSQHtyDNr5bAKLarfribXndq9zdWtrtLrQ4GgsuC9f
         gg3qjZc32iHxuiFphIFHpgOXqwcuH3Em2yu7DgMNcOdwREC6XTGc/YsVhUKH9R+9n4+m
         nfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMcfQj3xu7SzJYqwIC9m31n4fvakOQVoNjyilo/BVOA=;
        b=WQi1pIAJ3MBaGiS85GHk0IIpglzshhYXUinuEFDRWwRTzBzc/K4C0TvWk7Hs1tDAX+
         tRB+wlSfYbumE6jP295kHiXjVBTX9YYN465ON2sJl6t6FbIAIKgjUeRXCktjKVuxJvwj
         enm6azUSxJTidtIS0L4zI5POlw/SMtNYiK5Jj6EuqKlvg0ozMk9qK4Go2Qe3kxJA0oBx
         EnDDyr+yNq8c8RnTO+3jL+UqqH19VqHDclK+nw+dteBLgAHrvj/icmHg+V/MNVplJHnP
         3xBLMT0NJUGosR63+SA1y7aaLYmMc8EdMErTx9I9BYjKmfxV25D+RupFnUErTk+JlVhP
         VJYw==
X-Gm-Message-State: AGRZ1gJvwnCw6KnaIYmia/gd+LiNeu4DqOSmEquu4zLUyMb9/BSVLSqN
        uXt6sovcIRVm+89EWSssyj8W2A==
X-Google-Smtp-Source: AJdET5fn97qu6A8xO3jdaVfXnblLQNF/EUFd/ynj5bCOJts02NkQgS/0uy0cRQCWC4I435c22g35Dg==
X-Received: by 2002:a17:902:7786:: with SMTP id o6-v6mr2561607pll.95.1540979327437;
        Wed, 31 Oct 2018 02:48:47 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id k132-v6sm34882783pga.28.2018.10.31.02.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:48:46 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E836F301604; Wed, 31 Oct 2018 12:48:41 +0300 (+03)
Date:   Wed, 31 Oct 2018 12:48:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm: introduce mm_[p4d|pud|pmd]_folded
Message-ID: <20181031094841.cawzzoddkemmufwl@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-2-git-send-email-schwidefsky@de.ibm.com>
 <20181031090255.bvmp3jnsdaunhzn7@kshutemo-mobl1>
 <20181031103536.0cab673d@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031103536.0cab673d@mschwideX1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:35:36AM +0100, Martin Schwidefsky wrote:
> > Maybe
> > 	return __is_defined(__PAGETABLE_P4D_FOLDED);
> > 
> > ?
>  
> I have tried that, doesn't work. The reason is that the
> __PAGETABLE_xxx_FOLDED defines to not have a value.
> 
> #define __PAGETABLE_P4D_FOLDED
> #define __PAGETABLE_PMD_FOLDED
> #define __PAGETABLE_PUD_FOLDED
> 
> While the definition of CONFIG_xxx symbols looks like this
> 
> #define CONFIG_xxx 1
> 
> The __is_defined needs the value for the __take_second_arg trick.

I guess this is easily fixable :)

-- 
 Kirill A. Shutemov
