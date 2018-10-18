Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED732C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A969820645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZN9Ykll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A969820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJSFB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:01:27 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40442 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSFB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:01:27 -0400
Received: by mail-vk1-f196.google.com with SMTP id h20-v6so7603866vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1i24LIohU9tnCWwwWe6eoXmTwIbVlwGW9MQC8jaIZI=;
        b=tZN9YkllQeAA7N5ugKuSUKLB3ACfoablV6lvTJIOSNHaO97lRGOXVqvnCs276MG3sW
         q93zncV1UguQsRrE52urKg3paN590Ihvz0o6DaaqK7ZnMErgRx+yAmjSc6Pq2Tgdud5Z
         a+MekDPF4fonchkLm6pQihktQkcu6xBZLqJ2QGIcpNA6Cqdmtgwc9/4XchxUZ6ifou6R
         iJcdqePo94o2Qkj3wX7RXpugeUrKeTfpwY+BTsIh8fTYPVnb8n6IXbA+JKdET8SVuLxt
         P+btRMh5h7VgTiYwelWD8eTZjxcjyqHksCwiiwcaDVvP7qAfCEbL1YBM0ZqyFudJZChr
         KgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1i24LIohU9tnCWwwWe6eoXmTwIbVlwGW9MQC8jaIZI=;
        b=YGPzYwxgNVj3Fwxmmc+lpfe8iKHA0hyGi8V2Unzh7hROwq3E2OM6LVs/i/wB3am9nj
         1v58WSZE2Nx7AisLBFYzwcEQAyVWC5GJnFtUM4VMXjCe3SpS6PoeMVuC5tKBVgI5y0fB
         1MRorNByTi7sqvDbk3kk6tYzn8KmQ0N+K7UuS+z59mueiUhM67ag8f1FxryCA2pFzR49
         5Urj5J5hBq8gCCqoyGiekuT/frKZ5tir/lOsIztdbib3BZStIBlz38PeH2SUVyDnos8E
         +KRBufsXEuHgSEfvPfyM0RN/66Qo17MISZQFDqC1ryNWgARcjyKmZtHMpFtyoxJCey8g
         YPLQ==
X-Gm-Message-State: ABuFfohHLi6CXI+50RQwbXQUDqsYyIFkJcs9U9b0Nitb+jWtUm/JHrTH
        XjL8v9kawG7moeixL3M6pDfLx4+4YYt8Se5+MaaD+Q==
X-Google-Smtp-Source: ACcGV63vz/IRpYoNKHYRKy4hpFJg5RCdJ8prWWIUpRQnry5vOEnmebyDkPJst7G4QKubrF9xLrPaQfqoQbgf9bSfRhw=
X-Received: by 2002:a1f:56:: with SMTP id 83mr11832470vka.66.1539896316216;
 Thu, 18 Oct 2018 13:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com> <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
In-Reply-To: <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
From:   Ross Zwisler <zwisler@google.com>
Date:   Thu, 18 Oct 2018 14:58:25 -0600
Message-ID: <CAGRrVHzd86TYe8sE0S88HObDOXKNAfsX9T=GCo0gkTr2n1wDQw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     keescook@chromium.org
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 2:31 PM Kees Cook <keescook@chromium.org> wrote:
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

Ramoops needs a start (mem_address), size (mem_size) and mapping type
(mem_type), right?  I think we get the first two for free based on the
size of the namespace, so really we'd just be looking for a way to
switch between cacheable/noncached memory?

> ramoops will auto-configure itself and fill available space using its
> default parameters, but it might be nice to have a way to store that
> somewhere (traditionally it's part of device tree or platform data).
> ramoops could grow a "header", but normally the regions are very small
> so I've avoided that.

Several of the other modes (BTT and DAX) have space for additional
metadata in their namespaces.  If we just need a single bit, though,
maybe we can grab that out of the "flags" field of the namespace
label.

http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf   section 2.2.3.

Dan, is this workable or is there a better option?  Is it a useful
feature to have other types of namespaces be able to control their
caching attributes in this way?

> I'm not sure I understand the right way to glue ramoops_probe() to the
> "seed-device" stuff. (It needs to be probed VERY early to catch early
> crashes -- ramoops uses postcore_initcall() normally.)
