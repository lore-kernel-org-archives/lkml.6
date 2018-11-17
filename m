Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0F2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AldZqVFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF0F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeKRB6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:58:33 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35421 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:58:33 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so15473238vsc.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dhHt+/pAn8gqsUa/fUYyDgEHHH91NFoOBCQ0tbAYAkI=;
        b=AldZqVFadKX3ltdceyDzJmpdwkSYIsWeEvxuj4z0RJgPklGttWSxgpRyE4sfuZMWnn
         KFTVkqZ9mR6lYd/DXp5gmVvOKSzvZ3qweETcdvT3maNwNYYrFgy8hy0+U8aYxujzao3W
         BdehdQF2F4tVnvr9lmjRhONcA8ia8Zol7yJTcOyKjT4P0cuxIwYcTMfLadZ0NRMa2ye1
         aMhNF+j/ChjIMJ4phE1KytZOwOI+vG9CSZLlXZenfMldq/T6wtYbFZNXc9vU7QHexNg9
         7GthLBmUbLg/pxMZVWw05Jx2AUurIYWnMqSIhDOTxARKTupCbaxSTmLVkhE3hDXUAEKb
         ugww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dhHt+/pAn8gqsUa/fUYyDgEHHH91NFoOBCQ0tbAYAkI=;
        b=PYmNKo4cmo9YGdNQeelhD9Ybg9jt8n0nQbyDlDDhSRHGpFaI1+SP41UeXym1ax5Yxp
         fwjMq6QUMWGTAiTmLJKDnNw6EIx0IWwj24wFEyrbuYBvbf6nVdSreU7ze6d9u2CkgBGh
         6F6XJeLnZYPt5gFVPrvMsCvnPGtINOR02BDwjackqya1ZvJjkL3KZN3YqK8SIErDEA/t
         CjHnxEDwwYoG1MznmxcFkbEhuoZwf3K8ciglvQyFYu3FONlHeYJFPtiRlwLQ7pbtH942
         DQairMqrwr7viUk8JPDGJUVnGEVCy35AEz+MBc752RRw2tJaGLwuWZeKL9ogXHtUWirp
         +wXA==
X-Gm-Message-State: AGRZ1gKKK8j9O3Te/GklrJl61mR56zdZeKXPuatc/xqbDLAWZT+I6UsP
        CIXGIDuc8HjxcQ0EbDK/nxpKChGXNs9AigWLQ35png==
X-Google-Smtp-Source: AJdET5f+TxOyt5OH+AKUpWI4L4aI22oUoKhSlo2Wk0NTObtZ5zSlhimZJcckp0AWlwtDuvjqKDsUIHPIH8bKnLFbKjo=
X-Received: by 2002:a67:ad0b:: with SMTP id t11mr6219860vsl.170.1542469290559;
 Sat, 17 Nov 2018 07:41:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:4401:0:0:0:0:0 with HTTP; Sat, 17 Nov 2018 07:41:29
 -0800 (PST)
From:   gengdongjiu <gengdj.1984@gmail.com>
Date:   Sat, 17 Nov 2018 23:41:29 +0800
Message-ID: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
Subject: Resend: How to handle the SMMU RAS Error in the kernel
To:     robin.murphy@arm.com, James Morse <james.morse@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Cc:     xuqiang36@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gengdongjiu <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi robin/will/James


In the current kernel, it only handles three kinds of error, which is
memory error, PCIE device and ARM process. But now the SMMU already
support the RAS, how to handle the SMMU RAS error in the kernel?

I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
seems the IOMMU type only are specific to AMD=E2=80=99s IOMMU specification=
,
not have the ARM=E2=80=99s IOMMU section type, can we reuse this IOMMU sect=
ion
type for the ARM SMMU?



N.2.11.3 IOMMU specific DMAr Error Section

Type: {0x036F84E1, 0x7F37, 0x428c, {0xA7, 0x9E, 0x57, 0x5F, 0xDF,
0xAA, 0x84, 0xEC}}

All fields in this error record are specific to AMD=E2=80=99s IOMMU
specification. This error section has a fixed size.
