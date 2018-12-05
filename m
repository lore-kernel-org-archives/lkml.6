Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE94C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406762064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq+iUBmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406762064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeLEQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:21:31 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35119 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:21:30 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so21092411itp.0;
        Wed, 05 Dec 2018 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nduLlnBo/Uywkt7yTjD99E0aRSNQV7XfrKlh9WL4JGs=;
        b=nq+iUBmCfUSArwFPeRVf30/zz/zZCCroLWlbaYxDyHgEJP3Q0BczOvHd91r13Ogjh7
         rRFmgg0xhqepDV4e/4DAiZkdvYDBH/69dxH1EiyoW+AQcT5xZvxPpJD2NjnXZlJB3Byi
         cipzIZRClcjJmJam3e2BYJRvNEh1ifuHu2aY4zdyBZ8aw/E+g2f+Kj457BeA7a8Hubf0
         24kVpTy/qbWA1w+PCVSxLKs4O/z/MMBOZVbc8H3aA7+FPDjxcn0Ov9/FqsR5jtOPTQbP
         vWl4Vahr9Lcpd7o2EXT8xL/DlSw25TcrX0XC2hj/i5JaeYXIORutPuirvTtXGckEqUNt
         Hh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nduLlnBo/Uywkt7yTjD99E0aRSNQV7XfrKlh9WL4JGs=;
        b=Z+8X7Eib4O3crAz4IMFdcnWHLYNfEJpDllF9nRSgxCbvA6n7q3TkzYoYqG1KpcmAWp
         jXZbGbAL9tATCn8HVw2+dNOWFgoU50UmZCouSYP4T08FevJPeTKHAZ900RprF7Ju7lKz
         dxcSWIEY5zP7AkL4pVqugBwXNfcNMQLWaEO69pnCRmznPSMSUwDdoERA0OAe+msGSFbY
         VNVF77YZgVNmXAcF4JNeAcJdyCkpB19kPhO1AbekrlYeX4UM2IyiThBSBrFaVtEHYsXK
         KXEy0o+/nMSVLxJvCOlUaEih61ONenccf57NLuPFTspT+hve4/H7AUwv2NAUymgSUx30
         Y2eg==
X-Gm-Message-State: AA+aEWZBGJz5VHBoRmF+pX0C5ybF0WkJbLQTTNSh8lZ75I7xwEfBQz+e
        OChX79mGSAB8oZddwFKBvJ3uvFGWQUwDuFsbPGQ=
X-Google-Smtp-Source: AFSGD/WjC2Ge3pbLrupBxazf8RTz355OinquUWHktsr9na4GGCKhAyL6bwvlST/f2BJKxAHU9+wpy6bDPFppE93sw4w=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr22442031jab.60.1544026889461;
 Wed, 05 Dec 2018 08:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20181130154249.3222-1-tiny.windzz@gmail.com> <20181205082719.GF2847@vkoul-mobl>
 <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com> <20181205155912.GP2847@vkoul-mobl>
In-Reply-To: <20181205155912.GP2847@vkoul-mobl>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 6 Dec 2018 00:21:06 +0800
Message-ID: <CAEExFWs6vFswAw6nwF8+0o8WRnin1Rk3bFHiMeJqTP1EsikVTg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, okaya@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:59 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 05-12-18, 23:49, Frank Lee wrote:
> > On Wed, Dec 5, 2018 at 4:27 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 30-11-18, 10:42, Yangtao Li wrote:
> > > > We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to defin=
e
> > > > such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify s=
ome
> > > > code.
> > >
> > > Spaces after full stop and comma please
> > >
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/dma/amba-pl08x.c     | 14 ++------------
> > > >  drivers/dma/mic_x100_dma.c   | 22 +++-------------------
> > > >  drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
> > > >  drivers/dma/qcom/hidma_dbg.c | 33 ++++++--------------------------=
-
> > >
> > > Do you mind splitting it per file.
> > Hi Vinod:
> >
> > Why not apply it once =EF=BC=9FThe change is not too big.
>
> It is not about big or small. A patch should do one thing and touch a
> single module.
>
> It also helps people when they look at changes and backports.
Already divided into small files, as you need.

MBR,
Yangtao
>
> --
> ~Vinod
