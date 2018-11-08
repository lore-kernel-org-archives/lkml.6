Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEB52086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkx1rbZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEB52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeKHLTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:19:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35164 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbeKHLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:19:22 -0500
Received: by mail-io1-f68.google.com with SMTP id 79-v6so13473897iou.2;
        Wed, 07 Nov 2018 17:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csWGnVVVFpNbuE1SB1MGKj094gsKUpU0jLP+zy5p7zw=;
        b=fkx1rbZweWll96uCB6mGGxOqdVUG5AtfnoE/wsCP5HokL7wd8ExT/SruncBPXNwfit
         8ZpDNEBP4aDFXqML5ID32AFAPfUqeUXmLcmj3dFM6Z+y2TJZWU+c2JkLOyFI02wzgcdB
         akatjC5JXBxtH95dqYWxRnx5APb+G1xmxm1sP6Uy8dCtKxxu2rdHBQjUNmZ2iEx6B/SF
         auCezzzqx6mhw0Bxop1ntQkgvE9RRKoiDsi8jg/93xg1ieV1UU5wr+vD63rRxeDQCGff
         Jh43Eig43oNbokrJUtw9T2Etip/AWLaJKRdtnfTDku6MS65AIAU7/PeKrWcYaXfB0nIm
         W6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csWGnVVVFpNbuE1SB1MGKj094gsKUpU0jLP+zy5p7zw=;
        b=Ejz3AJf2C8QxH0WUlI5kMTJbvZqgoyKStcSPJoA3Njrmoj8amQ9+ql9aMmAmoroVB5
         oLUwn7U/tR+5rFfOAs6nGIlLuT8tcN6xujhFxXUlJghDAe+QxYtBT97NVkzOiXJbBzdE
         ElI1zX1FCZ9wYrtUVeDcHldT+Z49O+93EFHPRp/54PgqcxGOcK3Z2bUVdLL01b+af21J
         qdn7xA6ONDr/BMD4IhEfnhlduq6vR+/+aIVdNCpiDcWVgkzYFrf0BOpesSE7BDBhRvy0
         d+iSY8kuq9Cnfmma+uCMKMhgEkJVcIRufi4UB7Y4mvqaDNm+yz9/On6NF8OIMsVMGKdH
         v2cQ==
X-Gm-Message-State: AGRZ1gJ0q8VUF9nFDKdAQBgFe5X87w6vozD3zONSy5bbsFQNjmLYp44q
        4nbe4G6O/WHJPYWrPLZt0/sHN/5O701ZyUIE5do=
X-Google-Smtp-Source: AJdET5fDyjyz1jsW1ys9dqzlrKUskYywIWHr1UwTOsBts5epKA+6TlZt4PPv389d56vHw8jsRy4sHxS+MhdlcRSvf1Q=
X-Received: by 2002:a6b:9046:: with SMTP id s67-v6mr2064167iod.295.1541641578473;
 Wed, 07 Nov 2018 17:46:18 -0800 (PST)
MIME-Version: 1.0
References: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
 <1541589617-1607-2-git-send-email-laoar.shao@gmail.com> <560b2828-cb1b-5ab5-f98b-b042a7e483f8@gmail.com>
In-Reply-To: <560b2828-cb1b-5ab5-f98b-b042a7e483f8@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 8 Nov 2018 09:45:42 +0800
Message-ID: <CALOAHbAUoWgBKSKT+vb6CaxGaUkdxvgKXHGAJNZ9G8hiWezqRQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: minor optimization in tcp ack fast path processing
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:16 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 11/07/2018 03:20 AM, Yafang Shao wrote:
> > Bitwise operation is a little faster.
>
>
> > So I replace after() with (flag & FLAG_SND_UNA_ADVANCED) as this flag is
> > already set before.
> >
> > Cc: Joe Perches <joe@perches.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 2868ef2..0167015 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3610,7 +3610,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >       if (flag & FLAG_UPDATE_TS_RECENT)
> >               tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
> >
> > -     if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
> > +     if (!(flag & FLAG_SLOWPATH) && (flag & FLAG_SND_UNA_ADVANCED)) {
> >               /* Window is constant, pure forward advance.
> >                * No more checks are required.
> >                * Note, we use the fact that SND.UNA>=SND.WL2.
> >
>
> What about reducing this to a single conditional jump ?
>
> if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) == FLAG_SND_UNA_ADVANCED)  {
>

That's better.
Will change it.


Thanks
Yafang
