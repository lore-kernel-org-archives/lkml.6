Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B1C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8A620859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uZRKdTAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfBTWOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:14:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44420 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfBTWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:14:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so42873481otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVjBnSUI6LhspCqy+73O1/b+atYXeJzMReN5ofxv4gU=;
        b=uZRKdTApkbIvtfeHSNDjyAhSJ4BWOMaxzfeM4Z1KuDX5H9f8P/nNvwKiE+kRHCpWQo
         Pzzb8KHWZ2VnG/ITfw2dP7KQ7RX5uNV+ZJpXTaDp4yfG3VLORJdVv4AJNzl39NWjy20V
         bYPkPod9XP5K2AluOq25assvrlESWBmEs+10hqobdZX0Rr0IKEuEZ2TpY+L2qVVDGrtW
         jLuR5/oylrEgiR/2eMJ9MbgqLWjg6QyWBEpUazDYmiC4jkdLmyjnsKnj6aCCN5Rkd1b/
         nOCO5ydPM6xlBo0b9rxwC3a+4g2Ut+35mDt3GLBSRGZ2t06FAGm9awZyVSVvFwWAAejA
         DIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVjBnSUI6LhspCqy+73O1/b+atYXeJzMReN5ofxv4gU=;
        b=JedRXGy6WbffTmBSVc6vPQrmJACSL0nbZBQJ9kgYHbkfXROSj+PYWQjRRZlKt5ysdP
         TEdG5zWDRJjz6F5BB5xC/HqjuTHrc8hHEBYd02QMXm5/NeWlZzM9XghAdDLJNjbXgyzl
         53RVF3fFhN26QMuIe4bQs2SP4uNsM6W+7Nyl7NebpK/O3C5kA0qdX0SBTlNpKYiRW23c
         k9KM9ZwPIrvBALShgM8Iv5svjnj2FM/Y32zEXNkMj0apQLoE6RUKcWk30xJhdoEi/Y1d
         4Eqvwius3Jox6k1h6mN1FCg229eQTPpecKoA++VxRIxqopY48Tpvh5ZB7/b+g9NdU6mo
         yQ+w==
X-Gm-Message-State: AHQUAuZvGHKzY59jRx7R5s3aYt1F9wxSWzLAmhH1d9m8aoBVf+g/HTvk
        qcw8bh07QN/rvnTHBJvtlx+ADlqaLA7C8qOPvF7vpA==
X-Google-Smtp-Source: AHgI3IY0GyUmAI/F9u0gGK3DKJZ+Md1zuqirUF+1bxatdGk67V7iWwe2Co33YIOqW9sjrBC59CPTREFBBrgJ5hH/5nw=
X-Received: by 2002:a9d:37b7:: with SMTP id x52mr24320675otb.214.1550700845305;
 Wed, 20 Feb 2019 14:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com> <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com>
In-Reply-To: <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Feb 2019 14:13:53 -0800
Message-ID: <CAPcyv4iP032bqAgCZ8czRXkJ_gXz0H1EVC+ypf6NhKQ65aKczg@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 2:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/20/19 2:02 PM, Rafael J. Wysocki wrote:
> >> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> >> index c9637e2e7514..08e972ead159 100644
> >> --- a/drivers/acpi/hmat/Kconfig
> >> +++ b/drivers/acpi/hmat/Kconfig
> >> @@ -2,6 +2,7 @@
> >>  config ACPI_HMAT
> >>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> >>         depends on ACPI_NUMA
> >> +       select HMEM_REPORTING
> > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > as a user-selectable option is a good idea.  In particular, I don't
> > really think that setting ACPI_HMAT without it makes a lot of sense.
> > Apart from this, the patch looks reasonable to me.
>
> I guess the question is whether we would want to allow folks to consume
> the HMAT inside the kernel while not reporting it out via
> HMEM_REPORTING.  We have some in-kernel users of the HMAT lined up like
> mitigations for memory-side caches.
>
> It's certainly possible that folks would want to consume those
> mitigations without anything in sysfs.  They might not even want or need
> NUMA support itself, for instance.
>
> So, what should we do?
>
> config HMEM_REPORTING
>         bool # no user-visible prompt
>         default y if ACPI_HMAT
>
> So folks can override in their .config, but they don't see a prompt?

I would add an "&& ACPI_NUMA" to that default as well.
