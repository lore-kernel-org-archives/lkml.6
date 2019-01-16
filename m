Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B421C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14C3206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/BWr3r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfAPV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:59:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbfAPV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:59:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so3681426wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qIfL8Zi2BtD5K9xGzCCu2hOnxmvhp5ChjrJu31awZE=;
        b=f/BWr3r+8ex/j4S381sHZg6EeV8ry9z0Atj7CQIjjMV7CZ+VkFOL626b6L+T9/e8qH
         AV55WLrud4Z4wCUYOTIx70Ml2zS1spEnZ4VVP8XBn8jY5XvSwp3OoEPj+K7Bi4auqhxf
         PYbpsbR6Uhwn3TT3iH7OOzj+6mUTRGkdMWYxbpAmgVfWkXJDvOmFcAGfvI34+w5d7ieB
         QpIkx+ZHiFXH1BUhTDbv1uBfRRLvHsd2DrcWWtc1EU6tw/zlRRSrsnT0jfByq5fhujJV
         XI37In3FiNudTdvS0CgWnxzHiqTZXSzGllKziYiEvehtdcadEXf+dT9BsYM0VtfUwTFt
         YsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qIfL8Zi2BtD5K9xGzCCu2hOnxmvhp5ChjrJu31awZE=;
        b=SUE3dMiWNjM2IWBFL8GkwbE8tYQ67EdbVGTjBssceF6DsW5wE2M4TBsl/TQN5I4x8V
         NZO4kg7/DvsTu1x0yJR48LLsdoC2lOGReGhj6EYKwik2w0OJM/yrt9cUYwenpTwsVL20
         PCqm7dWzb2LnhBzM2ForlLtMjpV5lt0yfViFWPFx3gYx0frpMzUdgC5g8a7srB354hon
         FYQADbtycEDOfxINBtXufdZ/2iYKg5i/G6dhfX+ewOeRV18kyQkyDyaJ+/isJVnlnI1d
         H6Cm/1Czn1KzjenIcM3Y7nob1Y68Jz5lKoQAQLzNNpX8fFkDPZ1hzEPfVgCLPULMuEAA
         ff9g==
X-Gm-Message-State: AJcUukcZN12LfXo2I7ToG3nDGhYGyGw43WIQeSGLlGP8KcCIu5UA7BC8
        GwQk8lw12I+d2iJ7H0HYicFCujmVkSUO/Kk7K36/
X-Google-Smtp-Source: ALg8bN7DFQ+VFScKFhjl+kHX02LbzQtshD6fLYiI7hu9xwk9q+DRsE0s/fr3ogHGivCalOmsl3MbopOjws5wT8biNJA=
X-Received: by 2002:a1c:5984:: with SMTP id n126mr8847488wmb.62.1547675980793;
 Wed, 16 Jan 2019 13:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <20190116181905.12E102B4@viggo.jf.intel.com>
 <CAErSpo55j7odYf-B-KSoogabD9Qqt605oUGYe6td9wZdYNq_Hg@mail.gmail.com> <f786481c-d38d-5129-318b-cb61b6251c47@intel.com>
In-Reply-To: <f786481c-d38d-5129-318b-cb61b6251c47@intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 16 Jan 2019 15:59:28 -0600
Message-ID: <CAErSpo6xjELcvj1jZ20UZS-rEHr-kNioPFTjWR9K3CuZq8ecmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal RAM
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave@sr71.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 3:53 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/16/19 1:16 PM, Bjorn Helgaas wrote:
> >> +       /*
> >> +        * Set flags appropriate for System RAM.  Leave ..._BUSY clear
> >> +        * so that add_memory() can add a child resource.
> >> +        */
> >> +       new_res->flags = IORESOURCE_SYSTEM_RAM;
> > IIUC, new_res->flags was set to "IORESOURCE_MEM | ..." in the
> > devm_request_mem_region() path.  I think you should keep at least
> > IORESOURCE_MEM so the iomem_resource tree stays consistent.
>
> I went to look at fixing this.  It looks like "IORESOURCE_SYSTEM_RAM"
> includes IORESOURCE_MEM:
>
> > #define IORESOURCE_SYSTEM_RAM           (IORESOURCE_MEM|IORESOURCE_SYSRAM)
>
> Did you want the patch to expand this #define, or did you just want to
> ensure that IORESORUCE_MEM got in there somehow?

The latter.  Since it's already included, forget I said anything :)
Although if your intent is only to clear IORESOURCE_BUSY, maybe it
would be safer to just clear that bit instead of overwriting
everything?  That might also help people grepping for IORESOURCE_BUSY
usage.
