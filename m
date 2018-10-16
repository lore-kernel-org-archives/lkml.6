Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C797C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549F520881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2TPAPYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549F520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPPY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:24:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33607 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:24:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id 84-v6so13528462qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnTZJqi9B+x2loUXWQlDU40MlAXjG9jo3MtBBIGqVKk=;
        b=A2TPAPYNZxVHrY5EiDXXTw0S4wCiJOXuDwOCQACNu/J9vxNp4RREZ4YILE9V7zZV5c
         H9l7eUlIcv1Q+WqahLUStAWaR8ntUSJKQptqG+4L3u2VFXAqEhFInRxLinkkBPmvQ5jO
         oKqpbyf46duRrFI7D7pArpdhY0zR4yCk6PuUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnTZJqi9B+x2loUXWQlDU40MlAXjG9jo3MtBBIGqVKk=;
        b=VRvSqPQlIw0JoEaa2DsQ/lSME4V6I9T9Oc8Gz5NS7seYnNeDepcZibqogpQQalBY1j
         /oo1kgS5IgMaY/5RfFEjNCJUfUYPh6AXEPC0n4jvODcvMSeXTchR6BNErG4D0MwuORTa
         zTyQ7AnYzv9qWzWfDUf8N1qPq/ncvyDjCG/5cBYJdG9/I7EYDWF9Yw9HM9zv+AVCGBzl
         h/7ecnH5IBl+r+f2FZ8DcKMLLQh7fZZ/hXn9SbV0g+EvnNszpXddN0lwsDE769QOUNtj
         NB56kA6xlvqznQVtYRqjdolAhH1YQ8yByv804byv1c51jyzgoDMM67sHRuon1lX7pZAR
         OLiw==
X-Gm-Message-State: ABuFfojRNLLAgsAgCpRvQQaDONS3/NRClqrgGvEEtuoRzU8ORsm3ebOG
        fU8FoHRRQE05InG1/5zGHecbKpFe74qdcaGhsul0/A==
X-Google-Smtp-Source: ACcGV61VT7BMkQT3FKUNSmgPEHdeVJauC0rIfKqzaZcjmQDPAGvm32KgoW/pIcVrR9dwjz3VkBIitIbsHdz0gAih+zQ=
X-Received: by 2002:a37:5185:: with SMTP id f127-v6mr19421865qkb.44.1539675322582;
 Tue, 16 Oct 2018 00:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 09:35:10 +0200
Message-ID: <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 1:39 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> To continue the discussion started by Dmitry [1], this is my proposal
> that I mentioned in my last mail. In short, the idea is that instead
> of trying to extend the support for the currently used struct
> property_set, I'm proposing that we introduce a completely new,
> independent type of fwnode, and replace the struct property_set with
> it. I'm calling the type "software node" here.

I'm a big fan of this approach.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
for all patches.

I don't know who can finally review and merge this though,
I guess Rafael?

Yours,
Linus Walleij
