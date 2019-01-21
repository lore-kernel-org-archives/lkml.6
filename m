Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506BC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334892085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTm518DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfAUOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:44:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38391 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfAUOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:44:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so15683804lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RHf2FDgu2eha7U5ZncUquSbcgdedrdNiXzFGAhlRcts=;
        b=DTm518DYYutI1o5xoVH4pXLO64n6BouRr99pmEySdOJ3L5XGNZs6B2YPiKttuKkxlh
         x4OxiJ/WIkTJ/RqpNIBtMf3bS8O5JwUmXcI9gxDt8ATqVrzbESBGHBBswpq0gJg5zkz5
         s6hnml04kGMwyUNMSRoeuD3ev3snp+YlVOxURqvTwLHG3SsEsPUl1M+HdnL4x4Gs4eGD
         ZguM2123AIHckauNRrTJXvxe7d+QnGAM86VWQ5N22MOsrW2VjsNlSX4o028c6B6c3mz2
         x8PADEogaGeliYEZk8NoyM5S1EjgvpzdvSlmuMRkph97tlzn4di7D1NrVDVEaKjud5kN
         IjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RHf2FDgu2eha7U5ZncUquSbcgdedrdNiXzFGAhlRcts=;
        b=CETiVWz7ltSccmksMDpG8xl5lbwFJeEQiVzJ23CcjNhagrRM420CyaRr8uc2RaOzsF
         XcQql82lAkggn965jdfeh7o/QOEjyza8jj83KTP3ogMavbv0kPjQbqYTIQx9GCurD+NZ
         CgDA/bcngV8PTi3jzUI66AbTPkEnvMaYwXq+4KPfA1CEAh9Yv7/DFbn5SApD9cqpvueI
         PZf8tacZ5l9PlpKXDG897q1kb7zOdWNd4WYd+hnMJipZSx2USAxGbZ3FbtujrX8+EaSB
         Nkl0amFn+OfTZrEBDLrliS1uk74pbJXqlwku4mfG4yKDqeOTDSesOsGlimDrN3XwD7zw
         YhHw==
X-Gm-Message-State: AJcUukchSVooIBXMvSNe/N+MIIUedfEAHYCKKWFotw5Zm/E91UPhTpj5
        AADG5bP4OOPBlJShynhnr7vTCSvkFIyuTg7Ivh/KT0nq
X-Google-Smtp-Source: ALg8bN4WQdkQY8dpbtooBfpDAUMXidNfcf1uXsQlbUeeHqVtFM6Z/bpPMhvizzYrzXrCUkJ3ysfunmzqvi0wu5l+3Ro=
X-Received: by 2002:a19:6514:: with SMTP id z20mr17614616lfb.31.1548081875592;
 Mon, 21 Jan 2019 06:44:35 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 21 Jan 2019 15:44:24 +0100
Message-ID: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IMHO you are missing: 41d1c8839e5f8cb781cc635f12791decee8271b7

Which should be marked for stable, it fixes:
https://bugzilla.kernel.org/show_bug.cgi?id=202235
