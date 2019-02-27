Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2697B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enUuXHpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfB0Mxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:53:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40611 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfB0Mxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:53:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so17840746wrp.7;
        Wed, 27 Feb 2019 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TZ0yC22InZNv+GKxU9JoaRo9AuTNdd2AlCCZk59A34=;
        b=enUuXHpygSoRfF3yJx+VIz28sso2Ti7cwEfY6bz9YS+BdrTgLZHdYJNE59tL/qy2bg
         fhI+S4fCrrttdgCKLL/ikopnGKMSqR3GsLfGM80kwjE87mnjjjvIt3LfgLtH1JYqcZQM
         5jsDYGilIswP7Pk2tmy12OOljrbLRJyXbeGYx87IkjMfgwfizZE/mILSTDcGWSmyGZUz
         /NDJVqBdT6zjuehkTeEbKvUC3/XtrCu7663ojorH9JUMfWHhqEBVmEoQ7ZPtFJRZ8v6D
         ED/fgx2R+utOU/13GgMXmUnt8Mcp9mhdSUYkTh4yM3mTQ15rJfDkTpXaFceXTAJ8FRDk
         07tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TZ0yC22InZNv+GKxU9JoaRo9AuTNdd2AlCCZk59A34=;
        b=Xiu0LQ5VOVd87+oG5cfXaoni5zIR5vGEsa512L8oieM3ZP2prLVEVNalbkimzeF2VF
         jbmkgIOylHIrqXn4URFNATId2z9kAGAzCBs3q9SqVTymNiNBlsdna9rxLz33DMuL0Ixb
         CmTflLQsB/Z+f8AN+zRDmB/NRGgDdRmLBtaUPW41eHSRpsfpEqHenFF/0lAwb0jQMudS
         ErEaI8aGPKs0GFw4V0KU3kA+43euSbKmM1ofLnomopD7TgVJuL8BNhjY0WOIfSafMDqj
         nLFbAYE7Ra597OQb6CJB1KDOCv+1EFIFrCH54eDGj8hEUAxhgwCVI4sujWaz4SXyBcFV
         Xykg==
X-Gm-Message-State: APjAAAXY1aLxB2uC7qO1mCgJqxLkZPav8X0pCdRmmuzFa7fmlurD2aBK
        CyENf+CnvKjUhbjrunRZXQhz4gt2e2ymC+yUYGc=
X-Google-Smtp-Source: APXvYqwLPIlYxG5EUmXERd+bR0S9+6ncOfCNO3FQLwzLhqdDO7BuQCUeEbLFPQRxKayS3Z1Rwv2G9pYJQXi+yxh/l/g=
X-Received: by 2002:adf:c3c5:: with SMTP id d5mr2239697wrg.308.1551272017720;
 Wed, 27 Feb 2019 04:53:37 -0800 (PST)
MIME-Version: 1.0
References: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
 <20190225124614.GB30699@hmswarspite.think-freely.org> <CADvbK_cC4q1D5w1AHAVQjCTW4Pm6H+-ZOVg7xCp+eiOkkRJ8SQ@mail.gmail.com>
 <20190225140720.GC30699@hmswarspite.think-freely.org> <CADvbK_dtfZnKQvWO5CMaVfaUg+yZUGH3TVN2xkWrqz7L+Z_MGQ@mail.gmail.com>
 <20190226122902.GA13064@hmswarspite.think-freely.org>
In-Reply-To: <20190226122902.GA13064@hmswarspite.think-freely.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 27 Feb 2019 20:53:26 +0800
Message-ID: <CADvbK_cFyjd5T-rrZTBaZCNU0RVJMHd_ouuCE-kKpSWoMpFJog@mail.gmail.com>
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

