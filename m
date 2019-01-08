Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD64C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0FE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oz3EqEuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAHXAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:00:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35667 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAHXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:00:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so4224230lfc.2;
        Tue, 08 Jan 2019 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqVKiaumFqDCnajS3YPLWJ/gLAjmJXW0r/JzDCtZcno=;
        b=oz3EqEuh8sXDbMVHGtYXEf4Wl42yKRVUdaPlbmGyriqdEZHcmBdJnDgLAgsXvm09Ym
         1jbU9ERuYRRcnuf3H3qC2apl9dBea9eepj6FnNHqb/TbUmOTWqbDz8h8kkSUGrjCzP3G
         T5TjaiZtielK+DBC/P+TPHtLykzShkomABZbp7KP+6MxTrEFfAmjAWfJkgMKM4uoT65G
         utOeyh4HEeRhWjUPp2nC2/RauW7Uy6dXgpe/7IvmrVKXJcV5fmlTchdivWDv4JFdHEMj
         QxHm4ldvHpIWltPbpLjTmCfVLLSox6F0w3uzzsxUN0X+xMD+d8PzHNF2ddfVYuxJVG1V
         xv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqVKiaumFqDCnajS3YPLWJ/gLAjmJXW0r/JzDCtZcno=;
        b=CzEsuuCLp9LQUppvIXAmRuL+tbYpUQ69DUps3ejt/Fq4CU1PgBNP+Qln2cXyyT7tFn
         T9goP+HrDh1lc9GYuuPOuO+C/6Gn80S/H86Q3pvoP25qCxgqmd2z10Qu5PLQ5hiqW7rL
         9UcNcYVVBC2Ksh/ktTke4cheTXfahjlPU7Qluo1x7v8zHPkxISHA4wYlach4cCs5FYZB
         yO1A47fS98961Gj6E1jo5wcRgp/NMHJMVQvCuj47Y29GBXU08zUpYdFblZWBjZvfbEYO
         UoCjAbXJTuMVoCA6DxpqL5SYLqBQcqF2zAoxwEmzTT5IaU3LXtKTFLRIVrd2WlAnkDGd
         UG+g==
X-Gm-Message-State: AJcUukf9EJPdI2U3l27SNDhyqvwlKlb5K4yS+AqLzWIb0vA8xJBgMQ2v
        yk0vXlBwnO4hHaWSX+Eohq6eQpoH4LrTzq2deZ8=
X-Google-Smtp-Source: ALg8bN6J4pcZBoZP1VbUCrnD4X7lkolwmamfiBieAqPvNRdYVguqMQrq8l01jhmc0EKhHBvXvJRgy9edywh9huiIwko=
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr1006952lfg.93.1546988414455;
 Tue, 08 Jan 2019 15:00:14 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
 <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
 <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com> <20190108145112.65fc554f@hermes.lan>
In-Reply-To: <20190108145112.65fc554f@hermes.lan>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 9 Jan 2019 00:00:03 +0100
Message-ID: <CAA85sZt=mrqprwkKLGbv2UMy6vQb0XSc58YrWvqxzK4yhdbpGQ@mail.gmail.com>
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in 4.19.13)
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 11:51 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 8 Jan 2019 23:10:04 +0100
> Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > On Sun, Jan 6, 2019 at 11:21 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > [Sorry for the repost, screwed up the netdev address...]
> > >
> > > Hi,
> > >
> > > Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.
> > >
> > > My firewall (which also runs the dhcpd) runs VM:s and it does this by
> > > having physical
> > > interfaces attached to bridges - which the VM:s in turn attach to.
> > >
> > > Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
> > > seen - a response is sent but
> > > it never enters the interface attached to the bridge.
> > >
> > > Basically:
> > > VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
> > > dhcpd eno1 -> siwtch and... gone.
> > >
> > > Any clues?
> > >
> > > All the nics are handled by ixgbe
> >
> > So, doing similar tests at work with other drivers works - could it be
> > related to the mac address filter that was added?
> > I don't *really* use VF:s though... (can't really find anything else atm)
> >
> > Will try to test, but the VM:s on this machine is in use.
>
> The default MAC address of the bridge device is the first device assigned
> to the bridge.  Remember most VF interfaces will only allow single MAC address
> and no promiscious mode.

Yeah, I'm not running any VF:s and it just seems like the responses
are dropped somewhere

when looking at "git log v4.19...v4.20
drivers/net/ethernet/intel/ixgbe/" nothing else really stands out...
The machine is also running NAT for my home network and all of that
works just fine...

I started with tcpdump, prooving that packets reached all the way
outside but replies never made it, reboorting
with 4.19.13 resulted in replies appearing in the tcpdump.

I don't quite know where to look - and what can i do to test - i tried
disabling all offloading (due to the UDP
offloading changes) but nothing helped...

Ideas? Patches? ;)
