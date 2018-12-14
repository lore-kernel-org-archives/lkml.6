Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A29C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581FD208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXHbywmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeLNN4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:56:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37208 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:56:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so5088720wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfkVA1cvUFm6l9t+etnGa86DMGuVQeEpE9AwskkVrDM=;
        b=UXHbywmJL/JAdoiz9KaCZDRsHbhL83oD6upSmz75bso/1SNRS6vuvuyhoYYOCYrSza
         5ykoFbFs2vxmh3KenJWadPqqltIBk0EH/U2POqkaaYulj4+hbq8p8TlI3ppWrmdoow1H
         +d5UYg8+3ko7tb5OdK7KIs2Iok0coiFTQSxA9OUbJyzFMO97Lxiy9VmR1wJ30gCsV0VV
         3mA3TVuiW/ICzwLCDOX0yiHDk/lJRaj9F35F5M+AQRVZTBApNnuhxnJ+7AhW5xUAQuAb
         VzJ8XT7uPUoQfdbR+CxLS5axCH6ongkEWV6nwwD36gKvoqSuqtzzXZ4rnaPFetrhT91T
         uxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfkVA1cvUFm6l9t+etnGa86DMGuVQeEpE9AwskkVrDM=;
        b=GblCZCGi5TWdl5LjQASnASz53MZq9Q5Trgbb9aWOQf+Kua2q4+g0CBiCIGYKPY00pl
         xOjpkfeg/SjiIiEsRNVwAH0uZi5HVR6pQ/Zu2ZTyjhRoeAyZKasREGUX7IrdrM03M6Jw
         LHXkSeQtxopKMF/itaSmLDvCWP29y5WgLXSU6HUG47h5w3P8RyYL3NIrDxs/GIBRUJNf
         /AB0I+2XQQFzX3wpbP0I2Hv6am6toXA/NTVCH9rGaZ4LR7HxvmwvtfhhUWnVreks1BLb
         Qylfc0NleJ0bOb274PmNexgAETIyQuZkmSWByz7UCsqIp4dEZeVK8PxwvPgdjt1aYJ3p
         tRLQ==
X-Gm-Message-State: AA+aEWZNcUpPGwolZu0J3jIxEs3LXUFygLfddARJ2UYU8k62TgrepoZk
        FHvIf+M3irYrhgEP+e3MI/+cJAS7VG+N0Z80yTI=
X-Google-Smtp-Source: AFSGD/WDS0iPek6MPIjugXC76c2Y2AtyNB5SXitXq6H3A7vG8BKugqL/bKFliPwZWoCq4/BnwHTS8u4t+u01FGHwJS4=
X-Received: by 2002:adf:b102:: with SMTP id l2mr2624320wra.296.1544795798889;
 Fri, 14 Dec 2018 05:56:38 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz> <5C0654EE.5040001@oberhumer.com>
 <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
 <5C093A30.4020705@oberhumer.com> <BLUPR13MB0289EC81589A10E95912675FDFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
 <5C110083.8060502@oberhumer.com>
In-Reply-To: <5C110083.8060502@oberhumer.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 14 Dec 2018 14:56:26 +0100
Message-ID: <CAFLxGvzj=P2FY6w7CBYztsUjJ5Td53zCzGa_FUjrfxA94cmSgA@mail.gmail.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Cc:     liyueyi@live.com, dsterba@suse.cz,
        Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        donb@securitymouse.com, Jiri Kosina <jikos@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing Kees]

