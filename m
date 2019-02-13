Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC25C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2898B222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SXZKFc0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbfBMIYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:24:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45239 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfBMIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:24:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so2483244ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7qNWB9rVEU8q8GRaLsXEEl1lIxUobDqlhu6T5ihfDLQ=;
        b=SXZKFc0CaiieBEMRJFU3IHgezclIzC4eOxNuvzXVBkX+ZMjTjEKcP/ZknRhxbwNDDU
         aVzwScUhnnYCm+ilVgGiA4CLnLMCTtjmRFyAAkf6uxcTkVX7iP5HUp8mAT3iHYVs1RwV
         iUY8LSK5UwCDWYnUB6/1vj+zqcJooCHzWSoZiXZyfYbD5r6vNxrsgNcjWa4XjdenIWTp
         9oRR2XB1/gzF1AVjiGdEHCbfcfbsHUdbihPmi7mk8aTM8aoZaJPlnuZFFEkrjxCNFynm
         vDMoJqpwj/cRLGKvcVP9m4z/3HAv6zZV4f5r16QPGrXQxvI1QgS/MSAb9LHHsrpL8LRL
         HnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7qNWB9rVEU8q8GRaLsXEEl1lIxUobDqlhu6T5ihfDLQ=;
        b=enNAMZoitkPBmzJLqWBCdm84gzW2XWelF900kqaHGdx7BLaYuancm1gE6nP5JRrDWc
         EF1Jki1uF5r1InfJ6XfvNGFTq0CE4mAy+8QgJNnutDI+Htlx6GkitA9l2/woTcrQjqba
         AktjlJqEIif4nfxSquULYPElgBzlcCvS4QUtxr0IrLB9CNgKYfhvSGOPXw8g0IZe787A
         SMGa/wdUo4x4c9EM8qErA0rTaBrWffLiSKOOLeng10ciDYRn1M8bMdzD58PRPIv44DCm
         QzLjw+zwYVd4SOnP8SUSg8dFvNR+S/1hudw2ImDrjiLf9odLwQZPFTX0+3bFxGvKvsfP
         fWcQ==
X-Gm-Message-State: AHQUAubeKJQmmeEi7Ov5Iyq4+df3v8euPVtgHETuAnORTEtdpC1NDQml
        QiHVK4w3yNMKFUYKUKLK5M+43WtIryagz+RUDAHt4Q==
X-Google-Smtp-Source: AHgI3IZRYsrcXjKGkoY18D+zNskgLx6ztmeOTYBqDscZ9Oco5xyF9ZcJycOeg27Bjd2oh2j5/bgEudDekSXCPbvG1LY=
X-Received: by 2002:aca:c3cb:: with SMTP id t194mr458706oif.70.1550046255452;
 Wed, 13 Feb 2019 00:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <c4c6aca8-6ee8-be10-65ae-4cbe0aa03bfb@inria.fr> <26ac36f4-7391-5321-217b-50d67e2119d7@intel.com>
 <453f13cd-a7fe-33eb-9a27-8490825ca29c@inria.fr> <CAPcyv4jF7ZyKaFDw7nb04UvWkVWGJdLGkZDQ1g=X7i+kdu7JRg@mail.gmail.com>
 <a3bfe739-228e-26fe-90f7-4a4f8ceb3a9a@inria.fr>
In-Reply-To: <a3bfe739-228e-26fe-90f7-4a4f8ceb3a9a@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Feb 2019 00:24:04 -0800
Message-ID: <CAPcyv4jJ=C7ZEsJqBxzBMsQWz4+C8BZmWuk7OkztOebprd2rMg@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:12 AM Brice Goglin <Brice.Goglin@inria.fr> wrote=
:
>
> Le 13/02/2019 =C3=A0 01:30, Dan Williams a =C3=A9crit :
> > On Tue, Feb 12, 2019 at 11:59 AM Brice Goglin <Brice.Goglin@inria.fr> w=
rote:
> >> # ndctl disable-region all
> >> # ndctl zero-labels all
> >> # ndctl enable-region region0
> >> # ndctl create-namespace -r region0 -t pmem -m devdax
> >> {
> >>   "dev":"namespace0.0",
> >>   "mode":"devdax",
> >>   "map":"dev",
> >>   "size":"1488.37 GiB (1598.13 GB)",
> >>   "uuid":"ad0096d7-3fe7-4402-b529-ad64ed0bf789",
> >>   "daxregion":{
> >>     "id":0,
> >>     "size":"1488.37 GiB (1598.13 GB)",
> >>     "align":2097152,
> >>     "devices":[
> >>       {
> >>         "chardev":"dax0.0",
> >>         "size":"1488.37 GiB (1598.13 GB)"
> >>       }
> >>     ]
> >>   },
> >>   "align":2097152
> >> }
> >> # ndctl enable-namespace namespace0.0
> >> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> >> <hang>
> >>
> >> I tried with and without dax_pmem_compat loaded, but it doesn't help.
> > I think this is due to:
> >
> >   a9f1ffdb6a20 device-dax: Auto-bind device after successful new_id
> >
> > I missed that this path is also called in the remove_id path. Thanks
> > for the bug report! I'll get this fixed up.
>
>
> Now that remove_id is fixed, things fails later in Dave's procedure:
>
> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> # echo -n dax0.0 > /sys/bus/dax/drivers/kmem/new_id

In the current version of the code the bind is not necessary, so the
lack of error messages here means the bind succeeded.

> # echo -n dax0.0 > /sys/bus/dax/drivers/kmem/bind
> -bash: echo: write error: No such device

This also happens when the device is already bound.

>
> (And nothing seems to have changed in /sys/devices/system/memory/*/state)

What does "cat /proc/iomem" say?
