Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD05C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7A62081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlehDFIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7A62081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeKCATQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeKCATQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:19:16 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB4E2084A;
        Fri,  2 Nov 2018 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541171511;
        bh=PLLSRBxH2duP2huVUvic9ejnCt3PIwq3FNbz6pgJQ3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZlehDFIH8S2yYSB2/oNyahRURIlvrwtQ8QmSaCIwCY/OptqQTCvV4MnjkrWPl64ki
         C/ympURNIinqkFlZnc1XlGUDtNRajnrf177t+03/Y1dOhs9dnietaVWwUgjTLFIucB
         cpbusQ2DV1ZSaf/U4w4PfDOYhgg4I004AYZ9m93s=
Received: by mail-qk1-f181.google.com with SMTP id y16so2329943qki.7;
        Fri, 02 Nov 2018 08:11:51 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKabLiHlMDgojQ7xe4J5ZqS4SrWOFcQAUGPQvn8+uTD+RjHH5ps
        JAZMemeTpHlKDXrF3t+bT7BPUlYOfq6GUbrw7g==
X-Google-Smtp-Source: AJdET5cHO66c+SibzTkdcLkUK2Rl45VKgMq3pyIv10odKE7UWpDnLDk280BNDSRHKFYg91/7QBFTk9NpdE7J+gujPKU=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr11100001qvl.77.1541171510679;
 Fri, 02 Nov 2018 08:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <1541113468-22097-2-git-send-email-atish.patra@wdc.com> <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
 <20181102133100.GA13130@e107155-lin>
In-Reply-To: <20181102133100.GA13130@e107155-lin>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Nov 2018 10:11:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLO+cOcHkr41ebPtONwrzOWGhksH1ypph+tihsuOVDOug@mail.gmail.com>
Message-ID: <CAL_JsqLO+cOcHkr41ebPtONwrzOWGhksH1ypph+tihsuOVDOug@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, alankao@andestech.com,
        Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:31 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Nov 02, 2018 at 08:09:39AM -0500, Rob Herring wrote:
> > On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > > Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
> > > But it doesn't need a separate thread node for defining SMT systems.
> > > Multiple cpu phandle properties can be parsed to identify the sibling
> > > hardware threads. Moreover, we do not have cluster concept in RISC-V.
> > > So package is a better word choice than cluster for RISC-V.
> >
> > There was a proposal to add package info for ARM recently. Not sure
> > what happened to that, but we don't need 2 different ways.
> >
>
> We still need that, I can brush it up and post what Lorenzo had previously
> proposed[1]. We want to keep both DT and ACPI CPU topology story aligned.

Frankly, I don't care what the ACPI story is. I care whether each cpu
arch does its own thing in DT or not. If a package prop works for
RISC-V folks and that happens to align with ACPI, then okay. Though I
tend to prefer a package represented as a node rather than a property
as I think that's more consistent.

Any comments on the thread aspect (whether it has ever been used)?
Though I think thread as a node level is more consistent with each
topology level being a node (same with package).

Rob
