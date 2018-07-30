Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB65C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA2220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYLvz1/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA2220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeG3XbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:31:20 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36785 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbeG3XbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:31:19 -0400
Received: by mail-ua0-f196.google.com with SMTP id c12-v6so8909792uan.3;
        Mon, 30 Jul 2018 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SU2NE381izxBL5wxEKm52J6ETHlUsqsVzTy/Ea39RQ4=;
        b=TYLvz1/boOJJteVkKGpgDnNJMmzRKSX2+aJ5+HHeoPv7AiM2Tvo5s0I/6Vi+ScLzMP
         ibyaUc5WP42obVYhHx6RBEe4g1p8EzKpQSc4qv87TlltlCxFJ7x4Nrb9Slki36sPfv4G
         F9C9+pkp3KQNZ20c+J2nvDDg4zZtZS7tvOiVpXN54ckZxdaPfT+MNbAxOXehostKFSvR
         TQVDWlBHHo8QUpBNZ2yw9kdyyTM9Q2Qt4dtWEpMPhVBmzzwTNFdmzQh+IIxpbTCZ7UVZ
         SmTbE7a8NXPYkdg9cpzBIk/g84q2iG6oX+PICPSMpuBPQQCp/FmUtLuyUomN3xiqVvrI
         irLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SU2NE381izxBL5wxEKm52J6ETHlUsqsVzTy/Ea39RQ4=;
        b=MhfWxse72WO1jYk3fRh+pxcZAkfm3lPdgaEVGDK8Ap5MT7gaMLJrG/FxCpARuP1IUl
         8GpNmd0E04faYzZkzxlMuW9bC1zIE3B99+lq3TfnOgIkilWlZp8LsgdYAPwEonDM8Pgq
         3r/xqfQFSHTZsY/38wzByc0ZDKnHQZyklFdsoGvrkZv//DM+dEA6OZJ/SveivyniND1W
         3EnXqeHPH9wsarz7ICBF/4At6VO99s6adOIaRxJn9hd30bgZ6vC26KI87QFcL4YADfcz
         esjX0N6f6SQQtQHyz+WZklN14hN1pY+oBTPtCQaU/eILX+7jAoefB2cyXUyoJkbxqRIr
         IF1g==
X-Gm-Message-State: AOUpUlHQQ32q9YC1Y40xzSlbRbFYi3wfw++UcPcN/sgU3zfg/qOtMVH1
        szcsSqOxyk2f+m7TW5XmXUgceaBu5gzXctFZ3WY=
X-Google-Smtp-Source: AAOMgpfE6A0rvz2S1H3rqukIQbZE2Mq4rrIsdsdiT4mceHDAgJSFtGjK5qEuF79xK7vgnF617n8JMf6n9xvUm81PFMI=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr13378448uae.47.1532987660548;
 Mon, 30 Jul 2018 14:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 14:54:20
 -0700 (PDT)
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Jul 2018 00:54:20 +0300
Message-ID: <CAHp75VfJBdDxgV3dnv5UrG-DHg-_3at+BeO3j8kFAXUn2t11pQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded interrupts
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:30 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Thomas, Christoph, LKML]
>
> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> If we have a threaded interrupt with the handler being NULL, then
>> request_threaded_irq() -> __setup_irq() will complain and bail out
>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> being NULL and set IRQF_ONESHOT in this case.
>>
>> This change is needed to migrate the mei_me driver to
>> pci_alloc_irq_vectors() and pci_request_irq().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/

 * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
 *                Used by threaded interrupts which need to keep the
 *                irq line disabled until the threaded handler has been run.


-- 
With Best Regards,
Andy Shevchenko
