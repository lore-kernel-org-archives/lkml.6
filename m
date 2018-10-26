Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F4ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A62085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAKqk9qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19A62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeJ0FEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:04:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38087 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeJ0FEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:04:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id r22-v6so2730099qtm.5;
        Fri, 26 Oct 2018 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2EqpVwwRHYa9CYLap5UB3RrJPc4qSO0d23QDEEqDXYs=;
        b=ZAKqk9qc/xKY2IgOWoFgKXUa/TxIduoxbNEuDeQJm2urKhlwHBEuqScS/1fCvRjnKe
         B+MhrRJrZiE+dvG5yWZTVLOYdtRl0GgJqHPEEafuWNpfF2SVabs9ULFzeJI2v7M+a2DX
         MZFfqcrnR6/8fpaX5JqH7yi1Gr8+K/jWylP6HF4BphdvAay02s2SY1gXQ9RwfBUpEU9T
         Z9iK7qjzCgkgDGbPDWdCpfrM7+kCtVohBzATs1WXuDtgR9sJlXR72f4/xAZOAzN22D2B
         tk1aB9rUo0d4EI/wjqKV5vSzkv3nYaOFuselLnWq1Iwgs8qXZCoInvarifMvl5ofkUal
         kKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2EqpVwwRHYa9CYLap5UB3RrJPc4qSO0d23QDEEqDXYs=;
        b=GZgEdoA0UD590t8jAr2Zc6nd9XC4Xsx7NIm1D233ZsAB8oy7ZjyWChyqoc4Req0RPV
         QX8lQ7k+juIMLAAO4WZhFgsTPDq/4+L6kCiR7NbLmE97iqv61IVuCQWJnZQQv+yCcmR2
         LiQK3Lcl5ohxeIlFwVxCIhZBUXeFnaadHANHdIMT2WZHJ2jVqJqzJr6j9v+Z4GyIhWtO
         XdxkRLKMB4Xbv6juA9jGV+GI5KDsg+cssVs/K76iasUkDbEcIF4j2WMQD7gZ69zISzny
         xQdHmFM4FyBcZYOg+VwZdREEGT3jW3PAXp+NYTy/vJ2C0Xrirx6EGmiLxVUlxtcUp+R8
         oJ5g==
X-Gm-Message-State: AGRZ1gLhPjVEVWtgM9KoG+dGeKF+jVkSMblRLw4nBKrNJNgpgbccHyVj
        fYyTcvlSjCONZDJijbuusI/kXPkMBkm5qx5Jbfdyxw==
X-Google-Smtp-Source: AJdET5dPZgC3dcC5K8lYdDngde3k3xZJoz89WGfSGJbSlwW0y1IQ25Bq9rks8sTQ/ku+6mwQ9Bk5t1FWMFI0TikDno4=
X-Received: by 2002:ac8:97:: with SMTP id c23-v6mr4594669qtg.376.1540585545106;
 Fri, 26 Oct 2018 13:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name> <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
In-Reply-To: <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Fri, 26 Oct 2018 13:25:33 -0700
Message-ID: <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
To:     hkallweit1@gmail.com
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:21 PM Heiner Kallweit <hkallweit1@gmail.com> wrot=
e:
>
> On 26.10.2018 21:26, Oleksandr Natalenko wrote:
> > Hello.
> >
> > I was excited regarding the fact that v4.19 introduced CAKE, so I've de=
ployed it on my home router.
> >
> > I used this script of mine [1]:
> >
> > # bufferbloat enp3s0.100 20 20
> >
> > to do its job on the VLAN interface, where 20/20 ISP link is switched f=
rom the home switch. Basically, it just follows [2] with simple bandwidth r=
estriction and egress mirroring using ifb.
> >
> > Then I thought it would be nice to run speedtest-cli on one of the comp=
uter in the home LAN, connected to this router. Download stage went fine, b=
ut immediately after upload started I've got a panic on the router: [3] (so=
rry, it is a photo, netconsole didn't work because, I assume, the panic hap=
pened in the networking code). I rebooted the router and tried once more, a=
nd got the same result, again during upload stage. Then I rebooted again, r=
eplaced CAKE script with my former HTB script, and after running speedtest-=
cli a couple of times there's no panic.
> >
> > Before running speedtest-cli I was using CAKE for a couple of days with=
out generating much traffic just fine. It seems it crashes only if lots of =
traffic is generated with tools like this.
> >
> > My sysctl: [4] and ethtool -k: [5]
> >
> > So far, I've found something similar only here: [6] [7]. The common thi=
ng is r8169 driver in use, so, maybe, it is a driver issue, and CAKE is jus=
t happy to reveal it.
> >
> > If it is something known, please point me to a possible fix. If it is s=
omething new, I'm open to provide more info on your request, try patches et=
c (as usual).
> >
> It seems to be the same problem as described here: https://bugzilla.kerne=
l.org/show_bug.cgi?id=3D201063
> As I commented in bugzilla, the GPF in dev_hard_start_xmit and the values=
 of R12/R15 make me think
> that a poisoned list pointer is accessed. It's so deep in the network sta=
ck that I can not really
> imagine the network driver is to blame. One screenshot attached to the bu=
g report shows that the
> GPF also happened with the igb driver. Most likely we find out only once =
somebody spends effort
> on bisecting the issue.
> d4546c2509b1 ("net: Convert GRO SKB handling to list_head.") and some sub=
sequent changes deal with
> skb list processing, maybe the issue is related to one of these changes.

Can you repeat your test, disabling gro splitting in cake?

the option is "no-split-gso"

>
> > Thanks.
> >



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
