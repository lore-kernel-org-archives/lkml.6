Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DCC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7091420651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pGdv3TAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeJZXQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:16:26 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56907 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJZXQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:16:26 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 70b441f7;
        Fri, 26 Oct 2018 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to
        :content-type; s=mail; bh=XaFKG5/tLYHfsaIN6vnMKKAZNdg=; b=pGdv3T
        ADHPHqlK+PvZlePtlreN0mFVh9M21nWX+92+C5Mqp7QrOXdMKxUEt/uAGbzPFh0h
        bIGcz2rDr5kznYLlndpfHWaOytEX5h3QsVpyBsBomh45o8bM1yLZ53+7HD4xRL9t
        V4FWJTfdRsqmUtMyXItr0VtORyNjdVpowsnaz+Y0FqYRN/JgM4MgiEHNS37DvcaP
        W1mqUiQ1SdRpyTVfpmU8M8YFEIenSEG9YMUdxliBXSeNMMRMufxfo8o3j2Z+hjon
        rZMnFVvD5BpjkaEDcb4hv2aziUDojDkGxpMARWsKzA86YmMCBIbThNTiC0/bNRto
        gZQmCIRrOOA3bB7w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb0afd63 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 26 Oct 2018 14:36:04 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id d5so1271018oti.6;
        Fri, 26 Oct 2018 07:39:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIfTLpJhuoWuJ2C1tD70NXFWGJUGdlQkdM7Vb764U5pdb7v5Pnv
        oNJBeYcyjcukzptVllZRhMaxRAFq+JaYYS/Lg7s=
X-Google-Smtp-Source: AJdET5cQcD5Ad30DwkYBgW2qpZ2c2dK20QgyrKn+YuqrAItY3Oya6wZnxJlM0WmRGBN01soesmiR0RevCnLmtgAWGcM=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr2191932otg.143.1540564743660;
 Fri, 26 Oct 2018 07:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181018145712.7538-1-Jason@zx2c4.com> <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch> <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
 <20181025224426.GC6276@lunn.ch> <CAHmME9pf=tCd=RKPTCpYuHLPkYqQwwr3LXEHP+_WXJ7DNjueZQ@mail.gmail.com>
 <20181026130914.GA8279@thunk.org>
In-Reply-To: <20181026130914.GA8279@thunk.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 26 Oct 2018 16:38:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9p+BsR8O67V=iJcXyKcFQnAqH8mYFmO02O-1=K3raXsrQ@mail.gmail.com>
Message-ID: <CAHmME9p+BsR8O67V=iJcXyKcFQnAqH8mYFmO02O-1=K3raXsrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 28/28] net: WireGuard secure network tunnel
To:     "Theodore Ts'o" <tytso@mit.edu>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ted,

On Fri, Oct 26, 2018 at 3:09 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> If that's what you are trying to conditionalize, why don't use
> CONFIG_PM_AUTOSLEEP?  That way if there are other systems that want to
> use the Android wakelocks style of suspend management, your code will
> DTRT, as opposed to depending on CONFIG_ANDROID.

That's a terrific idea; thanks for the suggestion. I'll make that
change for the next patchset version.

Jason
