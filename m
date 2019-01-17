Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11ADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vUaxl7EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfAQTci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:32:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37864 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAQTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:32:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so8717194lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5Y7UQmh6b6lXGKQkL93ka9r4Qd6QQlJhoMAPs0yLhI=;
        b=vUaxl7EKuZr9Gojq8NuVGrXqnjpoZqIzVII8Tv005cPXvw4ZznbeATnQQSbEzezvle
         hkyBp1QRqG4/STm5bSO81o01fXNfrqqO64bEdhDR3qpvlAqKN8HB/T6Pd2+j3XcaLs8m
         PPcSDrMfneJJ5iyml9LPx2IWEj27zhLb7tXLr4dgmr0ZS7nmlBTdLlnFQ/ykcjkl6f99
         kYndP4VDSEvyWawfr1CDL4vVhwAiT48zH6AKSi6EdOei6Q+el7xunYjKtfOkHxOMVxKM
         st6yOIeWeu4shOm2E8aIXVOzDws1TtkiI1BFWzVI6atYngr9AoF9Z3wK8/b8iEPAHW8y
         YUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5Y7UQmh6b6lXGKQkL93ka9r4Qd6QQlJhoMAPs0yLhI=;
        b=HanEb4rPCZgt3aGmgHamTdED0kLTjvCwSKW3+cnzf3VfSLIKcnDhnxRvc+9avurqwl
         lKaWystwCQWbstbEuWqHWv70ekdWCts0408Ge4x3UmgJTg/f7NIQ2fry/By/S9FofTjR
         6E3maYK2uUwHeVJ4dpXtL0l1FenCk6fbtfA3GOPdeWqf3DUx/LloxoDGly3DIHlbtrNl
         fsoHCU7T9A4Y3EAWJ+t//48jAYhPpXjebBR1IfkYAGBQNODoNgUBwV/sQFn/3KlKrjd8
         cH9IrtMkd9bcnT6ogftOSmWP2kPqC8j53ae4VnJOZgL7WRSWF1pmEYwPrWvm6DcofvDq
         7vTQ==
X-Gm-Message-State: AJcUukfm2dPJa/AjK9vItS5gwbhm1rSPtS3DzApStIUVkLjXR/bVQTkJ
        YcyYuTmJ8Yx/2xh5Er8BZ2zWy+dipGZTovSzrZWLOUU=
X-Google-Smtp-Source: ALg8bN7ebcsBBRhZ1ze7cpUY1jGmPXlphBeIaIkEMm4r2WJYxSLpaa9hty6MUKGiMLHN3chbRdfm3K25U4adMFantFU=
X-Received: by 2002:a19:f115:: with SMTP id p21mr7577051lfh.20.1547753555249;
 Thu, 17 Jan 2019 11:32:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge> <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117170815.40131a69@ivy-bridge> <CAHC9VhQqT9HW=m5_sbru2Q7HoJC6oSrzMzrkRxgeDB7sWFLA-A@mail.gmail.com>
 <20190117192610.tswga6xweyt42hmq@madcap2.tricolour.ca>
In-Reply-To: <20190117192610.tswga6xweyt42hmq@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jan 2019 14:32:24 -0500
Message-ID: <CAHC9VhSMsP=YqbQZ2YWJ_DJZajzuQQ_jAVP3j7RV+9beD5qnGw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-17 12:36, Paul Moore wrote:
> > On Thu, Jan 17, 2019 at 11:08 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Thu, 17 Jan 2019 08:21:40 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > On Mon, 14 Jan 2019 17:58:58 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > Tie syscall information to all CONFIG_CHANGE calls since they
> > > > > > > are all a result of user actions.
>
> > I see you added LKML to the To/CC line.  Fun.  Unless they've been
> > following the audit list for the past several years I'm not sure they
> > have all the context to fully understand some of the things in this
> > thread, but sure, why not.
>
> I added LKML in the original patchset posting, not Steve.

That you did, my apologies.  Why did my mail client highlight that as
new?  Oh well, my comments stand regardless; I'm just sorry about the
LKML noise I added to the top.

-- 
paul moore
www.paul-moore.com
