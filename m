Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2FF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd9GiRBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfBYNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:20:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBYNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:20:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so9869074wrs.13;
        Mon, 25 Feb 2019 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42P7JrA69uwhHiTSP2vRzKfe5v7Rl8PfBK+++Ng0/k8=;
        b=Jd9GiRBkLpuE2hi9wUfER2lFlMEExd5wcUaNDLj3HhDEKOAlexvJqGBAmt37pHfogO
         TjaJtylP5czejxmbsQFnSXqapGwWI6QihVBSmBkAFFUc0l+p5Rj4cHyPYAX9h4QMOn6M
         cO090KStyXNZBGGp4P/9Hx+UXaLQi5eZzifKCSUuPmIzOc3LaovbNcQMfFOp/IlMNELC
         7Sye7JQIqJRlHfZtNcV4bwsI6ad6ggIi+K90Y93yZVwMPUmXRZm2x7aqJ4gyO0ZT7syr
         i69kQ02JSt2dcyu3VOXY5nu/rXmCKCxrrxlz6foYHW7K3j5Jv7U/kCxG6KF2H2dGDAnw
         KeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42P7JrA69uwhHiTSP2vRzKfe5v7Rl8PfBK+++Ng0/k8=;
        b=hQM5b3LVNa+5U4IsoWwX6mv3Um5srEALBpHPginYSydA79li0x/t7eC8ZBe/un7TOX
         h7Bea1CM35Wuv4R7VF+f29yYIVKQ0OzD3LgoUHybSD1iThdoFCMuxnZHw6j8um7fFfjh
         mQ6qsyORWLCHKgKgHfveT5grT4mOA5px8F0NzBtAs0U65Jdl1zFWnlDZ7FbDB/+G2y74
         WDEO3qENyOtLu5AdIIppovgiFDTrgF3zZ/BZdl7I96neSkHJXSZY6Frcr8HPx/qNEA59
         JdS9MdSZ7o6jI+aN7pzjUXMOiArIT98Y50fVZo3MoKoX/EJ3lStaFyWdC1V8246GL27U
         Ktzw==
X-Gm-Message-State: AHQUAuaE97OKLOIOOW/B45Njnfy893Sx1CVybh1lWcld7AaJ2606LWMQ
        pEofihiUZqU8SVJNzMg6Wuh02+Pzvo1ntFABxck=
X-Google-Smtp-Source: AHgI3IaaBIMbhfc+lftcvF/Zh5vDGYnKQVsveAMuijj85TFYCy8hftRjB/hAguW+ncg4vRnRLb1Z8tC+GBm168Ts8xE=
X-Received: by 2002:a5d:6288:: with SMTP id k8mr13408646wru.173.1551100855319;
 Mon, 25 Feb 2019 05:20:55 -0800 (PST)
MIME-Version: 1.0
References: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
 <20190225124614.GB30699@hmswarspite.think-freely.org>
In-Reply-To: <20190225124614.GB30699@hmswarspite.think-freely.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 25 Feb 2019 21:20:44 +0800
Message-ID: <CADvbK_cC4q1D5w1AHAVQjCTW4Pm6H+-ZOVg7xCp+eiOkkRJ8SQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: get sctphdr by offset in sctp_compute_cksum
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem <davem@davemloft.net>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 8:47 PM Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Mon, Feb 25, 2019 at 07:25:37PM +0800, Xin Long wrote:
> > sctp_hdr(skb) only works when skb->transport_header is set properly.
> >
> > But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()
> >
> > skb->transport_header is not guaranteed to be right value for sctp.
> > It will cause to fail to check the checksum for sctp packets.
> >
> > So fix it by using offset, which is always right in all places.
> >
> > Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
> > Reported-by: Li Shuang <shuali@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  include/net/sctp/checksum.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
> > index 32ee65a..1c6e6c0 100644
> > --- a/include/net/sctp/checksum.h
> > +++ b/include/net/sctp/checksum.h
> > @@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
> >  static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
> >                                       unsigned int offset)
> >  {
> > -     struct sctphdr *sh = sctp_hdr(skb);
> > +     struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
> >       const struct skb_checksum_ops ops = {
> >               .update  = sctp_csum_update,
> >               .combine = sctp_csum_combine,
> > --
> > 2.1.0
> >
> >
> Shouldn't you use skb_set_transport_header and skb_transport_header here?
you mean:
skb_set_transport_header(skb, offset);
sh = sctp_hdr(skb);
?

There's no place counting on here to set transport_header.
It will be a kinda redundant job, yet skb is 'const'.
