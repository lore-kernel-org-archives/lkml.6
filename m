Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544718018;
	bh=+jxUzF+nZ34kAMn63Q/VWZ55YgSwHC8NTU19gSDQ1Rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zYaSbLhAs0QMjvCISibIyk9RAtMVIide+ykuU/5aXf0KZMu00T1nV1FDcHbrQuCo5
	 Aao/kc6Onnhv4fXb8TQbw+FNKhXx+Y5gfgZE5j/RoRM3rnjuisgQRV6o3LljVVijqH
	 g3thw42FG3U1v8YSJZ+bWF5P1uTbZWji3iim1yBQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CF92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeLMQUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:20:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37248 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:20:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id 40so2437733oth.4;
        Thu, 13 Dec 2018 08:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0OHL5UVUgVLGMcrKb/NAyVVoSC92t05riP/IXe9POo=;
        b=b4GAvW7PI3zXu2Up6ALftxu3lz+bohJ9RIT6ASwIliHsuDCx5Zao56KUvMQI4i5EeY
         aTges6DOy6tzZIMECVzqnjGDHPtPLLtcLGz/DlhAdp3aSWCPIHbEGJgHLSWZhaGyb2SL
         BCbEu76oUbjLTwlZ1ObWWJwnuUBu/iNx6EflkFV76F800xYT/zxAfbDdSZxpLE/h6avG
         bunFV/4BRY77dHuAPLWFJXE+vIr3o+/UL+QTavUoG6AnMfCP241G2UPHRTCs19TK6e1b
         vw9sji9ALhNaqHDXsQKvDPrYTGfdZ7o3uLMiSXmNDVRmYd4QUX9NoAmmK1xgcGe9dVxM
         U/7g==
X-Gm-Message-State: AA+aEWb0SzAFqcrFXkk/pbicpHbqn42zW9g+MeE0FZ8bheT278FuXvkC
        t0zT9FVlCSxfy1Y/GCqNVC3iiDroebueffTCsmedNA==
X-Google-Smtp-Source: AFSGD/V5Pyjq1luVJzg2oK35clPWBxVurNNuVkfiZtwCQSPgf4OGo2AGKheXzysTe7kQLGJ6l1Ob/GbUyQ7XS7zfIHw=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr2596755otl.343.1544718016225;
 Thu, 13 Dec 2018 08:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20181213044833.23952-1-okaya@kernel.org> <20181213044833.23952-3-okaya@kernel.org>
 <CAJZ5v0iZa_m8zL+BKrpMNRhPF=6k__jCtiKSk6ZBFDc3pXMi1g@mail.gmail.com> <a24b13db-049d-5027-4c49-81cdc0782c2a@kernel.org>
In-Reply-To: <a24b13db-049d-5027-4c49-81cdc0782c2a@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 17:20:03 +0100
Message-ID: <CAJZ5v0jHMa=7+L0MhGtD4f0At=CystTb2kEbedQuzzB4WWaDGw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration
 when CONFIG_PCI is unset
To:     okaya@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 5:04 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/13/2018 6:15 AM, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 5:49 AM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> Getting ready to allow CONFIG_PCI to be disabled with ACPI enabled. Stub
> >> out acpi_os_read_pci_configuration function that depend on PCI.
> >
> > Why don't you merge this with the next patch?  Is there any particular
> > reason why they should be separate?
> >
>
> I could. I thought it would be easier to review small pieces.
>
> Let me know your preference.

IMO it would be better to merge them.
