Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD958C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF0C11ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DE120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHaVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:34:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:34:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so11864825wrc.13;
        Fri, 31 Aug 2018 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QoZGT2HFme8Q3ztIq1Z9OsqVbgIPLDBdFi3J7NpRs8=;
        b=XF0C11ubjT525Fjlh+iMur/yKO8SB6/A48UaE3m+rWK5mVystgjKFW6RK7DXOLUqWG
         a8kRnvQSZP4PA+OEz3hKJIqOzeyZ6z1IqSMSr38mULj5kKE1UMVE6vTsnDLzt5Ovc5FJ
         kJWWONphnSUUG5Y4/MgjsOe6nX7Lvlv7Udc3t8FWTqxwqqVBy6QB2u7ahmyF9uhpM/rY
         Z3JqwbqLcdg1xXOW3GR8H/UdOQ67wp9oi3QS44maMVbFgiGHpJucJIdjl76QZzCtVd7/
         r4vjsvyquC9dOjhbsTjIam9f2v4XAOW97zgXQCFq46/2vEsAwSDgh2c84uQ0aZCwWfaZ
         7Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QoZGT2HFme8Q3ztIq1Z9OsqVbgIPLDBdFi3J7NpRs8=;
        b=kutmAOl7eByqA69FgwF3ONIfmWnGTGW9TkpgyOMdN4uqnkrvOCGf0lpxQmCdQc+Yc6
         LRniLDvJKRc+nXmLWm0I/6wTekSug30XEYA0wVn9EVTM9qp2JtF08DXBMK9zcF4Zxqp7
         lM4TGNbj+xnOjvncGckZpXqpysv4X8dCIqdEzI1BASygZ/gNS40SVXc1zelJUqlgp3Bw
         Eay20FIO6nRaRahR2/ciYdsL19FD1JxG7PjMhQim8c/gWlJo5ahZYc83HYCb1jMcNz7r
         q+myQqMVB6DForMoseUPBw1CUokLWXJ7nphzt1pxkzsvkyWIem39EFkwO/ovXKRH1rLY
         muVA==
X-Gm-Message-State: APzg51AFNvNtSPMVstyHEfmVk17kDRSFe4KGCUnFM8mLQgY7sgEqRhhp
        BF8N2krV69iUVsrFM7ehovce98zgM+D7P0NeZOw=
X-Google-Smtp-Source: ANB0VdYyrpwS2EK3SjuzAv4n+1rqG4idukUECmINHnduvypuWusmcGpZNCpkbx1U9Jac8TVY5lPnWyNAqT28K0rSskI=
X-Received: by 2002:adf:82c3:: with SMTP id 61-v6mr11972348wrc.131.1535736336582;
 Fri, 31 Aug 2018 10:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
 <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
 <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
 <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com> <CAK8P3a3q_rY6VHwX9xQ9VMNC_4EmJLKzzDPL28SE13qNHX7=aA@mail.gmail.com>
In-Reply-To: <CAK8P3a3q_rY6VHwX9xQ9VMNC_4EmJLKzzDPL28SE13qNHX7=aA@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 31 Aug 2018 22:55:25 +0530
Message-ID: <CA+sq2CdrNDDhsfHoGiXzrJgfUXirEZjkxYcBOvi07jvJgtnnHQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Aleksey Makarov <amakarov@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 7:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 30, 2018 at 8:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Thu, Aug 30, 2018 at 7:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > > On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > > Any PCI device here irrespective in what domain (kernel or userspace)
> > > > they are in
> > > > use common mailbox communication. Which is
> > > > # Write a mailbox msg (format is agreed between all parties) into
> > > > shared (between AF and other PF/VFs)
> > > >    memory region and trigger a interrupt to admin function.
> > > > # Admin function processes the msg and puts reply in the same memory
> > > > region and trigger
> > > >    IRQ to the requesting device. If the device has a driver instance
> > > > in kernel then it uses
> > > >    IRQ and userspace applications does polling on the IRQ status bit.
> > >
> > > What is the purpose of the exported interface then? Is this
> > > just an abstraction so each of the drivers can talk to its own
> > > mailbox using a set of common helper functions?
> > >
> >
> > Yes, that's correct.
> >
> > In kernel there will be a minimum of 3 drivers which will use this
> > mailbox communication.
> > So instead of duplicating APIs and structures in every driver, we
> > thought of adding them in this AF driver and export them to ethernet
> > and crypto drivers.
>
> Ok. My feeling is then that the API is fine, but that it should not
> be part of the AF module but rather be a standalone module.
>
> My comment about the generic mailbox API no longer applies
> here: you don't have a single shared mailbox hardware interface,
> but each device has its own mailbox register set, so there
> is no point in setting up a separate device for it, but I see
> no need for creating an artificial dependency on the AF
> driver. E.g. in a virtual machine that only has one ethernet
> interface, you otherwise wouldn't load that driver, right?
>
>          Arnd

Good point, thanks for catching this.
Will look into this and post a v2 series.

Thanks,
Sunil.
