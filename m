Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1321AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D3F2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQL/TsYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D3F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935026AbeFMQkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:40:49 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40984 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934388AbeFMQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:40:48 -0400
Received: by mail-ua0-f196.google.com with SMTP id a5-v6so2151340uao.8;
        Wed, 13 Jun 2018 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vKlqzKLNUQyzuvO2xsE1DkhfiDWBVgBuJj2p/IiMitg=;
        b=SQL/TsYE6gqIu7eKDr5vhIAamcpGGrLqFRRJa7vg2iZz65bxfhd6uAUXr/GWsDsT4w
         gt0SphNJexCnIc8fEoy+be4nKmxxukNAI/PHqBGqKuEnwHQC1kmrO/ikXieSTQQNtV7+
         61qaXrJU58IFTDE5Qiww2fOiXJ9yNhSSNZ/t1/piqba6pvtgeGAjEIz92Lzj5wriE7Hf
         umycBiOhEkN81yQ8puncRIt/iW7qpN4de9p+1OWjBgckOxBh/zI1iLm1hOt0ghFcCrFF
         +bQgFOFXxCAe+ZnHBku7Z6mMwcdDaPbCA4kcQONQ6JQEEviAcxsojD14eTb404dwIboA
         k0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vKlqzKLNUQyzuvO2xsE1DkhfiDWBVgBuJj2p/IiMitg=;
        b=nw+TME2QSr/g8LApJHIAOySq9h9U/0D6WFMfDR0Wjx+Mw2IP3CXi08VP1W4dSjihqP
         oxQ+BxT5fG+Eu6/WviABP1dpdpTLpepYt8krQlGvV93QCc2nHWvn18SiWjEM/v4A3C9x
         uUfj65id8AIs0mZzX3GjwFy4V++Kz/rBCn0lbTNYUO43i+QomeY3Yj68zCRlVgsih+8d
         KQXNoiSsRLh7/Eu0jrDwnw0StkSEGoGsLezaupXxQg1m6kw7yUlztV5trrWJv3uGDNGQ
         vWZlfHwxtb/tzedEzu06t+nTwktfel14zhdAtYTK+u2967qiW6ichRxGv1nQk3QWMZWF
         XoZw==
X-Gm-Message-State: APt69E2jDBg7oM+27Z20+0QKKNhC84N1A+RgzRkPCJgH5cS3UjLsZSxN
        dOk1Io2dCLIVDLBhpIw9yxG1In2926eQY6BX5nFSxA==
X-Google-Smtp-Source: ADUXVKKbQDhnPInS/atf61mMxph26P+aMHv+g6jIS10KnsC+cnplFasgPADlJaFROtmxr8JR8RoiepHnyOkolRZFoho=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr3862745uae.12.1528908047286;
 Wed, 13 Jun 2018 09:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 09:40:46
 -0700 (PDT)
In-Reply-To: <20180613140724.GA31698@raj-desk2.iind.intel.com>
References: <CAHp75Vdxz2h1N_bLQ4wxrYoo-kRAHQK=+36Db0BfK1QR4iwVPw@mail.gmail.com>
 <20180609000237.7896-1-david.e.box@intel.com> <20180613140724.GA31698@raj-desk2.iind.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 19:40:46 +0300
Message-ID: <CAHp75VcZgdgwQsNhomvsCy1p_X33MvbcAFpBY2s+SCyL5tbM=Q@mail.gmail.com>
Subject: Re: [V3] platform/x86: intel_pmc_core: Add CNP SLPS0 debug registers
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     "Box, David E" <david.e.box@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        kyle.d.pelton@linux.intel.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:07 PM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> On Fri, Jun 08, 2018 at 05:02:37PM -0700, Box, David E wrote:
>
> I am ok with the design and approach and also verified it on a Cannonlake
> system. I wont insist for a V4 unless Andy feels a need for respin but there
> are minor things that were missed.

> Also ISCLK_OC / ISCLK_MAIN suggestion is missing.

I missed this in discussion, so, please send v4 with settled fixes.

Meanwhile I keep v3 in my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko
