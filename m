Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E3C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6308F2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuHADvJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6308F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLBCKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:10:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36986 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLBCKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:10:07 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so2677466iti.2;
        Sat, 01 Dec 2018 06:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6kFo1eZ8ABphdmLpbOUXAtMEimIy2gbxxzEuasDmxE=;
        b=WuHADvJfXhhDJWuI1KsG/xkhNemIIKorYZ0vYm3Tpf++sm25tAHMb3sEJ1BPSsAnpm
         sLf3b3hYEF95hAb8UnhhgSuCcg++0GkJjHTZsEeF7rOFc34uL3+I+VWZzEvffNliPOJz
         UmDGKVlPTVXs+gZObb9XQM1ncCtVJm5eSyS+wxW/uCj2WINQY2OcDvRZI3urilDAvi/4
         ctWNXkGNLDe3sBfN8jl5zrqLyC24wNNh9zha/XLyTf/G3vnfEjY8bHTpnmNqUglzOzXY
         SS51XtnxCzf6SaU2mW8zRDMPZKQZV4ngcjQ0w7jUipq/mKdB5GIBQ0a6I/OyNDV2jfv5
         aW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6kFo1eZ8ABphdmLpbOUXAtMEimIy2gbxxzEuasDmxE=;
        b=avHgUDm2lJg9H/3uTDp2YmKQvtUyCpX29h+zA7v29VmEs+SgbnsEkNBshS/caEajz6
         mKqaUvXx8twNTEooAuBx1OM1o/pddofqeGMqIepQhzWwTaVSAldC39ZEhxTsoaDA1XMz
         QR1bJ3/kDW42BNEWzAVLmGrC8pBIpLubET1Foee8sIRFnIpqvnHGGAbawTWRUZ5hyauB
         JNrwwbciUV00mwAkx0aLNQYQzPGXEGW3fhrqvGzxl3h/rd/9IINmrcyauepjsukBBkgI
         22H4qvpzbpAzpab4wGgbSw961QP/os+GFKypOufIky3+vH9SkeaE2MnrVm15prccQGwY
         KASg==
X-Gm-Message-State: AA+aEWZm+3L9yQiTb4slfi4z1rnIiz+i8YQhNNzVGTnnp5H4d+y88yG5
        TRRO0/CaJCJils31+PfonXFTau0nDBUhImZepDo=
X-Google-Smtp-Source: AFSGD/UKvsl2Qw8DHKWn6gq6Jw4U/XT/dejFotCP5uVIbYRvj0DbYns7Bw1gALbEnXFPN1iuMr1uAmBx8J84GyGtphA=
X-Received: by 2002:a24:648f:: with SMTP id t137mr2333345itc.95.1543676245373;
 Sat, 01 Dec 2018 06:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20181201101417.6368-1-tiny.windzz@gmail.com> <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
In-Reply-To: <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 1 Dec 2018 22:57:03 +0800
Message-ID: <CAEExFWu01nUBqb1N3R7rDXf96sLBYEfxOo06Q-ZAqMqYTmNKjQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, Florian Fainelli <f.fainelli@gmail.com>,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 10:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/1/18 2:14 AM, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> One patch per file, please.
>
> Guenter
Already split into small files.

MBR,
Yangtao
