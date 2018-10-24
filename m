Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C7ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DFF20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+ieZtxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DFF20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJYE1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeJYE1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:27:08 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C1E20833;
        Wed, 24 Oct 2018 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540411063;
        bh=FwSMMBXy4dTKeHHTSnecuMQFteZbKG+ZULO94V/G9pE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B+ieZtxxPkpl7s2uaCNCOQHb8m9Myj+Gcu5doULu5NVKrbelztJ+ImjQpuIoULgKm
         mT3tDOHOMvq+BdcXD5131P5BzLGYh699QThFT7hKSGu/Sylo90x7PwwPDkk32FJYv4
         iJaoDkIPA0Q8tniciTMu8zlX0fExjuW/mWzdpBAU=
Received: by mail-qt1-f175.google.com with SMTP id q41-v6so7080598qtq.10;
        Wed, 24 Oct 2018 12:57:42 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLHRgvpaeb1Mm8p1lSvm9qEum9ydpWSBO59U/l+r9qQyXylZJAB
        Tx7YCLwLlmvLkHo706UJiTO0iuklkcbcTHyPmA==
X-Google-Smtp-Source: AJdET5dz2pAxrLhL1s78L9G/BjFv/eV20ClHTl+pz2d+Vc1RRTtvEwx8YK8gPVn10dkAVdEWTBKPxZyRtiiBa2FaSoM=
X-Received: by 2002:a0c:8c86:: with SMTP id p6-v6mr3772591qvb.246.1540411062071;
 Wed, 24 Oct 2018 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com> <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
In-Reply-To: <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Oct 2018 14:57:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
Message-ID: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
To:     Alan Tull <atull@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 4:25 PM Alan Tull <atull@kernel.org> wrote:
>
> On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
> >
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > Add checks to (1) overlay apply process and (2) memory freeing
> > triggered by overlay release.  The checks are intended to detect
> > possible memory leaks and invalid overlays.
>
> I've tested v5, nothing new to report.

Does that mean everything broken or everything works great? In the
latter case, care to give a Tested-by.

Rob
