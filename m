Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFB1208E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZBdMKGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFB1208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933947AbeGFRbz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:31:55 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43165 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeGFRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:31:53 -0400
Received: by mail-lj1-f170.google.com with SMTP id r13-v6so9689086ljg.10;
        Fri, 06 Jul 2018 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IdodENOcD+TFwsPjqWauBE8dWlYrPaSgpgXVPHejJ+c=;
        b=kZBdMKGNiFyWdepSYMxpp+tiDjDxf+oJ5jmNkIrguZ9ZgdcaOa9PdYtwez8bQQD2J+
         Q+jtHJuCGXtRbU3CgTNjwahnQ9Q/4HPsBIV7WgpLuxwEHtAIj0aWCUchnUaP5gQ4in1d
         puA2s/FVAiC1OfoLe4UBfWMLq/VvRiU2iu1pdjuSVytLJPsFxbyvbBnGiA5kzFDeMaey
         8mLhjhau8oyQGdsr9cdESCHHBH+fAddPt41lBZdb7j4Qb9n/0ASwxTJqIMQ+ThR2bJLF
         Yd2COva9KGciCzoaXMNZfuPyQSxjQbaP5ITegqebJe7ByUr0RZlioPmwN6fgXCmRVG22
         7trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IdodENOcD+TFwsPjqWauBE8dWlYrPaSgpgXVPHejJ+c=;
        b=N4sgsi+mVhTvXaZSQoVjMWjMmEoJuTfh0QLJ0/2UCTIHTjs18tGRkBR+8VyaeTECWQ
         H+7FkILFWn+ZQI4Vng5GcHdAr5FPGkQ2Eb4W/bM9LFAGsqzJ4o/r+eMDl5o0eflS22yw
         Q58Y3jjRtSVfEGeQ+s6fJ8kpob89aghJTsRWCAQBMEx8tAWLCJaXFcKsoOcB5zEu3nfx
         ocHj+4iuz2tz+wH8/U7lOiaS16waI1kYnWVRZrz5HGabCNxPIUcVUZ+WVQFiHsgiSDeq
         u/VQ1pMt/ml3qZ92fmdXtUB6jNwPAvUZLCGI0EPMDBX6APP9s2eP+8ppQHXO6aCKZXYq
         gNAA==
X-Gm-Message-State: APt69E1bjM37CNbtiMe0f82bO/49o4AnOe/X0n1VDUVrEQT5LBGLiKaB
        FD2gO5Thg9V0c0eg33gYXkAyw1bl4KGetyvU/jC8
X-Google-Smtp-Source: AAOMgpeDnnurVWeS1f/dwRdXBcdxhT4iajOKiXLrgGCuSRao0DOOXqKZMn+1iuA+eSE2qPqGEsQev+Eo9Jpq6o+Or/M=
X-Received: by 2002:a2e:4357:: with SMTP id q84-v6mr6882329lja.13.1530898312377;
 Fri, 06 Jul 2018 10:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ef16:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 10:31:21 -0700 (PDT)
In-Reply-To: <20180706163307.2jb6bqx2xvzyxwkr@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1> <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com> <20180706163307.2jb6bqx2xvzyxwkr@kshutemo-mobl1>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Fri, 6 Jul 2018 19:31:21 +0200
Message-ID: <CAEJqkgidhy8da14tkYD7OgUyOzGho43znP+g543_YDHjgRMQSQ@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 18:33 GMT+02:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Fri, Jul 06, 2018 at 04:39:28PM +0200, Gabriel C wrote:
>> > If not, we do not need to think about that case.
>> > Just say "Do not do that".
>>
>> I am sorry but I have a hard time to get your logic here.
>>
>> You are saying : the *env* variable LDFLAGS as well passing
>> LDFLAGS to make , which your build allows should not be use
>> because is for 'internal usage' .. ?
>
> Environment variables do not override make variables. Only passing varible
> assignment as make argument will do this.
>

Still .. When the build system allows to do 'make FOO=bar' and you know
when using that things will break , the build system should be fixed.
