Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C3BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F0206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rap/cz7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334F0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeGQSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:14:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbeGQSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:14:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so1898038edr.11;
        Tue, 17 Jul 2018 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOpiopesXL+0vpI1kyJiP+PCMmDgHcQPhCS9oZd+Dq8=;
        b=rap/cz7Qb7Xxo2LzGcrhpaldkTB0YoFfAaCTHaPEfT5zlF7O3FUgYTwu6GcJJwIHdr
         DeHVKDKO2/MNi9LgcEk+OI4lpksMKEd1IGfF4TayzqR7HpY7n5bff/Hz5bZxo9+Uve3S
         WhaeIRUe/j0+GSNSXtKy7iFDwnH5kANZPUi5PUui9SXK/ur16HgKw6P7/MRuC8RYOyE2
         Z5hmOmLx6yMoXHkSuxqJwH748O/pr5QB+6m/aNens396i2QeRVEXc46uXRqcTlikE49G
         dKbyPHLvkgJveoU5o5q+O5TKMMesO8n7cgGvd6L3DxlaUbOO6goMDaFrG3x+JJkNZji0
         2Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOpiopesXL+0vpI1kyJiP+PCMmDgHcQPhCS9oZd+Dq8=;
        b=GH5wd5tqEY5T9+9NsDCkzwQAkoAXgXcMvlEJ1sTn7HMl75falHY3cPHUfsVv5vLkJ7
         eiemvZwkvi+6P9VoWrGdZrCVq9Rh6fTphDdHz8Fh+eh7rndxT3t0eIX0gDMfVlVxyQYt
         i050gFyj53SyvzjYWZUZuqojQFc3IiS/kuptrYGBXSxf6i6YOzp98qYOA9OnIbSaw2am
         q/eVeSnHl+UEE5Q7e92tYhxvWYIXQMScUAmLtfvAW9u3nGjDHMtgFNtrzpPRMiX/vmgO
         FJRJyzDjcmODq8Du8kkHyrBrMDmA5t5Xhjakc46gNT7Etb30lXPj6xjQ5ZHIVHFUFeOH
         KvvA==
X-Gm-Message-State: AOUpUlGVW2OgA55JWvBDvr6qKSxvlLFYBTkJBHGqZQL0G6qGh3WDXMWH
        TYyUUZfHCB7y3CZVhslj2b3G9GZqiywBQaSe73dvv4h0
X-Google-Smtp-Source: AAOMgpcFrJKBZ65sskvAi97WPj8WGUdOQKAK0aMxjhwLYkKbFf9cf9vwudl7bemSJeiuFYSIL8pda2kEnxCctlSUhoI=
X-Received: by 2002:a50:be05:: with SMTP id a5-v6mr3676802edi.258.1531849221445;
 Tue, 17 Jul 2018 10:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180717120651.15748-1-dsahern@kernel.org>
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 17 Jul 2018 10:40:09 -0700
Message-ID: <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
To:     dsahern@kernel.org
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:11 AM <dsahern@kernel.org> wrote:
>
> From: David Ahern <dsahern@gmail.com>
>
> Nikita Leshenko reported that neighbor entries in one namespace can
> evict neighbor entries in another. The problem is that the neighbor
> tables have entries across all namespaces without separate accounting
> and with global limits on when to scan for entries to evict.

It is nothing new, people including me already noticed this before.


>
> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
> namespace and making the accounting and threshold limits per namespace.


The last discussion about this a long time ago concluded that neigh
table entries are controllable by remote, so after moving it to per netns,
it would be easier to DOS the host.
