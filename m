Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F78A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi2Cfgj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F78A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFUIEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:04:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34968 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFUIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:04:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id z6-v6so2068402qti.2;
        Thu, 21 Jun 2018 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wRhbo79pXsg5eUFRbTF7obJcJfzHtdIB9cywHfSRbEk=;
        b=Gi2Cfgj4555XJ0dYVp9sKgAQ8aPp2SJGahtxf+qD1Xj3yEtBKOhOw6Io2pOulsrLiD
         VCjY/UM/NbiGTvDlx6imuLmGLvKSlTFvfA9FLbq9YFu4cxRChLtePGd4y9PbfeUvTlxX
         FqXLQGSadHeaHjIHTZeb0yfsmuZnq6fp8e9AlsAv7ZF6l66H/cWlOjiTlgDDN3vxMg0G
         GUfkonpDUQijZIWmr05sTtKDCc98rHlui9TLyR29XQLX3yyKAWghkW+nue1ESjv2RoJA
         hh+46YpSXzw9mBWXJ+gBjW2wVbw2hVOAte+Dvg5z2MythOoKa/1M7vQSMaQnqIRKv1ut
         R8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wRhbo79pXsg5eUFRbTF7obJcJfzHtdIB9cywHfSRbEk=;
        b=sOTEgiiiObCYgaYFxjBhLECRmwhE+2l4yt9zillCfJLDaWkuQLVoMxTb0V7gMnQSit
         ZWjCxHOwPzWg0PcwQNVtOZoxafIZ5tDh1rvCIoR8z8r5AuGUOyKSq/9UuFSvdlVPkS6M
         xf8GH3B9A18BPpDgrm6S1NJBYRakeijNW13OhUvgnFjEM78JtqINzkS/0k9QDHzcKVXH
         s15yf1J6MH8HpUWRXNYiR+bf1xOETs4ehhQQDYUyWNQ0CHyFNUklb2yWLKFt5WHA1dnS
         aC8Rn+vN6kXWEG1TtHhDiJp0LMfwgJMuVsHbuwCXP9QXnsw67eU4KdUmkhGWYjsQmYdl
         wHdQ==
X-Gm-Message-State: APt69E3O9mwWmLwNv7ALL7YLj37kMNz2IlB14nNUHlA0siWEYIS57y3z
        zsBRbiB6f5tJ4VvRrcMvpRGK0yYHA2XScWzzVoU=
X-Google-Smtp-Source: ADUXVKIrmVcZwqiuwtqGmD89Py89dWCF9yIjpB+jJdmo7kiAiRASRZcf6YNpBOLyc/O0841YPF11/zBrGZccCPKghV4=
X-Received: by 2002:a0c:d08c:: with SMTP id z12-v6mr21636008qvg.195.1529568277188;
 Thu, 21 Jun 2018 01:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
 <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
 <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
 <CGME20180619082320epcas5p228d76c9e326d24acc1c38b43ff152347@epcas5p2.samsung.com>
 <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com> <5B29A43E.2080402@samsung.com>
 <9186fc15-c884-a67b-e2fb-113721613146@collabora.com> <5B2B5AB4.4020003@samsung.com>
In-Reply-To: <5B2B5AB4.4020003@samsung.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 21 Jun 2018 10:04:25 +0200
Message-ID: <CAFqH_539E+TEjPK8QNm7UprfdGz17nxRUtmY7vWCueZsYwyByA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        cwchoi00@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,
Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dj., 21 de
juny 2018 a les 9:58:
>
> Hi Enric,
>
> On 2018=EB=85=84 06=EC=9B=94 20=EC=9D=BC 19:32, Enric Balletbo i Serra wr=
ote:
> > Hi Chanwoo,
> >
> > On 20/06/18 02:47, Chanwoo Choi wrote:
> >> Hi Enric,
> >>
> >> On 2018=EB=85=84 06=EC=9B=94 19=EC=9D=BC 17:22, Enric Balletbo i Serra=
 wrote:
