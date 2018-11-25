Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D3CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9113220989
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WyoG7el9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9113220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeKZD3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:29:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41714 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeKZD3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:29:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so14463409otk.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gce5GsT1n9Pah5oD6y4zs56lRB06br/B/8ypmKx18w=;
        b=WyoG7el9YD9UgFgwKn8iKMHOSEmVHYi6g1lI3SARTNNNtqh++lxcOvCedYVv48DP+W
         5SwPkXyl2KxUiM7MiRR5o8LaMNUPdvWTLjPfle7XntNChx8fMyg2BxDZ+CAn9LX3W97G
         Z5VSH94CXpCJT8aKHqznOkz+qeEEzZ3sEuw2NC2tTvBXT1qui5X3fP0lAjwXFCLlwOmX
         R35nNY4wWqwQe6Rw2MjCSm96xi0tSQegetVaStQfBukpmlakZyvXKLUdpGg04NbBZ97v
         uaJSs1O/v/6MbosHeHkwW/UAvC/g02/RFAf3SZ62YUdRQmSyC3O88uLNuxupQ+EZdore
         37HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gce5GsT1n9Pah5oD6y4zs56lRB06br/B/8ypmKx18w=;
        b=PrspzLCKo+yz0LTErBiGUxMx79M1ivDxz0jL7E50Vk4Bv2D4nzNEbQTo9QUDDnuCeN
         TIrqNzDcANmMZw4DUy27HJtKe+bd4HWKTHe6/GlTT/CxsVTln1AljamDwNvu9WKVzTg9
         LgQoTbwZmFwyHBJggiwrB0it1UGKGoQj2O6zCS/JZIiLZ0Des8DgokKJkGSvQOjAU7Fj
         FcSfd5nR68bmzJ96EEp73Jz1A8JVv80FFontTrBZ5s9ImW3wm/f78e4g3aiBblR6YFkG
         MyQi7wwBk/q4+idFtQx7gXG6azOaQNV8oK9Qe0yI5d8nkg/sPWETCj+4nG6LAUB3+7r+
         hVOQ==
X-Gm-Message-State: AA+aEWa9rfgovQ7iWB8ULxhmOZmiCcXNgDAYaLlxrNtF0wzHNgjX2ZoK
        T4VL5CI9w/HHS8JBuo88E3naVFquRnmTIgCi5FmSBo92
X-Google-Smtp-Source: AFSGD/VItl/EL3xYJuda9he11SqFZQRoyDlTJjiXThqDbJSM9sau9EHBtUs4kB8m8LqTZACAPIV5sGkx5tEhebZ8bLQ=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr12774426ott.353.1543163885222;
 Sun, 25 Nov 2018 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <154308522458.237140.16550557898744466932.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181125075410.D0EF220865@mail.kernel.org>
In-Reply-To: <20181125075410.D0EF220865@mail.kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 25 Nov 2018 08:37:52 -0800
Message-ID: <CAPcyv4gQmTSqwLUnD2pR0hgJrmRAGEToHNmPZMYQ4+oUmJapRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm, pfn: Pad pfn namespaces relative to other regions
To:     sashal@kernel.org
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 11:54 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: cfe30b872058 libnvdimm, pmem: adjust for section collisions with 'System RAM'.
>
> The bot has tested the following trees: v4.19.4, v4.14.83, v4.9.140.
>
> v4.19.4: Build OK!
> v4.14.83: Build OK!
> v4.9.140: Failed to apply! Possible dependencies:
>     Unable to calculate
>
>
> How should we proceed with this patch?

4.9-stable will need a manual backport since this code was refactored
in the intervening kernel releases.
