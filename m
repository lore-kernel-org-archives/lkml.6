Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16225C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D3D20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiI+VGXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D3D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLAFqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:46:43 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46086 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:46:42 -0500
Received: by mail-yb1-f195.google.com with SMTP id x130-v6so2469636ybg.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGejEFpRiJZJg0cREEUYOHeUvPv00BzcjiIyJtnQwY4=;
        b=iiI+VGXBcqIPPkNnrPR6QSDfrca5KPLgv/MTOieTpS5SZqvBK9Y7DsL6YSnJ3fCLKE
         E08PiCFq2+NHvJjqQs5ehEAePWHB7dGyytnu0q25hD5E+kFhpV3EHpbx+3fPQ9lPhXVq
         lV/H9lmHkGGGM7ZTW7JdvmJNA3ehN3X/KvT8vTyutW+LNbNdMyKT74HpZYTdcXjN9FzZ
         C3V3PNiampDF5tGpPP/kT34jFQu1V+gFpqbLqscsqI5lRNdhttYrMHz2rzO2tZiLg9FX
         t+I8J/kD7E6KsIXEbZigAhDvyasHkEPL0C4Eyk2Eo/tFCFZr7wuehDj0KmE6jaeSw0yH
         FgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGejEFpRiJZJg0cREEUYOHeUvPv00BzcjiIyJtnQwY4=;
        b=MOhP77Ni7TXd61UaEFeKoifyBQBb5b9fso7rr/teNE3dw++svwqjfUGVtYWRnAf0si
         m7QVJi48UoYmoJxPEAOpXh5cFJ3MQOOfvc8EJGPjsKWyU5X/kpoc2E4Fv0wGeTGCz+yt
         ABRU0/F9e9aO8OtVCD3gP9n6uTEF63HmS/zOUhCKeyT7JD3rBjxvG3hseH20YrwbuQql
         1iZqfH+jEB5a7ufFaq3gSwgZ9dCHa9FWuNhTW0T9fLfNwF2o9XhSL8VL8DAO2huNLPj/
         xMb8CyDOugH2L7uHKBqewnXvbllryZwCvZuQwIf1Jb5LbJSK8kGD7QfQKeHB/qyKkhs5
         hF2w==
X-Gm-Message-State: AA+aEWYMIVT8+AlZuRhu7DEIYHf6rq9kCOwSffMlWGXunB+Jw3IoTMIP
        73sSW9iTEym7YLWEENo4xluN+xAZ
X-Google-Smtp-Source: AFSGD/U+/6sAyReFa0QRhIUZCM48JgNFL+C7ozbNR45I0n3ftHe5c7un4RqZ5Sr3FQlVMTJN+5oD6w==
X-Received: by 2002:a25:548:: with SMTP id 69-v6mr6366613ybf.476.1543602990850;
        Fri, 30 Nov 2018 10:36:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:51cf])
        by smtp.gmail.com with ESMTPSA id f10sm4471939ywb.26.2018.11.30.10.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:36:29 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:36:27 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: remove some duplicated includes
Message-ID: <20181130183627.GG2509588@devbig004.ftw2.facebook.com>
References: <20181126143326.31300-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126143326.31300-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:33:26AM -0500, Yangtao Li wrote:
> workqueue.h and kthread.h are included twice.It's unnecessary.
> hence just remove them.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Can you route this through the trivial tree?

Thanks.

-- 
tejun
