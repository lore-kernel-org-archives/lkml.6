Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC957C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8937220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf+TVxli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8937220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIFXGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbeIFXGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:06:49 -0400
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024A220869;
        Thu,  6 Sep 2018 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536258607;
        bh=zAyOvM+tfNpQsdTkCfli93Xl8CoPj0lIt7nvtEwYe/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xf+TVxlitTM7JmPwAbMeGgPT7xasGOSUn05thD9HNH3bD+Un/l2peN+3Z5WzkJ052
         ObipSw+gk8ME5JfOsFGefjvwVMhK78mmYoExb/+BpuYNw6a+kNITkCsCUZ/FUEVFIi
         yJhwEvwLd9uUN9mZH9l6lUSwCvy4pWluIroqcIyw=
Received: by mail-yw1-f53.google.com with SMTP id j131-v6so4430477ywc.13;
        Thu, 06 Sep 2018 11:30:06 -0700 (PDT)
X-Gm-Message-State: APzg51C71MAqx7N/S1NmlS3GtJ0s361YkMl7bpcoFdlaTPEF81NnXEmC
        D/4yJph0IdaxqDa/QEFVE6YGbXpHw6iIqZBYgjQ=
X-Google-Smtp-Source: ANB0VdbXjvpm3HCK591zFm9qJ6xHL0YnQIPWMVXpv2wi84aiO7C5z214jbfaQPPL8hQA3SeYsJAvEXBxbpV2QGrIhvM=
X-Received: by 2002:a81:578e:: with SMTP id l136-v6mr2290486ywb.396.1536258606192;
 Thu, 06 Sep 2018 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180906180152.3620-1-atull@kernel.org> <20180906182359.GB20419@archbook>
In-Reply-To: <20180906182359.GB20419@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 6 Sep 2018 13:29:30 -0500
X-Gmail-Original-Message-ID: <CANk1AXT_U_Sdkvgjwf_2+ryNF7zCjreKZUnFzXt3ZtRWcWz2+w@mail.gmail.com>
Message-ID: <CANk1AXT_U_Sdkvgjwf_2+ryNF7zCjreKZUnFzXt3ZtRWcWz2+w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:24 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Alan,
>
> looks like it's just the examples, right?

Yes, it's in the examples of use, not the actual freeze bridge
bindings doc that I'm correcting.

> So not sure someone
> would be affected by that, yet?

It's taken two years for anybody to notice and complain about it :) so
the effect has not been very terrible.  But it's good to correct it
since it's been noticed.

>
> On Thu, Sep 06, 2018 at 01:01:52PM -0500, Alan Tull wrote:
> > Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> > regarding the freeze controller bridge, secifically:
> >
> >  compatible = "altr,freeze-bridge";
> >
> > The compatibility string should be "altr,freeze-bridge-controller"
> > as set forth in altera-freeze-bridge.txt.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
>
> Acked-by: Moritz Fischer <mdf@kernel.org>
>
> Cheers,
>
> Moritz

Thanks Moritz!

Alan
