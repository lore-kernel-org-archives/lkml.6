Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2711BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AA7208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca5c+PHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AA7208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeGPO2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeGPO2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:28:34 -0400
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144D520BED;
        Mon, 16 Jul 2018 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531749659;
        bh=dEs+NUxpAa8Bni5/v5JDlF+zK4KvFbECxPnyy0xurjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ca5c+PHRvlrXyJPBceBayHn0zRuaJHkx1kHpb6GPuYsgC7tXLCUJBxMPP+KKwUbSv
         TVFmDMUmdte7ql5O4ibWl0MoGWsPYRZJ/osiH9uq3O/yiMzSgTN1LhgCw5tOp1ScFH
         7FkSpkFe7HQ++S0nm33gOlQWjd1XklQH80M9khgc=
Received: by mail-it0-f51.google.com with SMTP id s7-v6so20975188itb.4;
        Mon, 16 Jul 2018 07:00:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlF8sDI7CnMETSD9ZRJdyDLK9EX+xjuHIXVzvk8I5Jg40+xPvm4x
        +0cTWIs8M0PXgGdk+5Hdv0aknHTZ6/cyp25XYA==
X-Google-Smtp-Source: AAOMgpfv51K5tjbUTht0787PRAKLu9i/foChHNjgyIVLBCVzZQpEnrw4roLPDRt/vycYmPDFlZh0Y9BLB6/+NxEZbrs=
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr14568707jaj.131.1531749658476;
 Mon, 16 Jul 2018 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
 <1530797585-8555-9-git-send-email-todor.tomov@linaro.org> <20180711160713.GA29354@rob-hp-laptop>
 <CAA3CUABj_udpu1yAGGd070_uLNYLbTYEHb_sbHLheUErkPnYtQ@mail.gmail.com>
In-Reply-To: <CAA3CUABj_udpu1yAGGd070_uLNYLbTYEHb_sbHLheUErkPnYtQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Jul 2018 08:00:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLm7bMf5PgQa0vQR4ERApzdv+wOHfayOG7GdMtDKDJdbw@mail.gmail.com>
Message-ID: <CAL_JsqLm7bMf5PgQa0vQR4ERApzdv+wOHfayOG7GdMtDKDJdbw@mail.gmail.com>
Subject: Re: [PATCH v2 08/34] media: camss: Unify the clock names
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:53 AM Todor Tomov <todor.tomov@linaro.org> wrote:
>
> Hi Rob,
>
> Thank you for review.
>
> On 11 July 2018 at 19:07, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jul 05, 2018 at 04:32:39PM +0300, Todor Tomov wrote:
> >> Unify the clock names - use names closer to the clock
> >> definitions.
> >
> > Why? You can't just change names. You are breaking an ABI.
>
> Main reason is that this change allows more logical names and
> handling in the driver when support for 8996 is added.
> To clarify by example:
> - we used to have "camss_vfe_vfe" in 8916;
> - now we will have "vfe0" in 8916 and "vfe0" and "vfe1" in 8996.
>
> To achieve this I have changed the names to match more closely
> the definitions in the clock driver, which are based on the
> documentation. Yes, I should have done this the first time...
>
> I have used to update the dt and kernel code together. Yes, the
> change breaks the ABI but does this cause difficulties in practice?

That's up to the platform maintainers to decide. As a user of these
boards, yes, it would bother me. However, camera I don't care so much
about.

In any case, the commit message should make this crystal clear and
justify why breaking compatibility is okay.

Rob
