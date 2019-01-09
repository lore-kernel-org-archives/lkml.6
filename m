Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88672C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CE7214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AaicnVj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfAIGXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:23:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46601 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbfAIGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:23:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so5405670oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 22:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9x1cfbztaDUr4GZrp6DUYb4q3cN2ff8JiuJX41/fkQ=;
        b=AaicnVj9Cq3JPnpMLQ4BEVGTNzh9wk+QZykz7ZLU+E50/kqjEKLao9MUgSqpbzB3me
         uapjPAsAoDsFGQgyIOP0xX/g1xNVUWdswMgJvXkp89K/chfz7sVqOrqnWWieQNhHwChp
         vitHdSlQdM64Ylnq3blzQaIF8K9v8DBRnpgJfKxGZPuaiek9caEIN3Y6uA96I9XNIiSa
         Rh04KNm2vy5cOUgTgxaloRBk0r5PsSRCpW/JcIjz3K1rQpdVffTyrS3VnPIbreIWwxkd
         P0RRP2yBIzHsdGc5KKXSo9p5Z5PXzNM/HYuhT7+LJHjdr0MI/hCHAXfpw0r8F9Uueuxz
         bVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9x1cfbztaDUr4GZrp6DUYb4q3cN2ff8JiuJX41/fkQ=;
        b=s8mVDihYN7spdxjN/EhSYmPn2zZpQ5Rdf7WIp0P4998WF8J+e7S3PMObPf21n/jkaR
         OkAxTd3y97wUw2gHpkYLSYvc84gaIssCT7abpbYrD8lbryRklBeaypjDylNqAgR/Oa97
         wL7pvIg9JMDYK1LoeD+b2wjfY6Ts8eOFWsIcRAOCv3L4sqKs2swnnznR/aCVf/WZobJ7
         8lgFe8Neu69i8Ee4w9SXR+d0vkbROJI1d6TF/oD06pmge3RKkyldNP9/BOhT6zecPN3R
         akOX48xOeWZIY17lERcdqEsN3I6guF82IrrJHbAuknwTezbAS1Iaemi44LOVtTbyR5Dz
         Q6ng==
X-Gm-Message-State: AJcUuke3IvVB2JOnVTFbVsAsUnDz1JhhCZ7vTghMtnzQ/siMUVPHub3h
        K7Xi993t/XvAL+gsqkCgSPn+fNlfH77XMy3Kx2QAug==
X-Google-Smtp-Source: ALg8bN4LPW3zIgNTwk3lJi7jE3xNaj4h69WvQtGnoiopRXqrK2mKneOCdA+9V0GC4eucg0J+dBkPWVrs5d1IdayqLlU=
X-Received: by 2002:aca:b804:: with SMTP id i4mr2981177oif.280.1547015025364;
 Tue, 08 Jan 2019 22:23:45 -0800 (PST)
MIME-Version: 1.0
References: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com> <1546675718-31174-2-git-send-email-lixiaochun.2888@163.com>
In-Reply-To: <1546675718-31174-2-git-send-email-lixiaochun.2888@163.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 22:23:34 -0800
Message-ID: <CAPcyv4hsAi-1+kxVMA7hwG0Siy+Scat_vJC8WBY177M_hKpOxw@mail.gmail.com>
Subject: Re: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaochun Lee <lixc17@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:09 AM Xiaochun Lee <lixiaochun.2888@163.com> wrote:
>
> From: Xiaochun Lee <lixc17@lenovo.com>
>
> The function to_acpi_nfit_desc and function to_acpi_desc
> do the same things,delete the function to_acpi_nfit_desc,
> and keep the inline function to_acpi_desc.
>
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>

Good catch, thanks, applied.
