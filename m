Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5599C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F262148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS+oDPUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbeL0WSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:18:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36675 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbeL0WSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:18:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so18482074wmc.1;
        Thu, 27 Dec 2018 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oGNNGvY06rqC10oMV7fuETey3BupeXG8K/FvVNM0iaU=;
        b=KS+oDPUdLOWGYpfmAsSmGbPSPaBr0dzm7mMgi7I8/BMaKVIjI2iV+LBq1yqPb6FHaX
         ZTwnMoQnkvgdbYXcJpAAbrmWxiglKMbppMDuLWEPS+2SfjdsGpU1CdMH+8F7pdOQWW1X
         jQ+E7Sw+RXf4EUwsD2HILqsLwAgylKOq99gSMIqiVyLsRsGreW46rIKPFfFh96zp0IuV
         vF9E4tbj8/lYBwBl6B4F+0NSRD5K7OQaNQJdKSmF3wKLI/lV86YgZA1GtQsLx9lWWRPo
         tcEpxbT+96eaeVI0Smkb9kj3hdJXCtbwIcejPDZHqCVxD2Rf8FLPuBauKNFR0LUekuZU
         i2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGNNGvY06rqC10oMV7fuETey3BupeXG8K/FvVNM0iaU=;
        b=F1kxumExgF5h65xvxp1idYEdfjqfhYkOfpS7LSGFVcGjFCpkfWyt6k+144oK8rkPnP
         6nMCpovf4Lxl76qJYne6yUznFlcVLxSLr6ahZmknZGMmOi+VnHdxNpqoGoRFiy/soOux
         dxItUJCSuT1T5i9ZH1FpMxPSt2TeiRCpFMz3msiBY44Sq1sDy8YuhgIEv6IYzc8ohjId
         i6K04+eUbED3vYLecdAR2ZoDl++uTGp93ZM1JPZLmvyIe/A9L61I02oWhboX/CdNa2Lv
         VQqz1Vcyo2+WkAf2nyVXUEWoD15NelJMN/YIzdH0nJ3K06xKFqzwg6OBew3BcFWTcFrP
         Pr1Q==
X-Gm-Message-State: AA+aEWb772hRjlrmKoWQUepx+V/0ojm3K2lNB/tvMORxTWG8f2UihpeB
        LbaOZfraZTCVRNiM/gUVQCA=
X-Google-Smtp-Source: AFSGD/URH75KiQQuhKr4u9DKFGgJzoVaAm/jQfogPI1xvP8PXaIMHFeKk0zD/7XVNm2uJALFbBhYfg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr22486139wmk.152.1545949080352;
        Thu, 27 Dec 2018 14:18:00 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v133sm27149420wmf.19.2018.12.27.14.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 14:17:58 -0800 (PST)
Date:   Thu, 27 Dec 2018 23:17:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Bombe <andreas.bombe@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181227221748.zsz6bwqqia7ybfwj@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
 <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali>
 <20181212135736.xtb57r2eatqsgenb@pali>
 <20181217095004.c6c6itvyfp7cf3ta@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181217095004.c6c6itvyfp7cf3ta@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2018 10:50:04 Pali Roh=C3=A1r wrote:
> On Wednesday 12 December 2018 14:57:36 Pali Roh=C3=A1r wrote:
> > On Thursday 06 December 2018 09:38:28 Pali Roh=C3=A1r wrote:
> > > On Thursday 06 December 2018 01:53:02 Andreas Bombe wrote:
> > > > Pali Roh=C3=A1r <pali.rohar@gmail.com> schrieb am Mi., 14. Nov. 201=
8 um
> > > > 12:33 Uhr:
> > > >=20
> > > > > And... has somebody else time to look at those pending patches an=
d do
> > > > > some initial review? I would really appreciate if somebody look a=
nd
> > > > > comment them.
> > > > >
> > > > > There are 14 open pull requests:
> > > > > https://github.com/dosfstools/dosfstools/pulls
> > > >=20
> > > >=20
> > > > I'll spend time on this again. It would help if you could make a li=
st of
> > > > higher priority PRs you would like see being looked at first.
> > >=20
> > > So.. here is some list:
> > >=20
> > > https://github.com/dosfstools/dosfstools/pull/92
> > > https://github.com/dosfstools/dosfstools/pull/93
> > > https://github.com/dosfstools/dosfstools/pull/94
> > > https://github.com/dosfstools/dosfstools/pull/101
> > > https://github.com/dosfstools/dosfstools/pull/104
> > > https://github.com/dosfstools/dosfstools/pull/84
> >=20
> > Maybe you can start with Year 2038 problem in PR 94:
> > https://github.com/dosfstools/dosfstools/pull/94
>=20
> Thanks for review of #94! As next you can take #92 from list.

Andreas, can you look at next pull requests?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
