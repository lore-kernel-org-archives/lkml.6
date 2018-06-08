Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o2nKA6TdGVu+EAAAmS7hNA
	; Fri, 08 Jun 2018 01:36:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4B336074D; Fri,  8 Jun 2018 01:36:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pZRaqhye"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 40199605A5;
	Fri,  8 Jun 2018 01:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40199605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeFHBgc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:36:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42217 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeFHBga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:36:30 -0400
Received: by mail-io0-f193.google.com with SMTP id r24-v6so14083482ioh.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LPMdK0z3b+tS1na3nB6YdVX/8ynulUVDdyaDiFOMruo=;
        b=pZRaqhyeGcdiRU+Iy9WETCrCgtZOEFbfmA3zF9q6oWABj+79KWK2DnE8g5hNTLIOv2
         f2Ds0/Yev5NQZd7uR3dyC8yZdRtKuEhLzHP0OIDq8gj9dLZvlwUBWshWbS8xS0V4tbiA
         zEzidsnJonkNogs3bcVid7EJKvEaJhYDajd7LzeGPz9xS13qcC3RxCE1doi6uVRBq/8q
         Yd6sz0a1boxdrCaZxXnA1AiLUjnokG7p4pXBAvK/HZWZ9mp/9xMV8inDvfGRUuGNa8L6
         gjMHgA/YapFeTS90HRLW7pufrxFrdYt3mDeNONrL1X/HOqOis4ajwjzmIyBTdWoFiT20
         EXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LPMdK0z3b+tS1na3nB6YdVX/8ynulUVDdyaDiFOMruo=;
        b=mYrggkSio+O2ryCY/GN/xhrJIKvQzxH+ui5tVupubMFSOU6oY0eLPHUqXc35VjbrYZ
         HF1xjWuU6ulYVv/6fQ0Hjq1YBS4cCsIAdOZ8ol52plunp7pNDA8ln8XSg9g9OH6mzqmw
         z7H8bY7MsGfvjFSE9POgktvY7DCKSY4uVD2NXQ+DwuaATS9qsc69eViZxqSu+2/8CZ+7
         ItCnzKDfbe3zwX2WGP4+LEN3gcttra4o4Nhr2g3MHwHDu8UngmJhBSwRD0IyasuuwSXh
         T68xd+gDdEqyvf1ehZNZxWaqWn1l5ZDqAiQjAGQcP/fZJ1seasluTQcg4/SVSlGxADFj
         M55w==
X-Gm-Message-State: APt69E0gyVPly/ZMtcbaZ2O8WvQ4AoG206CMKAOMjx/+aIzWIYd22AgP
        e6r5gz6MLIiOsdaBoTy5uM4JCg==
X-Google-Smtp-Source: ADUXVKKTtAe5pJI5R8UZc0pRumKP7VD0i8rKMu/VEHtjgxlyFjDTr8bUfCuSjJHJYVkvk+YIP21UoA==
X-Received: by 2002:a6b:ef02:: with SMTP id k2-v6mr3543645ioh.136.1528421790188;
        Thu, 07 Jun 2018 18:36:30 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id t123-v6sm200709itb.20.2018.06.07.18.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 18:36:28 -0700 (PDT)
Subject: Re: [PATCH] md: Unify mddev destruction paths
To: Kent Overstreet <kent.overstreet@gmail.com>, shli@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <20180608005254.6692-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <82fb97f6-b41b-37cf-b4fd-51e20dc4b4d3@kernel.dk>
Date: Thu, 7 Jun 2018 19:36:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180608005254.6692-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 6:52 PM, Kent Overstreet wrote:
> Previously, mddev_put() had a couple different paths for freeing a
> mddev, due to the fact that the kobject wasn't initialized when the
> mddev was first allocated. If we move the kobject_init() to when it's
> first allocated and just use kobject_add() later, we can clean all this
> up.
> 
> This also removes a hack in mddev_put() to avoid freeing biosets under a
> spinlock, which involved copying biosets on the stack after the reset
> bioset_init() changes.

Looks good to me, much nicer than the previous hack.

-- 
Jens Axboe
