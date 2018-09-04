Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3DD20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmfpcSCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3DD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIDGgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:36:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39385 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeIDGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:36:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so875190pff.6;
        Mon, 03 Sep 2018 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2Vgn5tIdgj7CoHJEqryrP7DUYBh1p24Z3XkJNwrld0=;
        b=KmfpcSCFp0nPaShnrPTQ+3erHmmqtXkZeNDm8TxEVlV8y8mHy2/Dv0llOJqSsOxtwu
         mOCYRdopUosp8zBH2ui2WArn5iP4FrGFxeu5GVlmXAS1ZsviWVY2bNxi2SWAukplP5LG
         vhd+HmulFfy5j2FC49MRozN+wLzwvw8J/hJoBw/ebs09L4FeDMkuoanMeSrOdix7FdSv
         gFjUh3BPxey+AIavMsRv4ishInxzGRUuGYDoo4jM8zouIIbop49DQXoV2FhnfWzdFYLZ
         iHcZTyfffz8l6Is7ou0tnKCHV9u2mRyBpAZu8ebKstDhVMgiPPdCGs99xvUOHgYF/w6l
         pxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2Vgn5tIdgj7CoHJEqryrP7DUYBh1p24Z3XkJNwrld0=;
        b=ugWhr5RCwcb+MpQxdz58iOce//FDUfG3oAsLCniwVEafPNhVPvHFooHvedOONc/4z9
         f6MlKRVFiEHcZoPfvhE5dopAJeNlID2BgZkGL/2eFOgqRxy8mY+EoCUkKnKnh7vdvJn8
         D3xfwGWojl9xLj3oL72yqj4yzJg/M5XA2lNNnGe1ua1r1+odm8Q3ENyz0SLNNB71WNO+
         YFykOYAzoWOglIUoNPXp/stjz/ONWpj/JvwCd8BfWtu3WA+3mtWtzlWyeGXypOdGHoF4
         FnsPqPN2awIBIczKTDa2IF7wiDqEgMrS8hGjzd/q00/KoOSExB30hNzXYv/JPPuyM3eR
         KyBQ==
X-Gm-Message-State: APzg51CEhpkMCSPy5C/BuL9rt41PmG7gSdv1hpHqtbeVzLavxlnMAGS3
        AlzpcRn/2tNr3Zi02t1OjjdZhnz3O6yUPt22SvI5yw==
X-Google-Smtp-Source: ANB0VdaBBQj36Qo5HYE0x4CY9onvUGvW8opx2EC64NXeIaIi71orwsQ0KUAlavmo8CcO6SLre61laNiDrKBeYN8Euxs=
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr28907585pgp.69.1536027194097;
 Mon, 03 Sep 2018 19:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180903131558.21cdeb35@canb.auug.org.au> <CAH2r5mu99E39iwx=70w6F5MxvNh1MrzbVwTRb2e8dmz9WU52sw@mail.gmail.com>
 <20180904112218.3f7e3337@canb.auug.org.au>
In-Reply-To: <20180904112218.3f7e3337@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 3 Sep 2018 21:13:02 -0500
Message-ID: <CAH2r5ms92TpMjA+OKU=qz-ZTK6iRZ-nrv3FFivuhwdQ6z50rDg@mail.gmail.com>
Subject: Re: [PATCH] fs/cifs: suppress a string overflow warning
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok - it looks like it will be a little simpler if I wait
On Mon, Sep 3, 2018 at 8:22 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Steve,
>
> On Mon, 3 Sep 2018 09:44:17 -0500 Steve French <smfrench@gmail.com> wrote:
> >
> > Merged into cifs-2.6.git for-next
> >
> > Is the message annoying enough on powerpc to merit going into
> > 4.19-rc3, presumably should wait for 4.20?
>
> Up to you, but 4.20 is probably fine.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
