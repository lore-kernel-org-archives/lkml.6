Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB50C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A12F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w7iZn/Ci";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w7iZn/Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeLQNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:39:15 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:38640 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeLQNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:39:15 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 8D954202CC;
        Mon, 17 Dec 2018 16:39:12 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9ojair3LNb-dCQWnFG6;
        Mon, 17 Dec 2018 16:39:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545053952; bh=B3seQixI2CSeLl34u1KeshLhri33S3Gv85wWE+kBH7s=;
        h=Subject:From:To:Cc:References:Message-ID:Date:In-Reply-To;
        b=w7iZn/CiYUIpiUQcBfbqsAzsmRqjLpri40wS1pOrcl35TyGwmQ0q2kFgwo+z5YC19
         hLZ9E3IQPv9vSheyD3Bq27lXoUiT1uBgq/9/CfYwmpiyvcK7uEW5rkAMNF2vc2I1oG
         Vf0tEQy3UO0rkMuYRKNRWlWD9fgDG6+AyHzX2GxI=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3712::1:90])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 4Wd1QsDFjF-dCAOCQGK;
        Mon, 17 Dec 2018 16:39:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545053952; bh=B3seQixI2CSeLl34u1KeshLhri33S3Gv85wWE+kBH7s=;
        h=Subject:From:To:Cc:References:Message-ID:Date:In-Reply-To;
        b=w7iZn/CiYUIpiUQcBfbqsAzsmRqjLpri40wS1pOrcl35TyGwmQ0q2kFgwo+z5YC19
         hLZ9E3IQPv9vSheyD3Bq27lXoUiT1uBgq/9/CfYwmpiyvcK7uEW5rkAMNF2vc2I1oG
         Vf0tEQy3UO0rkMuYRKNRWlWD9fgDG6+AyHzX2GxI=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] tools/perf: fix silent build with 'make -s'
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
References: <154504723398.564691.16359911285545406564.stgit@buzz>
Message-ID: <1194e461-2385-bea9-dc85-d55d4ad89430@yandex-team.ru>
Date:   Mon, 17 Dec 2018 16:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154504723398.564691.16359911285545406564.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 14:47, Konstantin Khlebnikov wrote:
> tools/perf/Makefile conflicts with option '-j'.
> The rest options must be passed as is.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   tools/perf/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index 7902a5681fc8..989c3d2f847b 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -16,7 +16,7 @@
>   #
>   # We don't want to pass along options like -j:
>   #
> -unexport MAKEFLAGS
> +MAKEFLAGS := $(filter --j% -j,$(MAKEFLAGS))
>   
>   #
>   # Do a parallel build with multiple jobs, based on the number of CPUs online
> 

Oops, this breaks static build because if LDFLAGS=-static is in command line then
all assignments in makefile are ignored while Makefile.config have a lot of that.
