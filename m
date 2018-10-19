Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01FBECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE0821486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="A2PRjejP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE0821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJSSfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:35:47 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37768 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:35:47 -0400
Received: by mail-vs1-f67.google.com with SMTP id r83so24954177vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27VeGjkstgB/rAvrWrvrmLOqMq29C9n9d/ioyLE95UM=;
        b=A2PRjejPB3p25531ltPOhB/uiQinxu3wUiX73pGibcw/6GOIywqOIygD0Vc08DeXi5
         84M3zRvmdTN3ykD3vBIHteAXmxM14KfbDD6B6TdKnsVTf66tvMKPu/Xr6Hhq5cLBvIXx
         8rxUMQe1xUKEoEWh13UN36NMlPzGs0dxvqP2a+Mq0GYkRjmwRSzthAw+E94dzRocjs3Z
         I35pv59qHsB029WLU+2ebHczT5H5VmQL61IYrDUNFGaggQ2n27H3LMGGsNko1bL52/Ij
         hjUK5xyaVVkIXu44Yso/XIs/WCjS8/WCmxXPH0ulYBNZuvdQUXUxL0P/fErQr1LoxCBu
         I7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27VeGjkstgB/rAvrWrvrmLOqMq29C9n9d/ioyLE95UM=;
        b=lQ91mR680NEX74sg3h1leGJShsdv+I7Q9q4V5f/xwTlpVBUUVVSq+vVOrIY4iechgx
         9TtP456/iwoLpnDQFg5Mu4NHQiH2cDynUOpch+QI3UP2TsZqdkUjA56L8SfUsB16y5Io
         pfbp9KBATv9GEsDINN6me3iEGu8NcaGmjp+SRsCI9hNqIjqRYsFvxi+c8bo8m8A3aoJo
         LHQnHmepWXZ8XpjgqOC7AuA8PqWeZhSavTlsI5STV9oXOYN824uc/OhQuoxEDJINTbcB
         4F3vGgZwfY5oR+fMe5ictIkxwNaLMC+DvRH45mytY16XfdmveHme+0mIYeD0JcH/INZL
         HFgA==
X-Gm-Message-State: ABuFfoia9pScr+hiNGCzZpfNrJZrfszu+UC4JK+c//PpmgqK90SymJxb
        nd+4GVqnMKtbTNRjX21QrXt3j4WkgTEvvPr0hoTTiQ==
X-Google-Smtp-Source: ACcGV61Yc7LOSizYpYtzdIX1DVn+ufbXJt22iCecKwO/uHmPPl9GQdri4c0gfV1JXGuLWo2K7cDMut2eHTDlg0CmGfo=
X-Received: by 2002:a67:8255:: with SMTP id e82mr14104494vsd.178.1539945017738;
 Fri, 19 Oct 2018 03:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com> <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com> <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
In-Reply-To: <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Fri, 19 Oct 2018 12:30:05 +0200
Message-ID: <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
To:     Claudiu.Beznea@microchip.com
Cc:     alexander.stein@systec-electronic.com,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 3:10 PM <Claudiu.Beznea@microchip.com> wrote:
>
> >
> > We take the normal path of sys_reboot =3D> kernel_restart =3D> machine_=
restart ...
> >
> > I added code to print the c1 register in different paths. And I-cache
> > is enabled.
> > So now I am really confused about why the patch worked.
>
> Just saying... maybe your instructions add some delay on the execution pa=
th
> and this is why it helps... try to access cp15 co-processor for read and
> write back the value you read without actually to modify it, to see if th=
is
> could be the reason: e.g.:
>
> mrc     p15, 0, r0, c1, c0, 0
> orr     r1, r1, #4096           // whatever is in r1, doesn't matter
> mcr     p15, 0, r0, c1, c0, 0
>

Yes, this also seems to work. I have over 100 reboots completed with this c=
ode.
So what could be the issue here? It seem related to the powering down
of the sdram at least.

This thread on the AT91SAM community deals with the same issue:
http://www.at91.com/viewtopic.php?t=3D25830
There the solution people chose was removing the SDRAM powering down.
But that leaves one open to the cause of the errata.

Do you have any thought on how to approach this?

> Thank you,
> Claudiu Beznea
>

Regards
Jonas


> >
> >> Best regards,
> >> Alexander
> >
> > Jonas
> >
> >>
> >>
> >>
> >
> >



--=20






JONAS DANIELSSON
Software Developer

+46 72 361 5022
Malm=C3=B6 - Sweden

ORBITAL SYSTEMS
orbital-systems.com




The information contained in this message is intended for the personal
and confidential use of the designated recipients named above and may
contain confidential and/or privileged material. If the reader of this
message is not the intended recipient or an agent responsible for
delivering it to the intended recipient, you are hereby notified that
you have received this document in error, and that any review,
dissemination, distribution, or copying of this message is strictly
prohibited. If you have received this communication in error, please
notify the sender immediately and delete this e-mail from your system.

Although this transmission and any attachments are believed to be free
of any virus or other defect that might affect any computer system
into which it is received and opened, it is the responsibility of the
recipient to ensure that it is virus free and no responsibility is
accepted by ORBITAL SYSTEMS AB, its subsidiaries and affiliates, as
applicable, for any loss or damage arising in any way.
