Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6468C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718D92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODvRaonM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718D92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937095AbeFSBxG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:53:06 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46218 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936834AbeFSBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:53:05 -0400
Received: by mail-ua0-f196.google.com with SMTP id d7-v6so11984231uam.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WxY/cwNcW1PS8XxmyQrYB6nSFA1vc5hdAsk4jNzwlbY=;
        b=ODvRaonMVeflgmHT88QQ3ianTpafML54g2mY2aC3vGnJUDQPcy7+F5jmADF5QxVwI2
         7VdFwH+pA5s9LcTlIJ7ux70w5oZ0PPW4K5MU/6DzCPjKGVGCVamzD/a1iEAxj92S1nBr
         Fp8O2QQjSL/DFb3srfmsMLg/cTFgtfaPxhwjO8cFDLOsEJbqWYSgc+RdZF0qqDOB1SE/
         cZ6e7FTDJ5qiutx4K7tFplFNDD98Ce1ueczKQP/GNnOTyIy7K5OWXgad1SrRGvra1/cS
         OsYtW375X3yplj0Zh1Nao7UV2z1E67Vl3v105MD8zVxPTpG51Vd3VyywVacKL5+zf7i1
         7PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WxY/cwNcW1PS8XxmyQrYB6nSFA1vc5hdAsk4jNzwlbY=;
        b=ZYYleIzQX1toowza5fO5JvhgkSSr12TE63jqCfCKfE17dO+xdzp/r+6xtC8Qry1WA2
         H8lTuy9XRP/wDDMV89lrc4TjLXoaSUyXd6hFg4I3g5K3ROt/VWUOkywCOtijVGJ2sUAj
         BKkYKqw/RRSO5VnIU9XuD5QZEQnAOwFwx7SaiEpI9oV2Qu785gb9RwktrDouKMV80o55
         x7QP2JXDV3KHYS0BnEmVWAxHuqn3Cx1j6uFwsgmgil6Ib8SOLdwAtGF9m3tZWK9Pw27T
         tEgps13iUMgDQ7hV7N05G5cXUMQK1uPkoqD8xFxkUbqmKb+hPOhg/fEeiC13ka4XNrJt
         FS3A==
X-Gm-Message-State: APt69E0lIzjQn5ejwxV9WE7eHPxyWzTWJiD4NC8GIEX0StMxhayWieTw
        kQ+NezFPSFgg6XM5ZON6zaMRQdpT9WZtDEyl+xM=
X-Google-Smtp-Source: ADUXVKKsWsYEwKgmT93+djVUfY9GVdwQUsAGIb6uMD1Ojymb14v/7Y68Uxv/2Yq82CexQs7DS7/Q0qz1+1UKrz0u7UM=
X-Received: by 2002:a9f:29c2:: with SMTP id s60-v6mr9666696uas.126.1529373184405;
 Mon, 18 Jun 2018 18:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:549e:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 18:53:03
 -0700 (PDT)
In-Reply-To: <20180618095653.1538471-1-arnd@arndb.de>
References: <20180618095653.1538471-1-arnd@arndb.de>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Tue, 19 Jun 2018 11:53:03 +1000
Message-ID: <CAKTCnzmTV6g8NhkUv1sj=iMQemOTZK7eN_59dqjbpFnrGdsk2A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: xmon: use ktime_get_coarse_boottime64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, y2038@lists.linaro.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 7:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
>
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good to me!

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
