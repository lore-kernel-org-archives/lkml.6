Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B3A213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrtQ2Ttw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfBYQQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:16:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:16:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so10603379wrw.3;
        Mon, 25 Feb 2019 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4mbrf4hSifC2rI+Ol4ZYxxZi3/Gzwo7T+9roZ/nN68=;
        b=mrtQ2Ttw0HcE1W54Ve/6MNuzN21yABzQvfS/uq95+5TK5nJj8I1dtR3x1MGCHv4K0X
         EmyGuSFzFaszfGAB7/4OrRi/AFNyreywM1cNyh0GFhEdjUDULkvYT+FHh5UY5iL+b8KG
         k05XdPrFbmoF1i23Uvgahzb2P9wuPpjmj50gA+fMQQZSdpj2LV2wBwZjAz29dvuG+6qO
         3GLlCRNsrEU3p23Bn1XTbJYmP2pQaVbCJISEfkWrA9duV/R+CGMskKmZ0cVZcJhAhr7s
         SmpWZZkUtu/98HDl2RXe/Omi483SPUCySbkIl+4tVW4tZS5Nl5XE+E+nBUFxB4V0s1hs
         x5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4mbrf4hSifC2rI+Ol4ZYxxZi3/Gzwo7T+9roZ/nN68=;
        b=E+wjy5lU0BLNDyHa4h4GB5gJhh+JAkm5N532L5io5v4ysFls0jLOiQ+thDmSZzB40l
         FerQhqQ9a7e4RkkH9Jg7uWH2FNtu14MJML/wX8iWy9s6Pincml3Jw1keEIvoLORGIq9L
         aNI8YpWHZZnd3ULUCsn1dilJfePoOW2sYnD+D8l68dNmlm4pEKQwsiqmLYHDYA0ub6WV
         oT7D+nwDykrtjbJJItdFo7PmKJL/mmJs7dyV0zyN4IvTciasWP3+2nhkjmnOgS+m4iUA
         D9ZG65X8D5wZCXoIlGMnqtEFarDjd0UnqniMrf61QyiPGq0kNwa4DwmIEIesoosGozCk
         FKGQ==
X-Gm-Message-State: AHQUAuYP/UdPRRPC6m0WLEp52cnpKaxOZXI0ecMj3CRdrFsNHExqNkCf
        LferCYD98qZMWe/6krnyhg2m3oq0wzuAVz5YJaQ=
X-Google-Smtp-Source: AHgI3IYt7eNDKgd5XdyZm7ojxZk7XFqu5My/00c7b+uwPi2o2NsKzN9bEhqe4K5qjjlFTS48R+hBqrQvXPHnElrINY8=
X-Received: by 2002:a5d:6288:: with SMTP id k8mr14024402wru.173.1551111365600;
 Mon, 25 Feb 2019 08:16:05 -0800 (PST)
MIME-Version: 1.0
References: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
 <20190225124614.GB30699@hmswarspite.think-freely.org> <CADvbK_cC4q1D5w1AHAVQjCTW4Pm6H+-ZOVg7xCp+eiOkkRJ8SQ@mail.gmail.com>
 <20190225140720.GC30699@hmswarspite.think-freely.org>
In-Reply-To: <20190225140720.GC30699@hmswarspite.think-freely.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 26 Feb 2019 00:15:54 +0800
Message-ID: <CADvbK_dtfZnKQvWO5CMaVfaUg+yZUGH3TVN2xkWrqz7L+Z_MGQ@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 10:08 PM Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Mon, Feb 25, 2019 at 09:20:44PM +0800, Xin Long wrote:
> > On Mon, Feb 25, 2019 at 8:47 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> > >
> > > On Mon, Feb 25, 2019 at 07:25:37PM +0800, Xin Long wrote:
> > > > sctp_hdr(skb) only works when skb->transport_header is set properly.
> > > >
> > > > But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()
> > > >
> > > > skb->transport_header is not guaranteed to be right value for sctp.
> > > > It will cause to fail to check the checksum for sctp packets.
> > > >
> > > > So fix it by using offset, which is always right in all places.
> > > >
> > > > Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
> > > > Reported-by: Li Shuang <shuali@redhat.com>
> > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > > ---
> > > >  include/net/sctp/checksum.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
> > > > index 32ee65a..1c6e6c0 100644
> > > > --- a/include/net/sctp/checksum.h
> > > > +++ b/include/net/sctp/checksum.h
> > > > @@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
> > > >  static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
> > > >                                       unsigned int offset)
> > > >  {
> > > > -     struct sctphdr *sh = sctp_hdr(skb);
> > > > +     struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
> > > >       const struct skb_checksum_ops ops = {
> > > >               .update  = sctp_csum_update,
> > > >               .combine = sctp_csum_combine,
> > > > --
> > > > 2.1.0
> > > >
> > > >
> > > Shouldn't you use skb_set_transport_header and skb_transport_header here?
> > you mean:
> > skb_set_transport_header(skb, offset);
> > sh = sctp_hdr(skb);
> > ?
> >
> > There's no place counting on here to set transport_header.
> > It will be a kinda redundant job, yet skb is 'const'.
> >
> I'm not sure what you mean by "theres no place counting here".  We have the
> transport header offset, and you're doing the exact same computation that that
> function does.  It seems like we should use it in case the underlying
> implementation changes.
1. skb_set_transport_header() and sctp_hdr() are like:
skb->transport_header = skb->data - skb->head;
skb->transport_header += offset
sh = skb->head + skb->transport_header;

2. in this patch:
sh = (struct sctphdr *)(skb->data + offset);  only

I think the 2nd one is better.

I feel it's weird to set transport_header here if it's only for
sctp_hdr(skb) in here.

As for "underlying implementation changes", I don't know exactly the case
but there are quite a few places doing things like:
*hdr = (struct *hdr *)(skb->data + hdroff);

I'd think it's safe. no?

>
> I understand what you are saying regarding the use of a const variable there,
> but perhaps thats an argument for removing the const storage classifier.  Better
> still, it would be good to figure out why all paths to this function don't
> already set the transport header offset to begin with (addressing your redundant
> comment)
The issue was reported when going to nf_conntrack by br_netfilter's
bridge-nf-call-iptables.
As you can see on nf_conntrack_in() path, even iphdr is got by:
   iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
It's impossible to set skb->transport_header when we're not sure iphdr
in linearized memory.
