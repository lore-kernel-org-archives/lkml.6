Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA25C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E420895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+OdEfMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0E420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJMP6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:58:08 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41444 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeJMP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:58:08 -0400
Received: by mail-wr1-f48.google.com with SMTP id x12-v6so15717585wru.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvZwpmp9+/p3OLf4V57aOVwKoeoTvxMJ6MD2wSfj8GY=;
        b=J+OdEfMbfmmtvlrCZRaLxKcPM5yb2kS/kyrS030M0nIJGE0xJ4vWxiJdlghTqR34TA
         aMS/NjiBC4RYJaVGr1JKX562Z2DKIV52/5amgb6cwey93IXcDeJmMInQffrk7Xpsmc90
         ztwXPLeio0KTyX+wf6SpWdM/u7SuQ/SRewD/cwm7WAJQmzD2Vggh1eiRzg+hLG9BCdZa
         D0/BmNGlHNeNyZztMQqSpOoYkzuyQo8cdxC7ra8h8QC6lL/52/o9+62oz5qa8W5j8S2n
         KajoxDAjQNvSuljE+8yCl0rhJeFk8AwV4q3VfhJfAESrhbzvgeQ1wUFMX3sTWo4o+LCd
         yf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvZwpmp9+/p3OLf4V57aOVwKoeoTvxMJ6MD2wSfj8GY=;
        b=SJ6+oNnrMfp3M/84myLDRIRB+MVp+22q+eLTby8haeoFM0qWe72I9F3Frn2Q6p+UCX
         nVdgqwHR/47eMnH+NbLShX1U/kWs74mEc4HM7+PnlbJ/Xdt8Tr/OrLyzQdzI2ukwPn1h
         CVDQkW0Fm/Zavcv6nh6NffTdBpllDxPpLnhNbEEpNiosdU4jDVLGVPJTbIBnyRbJeNCO
         J8kwW6rkN4pK99J3aQT3EH2Qx6D4w5ceHXRXwtfgWLSBb4UbKJ4/jHJuP/07EvRPLmCn
         aD4LFXgJHYxG0bNYIX45tkEdSSqXJrpsMoZ+37t72g/q2FrL1ilsumIwYf3EPYmNQKLC
         DdIw==
X-Gm-Message-State: ABuFfohAloOd5TGwTY59xUQUTNRvb854mj0rYNog3lyU4XdSPbxrmQ4J
        mSfYyIEAgXMAfVwtisoCq3YSDUrScs5B+ckl3KuYwQ==
X-Google-Smtp-Source: ACcGV60EUo2SzL/Nn4T+tmq813XTXEpB1h9BCN4W7C9qvL0ngsHz02Qn1SFrAcGGP1sO4IVQwDE5vnQAMzF4LQChEH0=
X-Received: by 2002:adf:8322:: with SMTP id 31-v6mr7720510wrd.285.1539418912784;
 Sat, 13 Oct 2018 01:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <44aa413b-cc4c-c1c5-ebc4-895d07b5a159@infradead.org>
In-Reply-To: <44aa413b-cc4c-c1c5-ebc4-895d07b5a159@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 13 Oct 2018 10:21:41 +0200
Message-ID: <CAFLxGvxEP+j07s8gnVw9DiJZeedxgrk1xtEkaXAMvkfa9HHvCw@mail.gmail.com>
Subject: Re: ubifs: WARNINGs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

On Sat, Oct 13, 2018 at 3:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> Linux 4.19-rc7, x86_64 laptop.
>
> I don't have an ubifs filesystem.  When I just modprobe ubifs and then
> rmmod ubifs, I get 2 WARNINGs from these 2 lines:
>
> static void __exit ubifs_exit(void)
> {
>         WARN_ON(list_empty(&ubifs_infos));
>         WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) == 0);
>
> Is this normal/expected?

Nah, in -rc1 I rewrote all UBIFS assert code and these two are a corner case.
I've messed up the logic, ubifs_assert(exp) is WARN_ON(!exp).
Patch sent, would be great if you could give it a try.

-- 
Thanks,
//richard
