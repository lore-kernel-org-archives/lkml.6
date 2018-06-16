Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41341C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E1520874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5EmhILT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E1520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbeFPIVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:21:34 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36700 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeFPIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:21:32 -0400
Received: by mail-wr0-f173.google.com with SMTP id f16-v6so11993349wrm.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bz73NhUINlXZu40b88LzPw1ccT8UgG4bhfFRy5iC9Ps=;
        b=D5EmhILTkU1H1aTUp9E1AsUefZJxoDSqJi3kvlXBWYCf6FIpCoUdqBBInN3++0owTW
         d3hnPjZLq/vzM+SdrYnzqsF9U63gKUE9/Jcp3XgoWKBZGZvb+TW1w8KDzTez+zHo6pTx
         G0V9Wc69tTbGCwkmHyO4rjSwbVLP0tXsqAqoGPSdUQiuxkrP5k2sOlRWk/wr6IcYwV7i
         /Y5poJ1aY0yh1Bfvmj+PhTtaS4PmFEZRqLwU2rgMkes30hvi8Bj/wqDiIKo2ZHHLc/PK
         n6EBXIBvkDsQtEKx36OCNk0SQGMRjEkpCwZXFIGx9zrIlWYyaCtOqIfGxQjtD/EKJHSF
         17Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bz73NhUINlXZu40b88LzPw1ccT8UgG4bhfFRy5iC9Ps=;
        b=MaQO32SnfSKSojwOAks+kHUu/bf5+XDwM1LR2gbI8rKm3egUwv2BJ1L4uRmHEo42kS
         uJ92+6YWgfGSK1lWyg3yt0ek5A50RLRKtMsLxzNcS59YkuIcbqoIPtmzivLSC3AdrPCW
         iknAI4uaA0aSjv4rxGjDsnrRp6C8A5JtnVuG11jkT/35VDHhkW1OLr+LYSLAtkJpu8Gf
         2gGRZYXWUdJQiTSp7WbR1h39qc1RcFNYX/V1yuANM4jdJ+nSGNDhD5CDpsFdJfjTOrgL
         bqORvIrN3VoXfr9WZestJTmmaJJqnXM93UO65xYy9GPffrLOVdvm89bmFTvM1UJ/xmx5
         8udA==
X-Gm-Message-State: APt69E1uznoZBValTkcuF6Tv47MonTYQZm6/2u+6A78N/psggQ24LjiA
        jzMthbgQafYogcwy6lFRiZZhqYH1XPwtL2L0xgg=
X-Google-Smtp-Source: ADUXVKKxZhyICYgDCeuh4GpSQCvssC4v6zpqKGRk/LHLpXsGl0xc1+V6zk2DnoE9S5/HNZDbXnuoQYJAwh9XQ24MPyE=
X-Received: by 2002:adf:dc8b:: with SMTP id r11-v6mr4097634wrj.166.1529137291392;
 Sat, 16 Jun 2018 01:21:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8271:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 01:21:30
 -0700 (PDT)
In-Reply-To: <CD71A13FD89021478C0F0D323D55243A015AF10A@MX202CL04.corp.emc.com>
References: <CD71A13FD89021478C0F0D323D55243A015AF10A@MX202CL04.corp.emc.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 16 Jun 2018 10:21:30 +0200
Message-ID: <CAFLxGvz1Hdc5j9a706_ZUQywC0k7S2Lng5zAL=T8UsXP9MYRzA@mail.gmail.com>
Subject: Re: Recall: PROBLEM: JFFS2 Empty summary info causes OOPS
To:     "Veluthakkal, Sreeram" <Sreeram.Veluthakkal@emc.com>
Cc:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somarouthu, Murali" <Murali.Somarouthu@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:13 PM, Veluthakkal, Sreeram
<Sreeram.Veluthakkal@emc.com> wrote:
> Veluthakkal, Sreeram would like to recall the message, "PROBLEM: JFFS2 Empty summary info causes OOPS".

-ENOMSEXCHANGE

-- 
Thanks,
//richard
