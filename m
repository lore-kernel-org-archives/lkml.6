Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A47C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3812083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="dBzq2M93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3812083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJRSUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:20:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36455 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeJRSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:20:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so33039434wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LLBRSKNjMCTZbAz3UaCdMbbhTGEJYSrCBKMwUgZ2TOg=;
        b=dBzq2M939w28jtwmhTNyTJ3AU0j+zdHGr4cLDuMEerMZH7lj6noxhTOcY6CtR30Tfv
         hjWSimTnBGQBbCBtVNOcFAvNPR3jRN6umqJHFRNZMVRxm95qo6Ib0dkerkvjsOsyf1zV
         tBDCJO6Ffcv9jcPHYnJS8XgTzk/czM5uCXbt89ariZOzl71mXRMTVTDCZdc10OWWVxCu
         j4oVvCq7rZ8PhagW+Zi7HwF/XuniHsvaOS9gOI71511DvmSC5BnQ8bsHLu3cdVAPfUF5
         /AF1h8P5s3jDniCKDTwN775g00uZy7oRRz+g/KE1dGfCdBBzGiyceilBW7n+CDAJo2S1
         uQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLBRSKNjMCTZbAz3UaCdMbbhTGEJYSrCBKMwUgZ2TOg=;
        b=FLAvRSsJM5ZKxY340DHqCq81EPa5nkg+S6YuR3VuVqccs1+mCkEkIHHZJi2aDHyHAN
         CujfZYuOljVGtzX5eWkHZh0jR1NbS9BOr6Jdt8FbQFTxf5SxTo9tpbkpdnfKvLChiK5o
         2jaWpEmNlj4erPKsLlXEXS6r88z55V3Lj8+nkWGr1N8S8iQU11KkPAjb5Lx7UCUCwpNE
         pXT2UEmN8+kcEJiXwMlZC5RqURrnuRGYLJkHtgCNflQzWnFrn+cOYFAHcYOrc2ykhnP9
         d10UA9aoNkcRsj7X+wqSrAYJTXmzO54IHfTPDqmjF3c2V0R0ELwEQm8brIRvp3bgUCex
         cGuA==
X-Gm-Message-State: ABuFfohhSob0ZrD68lAbHy9bNC8iZ872XCAwhIpgeJgGK9n3E0Zd/ZgE
        fKC+r/tiXj5pN/C/6/yfkVgjQA==
X-Google-Smtp-Source: ACcGV61dI4djYjxkZ2zvPJMsrjaHqQ5BvqMZlLBbU0OtVKf85/W6t2wBaHpXrxA8raKe1wXPtLr+6g==
X-Received: by 2002:adf:f208:: with SMTP id p8-v6mr25859175wro.313.1539857988422;
        Thu, 18 Oct 2018 03:19:48 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id v16-v6sm16640988wru.31.2018.10.18.03.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 03:19:47 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:19:45 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dushistov@mail.ru, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181018101945.GA4787@pathfinder>
References: <20181017100809.GA9070@pathfinder>
 <fc2004614b7e4a35a67eb93a007a60f8@AcuMS.aculab.com>
 <20181017233305.GC32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017233305.GC32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:33:05AM +0100, Al Viro wrote:
> They are.  BSD folks had (sanely, IMO) put the 'type' bits of st_mode
> into directory entry verbatim.  Again, "symbolic constant" != "can be
> expected to change"...  If, e.g., some port decides to change S_IFIFO,
> they'll have no end of fun accessing ext*, xfs, ufs, etc. since that
> value is stored in the on-disk inode and in effect pinned down by
> that.
> 
> All S_... constants are universal and going to remain unchanged on
> any Unices.

Dear Al,

Shall I resubmit without the compile-time checks in the latest patch then?

Regards,
Phil
