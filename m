Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36640C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049262184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBVh9YAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWRRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:17:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38861 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfAWRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:17:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so2644091lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIsVcNZNOHMZnK2TCunEMUNz9sxBahEm12fUUhbAI0c=;
        b=KBVh9YAajbJqw/aZCsIVQ9DQ2v6pWrhkS5aTL4ZucDXj/J8+RS7SvIGfECl7ZzP1qD
         YUZ9r9SBisjgI8TtUaF4eHfFb9Dr1ExM6zyTit1roCyhQEHASr8/n0VSN9fwzZrV8yxR
         3U1MPsay74q6B6EFItWXsL1ujdV0Bt+kr+HmQwd+lZ33LCN7uDSRIbW5E6HDdCcWYNS0
         VFYLrqUxs1Nl4G35SI6LjqKZC6DTUmX003bo6U4r6Z2LQliyd1yQYwKS3kftUkp8IQ/i
         0SJynf2ePvvxw1uqJ2UDEA0cMbJACRachzjfc2NJw4gxH+SaYfib4k7YtJXSpZBoztfl
         la8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIsVcNZNOHMZnK2TCunEMUNz9sxBahEm12fUUhbAI0c=;
        b=e1/eCG+IAEybkDpW22lrtj2oRh7vM2+d+qtkl5FCYwHlbONFpUKqn0L4jbN/RpDkeD
         RSG50zwbY0N587GyuDuzkU4m5j40f0b0TzxzZHlDqZQWDCt3pWvnb5Vup1rikySWP+PV
         yWOHoDDP70qpDmTfxs0S2kVC8FvHEosrzjjeJ3mERU6L0GXD8yBooj2F/aNk2rpuT9uL
         COoh6Cz4TGskYYxxq/qWnoQDrCqxsS6GNUmZXIAgKOU7Y6OPU1YTd1O/+dNDQ42KmH1M
         Z1x/RAynG6PKRVvR3RGaVDNeudUjbsN1OPbJVyCYWbwkEFLYbugcrljG3NeWb1YQwVGF
         kTJA==
X-Gm-Message-State: AJcUukfeOVbjxzgrHVST8ZgQ6KR/WpjaaLDk84D+vxyYUOKSvON6/mNY
        zJAjN96xKL+1yHwRcvOtcEz8G0M+EEXGT4i0QUA=
X-Google-Smtp-Source: ALg8bN7o9u3k8p+/eSbw6Kg6c6rxqocUwXF2ZDtnUogyiP/B/Lsy9zxXfacKSZuzHZ71fduiWVJRlRyEWjJzxKfSUBk=
X-Received: by 2002:a2e:9147:: with SMTP id q7-v6mr1591630ljg.69.1548263852092;
 Wed, 23 Jan 2019 09:17:32 -0800 (PST)
MIME-Version: 1.0
References: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com>
In-Reply-To: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Jan 2019 18:17:20 +0100
Message-ID: <CANiq72nwuD8FWRD7eSbofqvQu2=dCH8sovjFip5OncQwoWqdog@mail.gmail.com>
Subject: Re: New warnings with gcc9
To:     Laura Abbott <labbott@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Jan 23, 2019 at 4:27 PM Laura Abbott <labbott@redhat.com> wrote:
>
> There's also some missing attribute warnings. The majority are caused by a
> missing attribute in module_init/module_exit
>
> BUILDSTDERR: In file included from drivers/scsi/hptiop.c:18:
> BUILDSTDERR: ./include/linux/module.h:132:6: warning: 'init_module' specifies less restrictive attribute than its target 'hptiop_module_init': 'cold' [-Wmissing-attributes]
> BUILDSTDERR:   132 |  int init_module(void) __attribute__((alias(#initfn)));
> BUILDSTDERR:       |      ^~~~~~~~~~~
> BUILDSTDERR: drivers/scsi/hptiop.c:1704:1: note: in expansion of macro 'module_init'
> BUILDSTDERR:  1704 | module_init(hptiop_module_init);
> BUILDSTDERR:       | ^~~~~~~~~~~
> BUILDSTDERR: drivers/scsi/hptiop.c:1692:19: note: 'init_module' target declared here
> BUILDSTDERR:  1692 | static int __init hptiop_module_init(void)
> BUILDSTDERR:       |

I have been discussing these new -Wmissing-attributes warnings with
the author, Martin Sebor. There is a new copy() attribute that we may
take advantage of, but I will send the patch I have since you already
found this :-)

Cheers,
Miguel
