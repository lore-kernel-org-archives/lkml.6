Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1577C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59320831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT3QTBDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B59320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeKCFIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:08:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35746 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeKCFIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:08:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id 81so2758203otj.2;
        Fri, 02 Nov 2018 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wJb4dVMrmd9hBVEMZkDN4faOHBj8NveXDiTvpL/0+Q=;
        b=ZT3QTBDZJVIl8UmQuopTGqu6Gn59vMf4cRq/M3sXTaE98NmWc0lYuz7yi5L767X90a
         PEqr7uCeOVkpSHcvPBmGj8JkKjJfnUph3/LloYqqk/YJZX16wFiSxm3M88CSoFimBBHN
         6j+8ri/RoDRcG2/hCiAa/GUyIQ9oAnt4eXYhDurs0NiaVYmJmYDiyPPQEcwZfUPRDO5Z
         B1Rce7YNHI+V6amGO8bvZZpyWUpDBXxUY6V93/nfDmNEzstTaR5tCxA3QAlKQYSPGA+v
         PoJhAwpHNpO8gc+P7bOOoj8IqgC6lEZ9rFcBcoaKEPptzl2V9a6X3irumb6JTdCFfMec
         GU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wJb4dVMrmd9hBVEMZkDN4faOHBj8NveXDiTvpL/0+Q=;
        b=Stwmj8yBiBj4JU1TpmMBAfSF2MHOel5s9kcYYQ31+UDPEHTwNoO12xh0sToaNe+ZuC
         Ic2bKC5dNOMRpgzX8EiDRgvRZ9u42bQhWa849KTkuVapcvCVQbHnPV67h2ivOyj9wuzk
         HW+vrx6Ow1RD7LV9a47D0+WdO8qJrq5IjwSe4st2yexd76H9ncP0u74CUcHixl0roBRj
         mYDmYnqg7Jbd0I4BNinAyCBzewk9JT6e1uKSNo3IMCrQuc0kwaFxKbptwUlTtNW4Ky8c
         H5SP6Yip3yuk8iY91wv4cFTqwLMRAkp+0DC5Q34EqQsF4l4KKlo5Gp8+P+H5MosplU5s
         bcNQ==
X-Gm-Message-State: AGRZ1gJESAmF81n5ZwYtYDSptiER5u+TEVrklCLfRyftQTjdnrlQwmwx
        bNrxZU0SMvOkZ7X7anjVt13zo84ptnuJTktNce8=
X-Google-Smtp-Source: AJdET5cyZIiVQhEJo6m9vnUXfHTDEIPwpl7BYRT6vkTv7KlZPG0UheBCXVkPFuPGmjh2bBWZ+8k8a+gTVRoEcFMbhLY=
X-Received: by 2002:a9d:728a:: with SMTP id t10mr6948732otj.216.1541188814819;
 Fri, 02 Nov 2018 13:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182857.064326086@linuxfoundation.org> <20181102182901.906765329@linuxfoundation.org>
In-Reply-To: <20181102182901.906765329@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 2 Nov 2018 19:59:39 +0000
Message-ID: <CADVatmPo5-ehCRKP_i+5M0hoJNGF-JNKTTPdR+HEd-GKfRi60A@mail.gmail.com>
Subject: Re: [PATCH 4.14 060/143] net/mlx5: Fix mlx5_get_vector_affinity function
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, israelr@mellanox.com,
        maxg@mellanox.com, Sagi Grimberg <sagi@grimberg.me>,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 2, 2018 at 6:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.

There is another upstream patch which fixes this one.
e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n")


-- 
Regards
Sudip
