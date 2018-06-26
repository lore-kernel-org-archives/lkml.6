Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3C826A7E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XTy+JyS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3C826A7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934134AbeFZSww (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:52:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46347 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbeFZSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:52:50 -0400
Received: by mail-oi0-f66.google.com with SMTP id h79-v6so16975690oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dp4Gsuyo/S0fzQlMRo3ONbiMgTgD1AULKi8sXQ1s+cU=;
        b=XTy+JyS3Gksn6bTQ8jSHKPA8uIkXPlQvUOSbLwCEudZzsW3Q5EDTKKg6bjOvjkmMsw
         LwLJnDVRlz/qryEeuUxjdTxGk9u6COC4oW+7ToCzZ4iNKYYg+WKSEz1RlP64D1ldOmBp
         OkTC9/VJ/32KK97Tg1IEJA6bcR61EuCJHfRCnlqtt0Yh/2fgPby0Gqz9BXYd8a7HZ5MM
         Q8Zw2TmQkq2Pz5dLsGFh1rBSQbUvPiDVm9kmIIWTSUmvKk3uA70HS5NOOSX6PwqIcaBz
         AyeUMD0NSz3kOgZIuZVOn/VoRoM0539VrpEY46Ryy5pbnn1Lnvf27CriG1+mgMv280YR
         EX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dp4Gsuyo/S0fzQlMRo3ONbiMgTgD1AULKi8sXQ1s+cU=;
        b=iX922+mp3cvkNqXzopcSb78/vqTvS9Bk2566+dQFz2XNand/phOuYyGWI73D+hBANU
         ahyXuGgskx8UpC/FLDuMWvIkzimu6SDpgCbIRRbQUXL0ZP0XYfdY5fgw6WoUvZmZPV5T
         sqA6U31HyEi1MqsW5Umk16hLJLp0g8jp+AJe9agDEG9V7AiLcTp573ApIHluaqhRhI5+
         3jDObQcPNQGpODJu9DHpjnOD3MojOoiLQLujJtIASbuOLzL/yF+2FEM8LKhaFMKyeTKv
         t94bfpWaDfqr+ntha0BWnRD/qtKl8fC2cRcdSdq1/Rv1Vb61W3Z8gsSlAvUxJLIuLvra
         W/HQ==
X-Gm-Message-State: APt69E0KCxLaCC5o7Mt1SsvJlCYAwvEFnRxoVDTeNOmFKOP/bGuZYG/J
        ZLyl04N3YF8cNWbNOuzKUfFEc4K1JaBqedweMEwVlA==
X-Google-Smtp-Source: AAOMgpcaHgxd8/NeHhFeQ0rR3v+G5Ql9Z/f83QDQDMj+xpU3L7QnrxJC2dYgTCIzjDFVQNxUA9GmE0SHGNScpr3FPZU=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr1431536oih.295.1530039169643;
 Tue, 26 Jun 2018 11:52:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 11:52:49
 -0700 (PDT)
In-Reply-To: <20180626175932.8899-2-ross.zwisler@linux.intel.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com> <20180626175932.8899-2-ross.zwisler@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 11:52:49 -0700
Message-ID: <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> QUEUE_FLAG_DAX is an indication that a given block device supports
> filesystem DAX and should not be set for PMEM namespaces which are in "raw"
> or "sector" modes.  These namespaces lack struct page and are prevented
> from participating in filesystem DAX.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Suggested-by: Mike Snitzer <snitzer@redhat.com>
> Cc: stable@vger.kernel.org

Why is this cc: stable? What is the user visible impact of this change
especially given the requirement to validate QUEUE_FLAG_DAX with
bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
afaics.
