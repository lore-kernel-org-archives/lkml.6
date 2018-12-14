Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE004C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA7B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfzKGyCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeLNQ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:28:29 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41422 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbeLNQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:28:28 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so2506733ywc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPTovOa0/xKrjIcfaQ8pBrHGQV9oeq0Dh2k/kepRpuk=;
        b=BfzKGyCPEn3S9vx4TA/G7Gq+nNp6JrEFqoGvZhZoEnAm/+YLo238eGNvQQxWyapY3c
         B/qRvRXxUoCYejWVBH9QWp5F651YZud+G2SNGJtf8hoxkp7UNSRb/FxC/1z8vplw0B0K
         5IhGWoN+iDjACxlh5HertycMVxS9I2yquGLIHq/u6b+Me61dZod6hbXY3MSzebAgNUp7
         vWUpzX49UQ6Rsutf8Zcv6YNDbp+U4siPJs8+vzVlKHCq0T231F78R3dxS24jVBUQvh8l
         0zMARbhnE+RpP1IY/FwenNvvp/YGzXTQX+KB61ck+wxUKlF6rHdOzBnF7/0oQ2TMaSoU
         s7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPTovOa0/xKrjIcfaQ8pBrHGQV9oeq0Dh2k/kepRpuk=;
        b=M1Yzec9GkmB1z6XMxwkIqQsiSLlFUVLTvAWNWKEJn4HBo0y46Pwu/JBYb7Zs+f5Ssv
         kT+t5KcCpFoJ5wFHG+odYogGx9K6aEY88RWimDmSfOuyuK6CuUWBFnEEtH/q+StBxDZN
         K9VZGgWhE3mvoe5B0I/OFNMupLFyaKdwKLw7LR18WmohFCXcbbuNSJHGdQ1fhCwIhJoN
         AqLD6JBs1woCK0GwFgZ9o20cU/tMvmvDpQv2KOOeDRrXZ48kKWfOrNXuh1sR19syfhp+
         N858773bnLlxjH8XErksFxOIMjPGo2fzM6P3b298JbSJMa1NERnJJr7Dyl4lNkIs67S5
         y7/A==
X-Gm-Message-State: AA+aEWaWUMxzKVdYyJFOLbqNB4HuhuW7H57rVFNkrhf0OwBJBQ2Ivf2k
        nq0xL2bRIIRJxQDjVsiteopq6iV3/zxzZKwvYO0wi9iYZau94A==
X-Google-Smtp-Source: AFSGD/UYGjzTZdcm72ohC6JrOpwjNsuuyqUtnI3e6nNGUKQcYE+p6wzw0aFVurw4WR5GTN0d+Nn4XLZSwxMy6iJLpA4=
X-Received: by 2002:a81:6246:: with SMTP id w67mr3781204ywb.60.1544804907496;
 Fri, 14 Dec 2018 08:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20181214115729.658859279@linuxfoundation.org> <20181214115730.135586551@linuxfoundation.org>
 <20181214155226.GJ41383@MacBook-Pro-19.local> <20181214155435.GK41383@MacBook-Pro-19.local>
In-Reply-To: <20181214155435.GK41383@MacBook-Pro-19.local>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Dec 2018 08:28:13 -0800
Message-ID: <CANn89i++i+4XayxaKDF8Auak3h+N2ppUguLhW6_0sz0GNXvNQg@mail.gmail.com>
Subject: Re: [PATCH 4.14 09/89] net: Prevent invalid access to skb->prev in __qdisc_drop_all
To:     Christoph Paasch <cpaasch@apple.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        bhole_prashant_q7@lab.ntt.co.jp,
        Tyler Hicks <tyhicks@canonical.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 7:54 AM Christoph Paasch <cpaasch@apple.com> wrote:

> To clarify: Backport to v4.19.x is needed. The backport to v4.14 and older
> should not be needed.

Sure, but this does not cause any harm.

No further action needed :)
