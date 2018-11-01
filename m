Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E91C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282B9205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="laTLb0pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282B9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeKBBBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbeKBBBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:01:18 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2CC2082E;
        Thu,  1 Nov 2018 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541087864;
        bh=dSJCI9kE3qlgUTmBWO4YVagMCHYUBBnirKIyof1dfps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=laTLb0paqRoDWv5D7uguyobFglasgGw8oHoQKLvFJcAwOetkPNpKMWDD0SmKO+fRk
         szyBKDeK+5p8BzbeVfCrZeyV0jBqxj/YVRT5UKZVYrRFSrtQDTCd6EwiOKpWeV+lo5
         kSmrM0H/nKVp6siKQbAZyVB5Rj8G6xhwrsFKQlc4=
Received: by mail-qt1-f175.google.com with SMTP id v1-v6so17394193qtq.5;
        Thu, 01 Nov 2018 08:57:44 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJSS4kNrwSYCvDI9RARBKwYXYx65wmIf5YWemPpst512BdRM7rv
        JgmdAyzvdjASK8P5kTf1YdcP+jk9nZK06dAOjA==
X-Google-Smtp-Source: AJdET5cIOgMr5VYSgCTTegF1kAIR3sj2pwcA6iOD1hzovWzrmYVsT73EOZ+ZBxRSKBG/EisUkD7uf52DX1IKqYqLYY0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr7435448qts.144.1541087863786;
 Thu, 01 Nov 2018 08:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-2-robh@kernel.org>
 <874ld3jz6v.fsf@concordia.ellerman.id.au> <871s87jz3g.fsf@concordia.ellerman.id.au>
 <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
 <87tvl1dq7q.fsf@concordia.ellerman.id.au> <20181101151201.GJ5994@gate.crashing.org>
In-Reply-To: <20181101151201.GJ5994@gate.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Nov 2018 10:57:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmx_vjQfYMTFc5K4Sy4hEVXJi5p2PNL8uCpiyTdSir3A@mail.gmail.com>
Message-ID: <CAL_JsqJmx_vjQfYMTFc5K4Sy4hEVXJi5p2PNL8uCpiyTdSir3A@mail.gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
To:     segher@kernel.crashing.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:12 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Nov 01, 2018 at 09:52:57PM +1100, Michael Ellerman wrote:
> > Rob Herring <robh@kernel.org> writes:
> > > Yes, I was aware at least older powerpc DTs don't use 'cpu' for node names.
> >
> > Actually newer ones too, see below :)
>
> Good, because that is required by the Open Firmware standard (the PowerPC
> binding, to be exact):
>
> http://www.openbios.org/data/docs/ppc-2_1.ps
>
> (see 5.1.4, "name").

Yes. I should say I only expect systems following ePAPR (3.7) or DT
Spec will use 'cpu' node names. Those specs also require 'device_type'
which is supposed to indicate what OF methods are available for a node
which doesn't exist on FDT.

Rob
