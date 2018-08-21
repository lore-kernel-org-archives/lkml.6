Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9E92177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GIZvi5KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9E92177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHUUHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:07:47 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35364 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:07:46 -0400
Received: by mail-ua1-f66.google.com with SMTP id q12-v6so12247707ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BDkEf5k9dkHjOup5CUjO5xVZWg/tALtAYkBjHOV4qb0=;
        b=GIZvi5KQOyhTH7pC2aD7FcQJAoUoP3jsmY06U0sjBYjUKj4p35CnNB1tIkmSyrfSce
         aanGZVyPPis+/VzdTJFH258JsCQ1wnO5urftGRbUx4FAgQNPGA69TCmwSzqPIg6/DxNG
         XOw5YSxPMK/VKF5wR1YWU0i83g5IVkVbNYKrgUZAPu2YTOMB02mhn3tFYhiQYAbuth82
         G+iJXMWCRqaExMn6utekKm+lsOqmoUFMJIjDRMTOqdX0PPZPJ0UF7Rk9heoFqpu23xxO
         ZlafeapcNleKpBddXPEC9sHT236DKAOgshsBPWjPPQXh2snz+S6ARSQYp/fDOHV2tMPf
         3brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BDkEf5k9dkHjOup5CUjO5xVZWg/tALtAYkBjHOV4qb0=;
        b=tDWQzjOx0IkAufbDQcbbIV0/FedBeUvvctrZHrzaDc7FGf7qPZRhTw7ubFOnG3vTmD
         yy4e2KJy5+IYHqG5U2QOsrrPbik0ana+mgOXJTmEdcOl8cnU44Dj/017Br/UtrOWIPpO
         kyFiQBB8gQGJjWse8pZP1WmwR0zCQmPx+ldhhWKT/TMR001NPG27Bm9JO/6uuvsZTmgI
         vdYpuHRqCeQLkCG6V/ahvLDwuYIgndrNi8QRoXML7mTRnZ0EUb6w6nbNXLwnq4f1Rm09
         04La5ciH6X2Ug8m/z0RAJHB3j8OY85f+rbvk1X20WQVx+tWDhtLW3rwlzfSru8yCyAGT
         HBuA==
X-Gm-Message-State: APzg51DeT5n5+d8UyyfVDpY4Q4Zay+eoJEVEaI68/8UaZXuZs+6vQj6k
        6JbHv/CzlPb95v8WLOsJWAlDNX6eFetRX69X2X5SFYgU5Ttm8A==
X-Google-Smtp-Source: AA+uWPy1bqFqabmuSrxtZ2DVnelO/zp7ouoqYyjtfDJZ5E/c6YcW7tdN/rxeeE7U/mHLPB6ubf9sbYrSkNw/acnO1tE=
X-Received: by 2002:a9f:3968:: with SMTP id i40-v6mr3428144uag.63.1534870012926;
 Tue, 21 Aug 2018 09:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:2a87:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 09:46:52
 -0700 (PDT)
In-Reply-To: <20180821161258.19718-1-treeze.taeung@gmail.com>
References: <20180821161258.19718-1-treeze.taeung@gmail.com>
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue, 21 Aug 2018 18:46:52 +0200
Message-ID: <CAJpBn1zT1EnyKnzmoEO_4WwjR1qgY94wcQjHdKUPAa5z+5OvXw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Remove the duplicate checking of function storage
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 6:12 PM, Taeung Song <treeze.taeung@gmail.com> wrote:
> After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
> as a program for multi-function programs"), bpf_program__next()
> in bpf_object__for_each_program skips the function storage such as .text,
> so eliminate the duplicate checking.
>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Looks reasonable, but you may need to repost once bpf-next is open:

https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2abd0f112627..8476da7f2720 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2336,7 +2336,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
>                 bpf_program__set_expected_attach_type(prog,
>                                                       expected_attach_type);
>
> -               if (!bpf_program__is_function_storage(prog, obj) && !first_prog)
> +               if (!first_prog)
>                         first_prog = prog;
>         }
>
> --
> 2.17.1
>
