Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E12C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE520644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XmQnB5Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeJSFiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:38:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39465 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJSFiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:38:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so25259209oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo5IdB7RWsUA00e0IebT8XTDQdWVlTBdq9nvmfMqNg4=;
        b=XmQnB5EhvV/jzSSArGBDnFu1OBKu/AnBLVuR20NHyGg7DC+PteJlUOltUyx0QsRhyF
         esyt00+YNN2+ZwJ8GNp6oHCbSt5Jv4wWAi/Yr1DU1vlSjputKEqg5NCZ9rNyWSntvY7o
         b7ktl9cOnzZ14/F+5UuK6J7o28ZlZvc9C9rMGgTqcosE8xd0Rh9aMiLIf3sQc3V2srBJ
         K/xXuec+Xg1keX6uXRbC+7dyTFJOoapWiqIaw5aAx69q1fU4J1yNdv9mtgUtICAOwa6c
         kxjFKTfG/8++dnt4IZuoTboLTYy+9HbBxuNQgkviKh6137QUkQClQL8JgT7Mq2UJEnhm
         jeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo5IdB7RWsUA00e0IebT8XTDQdWVlTBdq9nvmfMqNg4=;
        b=gBevDaWGVVgROjen426ofiI8NJbPaA015P66+rMGbDXmFYYf2koaVYa671YX9LdNJp
         o7w297jtKjMMF/j2fADD1kAzhmaMn4s4UQgA7kFRp9I42/tcTtcIv6yoDVJphGa3bbWw
         4SwzAaEhd25rWi8pAlHhcQTiK1wK8CqlcqyI1jO2fHpIphDPQ70hJGHxEI9GuRXPon3E
         Of7RZVEtrgwUBKIupm4I+I4ndCGMqOyniDVioE/4DIB9BuNOtrBYOISNeWxmnqmYA06B
         OVm+2+5lwP/KRtGv2Iu19dI8nGjyykzcWmPVLWFYIxlXR12KcutgKZrf+wWfh0p14j99
         Pu7g==
X-Gm-Message-State: ABuFfohTf+VvxMGLIa5dfemJ2M1jaf1D1Qwdrm603czjGupfPsNgAJ/9
        mReGlYRtcOcnxlGHgAc6iOEL2jbqkz7PMelsYNA0nw==
X-Google-Smtp-Source: ACcGV6039qlj/oJtSrVvCJpD54JiUcJIc8mS37BzHXZdKs65jIciqsSkzpS5mkG8GsqLrCDdzmnY8IGzPVEux6Wn6aU=
X-Received: by 2002:aca:44d7:: with SMTP id r206-v6mr16512295oia.280.1539898553459;
 Thu, 18 Oct 2018 14:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com> <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
In-Reply-To: <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Oct 2018 14:35:42 -0700
Message-ID: <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>, joel@joelfernandes.org,
        zwisler@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 18, 2018 at 8:33 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> > [ add Ross ]
>
> Hi Ross! :)
>
> > On Thu, Oct 18, 2018 at 12:15 AM Kees Cook <keescook@chromium.org> wrote:
> >> As for nvdimm specifically, yes, I'd love to get pstore hooked up
> >> correctly to nvdimm. How do the namespaces work? Right now pstore
> >> depends one of platform driver data, device tree specification, or
> >> manual module parameters.
> >
> > From the userspace side we have the ndctl utility to wrap
> > personalities on top of namespaces. So for example, I envision we
> > would be able to do:
> >
> >     ndctl create-namespace --mode=pstore --size=128M
> >
> > ...and create a small namespace that will register with the pstore sub-system.
> >
> > On the kernel side this would involve registering a 'pstore_dev' child
> > / seed device under each region device. The 'seed-device' sysfs scheme
> > is described in our documentation [1]. The short summary is ndctl
> > finds a seed device assigns a namespace to it and then binding that
> > device to a driver causes it to be initialized by the kernel.
> >
> > [1]: https://www.kernel.org/doc/Documentation/nvdimm/nvdimm.txt
>
> Interesting!
>
> Really, this would be a way to configure "ramoops" (the persistent RAM
> backend to pstore), rather than pstore itself (pstore is just the
> framework). From reading the ndctl man page it sounds like there isn't
> a way to store configuration information beyond just size?
>
> ramoops will auto-configure itself and fill available space using its
> default parameters, but it might be nice to have a way to store that
> somewhere (traditionally it's part of device tree or platform data).
> ramoops could grow a "header", but normally the regions are very small
> so I've avoided that.
>
> I'm not sure I understand the right way to glue ramoops_probe() to the
> "seed-device" stuff. (It needs to be probed VERY early to catch early
> crashes -- ramoops uses postcore_initcall() normally.)

Irk, yeah, that's early. On some configurations we can't delineate
namespaces until after ACPI has come up. Ideally the address range
would be reserved and communicated in the memory-map from the BIOS.

In EFI terms I think early ramoops is only suitable for
EfiACPIMemoryNVS, but we could certainly support a late arriving
ramoops for EfiPersistentMemory with this proposed namespace scheme.

I cringe at users picking addresses because someone is going to enable
ramoops on top of their persistent memory namespace and wonder why
their filesystem got clobbered. Should attempts to specify an explicit
ramoops range that intersects EfiPersistentMemory fail by default? The
memmap=ss!nn parameter has burned us many times with users picking the
wrong address, so I'd be inclined to hide this ramoops sharp edge from
them.