> >>> Hi Chanwoo,
> >>>
> >>> On 18/06/18 11:02, Enric Balletbo Serra wrote:
> >>>> Hi Chanwoo,
> >>>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de jun=
y
> >>>> 2018 a les 5:50:
> >>>>>
> >>>>> Hi Enric,
> >>>>>
> >>>>> This issue will happen on the position to use find_devfreq_governor=
()
> >>>>> as following:
> >>>>> - devfreq_add_governora() and governor_store()
> >>>>>
> >>>>> If device driver with module type after loaded want to change the
> >>>>> scaling governor,
> >>>>> new governor might be not yet loaded. So, devfreq bettero to consid=
er this case
> >>>>> in the find_devfreq_governor().
> >>>>>
> >>>> Ok, I'll move there and send a v2.
> >>>>
> >>>
> >>> I tried your suggestion but I found one problem, if I move the code i=
n
> >>> find_devfreq_governor it end up with a deadlock. The reason is the fo=
llowing calls.
> >>>
> >>> devfreq_add_device
> >>>   find_devfreq_governor (!!!)
> >>>     request_module
> >>>        devfreq_simple_ondemand_init
> >>>           devfreq_add_governor
> >>>              find_devfreq_governor (DEADLOCK)
> >>>
> >>> So I am wondering if shouldn't be more easy fix the issue in both pla=
ces,
> >>> devfreq_add_device and governor_store.
> >>>
> >>> To devfreq_add_device
> >>>
> >>> devfreq_add_device
> >>>   governor =3D find_devfreq_governor
> >>>   if (IS_ERR(governor) {
> >>
> >> In this error case, you have to unlock the mutex
> >> before calling the request_module(). I added the pseudo code
> >> of my opinion.
> >>
> >>>      request_module
> >>>      governor =3D find_devfreq_governor
> >>>      if (IS_ERR(governor)
> >>>        return ERR_PTR(governor)
> >>>   }
> >>>
> >>> And the same for governor_store
> >>>
> >>> governor_store
> >>>   governor =3D find_devfreq_governor
> >>>   if (IS_ERR(governor) {
> >>>      request_module
> >>>      governor =3D find_devfreq_governor
> >>>      if (IS_ERR(governor)
> >>>        return ERR_PTR(governor)
> >>>   }
> >>>
> >>> Maybe all  can go in a new function try_find_devfreq_governor_then_re=
quest
> >>
> >> How about modify the find_devfreq_governor() as following?
> >> I think that it is possible because previous find_devfreq_governor()
> >> always check whether mutex is locked or not.
> >>
> >>      find_devfreq_governor() {
> >>
> >>              // check whether mutex is locked or not
> >>              if (!mutex_is_lock(&devfreq_list_lock)) {
> >>                      WARN(...)
> >>                      return -EINVAL
> >>              }
> >>
> >>              // find the registered governor with list_for_each_entry
> >>
> >>              if (governor is not loaded) {
> >>                      mutex_unlock()
> >>                      request_module()
> >
> > Then the problem is that the find_devfreq_governor is reentrant because=
 the init
> > function of the governor calls devfreq_add_governor and find_devfreq_go=
vernor
> > again. E.g for simpleondemand governor you will get this loop.
> >
> > find_devfreq_governor
> >   -> request_module
> >       -> devfreq_simple_ondemand_init
> >          -> devfreq_add_governor
> >             -> find_devfreq_governor
> >                -> request_module
> >                   -> devfreq_simple_ondemand_init
> >                      -> devfreq_add_governor
> >                         -> find_devfreq_governor
> >                            -> request_module
> >                               ...
> >
> > Makes sense or I am missing something and there is a way to quit from t=
his loop?
>
> You're right. Sorry, my wrong opinion steals your time.
>

Not a problem :) I learned while we discussed regarding the different
options. I will send a v2 then

Thanks,
 Enric

> >
> > FWIW I checked how the cpufreq driver does this as it should have the s=
ame
> > problem. The find_governor function is just a simple search and instead=
 of
> > integrating the request_module inside the find_governor function they h=
ave a
> > cpu_parse_governor that calls request module from the userspace call an=
d from
> > the init call.
>
> Also, I checked the cpufreq's case. We better to make the separate functi=
on
> like cpufreq_parse_governor() in cpufreq subsystem.
>
> >
> > store_scaling_governor
> >   -> cpu_parse_governor
> >      -> request_module
> >
> > cpufreq_add_dev_interface
> >   -> cpu_freq_init_policy
> >      -> cpu_parse_governor
> >         -> request_module
> >
> > Thanks,
> > - Enric
> >
> >>                      mutex_lock()
> >>              }
> >>
> >>      }
> >>
> >>
> >>>
> >>> Other suggestions?
> >>>
> >>> - Enric
> >>>
> >>>> Thanks
> >>>>  Enric.
> >>>>
> >>>>
> >>>>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
> >>>>> <enric.balletbo@collabora.com>:
> >>>>>> When the devfreq driver and the governor driver are built as modul=
es,
> >>>>>> the call to devfreq_add_device() fails because the governor driver=
 is
> >>>>>> not loaded at the time the devfreq driver loads. The devfreq drive=
r has
> >>>>>> a build dependency on the governor but also should have a runtime
> >>>>>> dependency. We need to make sure that the governor driver is loade=
d
> >>>>>> before the devfreq driver.
> >>>>>>
> >>>>>> This patch fixes this bug in devfreq_add_device(). First tries to =
find
> >>>>>> the governor, and then, if was not found, it requests the module a=
nd
> >>>>>> tries again.
> >>>>>>
> >>>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor=
 using name)
> >>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.co=
m>
> >>>>>> ---
> >>>>>>
> >>>>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++---=
--
> >>>>>>  1 file changed, 31 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>>>>> index fe2af6aa88fc..1d917f043e30 100644
> >>>>>> --- a/drivers/devfreq/devfreq.c
> >>>>>> +++ b/drivers/devfreq/devfreq.c
> >>>>>> @@ -11,6 +11,7 @@
> >>>>>>   */
> >>>>>>
> >>>>>>  #include <linux/kernel.h>
> >>>>>> +#include <linux/kmod.h>
> >>>>>>  #include <linux/sched.h>
> >>>>>>  #include <linux/errno.h>
> >>>>>>  #include <linux/err.h>
> >>>>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct de=
vice *dev,
> >>>>>>
> >>>>>>         governor =3D find_devfreq_governor(devfreq->governor_name)=
;
> >>>>>>         if (IS_ERR(governor)) {
> >>>>>> -               dev_err(dev, "%s: Unable to find governor for the =
device\n",
> >>>>>> -                       __func__);
> >>>>>> -               err =3D PTR_ERR(governor);
> >>>>>> -               goto err_init;
> >>>>>> +               list_del(&devfreq->node);
> >>>>>> +               mutex_unlock(&devfreq_list_lock);
> >>>>>> +
> >>>>>> +               /*
> >>>>>> +                * If the governor is not found, then request the =
module and
> >>>>>> +                * try again. This can happen when both drivers (t=
he governor
> >>>>>> +                * driver and the driver that calls devfreq_add_de=
vice) are
> >>>>>> +                * built as modules.
> >>>>>> +                */
> >>>>>> +               if (!strncmp(devfreq->governor_name,
> >>>>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_=
NAME_LEN))
> >>>>>> +                       err =3D request_module("governor_%s", "sim=
pleondemand");
> >>>>>> +               else
> >>>>>> +                       err =3D request_module("governor_%s",
> >>>>>> +                                            devfreq->governor_nam=
e);
> >>>>>> +               if (err)
> >>>>>> +                       goto err_unregister;
> >>>>>> +
> >>>>>> +               mutex_lock(&devfreq_list_lock);
> >>>>>> +               list_add(&devfreq->node, &devfreq_list);
> >>>>>> +
> >>>>>> +               governor =3D find_devfreq_governor(devfreq->govern=
or_name);
> >>>>>> +               if (IS_ERR(governor)) {
> >>>>>> +                       dev_err(dev,
> >>>>>> +                               "%s: Unable to find governor for t=
he device\n",
> >>>>>> +                               __func__);
> >>>>>> +                       err =3D PTR_ERR(governor);
> >>>>>> +                       goto err_init;
> >>>>>> +               }
> >>>>>>         }
> >>>>>>
> >>>>>>         devfreq->governor =3D governor;
> >>>>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct devi=
ce *dev,
> >>>>>>  err_init:
> >>>>>>         list_del(&devfreq->node);
> >>>>>>         mutex_unlock(&devfreq_list_lock);
> >>>>>> -
> >>>>>> +err_unregister:
> >>>>>>         device_unregister(&devfreq->dev);
> >>>>>>  err_dev:
> >>>>>>         if (devfreq)
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Best Regards,
> >>>>> Chanwoo Choi
> >>>>> Samsung Electronics
> >>>>
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
