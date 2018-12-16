Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03317C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686A2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JnGqsrGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeLPPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:41:16 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:25318 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbeLPPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:41:15 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wBGFetn4000474;
        Mon, 17 Dec 2018 00:40:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wBGFetn4000474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544974856;
        bh=e5LOmv8ANEcHGRNPlFmzRj5aVztB+2qngNsL6xNft5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JnGqsrGzBlYhuEN4RuL0GqmuFuqw4q+9Rs9lL3cEbpbUHHZ1CD1NBFzXaQBiDwHuU
         fdXYglbFyBHc1zWJUv6Bmqc8P5ZqqlFt4R1zBidQ5e9fsqgwXh71ZlRZ54BV5BRyj8
         wwpK9o4Y8iFEoVonghXaqwXj2vGM6ObOeW8DVVeX5i+YqwiK8kKuOim5rJSP8t/YUB
         md3zyAlBnTWKPkbUCJnArRyjOQ9bKNk/4wGMLo/2ifedOoPZyhPWT5n1vmsGYYbZCY
         7oH7i3EvJzOo9pNl4acJcVM+Fs9u57BJ//HxWqNgV72MxVIhmE5MQMBmpm/banSPSQ
         4Tv/nP9JJgOaA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id e16so3604442uam.12;
        Sun, 16 Dec 2018 07:40:55 -0800 (PST)
X-Gm-Message-State: AA+aEWZBYjdX8mNeuxBarm5auDfOkJPOEbikZHa/yI7p2cg8AMuTmX53
        nb2Yc52IsVPST8BzE7N/p+QZsmyqYKo7vz51IE0=
X-Google-Smtp-Source: AFSGD/VCp6dOGT9H6e27wx2Vwcrsd6f/Gw3OBuZ2bveRkE419N4cOZCQlkwnxp1itkxvCHWnh8q9Sa1BR5B8KRs2d/k=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr4805183uad.55.1544974854757;
 Sun, 16 Dec 2018 07:40:54 -0800 (PST)
MIME-Version: 1.0
References: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Dec 2018 00:40:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3o5+6-SgZqrUCKPVxWwtJ9t-vB+C1RzjY9AuX8p7uTg@mail.gmail.com>
Message-ID: <CAK7LNAQ3o5+6-SgZqrUCKPVxWwtJ9t-vB+C1RzjY9AuX8p7uTg@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove redundant quiet_modtag for $(obj-m)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> All objects in $(obj-m) are included in $(real-obj-m) as well.
>
> It is true composite objects are only contained in $(obj-m),
> but [M] is hard-coded in quiet_cmd_link_multi-m.
>
> This line is redundant.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