On Wed, Dec 12, 2018 at 1:37 PM Markus F.X.J. Oberhumer
<markus@oberhumer.com> wrote:
>
> I still claim that (0xfffffffffffff000, 4096) is not a valid C "pointer
> to an object" according to the C standard - please see my reply below.
>
> And I thought ASLR was introduced to improve security and not to create
> new security problems - someone from the ASLR team has to comment on this.
>
> Cheers,
> Markus
>
>
> On 2018-12-12 06:21, Yueyi Li wrote:
> > Hi Markus,
> >
> > OK, thanks. I`ll change it in v3.
> >
> > Thanks,
> > Yueyi
> >
> > On 2018/12/6 23:03, Markus F.X.J. Oberhumer wrote:
> >> Hi Yueyi,
> >>
> >> yes, my LZO patch works for all cases.
> >>
> >> The reason behind the issue in the first place is that if KASLR
> >> includes the very last page 0xfffffffffffff000 then we do not have a
> >> valid C "pointer to an object" anymore because of address wraparound.
> >>
> >> Unrelated to my patch I'd argue that KASLR should *NOT* include the
> >> very last page - indeed that might cause similar wraparound problems
> >> in lots of code.
> >>
> >> Eg, look at this simple clear_memory() implementation:
> >>
> >> void clear_memory(char *p, size_t len) {
> >>          char *end = p + len;
> >>          while (p < end)
> >>                  *p++= 0;
> >> }
> >>
> >> Valid code like this will fail horribly when (p, len) is the very
> >> last virtual page (because end will be the NULL pointer in this case).
> >>
> >> Cheers,
> >> Markus
> >>
> >>
> >>
> >> On 2018-12-05 04:07, Yueyi Li wrote:
> >>> Hi Markus,
> >>>
> >>> Thanks for your review.
> >>>
> >>> On 2018/12/4 18:20, Markus F.X.J. Oberhumer wrote:
> >>>> Hi,
> >>>>
> >>>> I don't think that address space wraparound is legal in C, but I
> >>>> understand that we are in kernel land and if you really want to
> >>>> compress the last virtual page 0xfffffffffffff000 the following
> >>>> small patch should fix that dubious case.
> >>> I guess the VA 0xfffffffffffff000 is available because KASLR be
> >>> enabled. For this case we can see:
> >>>
> >>> crash> kmem 0xfffffffffffff000
> >>>         PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
> >>> ffffffbfffffffc0        1fffff000 ffffffff1655ecb9  7181fd5  2
> >>> 8000000000064209 locked,uptodate,owner_priv_1,writeback,reclaim,swapbacked
> >>>
> >>>> This also avoids slowing down the the hot path of the compression
> >>>> core function.
> >>>>
> >>>> Cheers,
> >>>> Markus
> >>>>
> >>>>
> >>>>
> >>>> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> >>>> index 236eb21167b5..959dec45f6fe 100644
> >>>> --- a/lib/lzo/lzo1x_compress.c
> >>>> +++ b/lib/lzo/lzo1x_compress.c
> >>>> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
> >>>>
> >>>>           while (l > 20) {
> >>>>                   size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
> >>>> -               uintptr_t ll_end = (uintptr_t) ip + ll;
> >>>> -               if ((ll_end + ((t + ll) >> 5)) <= ll_end)
> >>>> +               // check for address space wraparound
> >>>> +               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <= (uintptr_t) ip)
> >>>>                           break;
> >>>>                   BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
> >>>>                   memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
> >>> I parsed panic ramdump and loaded CPU register values,  can see:
> >>>
> >>> -000|lzo1x_1_do_compress(
> >>>       |    in = 0xFFFFFFFFFFFFF000,
> >>>       |  ?,
> >>>       |    out = 0xFFFFFFFF2E2EE000,
> >>>       |    out_len = 0xFFFFFF801CAA3510,
> >>>       |  ?,
> >>>       |    wrkmem = 0xFFFFFFFF4EBC0000)
> >>>       |  dict = 0xFFFFFFFF4EBC0000
> >>>       |  op = 0x1
> >>>       |  ip = 0x9
> >>>       |  ii = 0x9
> >>>       |  in_end = 0x0
> >>>       |  ip_end = 0xFFFFFFFFFFFFFFEC
> >>>       |  m_len = 0
> >>>       |  m_off = 1922
> >>> -001|lzo1x_1_compress(
> >>>       |    in = 0xFFFFFFFFFFFFF000,
> >>>       |    in_len = 0,
> >>>       |    out = 0xFFFFFFFF2E2EE000,
> >>>       |    out_len = 0x00000001616FB7D0,
> >>>       |    wrkmem = 0xFFFFFFFF4EBC0000)
> >>>       |  ip = 0xFFFFFFFFFFFFF000
> >>>       |  op = 0xFFFFFFFF2E2EE000
> >>>       |  l = 4096
> >>>       |  t = 0
> >>>       |  ll = 4096
> >>>
> >>> ll = l = in_len = 4096 in lzo1x_1_compress,  so your patch is working
> >>> for this panic case, but, I`m
> >>> not sure, is it possible that in = 0xFFFFFFFFFFFFF000 and  in_len < 4096?
> >>>
> >>>
> >>> Thanks,
> >>> Yueyi
> >>>
> >
> >
>
> --
> Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/



-- 
Thanks,
//richard
