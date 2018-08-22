Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC087C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3uHYz87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB4F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeHVR5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeHVR5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:57:33 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E3221528
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534948344;
        bh=r+/uy4/GSEU3ms8it4N4w5h8LKfcGyk79CJhOskoNtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3uHYz87dwXCCvaEmA9LV4A3NbSr34+v1ot8CKv17uJ9P79BfmO41PrtqMnk+G0c2
         K9OleDl4WYBrMgmGYu4O6cFsmaAVIyBtQSx0+vzlu4Wd/moPJU9Ju4h9c5Am4C5Uu7
         rZUJMjT152WpkDZI3CGPYMUXwyQjBcHRd4nn+OfI=
Received: by mail-wm0-f50.google.com with SMTP id c14-v6so2224975wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:32:23 -0700 (PDT)
X-Gm-Message-State: APzg51APwwVyu4YOIAsoNd1BsxT/z9anaN3J5cFkKqpwpt/EM6wqeLMP
        nARmu+z25YdLKL0jxWkXTq35cTuaf75Tbp4o4nAmJw==
X-Google-Smtp-Source: ANB0VdaRl0t+3q16TSUSQw0KpBnUsp4F/6LFKXIWyWY6Jj/VvuYA31RizzJWLBp4h7+jNKUk7YAmzvrPj2nZd9wKJrA=
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr2515245wmb.133.1534948342406;
 Wed, 22 Aug 2018 07:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180822105547.9634-1-johan@kernel.org>
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Aug 2018 09:32:11 -0500
X-Gmail-Original-Message-ID: <CABGGisx6CDoDqxTo=q=jKBAb19Xx38N6pR=XrwzBHuSDtp_Wcw@mail.gmail.com>
Message-ID: <CABGGisx6CDoDqxTo=q=jKBAb19Xx38N6pR=XrwzBHuSDtp_Wcw@mail.gmail.com>
Subject: Re: [PATCH 0/9] of: fix compatible-child-node lookups
To:     Johan <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ck.hu@mediatek.com, p.zabel@pengutronix.de,
        Rob Clark <robdclark@gmail.com>, airlied@linux.ie,
        Ulf Hansson <ulf.hansson@linaro.org>, rainyfeeling@outlook.com,
        boris.brezillon@bootlin.com, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, sameo@linux.intel.com, sre@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:57 AM Johan Hovold <johan@kernel.org> wrote:
>
> Several drivers currently use of_find_compatible_node() to lookup child
> nodes while failing to notice that the of_find_ functions search the
> entire tree depth-first and therefore can match unrelated (non-child)
> nodes.

That is not quite right. It searches all nodes following 'from', so
not the entire tree unless 'from' is NULL. The purpose of 'from' is to
iterate to find all compatible nodes. But you are correct that anyone
calling of_find_compatible_node directly with from != NULL is wrong.

I'd really like to make of_find_compatible_node() function as
searching all of the sub-tree as that should be what all the callers
want (unless they've open coded for_each_compatible_node). Though
maybe 2 functions to search the whole tree and just immediate children
is best.

Also, it would be good to remove the type parameter as device_type is
deprecated (mostly). It looks like most if not all callers setting
type could drop it and just match on compatible. It seems to just
serve as additional validation of the DT.

> The fact that these functions also drop a reference to the node they
> start searching from (e.g. the parent node) is typically also
> overlooked, something which can lead to use-after-free bugs (e.g. after
> probe deferrals).
>
> This series adds a new helper, similar to of_get_child_by_name(),
> that can be used to lookup compatible child nodes, and uses the new
> helper to fix child-node lookups throughout the tree.
>
> This is related to the fixes I posted about a year ago, which addressed
> a similar anti-pattern when looking up child nodes by name. Since it
> took me more than a year to get all those fixes into Linus' tree (one
> fix is still pending), and as these fixes depend on the new helper, I'm
> suggesting that these all go in through Rob's or Greg's trees.

I'm happy to take them or apply the dependency now and then anything
not picked up by sub-maintainers for 4.20.

Rob
