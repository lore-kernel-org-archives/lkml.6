Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3207C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2036320852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SvmnGLH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2036320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeGYPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:51:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27771 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbeGYPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:51:54 -0400
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com [209.85.213.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6PEdpiP028890;
        Wed, 25 Jul 2018 23:39:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6PEdpiP028890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532529592;
        bh=mmco++PLQyXJUprrrFPTT8JVnXIVAQFX2GupmkMSGrw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SvmnGLH5mxT/1h7t2UGpAw/cNMBLXPEBeUuadvEMFT5MCTYOXyTsycKg/LCHCjrDU
         1P4Nv9KYcjcxNrnII8fRb891xLlyEWVGmAdlacaWnPLHo85GVld20V+Kd3EcladFIH
         c17dwqRhTIYQ+ads3MxPQ7xHdtwK1ChjxwafJ2RdXX83s0+9I5JMQY8JOGsZX6KR6t
         oiUamXA48BPg/veA9H7cUfNq9+1lnXqSD7kq8SP/8JxGrC4Ellf7pyn9TYWCxmqWih
         YlSDqpt1dUz4LG1JtSYoVwli5bu503i7u203kJuiKDvs4mxK+cEFOgHHrnaJaeY//B
         Qzko5qhy7KCdw==
X-Nifty-SrcIP: [209.85.213.45]
Received: by mail-vk0-f45.google.com with SMTP id p12-v6so3913031vkf.2;
        Wed, 25 Jul 2018 07:39:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlE5btl/OcBEAw/se72bxEbGqAZhxm9uCZpn1JzJI23gEhjMCQo6
        ySaQPPht9VlIM2fmmz2t5DCto0gvlezsorsk/sM=
X-Google-Smtp-Source: AAOMgpcohoXqRwdWx1U000bsFHUYFkKnI6LNlECXy37MiyssQ9aDlrNVrFfcGQUYHZw9YtJkSiAY06j5ESFQrf09C0g=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr13915794vka.140.1532529590360;
 Wed, 25 Jul 2018 07:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 07:39:09
 -0700 (PDT)
In-Reply-To: <20180720193528.1341-1-jcline@redhat.com>
References: <20180720193528.1341-1-jcline@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 23:39:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWotaFhMAnW=Ah8aFO8VMxUB4bXursTe6JTZxcTzettQ@mail.gmail.com>
Message-ID: <CAK7LNAQWotaFhMAnW=Ah8aFO8VMxUB4bXursTe6JTZxcTzettQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: Add Python 3 support to tracing/draw_functrace.py
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

2018-07-21 4:35 GMT+09:00 Jeremy Cline <jcline@redhat.com>:
> Use the print function. This maintains Python 2 support and should have
> no functional change.
>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  scripts/tracing/draw_functrace.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
> index db40fa04cd51..7d44e796d362 100755
> --- a/scripts/tracing/draw_functrace.py
> +++ b/scripts/tracing/draw_functrace.py
> @@ -20,6 +20,7 @@ Usage:
>         $ scripts/draw_functrace.py < raw_trace_func > draw_functrace
>         Then you have your drawn trace in draw_functrace
>  """
> +from __future__ import print_function

What do you need this line for?

I have not tested this,
but I guess print(CallTree.ROOT) will work for Python 2.



>
>  import sys, re
> @@ -123,7 +124,7 @@ def main():
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



-- 
Best Regards
Masahiro Yamada
