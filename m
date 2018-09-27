Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BCEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DC3216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DC3216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeI1EqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:46:25 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46331 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1EqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:46:25 -0400
Received: by mail-oi1-f169.google.com with SMTP id k64-v6so3600923oia.13;
        Thu, 27 Sep 2018 15:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ShoJtjcjQb0gjp7YdjvKzVSuec6myPwgPyE/EvL7OBk=;
        b=nkhZLniEuREpRMk7mFtAf6CTr6hnO/Cy2hLqdvIiop1WfZuR19rdDzYeQpLp8eJYzV
         mnXdWDKgTs5kDJPmGE4daNO/dk05HG2xwV5vmX3akh7kt+d1RTpP+JApt+2w0pnYQzK0
         +s3ZT+mWvyFPyTwsG5b6dM/6xcKY+2MdMMtQTbnh5MyOrgR9OCH9Gk/1GZ5TiCRUPVcT
         wHJQ3k8UFmuBk7Of/RL3NuLzpvqzBWjqcBeas0AILE2E4/Ell0u3kU76UCMVNVxg0/ab
         q3msP8lCjPK//uJUpWNJ1LB8iFv07H5tA2o6b8Eiw5hrQaOMQeADHmprZKcFl6XkP/0M
         mx0Q==
X-Gm-Message-State: ABuFfojVnrHEpqgs8tOcECOND9QwJysal3FEDPCJyV2B4P+CTjK1gIDb
        WuUqGw5g1AJHtnW9wU8ux72rANpe0mA=
X-Google-Smtp-Source: ACcGV63YobLeEinD1mFPX1ND/iHwPUDfPH1t7y8exlDyfP4vVIiBgyOFAwEcsUwzlnhVdbAyIS6G7Q==
X-Received: by 2002:aca:853:: with SMTP id 80-v6mr4054353oii.333.1538087154635;
        Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id y131-v6sm636891oie.25.2018.09.27.15.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 13-v6so3668964ois.1;
        Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
X-Received: by 2002:aca:fd89:: with SMTP id b131-v6mr4395787oii.30.1538087154014;
 Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
MIME-Version: 1.0
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 17:25:42 -0500
X-Gmail-Original-Message-ID: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Message-ID: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Subject: drivers binding to device node with multiple compatible strings
To:     Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob and Grant,

Various device tree specs are recommending to include all the
potential compatible strings in the device node, with the order from
most specific to most general.  But it looks like Linux kernel doesn't
provide a way to bind the device to the most specific driver, however,
the first registered compatible driver will be bound.

As more and more generic drivers are added to the Linux kernel, they
are competing with the more specific vendor drivers and causes problem
when both are built into the kernel.  I'm wondering if there is a
generic solution (or in plan) to make the most specific driver bound
to the device.   Or we have to disable the more general driver or
remove the more general compatible string from the device tree?

Regards,
Leo
