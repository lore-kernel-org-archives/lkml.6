Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D49C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EDC20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PfqiXRSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EDC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG2Dkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 23:40:45 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59496 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbeG2Dkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 23:40:45 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6T2C28A005073;
        Sun, 29 Jul 2018 11:12:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6T2C28A005073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532830323;
        bh=TKRNv+OwBbWoPHFU2RCqcHvixhKMHXpwFn/1JlbAfNI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PfqiXRSAnRwXE9k+WVCWqOGmXgI92mzugCV71zcILXFs6k605dGuGGnalCnFvzmzD
         Nw1TCpfrBWtHcNif7zuv/uPp+JOW0Ii17T6OIRPvfBRZyPkmomb3uk4+eWBcURLNeV
         zMHDORgq+PFxkF+kCyIt9nViMUins3AE4c2mMo7bSWx/siKVYGBQVOGu6gJ4Nxh/og
         Im+e0bV1J4QqzedrKDTPRdYyn+g2VdeU5sMBM8R4i+SvhJVUmKmevt7YlV6oLUhP8r
         4t8+UVR21283nm42Gd+Nj5mkF6lnCDMgVw4ib+Kef2krB8ry41uEQfC8OyEPVy75AE
         kWp3jeh6fTDvg==
X-Nifty-SrcIP: [209.85.217.174]
Received: by mail-ua0-f174.google.com with SMTP id i4-v6so5763542uak.0;
        Sat, 28 Jul 2018 19:12:02 -0700 (PDT)
X-Gm-Message-State: AOUpUlEun2Fny4ArRfg57zbFzD1OFSXgOxtQ60JDbbSrAe5Qqjr1ZDDx
        ITEUHxLE6jlU0yZ2GPm48o8vZzVfZ3K4+kV4WBM=
X-Google-Smtp-Source: AAOMgpdvi9IIA10zUBeSshsrTNl6LIsswVklvc30PtgRLGh70UADrT5nkd7s9Gkap8mWRwCXdLjEoTXPR7CtfZ0ITSw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr8515656uaf.199.1532830321995;
 Sat, 28 Jul 2018 19:12:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 19:11:21
 -0700 (PDT)
In-Reply-To: <20180728144833.6336-1-jcline@redhat.com>
References: <20180728144833.6336-1-jcline@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 29 Jul 2018 11:11:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASS_LfGOPthtL0Quueh74Sbatdhk0ouaRUZuufNB1VSvw@mail.gmail.com>
Message-ID: <CAK7LNASS_LfGOPthtL0Quueh74Sbatdhk0ouaRUZuufNB1VSvw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Add Python 3 support to tracing/draw_functrace.py
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-28 23:48 GMT+09:00 Jeremy Cline <jcline@redhat.com>:
> Use the print function. This maintains Python 2 support and should have
> no functional change.
>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---

Applied to linux-kbuild. Thanks!


> Changes from v1:
>   - Drop "from __future__ import print_function" as Python 2 is not long
>     for this world and in this case the statement and function behave
>     the same way.
>
>  scripts/tracing/draw_functrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
> index db40fa04cd51..9b6dd4f36335 100755
> --- a/scripts/tracing/draw_functrace.py
> +++ b/scripts/tracing/draw_functrace.py
> @@ -123,7 +123,7 @@ def main():
>                 tree = tree.getParent(caller)
>                 tree = tree.calls(callee, calltime)
>
> -       print CallTree.ROOT
> +       print(CallTree.ROOT)
>
>  if __name__ == "__main__":
>         main()
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
