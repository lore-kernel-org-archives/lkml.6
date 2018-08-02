Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2121571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqI1hw2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C2121571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeHBXQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeHBXQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:16:24 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F3C21580;
        Thu,  2 Aug 2018 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533245008;
        bh=sxRFS/jSYoM8xa6jGIw+8CBgwiKawq0DKGUpEGNsjZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tqI1hw2XnHDyYhbpDwXpHC6OHE7nMCawUZgLEuZf9CDMla2xpXCHXRwk+hn/josNo
         5pZ8FBt/rukNFtpiIfsLkkHfZAVWopXcmBWDBSW7Msi5ZB9pCsrf0xM9QKcSFq/x/u
         LK/AqD74xgpr3Bsmh61Mtd5Tde3md50ZdAjjIHVY=
Received: by mail-qt0-f173.google.com with SMTP id n6-v6so4020222qtl.4;
        Thu, 02 Aug 2018 14:23:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlFEarNxKBsrZWM1p3+ssKZsANFxTpegBEVeeyD+Ozq3hs64b/pH
        LzpqnvA8cmCPdwKGcO08z1R+QVzXavZ5BHHtQA==
X-Google-Smtp-Source: AAOMgpcRGquUnVfZMkbCeU3Z6DnS9jD/7cu/HU4nj/8JgmAj2B9+eJRioJTd69jR9MACVvnY1KcfRh5O4LZACvk1aiA=
X-Received: by 2002:a0c:98c1:: with SMTP id g1-v6mr1170898qvd.27.1533245007740;
 Thu, 02 Aug 2018 14:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
 <1533061333-7680-2-git-send-email-pheragu@codeaurora.org> <CABGGiswcMicPypOz2eW01NosuAHUw2B3KVxzrOfanEfT=Srf9A@mail.gmail.com>
 <4d6732e9172431bbf24ff470be345481@codeaurora.org>
In-Reply-To: <4d6732e9172431bbf24ff470be345481@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Aug 2018 15:23:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMouUOpb-ZcBqydKCHuF5MmODSdGOoneO+w5oD5AaCZA@mail.gmail.com>
Message-ID: <CAL_JsqJMouUOpb-ZcBqydKCHuF5MmODSdGOoneO+w5oD5AaCZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,eud
To:     pheragu@codeaurora.org
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trilok Soni <tsoni@codeaurora.org>, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        satyap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 12:44 PM <pheragu@codeaurora.org> wrote:
>
> On 2018-08-01 07:04, Rob Herring wrote:
> > On Tue, Jul 31, 2018 at 12:22 PM Prakruthi Deepak Heragu
> > <pheragu@codeaurora.org> wrote:
> >>
> >> Documentation for Embedded USB Debugger (EUD) device tree bindings.
> >
> > If you want bindings reviewed, send them to the correct list and
> > people (hint: run get_maintainers.pl).
> >
> > New bindings should not use extcon.
> >
> Why should we not use extcon?

Because it is poorly designed and has things which are Linux specific.

> Are there any alternatives which you
> would suggest? We were looking at graphs instead of extcon.

There's a usb-connector binding now which does use graphs.

But I'm not really sure what this should look like given this appears
to be both a USB device and a MMIO device.

Rob
