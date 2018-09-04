Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92297C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3F7206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc7VwYw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3F7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIDTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:51:18 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:40790 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIDTvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:51:17 -0400
Received: by mail-oi0-f51.google.com with SMTP id l202-v6so7459696oig.7;
        Tue, 04 Sep 2018 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ws9pxqv6QPzhTuWpIFcH5zHXu80OyCeK9HqxA+9OUnc=;
        b=Fc7VwYw2zOlQH+/lKdZDdo7+ZSTuL9G29BByBN0nQBmY4AsB0U0KRPmXVmgssD6Z2W
         CR6lWJYUNFkqTLN092RwPm100FmUo/5LmI5MEF+Hzsag0yu+mftZgn2+NC0urv+vCPx3
         iesaJDcicUSfULAgQ2wIEVOgAyN7pDPe6euo1OgwScksks/EP+KaMKXp8mLR9pHh7C5A
         0HUoHXixA7APzizCGITvH/U+z4nZA1MoLOmi0a2s6apGvT6KKuaspzO43hx/8OfmSqIQ
         z6/YpNs9yChYak0fapoN0WQF6XM2dKBsg+sKfngDaYeclkdySu0OtzXurFi/SyM3OdpF
         MVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ws9pxqv6QPzhTuWpIFcH5zHXu80OyCeK9HqxA+9OUnc=;
        b=QzDWMA0A2AKifFFYGruVbfHqfDLLX5LCiaLDDiY0zO2QXtQEw/ljUtFnUW6zRO0OP/
         sic/FQLW7KM/u3jYKsm3pSiBnUeeeRd1adyfeKDxAbN1TMzJ1kQe1PyA+oF3Yy5IiuZ6
         nbOn4MMUKKztyKyBf65cFgrXYrGdx/i9tvKYfl3UkQxK98EwTuvSM+wuDyawYHKKx3WQ
         SVsKqrodxAFP0DpOj2m91/XqeM31omkiNrCBHvGRyJxAXk4rSYws5bUKIlHKqPbC6bJC
         ci3VX0ZmXxpdM//j6fKzKORYhhyWGur1Bl8/5z+OG+7VgdBvOR2tVD9yvmP80KfZmU10
         Kk5g==
X-Gm-Message-State: APzg51BY5zNWlnXghMQ7+UTWQbO+1flNKhSuN32V7WYcOwVRqMlAlLXH
        A3o3LrBYYbyDsNE1dyStR1B4+KaEfzEtO0jn+4o=
X-Google-Smtp-Source: ANB0VdbTRJ838D3t+MLOkmGj7ZCTl5P8K1vT6b+j+6h47UUWZhEHHYu9QtenuxtWGLUhsP3TsSmRXM6DLIHWFlUQGVI=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr26811065oia.198.1536074742610;
 Tue, 04 Sep 2018 08:25:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2b4d:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:25:42 -0700 (PDT)
In-Reply-To: <CAOMZO5Bvj=kB8m7DcX2vSLr3e0_uW-CnURtwM71YJ=NWT+DCgQ@mail.gmail.com>
References: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
 <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk> <AM6PR04MB5158CB868A4E2AD5AFC5B476E3090@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <CAOMZO5Bvj=kB8m7DcX2vSLr3e0_uW-CnURtwM71YJ=NWT+DCgQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Sep 2018 12:25:42 -0300
Message-ID: <CAOMZO5BEadx1FfqqMHK16s5B3Ob6UaGwgL+fqg5wHP_WHDVcPw@mail.gmail.com>
Subject: Re: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus and Greg,

On Wed, Aug 29, 2018 at 10:57 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Thanks for reporting.
>
> Commit 157bcc06094c3 ("ARM: imx_v6_v7_defconfig: Select ULPI support")
> was meant to be applied for 4.18 only.
>
> I think we should revert it from earlier stable versions.

Yes, the simplest fix is indeed to revert this commit from the older
stable trees.

I have sent the revert patches for 4.4, 4.9, 4.14 and 4.17 stable trees.

Thanks
