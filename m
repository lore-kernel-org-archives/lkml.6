Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7510DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369E82145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PTW5HKGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeL2TYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:24:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43311 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeL2TYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:24:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so21129002lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2s0jvY7V1c2xkkOGGUxGrsCBJJpkkgmr0GmxT5GXqiA=;
        b=PTW5HKGwKEtLgaK0c6lNxT16mStDszF0dZ5qmTC3mp+aNRPFhpwef93ScBYj/IeBry
         3JrHzr68wXlznBPr6Uf7tvjx6JJLE6+SKhm42noMQ4feDKA7A1Lj7oUrYBxcusIEuj/g
         I/gYVJXj56ght1gexi+W1W2tMowmlPfCDlKec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2s0jvY7V1c2xkkOGGUxGrsCBJJpkkgmr0GmxT5GXqiA=;
        b=n4oHRPW0rT9Jj+gt2emZv4LoJd1JmXIimgcz3maQ9rLfDaMeWbGdTY+tDYdjWeOyg2
         nZmhDFsZVjj5w/KtEUXkjSMSsl3pPk0CDXqXRULw9ciRgCK9u+i5H5yVBMnsdMwz+kRH
         +JRlK7Czi2HaPq9hV4TjkpDRD1NHJrjKP/Z1AvZBBU2zoMhmh10AKbhZZy97+3mE6okR
         EEzI/Re52ChD/Qv7+DONzv5jUxVIy33e1Dir8Ei5+CO2iXWkSTR5b5Wsrv4hU6LrxAcw
         q3W9JI+anOL+Iz7yh3P7gacf6LRhOWpTRJxfGUqXJF8Rh/qAOeaKoJovKVfIk0vJloD6
         wZgQ==
X-Gm-Message-State: AJcUukfcloo01LvyhAkDiuSr0WpuWbmR7djqwVJlAJxrtUZdkL0tsXhw
        NpXOl22U9ZBwGUjMCyGOsEnnHKWF3aY=
X-Google-Smtp-Source: ALg8bN51N2bkFBOHmX6mztGCcCNfuNXj+DO9Q2e8IOV6N3cdl7NltUW3tqFgznewzXQ3wVUIEXTO4g==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr20179075lji.14.1546111492299;
        Sat, 29 Dec 2018 11:24:52 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x204sm8523056lfa.5.2018.12.29.11.24.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 11:24:51 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id k15-v6so21135244ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 11:24:50 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr13061961ljj.120.1546111490627;
 Sat, 29 Dec 2018 11:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20181228090622.4c210228@lwn.net>
In-Reply-To: <20181228090622.4c210228@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Dec 2018 11:24:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8=xoaS=QJXRMo70Si0E5xvJmdyA2-cu99_MA_FjhHTA@mail.gmail.com>
Message-ID: <CAHk-=wj8=xoaS=QJXRMo70Si0E5xvJmdyA2-cu99_MA_FjhHTA@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation for 5.0
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 8:06 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
>   git://git.lwn.net/linux.git tags/docs-5.0

New signing key? And one that you forgot to push out to keyservers?

                Linus
