Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D676F21B1A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgwUQ+on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfBLKZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:25:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39907 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfBLKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:25:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so1086104pfa.6;
        Tue, 12 Feb 2019 02:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbfa47FKIarHJs9DYsn8FNr6DF5wjBQdt8qn6ru3eH4=;
        b=WgwUQ+onrzoOzGT5x7InAr9RUnNdDiw127lk/jmc30D2sY+Si2MZU+aAYlqDa6MiwA
         hkQKMThpqfNwSc6RcCFVC7sCQc5mICZN/T1jU4ezCRtDaa+viNe3+jnAEZqy/bJmMhYd
         UUPZKPdE310OeW5dlH5TtrIBL5p7p1WNztDRsjspLCfMs2cXtiwmlQNRTj+vIZpXEZh8
         yMh48riFoc8UcUub8mPy6akilC0un6/JAsg+L6AO6aRzDBmUi2StGDXT3yS7vGa2gEk4
         B3RLzQUDscNP6c+MBW7I76/JOZY90g5tyoce/7ymKkwRt3DBtGIjWaOdNn9QIzEozW1w
         io+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbfa47FKIarHJs9DYsn8FNr6DF5wjBQdt8qn6ru3eH4=;
        b=bcZ4gFbYy9KrXUU42rHkbHR+7hQcPzr1pKyQs+NFyNPmA8PfAIPT8WSvGgoVk9EQzq
         GbFO2+Ke1Wzx3l7t5AJNUMDCGBXVENKk66PKtJTz3/efDlaV9l0Gc5qdxzudJFq4v1ob
         MIwGbuDyylKdZheidmbyQ6Vm9iatmzA4OLuAv7jA+iUPl0UXb/ZnBDt2eeAOJGTlXl10
         Xhq0jeuiDefbmaDcbcBbGp0IntpY0B15w6VkgZeQ+K89eeb+WmryNzX/IWYwPEMxwOgn
         AfPTXZoHrvuY3TmNr5dAJONt7fDzyFJ/h3A9GmxS/0DnGPL8Y9teEynMcb7QL4izNyzZ
         7gPA==
X-Gm-Message-State: AHQUAubE8nCZWPAiX4kFUBNQ7g/m+m1nBg3mJKjYSDVRpoH7WRl12XuD
        /io58xf0xen6Nol5ts3milFDS+CgqycJaG8VHd0zuUMd
X-Google-Smtp-Source: AHgI3Ib/AiBDVXNA3zFjmn+UP6LLFF6aHySFPnaEFJflLBXQqOmgeouaQ9sLWC5EPtEJFQ0IEohRztF57BngIjVYg8c=
X-Received: by 2002:a63:d450:: with SMTP id i16mr2947574pgj.246.1549967119759;
 Tue, 12 Feb 2019 02:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-10-rajneesh.bhardwaj@linux.intel.com>
 <20190211164118.GA23796@genxfsim-desktop> <78e5e6b3-5712-6ef5-283c-83b0f6d3dcc7@linux.intel.com>
In-Reply-To: <78e5e6b3-5712-6ef5-283c-83b0f6d3dcc7@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:25:08 +0200
Message-ID: <CAHp75VeZwgM9KPNahmpsLzzkmOKDN2JeBKQWO9hBK_O=Gk8oFw@mail.gmail.com>
Subject: Re: [PATCH 09/10] platform/x86: intel_pmc_core: Add Package cstates
 residency info
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Anshuman Gupta <anshuman.gupta@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:32 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 11-Feb-19 10:11 PM, Anshuman Gupta wrote:
> > On Fri, Feb 01, 2019 at 01:02:33PM +0530, Rajneesh Bhardwaj wrote:
> >> This patch introduces a new debugfs entry to read current Package
> >> cstate residency counters. A similar variant of this patch was discussed
> >> earlier "https://patchwork.kernel.org/patch/9908563/" but didn't make it
> >> into mainline for various reasons. Current version only adds debugfs
> >> entry which is quite useful for S0ix debug but excludes the exported API
> >> that was there in initial version. Though there are tools like turbostat
> >> and socwatch which can also show this info but sometimes its more
> >> practical to have it here as it's hard to switch between various tools for
> >> S0ix debug when pmc_core driver is the primary debug tool. Internal and
> >> external customers have requested for this patch to be included in the
> >> PMC driver on many occasions and Google Chrome OS team has already included
> >> it in their builds. This becomes handy when requesting logs from external
> >> customers who may not always have above mentioned tools in their integrated
> >> kernel builds.

> >    Tested-by: Anshuman Gupta <anshuman.gupta@intel.com>
> >    Acked-by: Anshuman Gupta <anshuman.gupta@intel.com>

> Hi Andy, Darren - Can i used Acked-and-tested-by instead of these two?

Better to split. I didn't see in common practice acked-and-tested.
Rather reviewed-and-tested, or reported-and-tested.

-- 
With Best Regards,
Andy Shevchenko
