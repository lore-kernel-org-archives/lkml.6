Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55795C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C420651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lBPe1Tta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6C420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJZXV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:21:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33245 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJZXV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:21:58 -0400
Received: by mail-it1-f194.google.com with SMTP id h6-v6so4756569ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nU9XAe4qGufzQa7BZbbzlwXxqj9tX1VPBZ30pvhIi18=;
        b=lBPe1TtaKUWZetkEb7sB5iu6KLPt1USO/nPRirIXZ5L8YUpeowN2I6NWXoMSTSEJHg
         5VS9pypVIKCBAehBXJyiLxA0ZOa6/owqhEGtfn25znmgj/r6v9B49OvE9bx+dDelKSAY
         GSkcPq1LnHDKV3ESyeLNyMA4Gucda74NekRBtINbWpnOm8XZEeeq2DgYMHa44Tuk/HJN
         H0PGcAJ+UNQ7Q3TyQ+7t4MuYzFONQgxRDx9nwToJG7dktNUjbXq5VYUCLWV9A3uxOWrW
         Qw8POWqg2N9kZww0W8y8thWmhw2sk8sZ8bNNT077pYRBa+Th6e1aZc7Z7snT5D/oOysR
         /FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nU9XAe4qGufzQa7BZbbzlwXxqj9tX1VPBZ30pvhIi18=;
        b=RgTfgnQ9QEkqYTr2uVWvryjddFNvizea14G6KXJmGUoUCOWs29hj+UjEOzVEWQCMc8
         xwuoFBLqljY4Gg/VqWyZ5MioA5T5tRL5jsFUl+2QMvTQW1iF+Ol1lPU7gWrZNt1zJWOb
         ttv1kp63Vl0NRuFWadtJ3wm7xuZIYJYJJuawl2nGbw16MVdH12UIH0Bi1sWZQcD162Eu
         uPDjqIdFogJbEFqtKdWiD+ousILmguwkztn0/DCW8NHUHP3UB3R9bU1SyBV7MZPAZ/Yk
         6XZaHE3NTcimLLh6+STdsTOmuElgmWr6awuPFFhTgj//R9Briu5R9fLil6FU/3FGHQ4e
         vbBg==
X-Gm-Message-State: AGRZ1gIDW7OE4nVxz4IIWuKuDiR+7wd541NTGqd0BCTDx8qNfhIAF0Nr
        n7Mc4If1a1bepUtd+C3+Fxy6aA==
X-Google-Smtp-Source: AJdET5cq9/mUWXF57D/vNoruZSP3+zVfRaON2+bPYOE0Ul6tTvVlLsvGMk8TmUdJpLM0PiCZ2bs8bQ==
X-Received: by 2002:a24:5314:: with SMTP id n20-v6mr3798504itb.37.1540565078086;
        Fri, 26 Oct 2018 07:44:38 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k133-v6sm2563155itb.16.2018.10.26.07.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:36 -0700 (PDT)
Subject: Re: [PATCH RESEND 1/2] fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w
 hint
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
 <cover.1540504380.git.evgsyr@gmail.com>
 <d3f2c6b14ebf020a07dff5e79410ac1c1fef6023.1540504380.git.evgsyr@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cdbbf807-4df6-58c9-7d9c-2aeb1727c157@kernel.dk>
Date:   Fri, 26 Oct 2018 08:44:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d3f2c6b14ebf020a07dff5e79410ac1c1fef6023.1540504380.git.evgsyr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 3:54 PM, Eugene Syromiatnikov wrote:
> According to commit message in the original commit v4.13-rc1~212^2~51,
> as well as userspace library[1] and man page update[2], R/W hint constants
> are intended to have RWH_* prefix. However, RWF_WRITE_LIFE_NOT_SET retained
> "RWF_*" prefix used in earlyy versions of the proposed patch set[3].
> Rename it and provide the old name as a synonym for the new one
> for backward compatibility.
> 
> [1] https://github.com/axboe/fio/commit/bd553af6c849
> [2] https://github.com/mkerrisk/man-pages/commit/580082a186fd
> [3] https://www.mail-archive.com/linux-block@vger.kernel.org/msg09638.html

Looks good, thanks for catching this. One note:

> Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>

Why do you have two separate sign-offs?

-- 
Jens Axboe

