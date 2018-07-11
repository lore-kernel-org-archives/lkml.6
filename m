Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA43DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7877F20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaCCXtzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7877F20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbeGKQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:14:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44051 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeGKQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:14:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id d17-v6so7514015eds.11;
        Wed, 11 Jul 2018 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NhwZLGw3nSghX6TewOHRNgOc82cBRt/NzV5Zp080cg=;
        b=CaCCXtzWCdDal5djEKUOGKyMB3gbmqj4S/hO9mXJbyUjJ+VYlNnxufwNMYpJBgj4wC
         Wc7MPyjhmoE8I9Vibb+7RV13jBrwC/ZexgmvdBpoKXQpn6hv1VPPNG63hHi90LSg6ywc
         8JOCfAGqQTH1E6Ro4WOQpLSec8OmdXK4qCSjrAW2PZqW1afy46opfbZ/ocPD51gnK/9X
         CToSv3iVmFp42t+lY7QPStXhFfAwyVzksUYExlTbuGdzmyUqm0sF6aUzN0slH45drO7u
         ul3/Cxy/4O83xAIob2jmL3r3V7zSv7yT7BgW4jApveM/hEUEP1KQbDW/hABMjaObzOxN
         Wuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NhwZLGw3nSghX6TewOHRNgOc82cBRt/NzV5Zp080cg=;
        b=rTMg0/xkNaQ6S+5ZHUX5zyuXnEUuzI4Pk1wv23vXXUNS5ZZ4xCZBdZQ4nFAgQM1WH7
         0pBqdqAAdN+eMTetHPZCLa8VgHLfSofhhDBGCDW8aFDzU/4Fry0pAwfeFPU16T3JwMgS
         98vuigoFbCAYQmuleYy2xOvZJjE4FINgbCx45Z0Khdm4yEf4KOAhq1E0oQ8NQ70dNRIA
         kXzQxvy2e1UwUg8KnYTwcubGh45Lb2j7uuSdL9kSNsQ0Ms9/c40MM43HEE28fOFWdZYb
         03CfjIXOhDCyt3Ntd18XLt0host3/JWRKb1cE4qJ/AWP9KT410iJyaW0w3CRo5m10j/t
         yH2g==
X-Gm-Message-State: APt69E25zXeaFOMtHSmG2WyGWgL+jtrxNzieo/gqo85Am+VUZYomChtI
        M4dMVV5P3ocbPEuNK5/7jfg0h3SLDoDsHAQA4Zc=
X-Google-Smtp-Source: AAOMgpejfM9y+bOKsqVadZW8VzCft1w20q/MPecjqsSbrqdPH7+NnZwXvip5cyNXrELuEL8N6qx54BYplf/+nT5oYx0=
X-Received: by 2002:aa7:d34d:: with SMTP id m13-v6mr32536284edr.143.1531325352127;
 Wed, 11 Jul 2018 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b0ee7a056eea93a7@google.com> <00000000000033f8440570585207@google.com>
 <CAF=yD-JgBPy+D2Jm7SN=-bzAfAf__pxE92qAqNWs=9EqfyLmAA@mail.gmail.com>
 <CAF=yD-LcXtF94=5Xt5zeD=AmqHxNHGP+NURazJERigA8ysBuAQ@mail.gmail.com> <20180711120753.6940b66d@redhat.com>
In-Reply-To: <20180711120753.6940b66d@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 11 Jul 2018 12:08:35 -0400
Message-ID: <CAF=yD-+VNTOqAQzOmOr-ReXSy-zOU33gN0AjZso_8jW3htya7g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
To:     Jiri Benc <jbenc@redhat.com>
Cc:     syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 6:07 AM Jiri Benc <jbenc@redhat.com> wrote:
>
> Sorry for the delayed reply, I'm working through a pile of stuff after
> being off.
>
> On Sun, 8 Jul 2018 18:58:14 -0400, Willem de Bruijn wrote:
> > Setting skb->mac_len to 0, similar to mpls_gs_segment,
> > is sufficient if the encapsulated packet is not ETH_P_TEB.
> >
> > If the packet is encapsulated at L2, __skb_pull(skb, vlan_depth)
> > has to pull the inner mac header before passing to l3 handlers like
> > inet_gso_segment.
> >
> > If that header includes VLAN tags, skb_network_protocol will
> > parse then and update the mac length in vlan_depth. So
> > hardcoding to ETH_HLEN should be fine:
> >
> > @@ -104,7 +95,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
> >         __skb_pull(skb, nsh_len);
> >
> >         skb_reset_mac_header(skb);
> > -       skb_reset_mac_len(skb);
> > +       skb->mac_len = proto == ETH_P_TEB ? ETH_HLEN : 0;
> >         skb->protocol = proto;
> >
> >         features &= NETIF_F_SG;
>
> I agree. I think my original intention was to set mac_len to 0. Which
> is obviously not done by calling skb_reset_mac_len...
>
> Strangely, skb_network_protocol does not set *depth to ETH_HLEN if it
> is 0 and the type is ETH_P_TEB, which is something I would expect it to
> do. Thus we indeed have to differentiate between the two cases before
> calling skb_mac_gso_segment.
>
> Willem, will you send the patch formally (with the htons fix)? Thanks a
> lot for the analysis and the patch!

Thanks for verifying, Jiri.

Posted as http://patchwork.ozlabs.org/patch/942588/. I forgot to cc:
you directly in git send-email, sorry.
