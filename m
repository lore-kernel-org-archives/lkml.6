Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82807C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FBE20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW/G7GZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FBE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeKJH07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeKJH07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:26:59 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5532520840;
        Fri,  9 Nov 2018 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541799872;
        bh=i6Yl9ehwxuvkZu0JHzcxfI9DUXZQnWkI23kex8Us1Bs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nW/G7GZtJh8KeVKTLuPSWx6/AlXMAcLXIn+dt+3J/7aI2hbtn7LYrUZhqtOucMs3b
         3Uk8Bm3gLkshwDu528zndXxVcdR6AIEvgr+CP9qy2/dQqVHCY9XvJBGQCvuRNlOwLh
         P/qy0Ynl91pvaApZLTv/Wz9YBpcknmn5hj1odtK4=
Received: by mail-qk1-f172.google.com with SMTP id y16so4272406qki.7;
        Fri, 09 Nov 2018 13:44:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gKS63OOAzZpv0ko+A+zzDB1w+ED2B7rqnAZIbAIR6tUL8rbBi1D
        Dk0lc9pB46Ml0imKfE7Uj0JvpBnAK3sByUxHcQ==
X-Google-Smtp-Source: AJdET5dll8YPqA7IlzBzkbVWwEDv5QadKxyJyTfFt+I3HmTsLE52xce2gx/7BPTnub1DCIncQbipkWjwOKu40SAOw7s=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr10393361qve.246.1541799871583;
 Fri, 09 Nov 2018 13:44:31 -0800 (PST)
MIME-Version: 1.0
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
In-Reply-To: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Nov 2018 15:44:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJHNAYAtL791UsPE=J9L97cOGvRVkqP+3VuuT5qVmRHw@mail.gmail.com>
Message-ID: <CAL_JsqJJHNAYAtL791UsPE=J9L97cOGvRVkqP+3VuuT5qVmRHw@mail.gmail.com>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for v20
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Rob,
>
> Please pull the changes to add the overlay validation checks.
>
> This is the v7 version of the patch series.

Pulled for 4.21. Thanks.

Rob
