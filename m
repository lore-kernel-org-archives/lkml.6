Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F63DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84592081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txG1Talp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84592081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbeKWBT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:19:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36450 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeKWBT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:19:28 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so6776393ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x3w46joQSfWZTIrZEwKPYwmRbQInNl//cjVuWteg3YM=;
        b=txG1Talp4wZ7Tff3+PYAfjSEt/EREr9sAq0W14xbuUuyvI3iHv9AgFj/1YXIBjefp1
         g4fITN2l9vYuOlyebkLg6I7q1vc/WHMjLGt0Iy6IfXTX+u3iZaRczmONpfkjGTrpf+20
         EW8htlktgKKFRFT/eTUNDGhP/Ykb7u4FOUC3Y86S8iaS4O3zkK/V9Jb6aTkrs+eJO90A
         Zj71L97BUeMszoz70ybe/xYkQr91XQO0s75O9h3QU0nsF6NkffUKz6s/4rNzs9KsMldf
         mbug06m/NQMaTYW+v6ftjlPF1KLpLCM3Iw/AIBYq1VfSyAStrTtYIYyu9LdJh2HSMPWd
         e7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x3w46joQSfWZTIrZEwKPYwmRbQInNl//cjVuWteg3YM=;
        b=UvhsK8xDmOptNsMuOgkaPaX+Gp7sS83R8C3kZbPQSdS2NGHELy2F/VR1pzDGlYPI0+
         l6u66bVUTPod0Wr9WmuD2kbVZlBW4NRWALLr7tTC94vsdgwDNpULapOu4FOSAsyxhamz
         joX3MPs1yR/ZFritixrdXc7lPiuC1HJ06QTgHKPB7oCJBmr9jMCAeK4zRRWq4CBxJvac
         BEh57lht+iQxNFcCzFejEfiK3XZ9L+kUn4xbFZksYYls4NjdOp6p0zP85Me8V0cYwxTp
         Kx31UNOABXYXOfaKuVWyq9H0VMQgmCW1QbLexEJOHt+dkkwGgqHlo4ybzLHC+TpqClnf
         WYvw==
X-Gm-Message-State: AA+aEWYQyi0YxI5iC4tjNVOzy4sOSTfonTwsKpfr0rAEzDf+FR00GAqq
        YD+vP0FEYPHieehZjaliTskPtfZ4bdjKG19iqKa8GieMBkA=
X-Google-Smtp-Source: AFSGD/UMFmBGnn9A1bISTq13rnuXxZ0cgp571LR28IGXgL6dRkiQviExllM6rfUL/H/z7mBweMOwB+0SS5UcEmM7Gtc=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr8173911iom.7.1542897589126;
 Thu, 22 Nov 2018 06:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com> <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com> <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
In-Reply-To: <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 22:39:26 +0800
Message-ID: <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/11/2018 15:33, Frank Lee wrote:
> > On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 20/11/2018 14:18, Yangtao Li wrote:
> >>> use of_node_put() to release the refcount.
> >>>
> >>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>
> >> Applied, thanks!
> > Hi Daniel=EF=BC=9A
> >
> > This patch is a bit small, I will resend=E3=80=82
>
> What do you mean by 'small' ?
        pri_node =3D of_find_node_by_path(path);
        if (node =3D=3D pri_node){
                of_node_put(pri_node);

                /* The primary timer lacks IRQ, use as clocksource */
                return integrator_clocksource_init(rate, base);
        }

        sec_node =3D of_find_node_by_path(path);

Under my revision, pri_node and sec_nodeare the same thing.

Yours,
Yangtao
>
> >> --
> >>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
