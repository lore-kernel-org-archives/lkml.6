Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751FEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F44B2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRFFFS6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F44B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbeITTdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:33:42 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37421 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:33:42 -0400
Received: by mail-qt0-f181.google.com with SMTP id n6-v6so8521836qtl.4;
        Thu, 20 Sep 2018 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+FIJ2gzNfVonhoyDkwidy0M/au+shFzdqkR0sI9z2zo=;
        b=ZRFFFS6kZk+rglMzQHaANF/VvPq0ayHDB2OT+3/4vRUYyms0ksi5Z+kplUJAnk+Ktu
         EF3xaOPm8fNIuFc2EYuIHhstdDFQ7I++zsvM08nApQgSiAqL4ZaSZBuPOCgEfqyXpN6U
         h29/WX18M0Di5b1bmhsnJoXmOwlf+CCoQ9h1i0zQDlYoCzitA2/miNc0kwpEJsKeLENb
         VusB8Yf/wlTnOr5eXf+pfBGyMg1mQyxrvfhija93IEBbs1no0wpt0TV8AIlX1vFI6Yh4
         3QC0VXlnQ5Pt0CXxBhDXtZ+uSh3JCJN7y0gSUA86e9B8beiZiERf0mI+FVa7PAfxg4PA
         8FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FIJ2gzNfVonhoyDkwidy0M/au+shFzdqkR0sI9z2zo=;
        b=IjGAGePYAwmiNvPVLuwyUJWAwg/B/0MgAV7hGwZ/9zD74GMQSIzVFiZMTRHi1ExL/6
         s8xrKVtsoiB02hJ+5xvO2oYuU9/ypKIVygC/vnSzglTYdh8TmG6VUlij8V5kAL4kuMsy
         eeo6YgqApkA5pQISCM4piueiDyZFllB27E9mbOLMB1ONgNSZ8XkhxstINygS/PuoVOvo
         evH/YqXqPULETicFgwQPZ6F8CL0FrxCUXSNHYjtAxe1FqlXxyUG6HEEtkyVuUbKZtyGf
         bZyzS7MvwxXctVcpEXGc3ULGyBO7hw1gdQYQJZQlLMoOOVcw25mtRfPpOJaWUMlPtbTs
         JUrA==
X-Gm-Message-State: APzg51D5K/NhpVfaC1rRYz2zJmbH+2vcJ6N8NrgnZxhEgyTNmy19R0pI
        WDeu3yGvs/dfko8bRO/iUi2s+j6aekDKRDDCL/+dBy4=
X-Google-Smtp-Source: ANB0VdaaMrH85fGxxLvt3VOp2zBVz2+dCyabdZoX4xo54sWI5lzxu4KSTHSWXCXPgjN3IwOEDaZsU42DOQDNGiu9ZSo=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr28665188qvo.106.1537451406507;
 Thu, 20 Sep 2018 06:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180920114717.2ed5ae6f@canb.auug.org.au>
In-Reply-To: <20180920114717.2ed5ae6f@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 20 Sep 2018 06:49:54 -0700
Message-ID: <CAL_JsqKCu76wKfo9tOKsmD7KB=RvhFCe=1exrCBfrWLJgyaJhw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:47 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Rob,
>
> After merging the devicetree tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:

Yes, that's expected. I posted fixes for all of these last week. Some
sub-arch maintainers haven't picked up the patches yet.

Rob
