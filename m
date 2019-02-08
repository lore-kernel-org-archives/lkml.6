Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF18BC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FCA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8nJ64Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBHQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:21:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36081 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfBHQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:21:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so6757142otk.3;
        Fri, 08 Feb 2019 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJih/aqmx9MgDhFAv4mEd0Lpp8a8n6K7Ehg4K+XvQ5U=;
        b=Z8nJ64Md7tJTNinKsB/iQ2/Ku6zEoeXrATItskdDNe3XqsQkSlwqolMzjvfaRa4tge
         UY5lKsZe/hDgGjQx9MwWciOciuGRRkfDNYtelBKr6NbrL5Su1XaoZ1JeewfX2escypW+
         Km7ctmRJhS3QY1lUhdV2T4Cz20dk+eLMJ1914ma3mM0LKALH3hguz9ibGwjduULEMbrV
         mWyxu+93ETvvOb5w+z0J05tBjwuP00lbrYUrE3eLNlUtBfP82yMV0hmqX2EMBOF6Uk1h
         Q1syvPk+fDz0duv4Pi/pIPR9fTtqFPF1aYCNBQN2Xfkm/ZOe3D37U1AZxdRrTR8zP8GQ
         BvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJih/aqmx9MgDhFAv4mEd0Lpp8a8n6K7Ehg4K+XvQ5U=;
        b=MV7vHfmU3oXOvXSTiOB+4mRGV6k36CGzuFsvZJ/UJ/KhQ2abdjVv2z6FYY4890CSdU
         +Fvus+ylp4APiZBuDEdY9qUxbsKJYSklk23jeuIvOlYyuHJhPB5sTYCjaBeA/RqhJ65D
         6stGCnDf2WoZWUedZh74nVq9GmvvedX2ResssPVQdJjphUPIAVD9BoPDGL33HSPwYHlD
         JasZsEJo6n+rucr3YPa5QjdQOOlBiNbzZNLs4iAlFBPCeseTT+ZJQDu5Q5Ihne9IrvAp
         RPVISBycfnPnFgg5CbgA1eAaPfYDtjA0RJJDUcsqQAR7LlxElavTMedznvdCfDVkvUgu
         21/Q==
X-Gm-Message-State: AHQUAuZjDvQa1dUsyZp+bZGSU6aluQcJGogBNNor5FwbWQscbWhiQO6X
        9Ey47ZOzdaHTIDZruhazYQaNIjwmpnwXi42wPjZafA==
X-Google-Smtp-Source: AHgI3IbjSgo7HzVxg2Zlkvd7gi+Nmn0GUUi/V+cnO6DdMq8dyQw4fI0RG2Wr6yguoujyGGS1JtBjLRxgcVxgTYuM2cM=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr13060008otk.279.1549642910353;
 Fri, 08 Feb 2019 08:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20190207222740.GA38612@dtor-ws> <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
 <20190208073102.GA31622@dtor-ws> <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
In-Reply-To: <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Feb 2019 11:21:39 -0500
Message-ID: <CAGngYiU=7k_5cP+UJBFePC=ZmN+YT57PEbZiDv58synviQXX0A@mail.gmail.com>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 10:51 AM Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
>
> I agree with Dmitry
>

So do I, you guys are absolutely right.
As far as I can see, this patch fixes the user-after-free.
So, after Dmitry changes flush_work() to flush_delayed_work() :

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
