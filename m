Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F76206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GN1D41yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBVSUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:20:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33405 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBVSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:20:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id z14so2478462oid.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UiFqq9fKUY52GYBPs9UIqyS4mptDo3CU893hKHjGS74=;
        b=GN1D41yy989ENSk/QaWlIPSo80f0ecxNC50ye26M8YOCiIc0C43TXgsMFGuWz7RT+H
         bK3/xGZRWd47wfLf5VW9mIyR4zdpAyw9YG/d+HfKhwkEX7fXuf0krOAuXKTivczfMkQ9
         fEMRPqKfupripK8WyiBo1CmsL4GFk6waMmOKGxI7xkkaGoTK1vpaup1DPcJUPkqS1don
         f3zBOuFxwizTC/RJH8GLJwomUdcCeRGZdv4Iy0Ys9vzRe16gSgojWFC+3KEv05eUpDei
         8gNzcU4aCFXVYdFo7/ml34OOOgzIPqNts2RVdBtBY36x548tTuxpPdW/MxZkK6O3ZjS1
         GNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UiFqq9fKUY52GYBPs9UIqyS4mptDo3CU893hKHjGS74=;
        b=JjRFuF0ZEDbuJODZf6sZRAZQXaON/iDDLGlYj536Amms6y8q5CwOvXwxNXV+I/vzve
         Fa1Bec1hdQqx90ZMO3R49/1HhoJ2eTMlHyV8rokiLEknudkWhBXZf9NQK9WMKlWrvXkD
         VUROWH1tgAUqr08FBYAryK2D3f8YtHBtinRJsj5vJL517luVjBXaESVsOyjC25/JsUo3
         RlTNVhSKhPPPYvemj5myup3us6GM/EfXV1RIxMiPwzA/VmVhWzWsjFCUZCQGrA8sx/6P
         yiDAlMSLke5LNf/6HHt7v6nZU76tXzSI9vMXLaGvygxGiN6C9HAZBoO+ipMd2aGIVrf8
         ziAA==
X-Gm-Message-State: AHQUAubuSVxVDeHR0D8gTNuXZbHUYHt07cpdWerTqy7bltguV/vs2XTY
        pbx/KmuwJnZX5pqkI0sQfK/qUX2nAhkz1vhtZ5AOBA==
X-Google-Smtp-Source: AHgI3IZ3GjohG8ZeA76M7eOjYWudq1T/tMGFoHWrlRHyeUncjvHws5E6JvWGfIvPEESyBMwC3C4GI6y40ZeIw13ln24=
X-Received: by 2002:aca:32c3:: with SMTP id y186mr3201069oiy.118.1550859619873;
 Fri, 22 Feb 2019 10:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-7-keith.busch@intel.com>
 <29336223-b86e-3aca-ee5a-276d1c404b96@inria.fr> <20190222180944.GD10237@localhost.localdomain>
In-Reply-To: <20190222180944.GD10237@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Feb 2019 10:20:08 -0800
Message-ID: <CAPcyv4itkDiPYAqkT4e0i8nQXKAEZCUQsFk8jACEJ__tZwUh3Q@mail.gmail.com>
Subject: Re: [PATCHv6 06/10] node: Add memory-side caching attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Brice Goglin <Brice.Goglin@inria.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:09 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Fri, Feb 22, 2019 at 11:12:38AM +0100, Brice Goglin wrote:
> > Le 14/02/2019 =C3=A0 18:10, Keith Busch a =C3=A9crit :
> > > +What:              /sys/devices/system/node/nodeX/memory_side_cache/=
indexY/size
> > > +Date:              December 2018
> > > +Contact:   Keith Busch <keith.busch@intel.com>
> > > +Description:
> > > +           The size of this memory side cache in bytes.
> >
> >
> > Hello Keith,
> >
> > CPU-side cache size is reported in kilobytes:
> >
> > $ cat
> > /sys/devices/system/cpu/cpu0/cache/index*/size
> >
> > 32K
> > 32K
> > 256K
> > 4096K
> >
> > Can you do the same of memory-side caches instead of reporting bytes?
>
> Ok, will do.

Ugh, please no. Don't optimize sysfs for human consumption. That 'K'
now needs to be parsed.
