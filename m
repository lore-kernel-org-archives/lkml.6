Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E60ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1182086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="FICJrEFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1182086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIRLTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:19:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44015 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeIRLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:19:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130-v6so367578qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bivoKUP44ypNPtO2W8tdt9jc/ntKI2F0sh6NsngOSkU=;
        b=FICJrEFVfK+KZr0fuBNSjrkBR2P5eWH6B8VFdb8/Cq1T/1BzYZV0lOtiExz7muAya0
         8TCW18aswZqlKJUCYff31MtJBqMGgXDHXmMXD0FNfjv2vwbf4eSrey+THox8/Ciuh/ec
         eOftrY2L975YMPqtUoLdIgOfP5kqsBQPFZWU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bivoKUP44ypNPtO2W8tdt9jc/ntKI2F0sh6NsngOSkU=;
        b=VIAc568Oo6AtYOsfZqSfUhQiwydW3Gx6cbIlzRve565CHe1ZgpsAaM2WnpFdrbza0t
         OxLumaBgQtBUoN2nDLZzXHxIWsjUBDJm0dLLL8icSDXiwx9Auh7153QGPyrKd7x2M/yW
         amIBoAMuoQac0Ht9NQHSugV6hIGlWkTyLkiCQXECNd4uKJ8/oUoF4fOepikNXZzJKFzv
         dmAl576/E671tHM0tzYCTDcKUd0RAWxkPng0tQpxi1pSOFMvaniAktyekYsfa6U1WAUY
         6EIGNeRnmAP9AklKQKI1MixwWWemMrxaOVQKQM0akaXbva6AhYIrh30cdjnU6w2pHLNB
         2uZg==
X-Gm-Message-State: APzg51DW+9ah/PlEsXxkLVlCrF/OjGMHGg95WL/qsMbWVO1ZAgqqML3z
        FWyJY+fPQXB0E3kBXDAWoX7GzbuM25KAYRUw1FXJXvAG
X-Google-Smtp-Source: ANB0VdYzfdgj6eCB9zI81JORRdR0WuaC7Xnswt5Wdf1nhKk/D2L1SW+LxHn9Y4RujbEuJoMTZUWjHttltOYQNU+PaKk=
X-Received: by 2002:a37:ae86:: with SMTP id x128-v6mr19477279qke.25.1537249694340;
 Mon, 17 Sep 2018 22:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
In-Reply-To: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 18 Sep 2018 15:18:02 +0930
Message-ID: <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
To:     christophe.leroy@c-s.fr
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christophe,

On Tue, 18 Sep 2018 at 15:13, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> Since commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), it is not possible to build kernel with GCC lower than 4.6
>
> This patch removes checkbin tests addressing older versions of GCC.

This is the same as Nick's patch:

 https://patchwork.ozlabs.org/patch/969624/

Cheers,

Joel
