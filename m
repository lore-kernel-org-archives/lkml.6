Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49785C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9111218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="DuVSRX2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAXH6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:58:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42246 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfAXH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:58:32 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so2971870vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=krVR0RuMpCJWesgiRw/G3mLFSaTJr/cS7jpVt5y4yTA=;
        b=DuVSRX2A6xh/6/3Vp8CUlWqeqMzPhevp7ZR/OvbMkmV1fDHcDQA/HFcPhMOeCOsJd+
         aefCZdTYZCtnv93Se1llzvjH60RSC0gg8OGd28TJe8nXYMA0lRLjmI+jrwPRE1cFY0yh
         oVvHUuxedpoHei33GANK1H4T0lfXEom825BiXNt43gNSC+kfopw2QKel9+nsV3+kA1sZ
         +Sr0L7WaiyjDNI9YWeK1/5zJPjF66inx7OlD7M/ITMbvcq6+CloUTWdMXfQpZIHWZ4tV
         sG+7INJzikpQTwCpaUdsb5HCzlJFZV6mkXAcpifVCZHL+8nCpzCOB3xzLwgM6DTgXOow
         MXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=krVR0RuMpCJWesgiRw/G3mLFSaTJr/cS7jpVt5y4yTA=;
        b=pttmCjwzMSZgxpcTaGDyhnSNuK0B7yZHlomksEVr4fHclDoXRObY/chzqhxD6QUJpr
         JsAh63JXwuBiF1lZDQuaGGInB9+gEvJhcdLeG+R7lD7IQucle/mJ+hHk5ctcx/Y8VV8f
         +RKzy8f4wcMwQsqwwCjs8/FblA84rmed5ss6QoqG9FLzjShsdZcNRzIQFfD6YzLO/Mfr
         ioD4+lW+9Q6VtRVbUHDHn/L+k1Frp39KaTMTZwaF5Z417kaQJJdK8qBKGZCRM29eD24A
         5Xi8wIxv8e10QszjkRcphzr8QfG1bwAlT3caYDnZiXZcSf1rhCiU6FM0/GBKKngFu+UP
         ByvA==
X-Gm-Message-State: AJcUukd3XcOc7/Zsu+SDveiRX9VZ8OBxUAP3WdS4I17djCIiPOr8XJ1g
        gB2IJdVIld8daWGXebCjgIwxzqncxrF0TjK6LI/KRyx2
X-Google-Smtp-Source: ALg8bN6TcJWCXfdu9u8s4v3gL08dDaH8MFOb5hucWLzLoF2BxKJFWcQV1ZunwrxhBet56OcybYOEZEbZlnQi+bSSq7M=
X-Received: by 2002:a67:f445:: with SMTP id r5mr2430437vsn.164.1548316710929;
 Wed, 23 Jan 2019 23:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20190122151422.14204-1-gregkh@linuxfoundation.org>
 <20190122151422.14204-3-gregkh@linuxfoundation.org> <CAOtvUMc92ghc4LjHYJ7z9r11Om82rw=mNdAqA1GYJMxmuUqCLw@mail.gmail.com>
 <20190123133734.GA24700@kroah.com>
In-Reply-To: <20190123133734.GA24700@kroah.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 24 Jan 2019 09:58:20 +0200
Message-ID: <CAOtvUMdTC46+dNt9m5eU_JrRDKpKPTv74A6cDCC2yXM=-YkFEA@mail.gmail.com>
Subject: Re: [PATCH 2/7] crypto: ccrree: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Yael Chemla <yael.chemla@foss.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 3:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 23, 2019 at 02:58:22PM +0200, Gilad Ben-Yossef wrote:
> > Hi,
> >
> > On Tue, Jan 22, 2019 at 5:14 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic shoul=
d
> > > never do something different based on this.
> >
> >
> >
> > I get the part about not failing loading the driver just because some
> > debugs entry isn't available,  but wont it be weird if
> > debugfs_create_dir() fails but  debugfs_create_regset32() succeeds and
> > we suddenly have weird files in the debugfs root dir?
> > Not the end of the world of course but maybe it's better to avoid
> > trying to create the files if the directory is not available?
>
> See this patch to handle that theoretical issue:
>
>         https://lore.kernel.org/lkml/20190123130917.GZ4087@dhcp22.suse.cz=
/T/#me91cc3d16185be13d64f85c8477c543cbda9baf6
>

Ah, sorry. I've missed that.

Acked-By: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks!
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
