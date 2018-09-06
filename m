Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E97C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106D2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oQYvEd53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIFFTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:19:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19052 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:19:40 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w860kkQq016151;
        Thu, 6 Sep 2018 09:46:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w860kkQq016151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536194807;
        bh=g0egjPCelI6n2dEjsi/ifhGbKKp3Uokc0v1jzZOk7RI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oQYvEd53GIFBZlalbTkwdrr+tR/+/yodv9LYuDMMU60hwM2r5QtSlOCk74/n0eIHb
         f3Li4Uax1+R7Q4QrxKUBhDsn4kNSPNS8k60UBhGImQKoYYM54xqACy9Q46YQmXNHSR
         BpsuEDSJSNkeOYoCDf5r/LWu287ZUOUVyqDlN417pNesiMucD4LBxjktM8asiihaT4
         lzj9qoNsX6BXNFDy7R1oQDnGdG1o25vlhocfHrA29mJi6DOKFuaKkP6eKFfOApwt6q
         Gsb9hSNs7Hk1Qvgt8Y43KRZaNiXPp1aKDOv2Yc2nYygk7rEU6kgKoLJWk1daJB0NEN
         8wBD1dQyulJgw==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id s17-v6so3420551vke.10;
        Wed, 05 Sep 2018 17:46:47 -0700 (PDT)
X-Gm-Message-State: APzg51DU+peYZgWaf55qFCXRUyqaaxmniIsoTFKvBGc4ekDbi0MIdryY
        eUbIhfyonyLhOvKyWxK8R7b9IXfN9cxXB+DVwM4=
X-Google-Smtp-Source: ANB0VdaYP7cEJwt9bh/vT+/bKvD0aRSC4TQyalpdis+wS70zFvWniSwVn5DwijncK81CHKMj4NGwXj24/4vANaYKDeo=
X-Received: by 2002:a1f:de46:: with SMTP id v67-v6mr87959vkg.55.1536194806193;
 Wed, 05 Sep 2018 17:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 17:46:05 -0700 (PDT)
In-Reply-To: <20180905225333.GA23155@gate.crashing.org>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
 <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com>
 <20180903093945.GA1195@zn.tnic> <CAK7LNAQOd-QA6E7189q4K-p_9ReRtE88UbhtuXS9600nOQTgaA@mail.gmail.com>
 <20180903100021.GD10249@zn.tnic> <20180905225333.GA23155@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 6 Sep 2018 09:46:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJ494dsB_dYu3LvvxebBJCo-ru+-9d=ctVmG_BbXr7Og@mail.gmail.com>
Message-ID: <CAK7LNATJ494dsB_dYu3LvvxebBJCo-ru+-9d=ctVmG_BbXr7Og@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] kbuild: use 'include' directive to load
 auto.conf from top Makefile
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-06 7:53 GMT+09:00 Segher Boessenkool <segher@kernel.crashing.org>:
> On Mon, Sep 03, 2018 at 12:00:21PM +0200, Borislav Petkov wrote:
>> On Mon, Sep 03, 2018 at 06:54:12PM +0900, Masahiro Yamada wrote:
>> > You are right - I missed this usecase,
>> > but I still want to excuse "it is rare enough".
>>
>> Isn't there a Makefile way to check file existence before including it?
>
> Sure there is, you can use $(wildcard ) .


If you work around it by $(wildcard ),
we need something else that terminates building
in case auto.conf is really missing.


I do not want to revert

commit 2063945fdc3d4c0ac8f9319d942eda720d02aabe
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri Jul 20 16:46:36 2018 +0900

    kbuild: remove auto.conf from prerequisite of phony targets





-- 
Best Regards
Masahiro Yamada
