Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2CF218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546624022;
	bh=DX9SVpw1a/H0h5G9P6YYsGTnS5rJGiARNv3EjPDdPy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WUwoL1yZOylJXg6PVBghw57tKU5SQ+/cbb/LFwDP2DB+UqGnAY24v4CjV+9gcSFnE
	 kQSGEDL9cVJn21tM+bsz/PI14xx5091KRi/TKNIvzA7R6CVD+3xhEOFw28OrJA2QCu
	 8nttaPfu0R7ZvYXiEl9hAz7EG2FH7WOmafDVAlac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfADRrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfADRrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:47:00 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D20218E0;
        Fri,  4 Jan 2019 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546624019;
        bh=DX9SVpw1a/H0h5G9P6YYsGTnS5rJGiARNv3EjPDdPy0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zah8HQFAQuxJ+V/LrIcbB6iPEj+pAV7fwibz8LJM1xgptNPjZpxX242qQrPL/SDqp
         kRtRy/nMKdiZVV7DKimMh9CfVuEyiemF7apb27P7W4PQ/pDl6piGLcWO7IbkzFtUtl
         zaUrNjO6Ruk9S2nhZuY3MWHRTOMr0LM6jRe3g0qQ=
Received: by mail-qk1-f179.google.com with SMTP id z18so5960025qkj.10;
        Fri, 04 Jan 2019 09:46:59 -0800 (PST)
X-Gm-Message-State: AJcUuke0M/7UVy7uwVtAepZYskqiCUQ66sUBeVjpcHOJjTXrdBXW4f/A
        5MxEBWQJGrvmHNRmzW2NGFD9wjRuvZQ47iuN4A==
X-Google-Smtp-Source: ALg8bN6lbN6IYt8HBU4h2chHQ+lI9e7YOem3Rwtx1bNujcBM644c/lYcoTmHl4NvCY8PPpoJsYEun8V1xQgJ1QzJyn8=
X-Received: by 2002:a37:b646:: with SMTP id g67mr48718816qkf.326.1546624018937;
 Fri, 04 Jan 2019 09:46:58 -0800 (PST)
MIME-Version: 1.0
References: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Jan 2019 11:46:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Message-ID: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: build dtb even without COMPILE_TEST
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 3:58 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
> for it was not builded.

Just do:

make virtex440-ml507.dtb

> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
> COMPILE_TEST.
> But building DTB is not related to a "compile build test".

But it is. We normally only build the dtbs for enabled platforms just
like we only build platform/driver code for enabled platforms. It's
hidden behind COMPILE_TEST so it only gets enabled for
allmodconfig/allyesconfig builds.

> So this patch made building of DTB independent of COMPILE_TEST (by
> depending only on the PPC arch)
> A better selection of which DTB to build could be done in the future
> like that do the ARM arch.

No reason you can't start that now for the platform you care about.
You don't have to convert everyone.

Rob
