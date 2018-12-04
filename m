Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6543C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920A52146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLern7E8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920A52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDGy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:54:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37965 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLDGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:54:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so12966880ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCVw5D5JKQwcqynqXV6M4mR/vwbFVP76FkiLwGbnmyk=;
        b=DLern7E82sXQQ+3tY8VlFT+NyxT+q1U3KNhWKSskHXkqlnjB1eFBWJf06c2B4sxYzL
         2NkDDBAA8jWUPZor6jqsiQN4kDtPY+G4tHhh/j9dqSvz5E87Rq5WWHZ9lkhkAcUAoh9Y
         dqXiR6skDOuX8LXiQvc+ZjKmxfdUU660htastXuovwdVkgPa71QT0WuR3AN4FjQhwhmB
         1/v8EXeFnSESRgaZaMTc5q5LyHFsL7R105FtgZ/pMLcJjcKeO0PHjwWTBGfbkcsPiBFb
         VMCM1cq/DpwRtpy72bfe8qwnlDrWMBeSzJNKfmzONx4hWfOk3kXfP6A2RSJvpDPiZyQY
         fgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCVw5D5JKQwcqynqXV6M4mR/vwbFVP76FkiLwGbnmyk=;
        b=ol8tAkmNBrVw2LaLZ/dMKTOO5oqlOmrWptZv7EdFdQox7nwuqeTFzCbhiz/ackYWMu
         nBE39exoOgLWWzZvxmQ/fEosbXMDXnXPcTOiPehakF0RCzrQXcE5Kd8T0Fsn3TYOUYzI
         wsyiPDN5+NokvFhxcmLiMrnYMVVHP3SBBbbPZfhEoAIf5xKbku8dcUNm94HUVKQqBlce
         9WguuwseUwJmPq3rMYbcIqSOlJwh/zSAYpIrKErXnB0zMOi4u7qX0xBDZ+7Iu+rZucty
         lO6N9UhUd+uTUuJusXRz95KTDlHQZ96zB/y9PcPwhRXXAXCLXcvhGUj5gZv3m2d6uw2V
         B4Tw==
X-Gm-Message-State: AA+aEWadKGeaCs6mGcBAev8UZcFdXduTl9NEBvZUNN5C2n/MAnaF5CQu
        js8wCKQK2dQ4KRnsZvvXGq8=
X-Google-Smtp-Source: AFSGD/UCjyTzod88DfphnUryNaMCijJ1rOPG2piwjYLGAmdItuP3MIREw+b7rrcMAxeHuiLz9VjXMg==
X-Received: by 2002:a50:c089:: with SMTP id k9mr16226073edf.89.1543906495209;
        Mon, 03 Dec 2018 22:54:55 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l17sm4467216edc.56.2018.12.03.22.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 22:54:54 -0800 (PST)
Date:   Tue, 4 Dec 2018 06:54:53 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181204065453.4rsyhtsk2aej4vim@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
>During my test on some AMD machine, with kexec -l nr_cpus=x option, the
>kernel failed to bootup, because some node's data struct can not be allocated,
>e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
>device->numa_node info is used as preferred_nid param for

could we fix the preferred_nid before passed to
__alloc_pages_nodemask()?

BTW, I don't catch the function call flow to this point. Would you mind
giving me some hint?

-- 
Wei Yang
Help you, Help me
