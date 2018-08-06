Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D4921A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8hvMWmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D4921A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbeHFRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbeHFRZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:25:52 -0400
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F8521A52;
        Mon,  6 Aug 2018 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568578;
        bh=bJVb7hhJZaZKGOrAQ3WlYb/R+37IkiZ71jK7OxKyzBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G8hvMWmFZJ/Vn86CkfPt7OSocrxeHHM4IWnozbkmVZ2ezn9k/arJMJ+kn4SYu06CJ
         +tNTXJNKjzgADOYWp90VcyPgnHudx0iQ1lXGVZCqZVWLcj6WZQ2kxUYuKFM8Q5Zr3H
         2QshlH24Lz0rATym/eah2T5bQ6mc1p5gRxjMi+50=
Received: by mail-qt0-f176.google.com with SMTP id h4-v6so14179166qtj.7;
        Mon, 06 Aug 2018 08:16:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlENRdAn0sgct/M2XrAoKvOKDqiy2jPgMsPjpGFZzCnFN+Aux6cW
        HdEd8f+953gb72JTj7h0bMr3UbMEsABBxA34GA==
X-Google-Smtp-Source: AAOMgpeWAstVrJqh0e89zXkpsiza/vVvDx8V25b/9cRwXe8aUXfq9EfjFHMTRLBjMexqUhWe7MkWnm9HZgnvVBz2928=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr15426288qts.354.1533568577899;
 Mon, 06 Aug 2018 08:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-6-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-6-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:16:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMZbDuUsqbg63P-pO4D_L6PHqhJqj2NXfu9xwmu3Rabw@mail.gmail.com>
Message-ID: <CAL_JsqLMZbDuUsqbg63P-pO4D_L6PHqhJqj2NXfu9xwmu3Rabw@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel
 MIPS SoCs
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> From: Hua Ma <hua.ma@linux.intel.com>
>
> This patch adds binding documentation for the
> compatible values of the Intel MIPS SoCs.
>
> Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2:
> - New patch split from previous patch
> - Add the board and chip compatible in dt document
>
>  Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

Reviewed-by: Rob Herring <robh@kernel.org>
