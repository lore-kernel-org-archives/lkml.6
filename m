Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10757ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC74C2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC74C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbeIUPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:05:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46857 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:05:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id v44-v6so12297637ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0QsiBSI1xvPBtHEt9ynVPGCTkf10IYFx1kl8i0mLk0=;
        b=C7q5XTSP1MrOaS9so5/CiTUC2ga7pocGB3+5DfkfVz+RZy0sgISC2piCeNMi5IC5B4
         Cjit6+mnefsxMZFSBz5R0zeHy4CI9AA/2e0XtuVE3wUIoH5pxR5SfwZEaBdcciWwcPA/
         f/uChDJEoHMrscHte+LsFN1G+Qzy6goGwp9OT9e3tMMq2pzgZ9eNLqQtQfpyGFwkZ0cl
         dsgdERZmbLOBziVu/+A8zNp4a2LBebaLvNPL+obIOyK7B80rT8ewaT11ax8eLdQN/hIh
         h6yI9Ok6gGDMM3Uhv7Ry9qrVKnsK+o9/f2pTf3e0dcLMs1iqwtLDvrmSx42Ks+dTx4jJ
         9zjw==
X-Gm-Message-State: APzg51DosxhgoyMk+MQxSDFWof7g7ZYkvtETKgkHz8fskvlWIOM+I2XA
        ikFO0GlDHqtZX69HGnGjtIh+Pnps4kTNpT+loGK3bg29
X-Google-Smtp-Source: ANB0VdahLtg7gbcXxd6Nz0JdGvTEAm3VrMuGuWpWi59T/3kcgxcpLWLf5UbTOFW5pKGThr3NvafE8dnAruCh/32fYCk=
X-Received: by 2002:a9d:42ee:: with SMTP id c43-v6mr23261137otj.54.1537521436670;
 Fri, 21 Sep 2018 02:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <1537422122-6166-1-git-send-email-svellattu@mvista.com>
 <CAJZ5v0j05v+69cCJ1jzekdC_2kqXu6SQaNLeOhk=04b08pT6YQ@mail.gmail.com> <CALabi0HOSbsemnw=v7h+arstXMMqaAYGmRPFNQDSE_U0+Kg0KQ@mail.gmail.com>
In-Reply-To: <CALabi0HOSbsemnw=v7h+arstXMMqaAYGmRPFNQDSE_U0+Kg0KQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Sep 2018 11:17:05 +0200
Message-ID: <CAJZ5v0ivF_HopaUXJVBkTJj3XLVk-7NPcW5JE-OmyrsQG+O2NA@mail.gmail.com>
Subject: Re: [PATCH] Driver core: add bus_find_device_by_of_node
To:     svellattu@mvista.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:45 AM Silesh C V <svellattu@mvista.com> wrote:
>
> Hello Rafael,
>
> On Thu, Sep 20, 2018 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 20, 2018 at 7:43 AM Silesh C V <svellattu@mvista.com> wrote:
> > >
> > > Similar to bus_find_device_by_name, but finds the device having a
> > > specific of_node.
> >
> > First, what do you need it for?  Please describe your use case in the changelog.
>
> This will be useful for drivers that do not register a platform_driver
> (but retrieve the "simple-bus" device_node using
> of_find_compatible_node etc.) but are still interested in the struct
> device.
>
> >
> > Second, what about a more generic bus_find_device_by_fwnode() ?
>
> If you think that the above requirement warrants the inclusion of
> bus_find_device_by_of_node, I can try implementing this in v2.

I'm not really sure what you mean, but if there is
bus_find_device_by_fwnode(), it will be useful not just for DT code,
but generally, and getting an of_node from fwnode is trivial.

Thanks,
Rafael
