Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A4B2154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="e2T3d8wN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A4B2154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbeIUPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:34:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40630 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389489AbeIUPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:34:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so11047019ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gm0nVpDcXwRqfbIJtSk7HIEi8uw4KdWhfb+8mOjjB10=;
        b=e2T3d8wNREefSF5AA4sQMMY5CI8FlKZI0t9o80SiWEJFewL0hyULwBRE2d1UVFXSB1
         Y6ePsorVhxm0xwxlqbuyfr7KqK9DA06f5haj8h3qcb5jqQAxmdUtCbQumTN4TFSKqX+v
         vDcQP1fZ+KY2OVR1ggQcWmK5j/YRMXmfATK7a/MiWruffV72baeI13ctgRJyPSNEZADF
         C7bHuRT90iPOsNq/SsEVkAidjsXoSRSAtqUr4eknDT/qFuns8iK07OosKdWqnJsMctsC
         FUuXs0scsXJguh94c1iznRl9UNSyL7FdPuw+IBKVckLyyqdqOOX8XVbSjbqoJI+22Uot
         QMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gm0nVpDcXwRqfbIJtSk7HIEi8uw4KdWhfb+8mOjjB10=;
        b=nJ+ptSsxURX9Bat8VkkAdc2LVGBxyPOSxy9u0TqisKUWjTbOsrRxoTaguPoSVRubvI
         pcXSKiea0meRFIATqlR+wKVw+GoL3Vx9m803Kbjhb8SdqChX4KzD6KvtZ+/RE8b6965Z
         QlGgNjCF+i4LB9CBcaHX0BagVZT0VXzHuBS2o4GLOk6VB98AQ4VsWrkCpvaLUFR/QDf/
         QFaD7it7WzJ6ruiRnhipPZwb4b77gXI7SfzKQdpBRj3GCfULuhoasShaX2Eb1WUNIR5j
         7PRyyyS1gunxQxb830m68/KhmnJiyV0li71Z5zOTZCRImqFq9YhTpaTSo2rvEd/Mg6zq
         ezUA==
X-Gm-Message-State: ABuFfogJizUuX+NzohJW2h+mXazV5EGW7B9ptoy+I0hk2Z0YHPCmjou9
        3PjHW0YXrZ+E3aMJavf2g29dX4hYfidxQ/gKNGTWOQKEAuE=
X-Google-Smtp-Source: ACcGV63jBgpPdUle95bxZIoUpwBVfMMjbzaw13pBXPgaP2/37yynfycGZzclup2Y+CbTZl1GGYRAJy46N4kQtcZy5tI=
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr1139188ljd.120.1537523161749;
 Fri, 21 Sep 2018 02:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <1537422122-6166-1-git-send-email-svellattu@mvista.com>
 <CAJZ5v0j05v+69cCJ1jzekdC_2kqXu6SQaNLeOhk=04b08pT6YQ@mail.gmail.com>
 <CALabi0HOSbsemnw=v7h+arstXMMqaAYGmRPFNQDSE_U0+Kg0KQ@mail.gmail.com> <CAJZ5v0ivF_HopaUXJVBkTJj3XLVk-7NPcW5JE-OmyrsQG+O2NA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivF_HopaUXJVBkTJj3XLVk-7NPcW5JE-OmyrsQG+O2NA@mail.gmail.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Fri, 21 Sep 2018 15:15:53 +0530
Message-ID: <CALabi0EkqtHpyXrK=yTUW3aHUAH_CGJ5Yg_kUiqyax3tqjKbqg@mail.gmail.com>
Subject: Re: [PATCH] Driver core: add bus_find_device_by_of_node
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

On Fri, Sep 21, 2018 at 2:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> >
> > >
> > > Second, what about a more generic bus_find_device_by_fwnode() ?
> >
> > If you think that the above requirement warrants the inclusion of
> > bus_find_device_by_of_node, I can try implementing this in v2.
>
> I'm not really sure what you mean, but if there is
> bus_find_device_by_fwnode(), it will be useful not just for DT code,
> but generally, and getting an of_node from fwnode is trivial.
>

OK. Will do this and send out a patch soon.

Thanks,
Silesh
