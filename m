Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B725C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391232082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqjlQ5lT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391232082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeKZQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:41:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46806 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeKZQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:41:21 -0500
Received: by mail-yb1-f194.google.com with SMTP id i17-v6so6987392ybp.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 21:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53W/Tu/8r7IuP2Xb0G/lG1j0onkTe193aaP1L5hAyEU=;
        b=pqjlQ5lTr/nv9lzuKShOgsz6xRql8ZTy6Y0csdvEQ/V/izE3GQCxMCC5bDa0chuyW7
         QoKlEP0PoOBr40j6HOXLdwgcJpHfRg6EmUP4g95WAu9z4fvuGhzROTpxVzzJ1sd+m7vy
         tydOjcipqOVZJSAXGAir+Nn5fUvVnIeNRKZ+F6gqT/7BWQmM8j8GDBiveK1qy1I3Fthl
         wlnpVXNXNY3NBfbtTI6dJ0E7k4gIoDBZKfykf1BRlJPDHz42CI85gjSCyl+/T9qf5EGO
         omYOB727N0YB0luRsSV6w+jRDNzqjOszK/wfe5d5TyNd9IsMhPqmSUGlgNRSKfZ7NHjR
         zazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53W/Tu/8r7IuP2Xb0G/lG1j0onkTe193aaP1L5hAyEU=;
        b=agjrNSl5a7QMl/+mCTBMJbpdlz7s0SVHzfhZwkZLHTZhCYkKj95Q30fFwv65mkyly/
         Lr6VnmqMJxibaQGR11t5Y5rumNBkboH9PQcayd+CumK6G/sFwl6+JvIp5hW00X3dU9LJ
         F3+JXiaKP9c8VgWVMDPODVy3ZulTLhG/m8QcvPTZ31j6x9h+wgkieSGkcWzupmvcT7jI
         5lGTuFYjdqQJ51W2nN/MhtZcsvQLuyMv5hRfoIU9lBmE56ZKUHhdjS7Pgwa+BLa2G5FD
         DT81gcJR+fdBrdM7HN35YXAa4YzA0z5JDzwQk10tzxoA0DKIFZ/IvEUoQVfDph8VBagE
         mWdw==
X-Gm-Message-State: AA+aEWZKKWevCyYO2MpfpRuOTPr2q+pZ0cAk55CWxYUkmlnEL8tSitqg
        gNXmTO1aj2W40Xb2jdvJJjYlRmwGEBmqK3HJ9XcC1Q==
X-Google-Smtp-Source: AJdET5fh6T4hGdduch61VEbx8rzg/ubk8u27gS5uNeZgsbsSc4K03gORBv+jL/j1ryLSt7GleQh5vifvq8Vv5k4m2Bg=
X-Received: by 2002:a25:2349:: with SMTP id j70-v6mr26150959ybj.137.1543211301268;
 Sun, 25 Nov 2018 21:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20181126111415.5cf17f39@canb.auug.org.au> <CAH2r5mvtFzp=nYK+J92vh9y4tsNLT3rD4a2+mB9LMyWcFN-EHA@mail.gmail.com>
 <20181126115247.53cbf7be@canb.auug.org.au>
In-Reply-To: <20181126115247.53cbf7be@canb.auug.org.au>
From:   Kees Cook <keescook@google.com>
Date:   Sun, 25 Nov 2018 21:48:10 -0800
Message-ID: <CAGXu5jJDbUZBmbx1ODS72WJKfcv20aMZczq=k4p4OhG8SV0roQ@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     smfrench@gmail.com, sprabhu@redhat.com, linux-cifs@vger.kernel.org,
        Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Steve,
>
> On Sun, 25 Nov 2018 18:31:40 -0600 Steve French <smfrench@gmail.com> wrote:
> >
> > Both of those cases are intentional fallthroughs and there are
> > existing comments in the code noting the reasons for them to
> > fallthrough
> >
> > (also can see the reasoning for these in the commits which introduced
> > them from Sachin c369c9a4a7c82) and dde2356c84662)
>
> I am not questioning that :-)
>
> The gcc warning can be turned off by adding a /* fall through */
> comment at the point the fall through happens.  Kees and others are
> working on the several hundred other places that need annotating.

Right. The goal is to avoid adding any _new_ cases of this. :)

> This one just popped up.

It's already working! :) Thanks Stephen!

-Kees

-- 
Kees Cook
