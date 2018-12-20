Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F878C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DBF21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FWYwGCVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeLTMNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:13:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41953 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbeLTMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:13:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so1155997lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ns4Fl397Yd/csnkjGHtLlFJtBrIkt6ofNV0u3m4Bt8=;
        b=FWYwGCVbBk+tj+KASK+hjcpw4YKAAaZUbElEzMMLt6kRTeRQfQG3Iufo+u2pZRI2lU
         a3USAW0c0RrVKMHmTBGQTlRY1xrCx5fx72pOdlF5eOY6GhSbVC26LQDdAlNcbKOiWKLe
         G8IZ+6JLEosJBaqr2QyrU4IuhpBF3DVLnrEyBOjLUwRzEzXwtHM+EybzgC8zCaKHL5uz
         KvIEEy11icAPu5thjzwXWolvBEbIW9KRspeVMFGGmLIc3lw4ytS7Pr1c/4KylgqplTQw
         nKPaJtW+hG1AyszW15Vi987dX/0InkqqEJlfalrVKlTNJdV1THRksEw5ncKoXkKWS8Ce
         WTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ns4Fl397Yd/csnkjGHtLlFJtBrIkt6ofNV0u3m4Bt8=;
        b=joNWZrSUHkFdFHz5G3WmO2BRa+eMfXovdL8BP0NlFUoKITxR0M+vjeKp0caA1e6oAf
         OvcX6G/L4ktAUdxmG8AmvmLCNV3lnytC0D3iM7fZK9+Ngc/ELygQaJIO9SqM1rUnXdYj
         P282yvgXxS5E7HSwAib2P5dtWSMp3Xuln4Du0Vh1jMcraWNzzjeXNRJ7I/IurP0cAIxS
         FNuqVl43KFk2UEvpiQqE2RvFoQLs9ftINum7SDcOJ+qBMOLy42hhCV1gE0HhGPs67uWN
         rIM4wnMecq8Yl2BQfmn0xnnILM394FRVN/EtrjIIWgHlTWqFoD/rdqHHj6V0QkTohmrR
         sBPQ==
X-Gm-Message-State: AA+aEWb6ZDjVad3RjRBfSsylxRpT8S5cL61i6ReKby/jG5A8gBM/loj5
        mPB030gnRrbSQlVsunNC0lrblini2sOW9wBOHkYCvw==
X-Google-Smtp-Source: AFSGD/VR89Qv5BlEFsgoXakYkunXSQqKpZdQPAOkHjiMsSrBFPZnONo4M/uFeHgf63Lo7bbh9uHywdNk618dEBFnnaM=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr13303543lfm.81.1545308017282;
 Thu, 20 Dec 2018 04:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20181220104057.18628-1-christian@brauner.io> <20181220105444.GB8548@kroah.com>
 <B16ED4A7-5C64-4285-A076-1CBFEFE47DDB@brauner.io> <20181220110923.GA10786@kroah.com>
In-Reply-To: <20181220110923.GA10786@kroah.com>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 20 Dec 2018 13:13:26 +0100
Message-ID: <CAB0TPYF6hgNt0QcYNj0_jZmKVxuUpko-nSoRGwz19_M0OFzmCA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update Android binder
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Christian for signing up!

On Thu, Dec 20, 2018 at 12:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Ok, no objection from me, Todd/Martijn/Joel/Arve, can I get an ack from
> someone?

Acked-By: Martijn Coenen <maco@android.com>

>
> thanks,
>
> greg k-h
