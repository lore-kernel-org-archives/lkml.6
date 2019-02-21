Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB24C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76D020855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550756313;
	bh=uAMaiLhiv31m+NQrRyBJDgZcwez/ICrSLarz8k233wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AYTAhfRY2Z/kVSYE8ynx9KuU+s5/NIlppLZKS9kSa9ah1rnfro7VqhH5MWklo6F9r
	 6Xb5026aLLbcT9e8tWHuL7PDgtkyXwNy7cGJfm4a9I9MD/Itn7qg7jy2g2DAAxWyYP
	 oNdTCPfWG/yz5HjqAjf0xm+cxzUSK/66aEtOQVMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBUNib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:38:31 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D0E20855;
        Thu, 21 Feb 2019 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550756310;
        bh=uAMaiLhiv31m+NQrRyBJDgZcwez/ICrSLarz8k233wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TyY5Y0SbOfQTz89pf1dxZTQ8rO++MICcJMO+f2CjGSaVpyHZsVluNKKu+rGSgNtAy
         1A8D4DlkW9sN7ZxcfGLmleAZyPkBVUH+iffIXG3IwJLBtdhVUrv+EKVEHXjyJ1nose
         AUNKeT+coqXWQDhWSiFqtKKU+F17E/VPn4ZlH4BM=
Received: by mail-lj1-f180.google.com with SMTP id d14so12841949ljl.9;
        Thu, 21 Feb 2019 05:38:30 -0800 (PST)
X-Gm-Message-State: AHQUAuYf0VTsrg8rXh0W3FewZ5vtnjQCnR0gnEU2SvrmUli0MPjZ2A/h
        PvntmfhtYedAvVHPcKQt9i0EdGFw6sd2NKQDbhY=
X-Google-Smtp-Source: AHgI3IZZ0OPqnGjS1B9ILUT21BFUL7JbtSVrhFG85yE/q1OGOjRS7OfvVSvCT11cKNgb27dEvBsXQOc6fPH5salwuQw=
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr1541661lja.113.1550756308447;
 Thu, 21 Feb 2019 05:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20190221131722.12278-1-axel.lin@ingics.com> <20190221131722.12278-2-axel.lin@ingics.com>
In-Reply-To: <20190221131722.12278-2-axel.lin@ingics.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Feb 2019 14:38:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfXC-d-YDb4nfwUkkQ7F+h_uSQXZ3OyortPW_Z3Ha7VQg@mail.gmail.com>
Message-ID: <CAJKOXPfXC-d-YDb4nfwUkkQ7F+h_uSQXZ3OyortPW_Z3Ha7VQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel
 implementation
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 14:17, Axel Lin <axel.lin@ingics.com> wrote:
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/s5m8767.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