On Tue, Feb 26, 2019 at 8:29 PM Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Tue, Feb 26, 2019 at 12:15:54AM +0800, Xin Long wrote:
> > On Mon, Feb 25, 2019 at 10:08 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> > >
> > > On Mon, Feb 25, 2019 at 09:20:44PM +0800, Xin Long wrote:
> > > > On Mon, Feb 25, 2019 at 8:47 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> > > > >
> > > > > On Mon, Feb 25, 2019 at 07:25:37PM +0800, Xin Long wrote:
> > > > > > sctp_hdr(skb) only works when skb->transport_header is set properly.
> > > > > >
> > > > > > But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()
> > > > > >
> > > > > > skb->transport_header is not guaranteed to be right value for sctp.
> > > > > > It will cause to fail to check the checksum for sctp packets.
> > > > > >
> > > > > > So fix it by using offset, which is always right in all places.
> > > > > >
> > > > > > Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
> > > > > > Reported-by: Li Shuang <shuali@redhat.com>
> > > > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > > > > ---
> > > > > >  include/net/sctp/checksum.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
> > > > > > index 32ee65a..1c6e6c0 100644
> > > > > > --- a/include/net/sctp/checksum.h
> > > > > > +++ b/include/net/sctp/checksum.h
> > > > > > @@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
> > > > > >  static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
> > > > > >                                       unsigned int offset)
> > > > > >  {
> > > > > > -     struct sctphdr *sh = sctp_hdr(skb);
> > > > > > +     struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
> > > > > >       const struct skb_checksum_ops ops = {
> > > > > >               .update  = sctp_csum_update,
> > > > > >               .combine = sctp_csum_combine,
> > > > > > --
> > > > > > 2.1.0
> > > > > >
> > > > > >
> > > > > Shouldn't you use skb_set_transport_header and skb_transport_header here?
> > > > you mean:
> > > > skb_set_transport_header(skb, offset);
> > > > sh = sctp_hdr(skb);
> > > > ?
> > > >
> > > > There's no place counting on here to set transport_header.
> > > > It will be a kinda redundant job, yet skb is 'const'.
> > > >
> > > I'm not sure what you mean by "theres no place counting here".  We have the
> > > transport header offset, and you're doing the exact same computation that that
> > > function does.  It seems like we should use it in case the underlying
> > > implementation changes.
> > 1. skb_set_transport_header() and sctp_hdr() are like:
> > skb->transport_header = skb->data - skb->head;
> > skb->transport_header += offset
> > sh = skb->head + skb->transport_header;
> >
> > 2. in this patch:
> > sh = (struct sctphdr *)(skb->data + offset);  only
> >
> > I think the 2nd one is better.
> >
> > I feel it's weird to set transport_header here if it's only for
> > sctp_hdr(skb) in here.
> >
> > As for "underlying implementation changes", I don't know exactly the case
> > but there are quite a few places doing things like:
> > *hdr = (struct *hdr *)(skb->data + hdroff);
> >
> > I'd think it's safe. no?
> >
> Safe, yes, it just doesn't seem right.  I know you've pointed out several places
> below that rapidly compute transport offsets in a one-off fashion, but at this
> same time, the other primary transports (tcp and udp), all seems to use the
> transport header to do their work (linearizing as necessecary, which sctp also
> does in sctp_rcv, at least in most cases).
> > >
> > > I understand what you are saying regarding the use of a const variable there,
> > > but perhaps thats an argument for removing the const storage classifier.  Better
> > > still, it would be good to figure out why all paths to this function don't
> > > already set the transport header offset to begin with (addressing your redundant
> > > comment)
> > The issue was reported when going to nf_conntrack by br_netfilter's
> > bridge-nf-call-iptables.
> > As you can see on nf_conntrack_in() path, even iphdr is got by:
> >    iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
> > It's impossible to set skb->transport_header when we're not sure iphdr
> > in linearized memory.
> >
> But if the skb isn't linearized, computing the transport header manually isn't
> going to help you anyway.  You can see that in skb_header_pointer.  If the
> offset they are trying to get to is outside the bounds of the length of the skb
> (i.e. the fragmented case), it calls skb_copy_bits to linearize the needed
> segment.  It seems we should be doing something simmilar.  In most cases we are
> already linearized from sctp_rcv (possibly all, I need to think about that). All
> I'm really saying is that by using the skb apis we insulate ourselves from
> potential changes in how skbs might work in the future.  I'm not strictly bound
> to setting the transport header, but we should definately be getting the
> transport header via the skb utility functions wherever possible.
Okay, I will change to fix it with the below patch if you agree.
I've confirmed this won't affect netfilter.

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c
b/net/netfilter/nf_conntrack_proto_sctp.c
index d53e3e7..6b53cd2 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -343,7 +343,9 @@ static bool sctp_error(struct sk_buff *skb,
                        logmsg = "nf_ct_sctp: failed to read header ";
                        goto out_invalid;
                }
-               sh = (const struct sctphdr *)(skb->data + dataoff);
+               /* sctp_compute_cksum() depends on correct transport header */
+               skb_set_transport_header(skb, dataoff);
+               sh = sctp_hdr(skb);
