Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F11C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CFA2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6j8lBNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CFA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbeIFWi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbeIFWi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:38:57 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A842086C;
        Thu,  6 Sep 2018 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536256940;
        bh=g1ok7CjF4A9I5owlrp4BhWLbhOJWera5vZfKGtvp8ZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m6j8lBNXO18aSYlf+jqKh4ZowTY8IraNeYYeMlNCuwXKOnC3IcfEyMgf25xoWW9FX
         aSOfKkN6dlO2sINMgfp7ReIOopnYi/UDusq7XFeQlkwHFDwpcrVEewhXFUWnNc2Xcw
         DMTKwtc5hMKYC7100sUrJfQEDzXy35GOz08cGNRw=
Received: by mail-yb1-f179.google.com with SMTP id m123-v6so4480043ybm.0;
        Thu, 06 Sep 2018 11:02:20 -0700 (PDT)
X-Gm-Message-State: APzg51CZa/yP//JvXhaTl4qPiG4+1pgEs8zJKFJWPLXDHVgkNPTrrA+O
        3WXAWg9OdYwIZykKDmcqxwEUI6d0tY/DMU5UhFU=
X-Google-Smtp-Source: ANB0VdafUXH484FSVUEjh31aVqtJNNTV0YOkL0/q1ZaZea5T8ZTUHWcrdib4STs/EWixHlQKh54oroWiAbO61fIxFDo=
X-Received: by 2002:a25:8b86:: with SMTP id j6-v6mr2183664ybl.88.1536256939341;
 Thu, 06 Sep 2018 11:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-6-atull@kernel.org>
In-Reply-To: <20180904212237.3078-6-atull@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 6 Sep 2018 13:01:42 -0500
X-Gmail-Original-Message-ID: <CANk1AXTiHNV7ovn8nLsA9peCqeoa95Oytevijy1Eh2novAg=ZA@mail.gmail.com>
Message-ID: <CANk1AXTiHNV7ovn8nLsA9peCqeoa95Oytevijy1Eh2novAg=ZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: fpga: fix freeze controller
 compatible in region doc
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 4:22 PM Alan Tull <atull@kernel.org> wrote:

OK I left off the DT folk.  I'll resend this one patch separately.

Alan

>
> Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> regarding the freeze controller bridge, secifically:
>
>  compatible = "altr,freeze-bridge";
>
> The compatibility string should be "altr,freeze-bridge-controller"
> as set forth in altera-freeze-bridge.txt.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
> ---
> v2: no change in v2 of patchset
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
