Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A04214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLRu8TFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A04214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeLFDHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:07:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42778 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFDHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:07:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so18807397edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duaU23knQ88/JeQ9XKeIbq22/brl1MX2UJZiXJq07To=;
        b=lLRu8TFV6kzb4NkJw4tuddMmks1Ud4njuauTYV6b3Ihkr5QvSafjlHhioCw2iOQMEn
         tVOMCbyhyNXbx8WW1quvwwSi4omVAupOKjIMSGgZtlrgvFVRQqp3MphEV81Tl+xOsWju
         ZrGcIGv18s5IZAFF0Hp4KYMDrmkPtuywOebMGLI3+RpQ+MXEFWwPEZqd5ysts7L31E2d
         Z0fNbHG27lFawIBd+2X/6mGfSmn1uQHOe3yOJR1lGlVQuV8jJRgQkui3O6INscFbIRZn
         8t2DEiyzDvY3OPEiYSXpnKwKBsYqjVXSKsWG+99lCZBUL9y9WOxISynne8awuvFsFwjS
         eUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duaU23knQ88/JeQ9XKeIbq22/brl1MX2UJZiXJq07To=;
        b=J6IoTI6NEJg6L2aQcl0G0m9QpDL9IIC9ug6ApCGUX95JvEaSI0KxnCla9dlQBh/ZBB
         0lpAaVOGqXX1MUHMtiQFg/juKp/02hqJ3REYYlIDGeGFPjXbDgTBogTSx8UowP4I39DG
         509GBf2S4RzLMfIZDgV0e2o9UKRQDX0TAsNwGRrwgPheAz0l81DDijLBq/HbtFj/M/Ue
         jmVbs31y/7h3XqKLxHbPPOyjXH+hJUKW3GItrmJF0qRrmuvZA2+5k0fxkLG/aF+lXLUF
         QB3uugqCFntGdonGwpfKx+E9Ot7dmrM3jaW9BKCnLIXK96J3HzLzPHUIqtFwq4cjK0SG
         M0fQ==
X-Gm-Message-State: AA+aEWY0+Ch1GjxvfmvAmSpSy+9gRtfDSj3S6zlnwx+tzp1jSGFtausZ
        LoIaqUtXQd/OE++Pefwy+QFDFxZTzyX0rFk62A==
X-Google-Smtp-Source: AFSGD/WUszKfJrce0CFwE/+EhnR9TXLW3IAYXLbxAWu9TM4LhB3r+KgmhfVEJgZC8uDXOiDu+WiuWmMd4GzTzHeq984=
X-Received: by 2002:a17:906:2acf:: with SMTP id m15-v6mr20117364eje.180.1544065665329;
 Wed, 05 Dec 2018 19:07:45 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz> <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz> <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz> <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz>
In-Reply-To: <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 6 Dec 2018 11:07:33 +0800
Message-ID: <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 5:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/5/18 10:29 AM, Pingfan Liu wrote:
> >> [    0.007418] Early memory node ranges
> >> [    0.007419]   node   1: [mem 0x0000000000001000-0x000000000008efff]
> >> [    0.007420]   node   1: [mem 0x0000000000090000-0x000000000009ffff]
> >> [    0.007422]   node   1: [mem 0x0000000000100000-0x000000005c3d6fff]
> >> [    0.007422]   node   1: [mem 0x00000000643df000-0x0000000068ff7fff]
> >> [    0.007423]   node   1: [mem 0x000000006c528000-0x000000006fffffff]
> >> [    0.007424]   node   1: [mem 0x0000000100000000-0x000000047fffffff]
> >> [    0.007425]   node   5: [mem 0x0000000480000000-0x000000087effffff]
> >>
> >> There is clearly no node2. Where did the driver get the node2 from?
>
> I don't understand these tables too much, but it seems the other nodes
> exist without them:
>
> [    0.007393] SRAT: PXM 2 -> APIC 0x20 -> Node 2
>
> Maybe the nodes are hotplugable or something?
>
I also not sure about it, and just have a hurry look at acpi spec. I
will reply it on another email, and Cced some acpi guys about it

> > Since using nr_cpus=4 , the node2 is not be instanced by x86 initalizing code.
>
> Indeed, nr_cpus seems to restrict what nodes we allocate and populate
> zonelists for.

Yes, in init_cpu_to_node(),  since nr_cpus limits the possible cpu,
which affects the loop for_each_possible_cpu(cpu) and skip the node2
in this case.

Thanks,
Pingfan
