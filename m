Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98337ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX0F887U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbeGSLep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:34:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52290 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeGSLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:34:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so5720109wmh.2;
        Thu, 19 Jul 2018 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oUHNCSzohWvpGgfi5YmEq9q3L3SAjDp0tndeDbJbNBg=;
        b=FX0F887UbHaSAO3E7GHw8HK8Me6LzMv9DrAIlMzsLhoUvsvT80YeJUfJOplv7PV8xr
         9HwKi8RkwLjc/eBw/tNnulkD1NHJsCTvCxMY0iVPJLFSz/2Q3pHCIj/lo08oUeiesJDi
         nzlPQ/blk5f+eheZjb+kh7cg9xlebD6biR3kqUsrIfskndpUyl7qa5cRltXHw0OwQeZ5
         YvNauLDlqds41rdd28GUF0KkDNGiV4KYTnFRq40+ZlWhqyBB+HUlkkiW7RlZBVnP8r2b
         FmDfXGv95Ds8ub3sri2a1qxeS5ScxeMN//9aC6CAQ7/iaGHQx4np5Tlcl0Wf3na8duuw
         75Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oUHNCSzohWvpGgfi5YmEq9q3L3SAjDp0tndeDbJbNBg=;
        b=UPz9+nPgvGN9/PT6SRjzTY3rpsg1K0i9ivSeJ7fYBng6nCTimp/kPn75yophz8CIQK
         ASHq8TLlNMzxWJQbe8QfcX+TCJpheKU6vW5hOPyyrbre9/EmVYhdzNFLc5/TWwQfvK72
         wdu4ZOSegi3VvOsVvYWysBONsQ82qAD8GUeLkhvUbWjdg81aP6A/HqGGfxaZ+o9OKjJN
         sALaNIwsIYdd3adlhKm0xBL4Ko/uuo0N1i+RUHI/UMIok8CTXswKDZ1cK53eyTVrTstN
         RLD5DfeZNvuCn5Tc+aFKeh+fO4Th1bMGEduxtWsZvl1YxP1h4auOaxdkqn6oHMKVkM4r
         nJFw==
X-Gm-Message-State: AOUpUlEk/jOOi5U/IUJs3AtkA7/51caHsck5CiRP80PGiYEC7Mp+WrsF
        qDgfdRpALKSc1JA3QEggS08jqUqjGcprEjvgquE=
X-Google-Smtp-Source: AAOMgpcxzPjnQZg98D2SMFR7PzCDMjvK7NwPt6W1UMRjbnFK46EJGVjVQMIHIE8WdMekoOQnj9C68LPzCrzB9xg6FD8=
X-Received: by 2002:a1c:a484:: with SMTP id n126-v6mr4166867wme.140.1531997528066;
 Thu, 19 Jul 2018 03:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1c2:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 03:52:07 -0700 (PDT)
In-Reply-To: <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com> <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Thu, 19 Jul 2018 16:22:07 +0530
Message-ID: <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
Subject: Re: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
To:     Alexander Duyck <alexander.h.duyck@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Linux Netdev List <netdev@vger.kernel.org>,
        dan.daly@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        netanel@amazon.com, ddutile@redhat.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +static struct pci_driver pf_stub_driver = {
> +       .name                   = "pci-pf-stub",
> +       .id_table               = pci_pf_stub_white_list,
> +       .probe                  = pci_pf_stub_probe,
> +       .sriov_configure        = pci_sriov_configure_simple,
> +};
> +

Is there any specific reason for not disabling SRIOV upon driver unload/remove ?

i.e if a user sets numVFs to a non-zero value and unloads this driver
then we have a
situation where there is no PF driver in kernel but VFs still exist.

Thanks,
Sunil.
