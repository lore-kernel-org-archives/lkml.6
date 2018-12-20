Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B927C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40881218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+WnQG9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbeLTTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:20:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46495 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbeLTTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:20:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so2800449oif.13;
        Thu, 20 Dec 2018 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLiUhJoetpaLm0dXAkPPIqRTNSalwtI3EAMxWk/bluY=;
        b=p+WnQG9mnt2Nh9ZIh/za1RI/jBS6mxpWK+Py8bcT0qxucKcHsfPLMQ2rN0b+FbK+Ba
         EcjtQTxWVwl8pdnDsMsAhzXstegh2tqBH3LU8ZeA0Uyg4e3El/eqtoZgYigsVWE9yfSr
         xmwPxe0L9A4lvayAte1TUfyjYMx3xSMK8KBID83UWq4f7iUzszwsF/EpB5iLtigMnO/B
         y2xfHqAjBnGkPyqv0FFtkR7Tl7PIru+cyuwuYZLSKvdfJPac/ofIcutj4akIN2Fr3gPB
         77Wr1Raq+sxvhPLKI54YUU/BvWd1XmfAlhok1HLS2jLh6kZsjfs+9leuQdIZ9JVjif1n
         I43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLiUhJoetpaLm0dXAkPPIqRTNSalwtI3EAMxWk/bluY=;
        b=qdF60fAJj28uShW+RN85UdhosVRJliKmqDo/8sjnBpb24qAvzzNRHEe7jHrjVTWkf1
         0C1pwpvVpqf8PteObtE5UM2Cmj/DwCNYyd1XZUCd3NoG2uwdVMzlmAw2h7uLKi5lfCFp
         QooKlsVcJpmSCGp9JIeOXMH8Qhj4H7Zyh2ceumiJGSOsc4339iWEa9KZKiIpKr6solID
         ld5DqrwOMgrIPXxSNdzQEOzhyYdXfVBgyaildj01A+GO0mCnAXb0vpVGNy+/Lf2q5IrB
         aOp+EsmgxgCB3s9lTMw6QMyyDL7NeEC34/Ykmfr3Xb2Pc9S+1K7HdcP00g3Eb0jIwIUS
         CaYw==
X-Gm-Message-State: AA+aEWYV4pwBltt9K8I1HqZpxYrkifcnpmrinJj6C/ujaA+fmh4I7OAQ
        DX41gcKxXwYxYc/JLhYNiOex3amPEaA2LNtuPDE=
X-Google-Smtp-Source: AFSGD/X1nRH7ENVbhNll8mZH/dqrEHIJb+gBvJ/+Z8nrwGsdAe0NJKtWzaW3p8r9FsSYWGWd4Z/eRhN4I1hllNha2z4=
X-Received: by 2002:aca:2ccc:: with SMTP id s195mr11706ois.282.1545333639183;
 Thu, 20 Dec 2018 11:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org> <20181220085923.169451350@linuxfoundation.org>
 <CADVatmMq2cNhoM0RJyuS=u_u-K9ksM1TWLeD1+ytTzVsHx=i-A@mail.gmail.com> <20181220154135.GB9962@kroah.com>
In-Reply-To: <20181220154135.GB9962@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 20 Dec 2018 19:20:03 +0000
Message-ID: <CADVatmMiwaOQ2R43CArk1s5=bxr7MUgzuDb0DfQO_LKLH_r-ZQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 21/72] locking/qspinlock: Ensure node is initialised
 before updating prev->next
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 3:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 20, 2018 at 12:19:04PM +0000, Sudip Mukherjee wrote:
> > Hi Greg,
> >
> > On Thu, Dec 20, 2018 at 9:27 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > commit 95bcade33a8af38755c9b0636e36a36ad3789fe6 upstream.
> >
> > It seems 9d4646d14d51 ("locking/qspinlock: Elide back-to-back RELEASE
> > operations with smp_wmb()") is improving the fix. Is it worth to take
> > this also?
>
> If someone could test that this really does help things out, I would be
> glad to take it :)

I can test if Will shows me how to test the improvement, but it might
be easier for him to test than showing me :)


-- 
Regards
Sudip
