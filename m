Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51642084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKqmMcFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51642084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeGSP4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:56:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38018 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbeGSP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:56:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so15591207oie.5;
        Thu, 19 Jul 2018 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4jNIFrG3VcyqV/YSOtZeJPoomFc64au5p9xTOZCJpYI=;
        b=dKqmMcFR+w4Ihzd+Z/IfeylyGG8FUJwxXbWPnXh/JezXedow0qNxvytF3BDJN2MrJB
         WbU89PIKTxpX+91MSgDH2wrjMfwFm2aOSB4EZgJzHiGg87bMYMG40xJuWXAbw+udUrSq
         Y+gg495D4jDX1rfSWF+wxGZ35TCtTUK/ZQbVy2e0DL2YLUcybMLRVeCNKw+6gQUUp4bv
         VWqtAy7iY1teKBKYHpEuZoehFaPzMCwtCPHNCD8H2cKeEi51/5uJemafHyKyfuGmdUHS
         UXdTZo+TzXIxulyxYUgY8i8fOagi8FdwO6SsqyDLWnreIoHk/NdyezcFRMaajutekwK0
         ugkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4jNIFrG3VcyqV/YSOtZeJPoomFc64au5p9xTOZCJpYI=;
        b=igCLQVy3rXMdjKa/DVxUeZ9Rgr141aQrChZTwhc4hNnOVAfbyRfo/skaNhX2mREc4L
         15gjFwXA/1QkuDEJnkMi4+yUDJGTqu/mTfMbpxIdc8+qrJMemFPw0JPr8q++GOdaOLvU
         aDpr1TH7kf5v79wXHIIUs3oJV3WJITNVyjbuLlbj/zOKEo0QF1m/FBX2qHG6Jw0vNcEG
         M5jr3OiTRWlkQuPWqCKlLC4rYD1VskfEOmfkzOL7I0i3u4uizAubfmOZpmaasUcvxfnw
         Jr9O6ng0eTD5IhMrQ08r3I4A1Rglgr1qwZ+qv6e+9HC4BkN5mQeBRRZBLOt/Bc7seCyu
         gnNg==
X-Gm-Message-State: AOUpUlGFw9n+izuR/AnhTBC+6XRnLlSjRj05iUGxwm76BP/gs4WhNNkb
        l1riyxREYq2HjLzOW7QjtIHyeFSSnBzrUgdQLFk=
X-Google-Smtp-Source: AAOMgpd+KOhZ1xS7CGCRt7NiLATfYm1gWdRGTk1UQR0HX5bQEH+6mHe+7ehPlTZ5ZRXzyahoqossu2vaF/9anbxHzbE=
X-Received: by 2002:aca:a69b:: with SMTP id t27-v6mr11926560oij.261.1532013166454;
 Thu, 19 Jul 2018 08:12:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:42c1:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:12:45
 -0700 (PDT)
In-Reply-To: <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com> <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 19 Jul 2018 08:12:45 -0700
Message-ID: <CAKgT0UcTn=fxhrTvAaJNbGFiKPyZ-MaK0T6+AJewFs6YzDvT0Q@mail.gmail.com>
Subject: Re: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Linux Netdev List <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
        Don Dutile <ddutile@redhat.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 3:52 AM, Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> Hi,
>
>> +static struct pci_driver pf_stub_driver = {
>> +       .name                   = "pci-pf-stub",
>> +       .id_table               = pci_pf_stub_white_list,
>> +       .probe                  = pci_pf_stub_probe,
>> +       .sriov_configure        = pci_sriov_configure_simple,
>> +};
>> +
>
> Is there any specific reason for not disabling SRIOV upon driver unload/remove ?
>
> i.e if a user sets numVFs to a non-zero value and unloads this driver
> then we have a
> situation where there is no PF driver in kernel but VFs still exist.
>
> Thanks,
> Sunil.

I think it was probably just an oversight on my part. Feel free to
submit a patch to disable SR-IOV on remove and I will give it a quick
review/ack assuming the code itself is fine.

Thanks.

- Alex
