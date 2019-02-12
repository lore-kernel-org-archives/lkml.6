Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07302C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C137D21B1C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBrAAQEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfBLKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:30:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:30:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1079233pfh.11;
        Tue, 12 Feb 2019 02:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ML07bNGup2ombJNZit1prKV/eZNle7FujA1kmgVXeLA=;
        b=eBrAAQEbAHFQPIQyQJUfubqweae3ZAjIVgrYNwWuTWOE/cU0GsI1QIq0XDdbgtSVsT
         vEU6OoRTTjz0Fbgfx+z+wiED2mIcMTXrXnfohhgBBcBUuh4kel1hh7x/VdJNWJDnLpeE
         JUIX7tsfT00xkd4KyZZqPeGI8jbFIkQhwTT3M6P37v6DymUyHdaFPhU7DKRUgCWlM2V1
         zneMDePU2PvhdIGmAMBFjO+cN/jUSL1hh0qOpuzxFT4xsTrAtCNhJVJfteJPQzMD1xp8
         ZiEBCoZaiUXdINusY6e1bO8y0zc3dofv+ZGa9+5NZ6MblkTWBXYsXnHwGtDnwd3tXeRb
         bL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ML07bNGup2ombJNZit1prKV/eZNle7FujA1kmgVXeLA=;
        b=EhUN4G8clZqgOjryw/+UF3PegjOYWYNeulmybE63OGttZ/d/prRqQRHweK0JRr46Qn
         qUxtnrIff++W7lZrsEehPSpZXLgbP91oOtYnhffUJAHgXpu7PcUuIkUsaCRoSdomGCGR
         tB3JVrbhKcbY9/Ub+RI1523O+UJ3brANbtutMa6nd/KLv1/E0jhR8PmGbFeHAIVzLqQ5
         fj0kXH0TDS/7fFTq7M83njWSoZP6DFnld6aJv1WIiBaiK4DRjSD5d8sUqjroq8cFL0Ut
         1Sio05nw7sf6kTLFoSZDY8e5qPGJ+07TivTpYjynQJG7F2L9H/C3if0yRR7c7Ttq4Lpp
         CClw==
X-Gm-Message-State: AHQUAua8pCEr9NjKVmWS0RzHBDJprt5RxJiHMcb8F6P+xLzwlHITwOBl
        xnzrw/RazP20D3pLkva2I0N8wM40TbFxSH+tcY8=
X-Google-Smtp-Source: AHgI3IatmR87+IBy8i8kfI5DnenvOuL8oTWoBhjostKwxNYol3iBApeL0X1FiV1EJFAn1jssEbxLsRnWkwYZDngoE6g=
X-Received: by 2002:a62:36c1:: with SMTP id d184mr3271761pfa.242.1549967425303;
 Tue, 12 Feb 2019 02:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20190210192408.GA81989@bebop> <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
 <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com> <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
 <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
In-Reply-To: <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:30:13 +0200
Message-ID: <CAHp75Vdbtou6Y0+He9f70kTRYyDiXR=jBATgTS8LK+SWXwTeUg@mail.gmail.com>
Subject: Re: X450LCP lost abillity to turn the screen off
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:31 AM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
> On 2/11/19 5:14 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
> > Hello Marcos,
> > On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
> > <marcos.souza.org@gmail.com> wrote:

> > You can check what is being sent by the kernel with evtest, and what
> > is being sent by X with "xinput test <device id>" (and you can find
> > the device id with "xinput list"). And you can re-map it without
> > having to rebuild the kernel using udev's hwdb. But simply re-mapping
> > should not change anything, since userspace does not act on
> > KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to the
> > old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:
> > Tell the EC the OS will handle the display off hotkey".
>
> I tried reverting the patch and only recompiling/reinstalling the
> platform/x86 modules, but the problem still happens. My next step will
> be testing agains't 4.20, since my machine was working with 4.12, so I
> might try the major releases first.

When you are going to try older releases, it would be nice to see if
LTS kernels (v4.14.y, v4.19.y from Linux stable tree [1]) behave
differently

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/

--=20
With Best Regards,
Andy Shevchenko
