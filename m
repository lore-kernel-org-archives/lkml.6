Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AFD2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYLpMfRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AFD2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIDRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:21:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42246 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIDRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:21:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so3034892ljc.9;
        Tue, 04 Sep 2018 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4e35L913xDSr0j/xovhj2vcLPquVwCJsUv7PuGFvYU=;
        b=IYLpMfRi1dgbLag2986Kx1Jsyg9gUkpTcCpaltlCOwgG+BvBkncL4WBvOphT5NZAYl
         ZVQN6tYboV0K9x5RNtNlk9jCrcVcuHTPSJY2Wr7FU48iWQ7EvwHqW8KOyoRF8gQm/Wcw
         cZ5EBZk56OF5jyLiHr6JGCV3OsFSYye/cEGDmLhKk88U2g5p87Km8jbZPKE51ohvthbH
         cV9amOipakYnHOwPtm381RicX7G7iY+S2NpBjQ1mtyp9302UpfU5lYQRAft1uqx2Aexl
         NyF+hbgKb9/Tned0d9eNSjWZi5/ojNvW19227GFVgvuMZ+yOK69PAfL6Hx5aA/KImJvR
         adKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4e35L913xDSr0j/xovhj2vcLPquVwCJsUv7PuGFvYU=;
        b=i2n7hDsPbk/lKGrwbobpjLXQ+0NfIKaB2gj54/Oqx3IlRInRkFVJNpHpdwQ3QOduVp
         o+3DwLkhkQy7BTFfzAaRKJzIfwEP+DcSfkcAz609LlyTwFLFMj3/sPvxKlU1YX1b8wPT
         A6rlsnWtK70NLbuVFWcP7p+i0aSsvwH/Xe8W9a7z4pa8DNJ3Gfn4haHy0DKlVH/0Ovnn
         GumPo4jBqBNPBELXt7ONCkH+cmTEiwxN76iLzZ4IOgXLJpFoiTElsadVOYKXlt40w8GB
         LflZFCWc0yaRnImPMvIJpuOO73NNMB2gxEWQ+myfJvE4ER2DGkTw3PGOm/ZioOtPs6dr
         nBwg==
X-Gm-Message-State: APzg51D5pZ/xp0Hz+gjn/84Xx8rKhRHmMkeDwIq5ESaOlLTWvwB+3fgG
        +hvLKYJDuGzbeSbDTaFWapgvUHor
X-Google-Smtp-Source: ANB0VdaeHYdfhBjUorG+jdUpHjNjdNQVBPZMrh8WbYtBL5coBY8+y1wqTiInyrYcvmAowHDQBW7F1w==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr7007740lja.76.1536065776240;
        Tue, 04 Sep 2018 05:56:16 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p9-v6sm4040926ljh.0.2018.09.04.05.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:56:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxAsa-0001eB-Dc; Tue, 04 Sep 2018 14:56:24 +0200
Date:   Tue, 4 Sep 2018 14:56:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 6/9] net: bcmgenet: fix OF child-node lookup
Message-ID: <20180904125624.GS28861@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-7-johan@kernel.org>
 <683bdf11-a662-d17e-8bc5-b3cfd238e463@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683bdf11-a662-d17e-8bc5-b3cfd238e463@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:47:33PM -0700, Florian Fainelli wrote:
> On 08/27/2018 01:21 AM, Johan Hovold wrote:
> > Use the new of_get_compatible_child() helper to lookup the mdio child
> > node instead of using of_find_compatible_node(), which searches the
> > entire tree from a given start node and thus can return an unrelated
> > (i.e. non-child) node.
> > 
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the node of the device being probed).
> > 
> > Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
> > Cc: stable <stable@vger.kernel.org>     # 3.15
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for reviewing.

Rob's gotten the helper into -rc2:

	36156f9241cb of: add helper to lookup compatible child node

so feel free to pick this one up directly to whichever net tree you
prefer. I've been able to trigger crashes after probe deferrals due to
the use-after-free, but this seems unlikely to be exploitable.

Thanks,
Johan
