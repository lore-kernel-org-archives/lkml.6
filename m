Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28340204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28340204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeJSCPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:15:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40192 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeJSCPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:15:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so30678931ota.7;
        Thu, 18 Oct 2018 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDBJm4nqmeaWFBJegkp3BQkCCdXjYEENsmO3iMF20io=;
        b=HBUvxhpk95s/y6cFtokRcxopOoyl8HhOQJOPDc6eLN2yGS81RZDoR+XsB07JlKlwJs
         XkSkLMzIFf8CDiQO3b22TsHwjbQxEWnKn1KerfrGKH57MCFzEhsJRl2Rb2AMuQ0FHZb/
         Xtq7dNXZI/BFl0SjuOk9IJZKSXJXKxa1BJUNhdXQS0wf76uF7HL8Tr0qFZ+ZHcDZZwM+
         v9Sc0NUgaNFgSUTNuk1M9ZKm3FcZPGgefLIl+hodu72Ofox1fc9Pdmg9AQv3NmdRwHBN
         Ic/av9NT3Zmz5k0uOQFyPxN8hCKwmVWnl2gSxAiHkbsAWy3S9W04ia231mgleWqXpVAe
         vOYw==
X-Gm-Message-State: ABuFfojGSIwa/I9AIloMkYk8Hss14mVdNNDmimQxBSAQ2ZtU5/MzHh7Z
        ia405YgZRvJrmriPeH1ePQ==
X-Google-Smtp-Source: ACcGV60nfGlaU/lcwaRenMZMvmmeXcFbwlfgCJJenxTqj8a+3KPHewNwOEJ2JrqNvTrBGvXgP5PmWg==
X-Received: by 2002:a9d:2e30:: with SMTP id q45mr18918099otb.69.1539886419710;
        Thu, 18 Oct 2018 11:13:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w128-v6sm5629737oiw.15.2018.10.18.11.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:13:39 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:13:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
Message-ID: <20181018181338.GD15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:37:29PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> If overlay properties #address-cells or #size-cells are already in
> the live devicetree for any given node, then the values in the
> overlay must match the values in the live tree.
> 
> If the properties are already in the live tree then there is no
> need to create a changeset entry to add them since they must
> have the same value.  This reduces the memory used by the
> changeset and eliminates a possible memory leak.  This is
> verified by 12 fewer warnings during the devicetree unittest,
> as the possible memory leak warnings about #address-cells and

Still missing the rest...

And what about my other comments too?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since v3:
>   - for errors of an overlay changing the value of #size-cells or
>     #address-cells, return -EINVAL so that overlay apply will fail
>   - for errors of an overlay changing the value of #size-cells or
>     #address-cells, make the message more direct.
>     Old message:
>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>     New message:
>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
> 
>  drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
