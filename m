Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044D8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D262086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="F5FaJTNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D262086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeIZC1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:27:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36880 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeIZC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:27:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id o13-v6so25784927otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz8TNOMmDYBqdlORXnz2NWjU8EzxxFAJWn9kcR4UIfc=;
        b=F5FaJTNylrYbCN9aOdejJdEtJLfh1dQW7C0V6H7ejZ1JnrA27WovrnPJwHjgTNYIAH
         Z/pAyTnMMj38Iu0FwAEwPJ4ykKH84VKKOsmZRhAqCRqI6WZkX+zuo7OeF+kAcJni/umQ
         938EUJip0hOp88aRsgZZoGI4d2Cbu0iRE2X2Byfr72iznqaS2ggqM2OTHRJdbdeXdJaw
         TTaWAtxlhbcCZHK++A4WgCrTt7xmDzSB1adNsvVWt/yvRLip4zvr985OKbdpubPgQvFI
         i0wMdJkADFHPDlsysZYVp1V1L//jgp/XkMl1P3D8szCCrZ/HvVCU372m3tJ7Mk1B+H7B
         YPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz8TNOMmDYBqdlORXnz2NWjU8EzxxFAJWn9kcR4UIfc=;
        b=Ys/yKz8NyA6EmovJNwmcEYpN62jC7wzF7ro3N1KtPQnQeK5qTXeLjhHoE9MKPYTo2M
         TXPUMMxuzAy6N1maCbZ5gKwo7F1rDNwIIcwxAm1adL2XG/f3PCjiBciA6md83MWjVtAq
         YXSfTlp5QDFtimCXofTQ5WYNd/0IXCDILYEhnnMj/Gw4Z/dQHZTjfEn9hKYbbIh+s/gS
         JmM3613SKSQ5Y55R4berA92kSlbn2/3QiOH3Q9Qw7FhVWmdBemTdQIwvHHaHxFLB5ZFY
         X7J/mZZgLwGDsQ2gC0Ae2p8YkrXWie+JbUhJ3joPD6a2fQhWf73V8qwQJxAJT3qM6YeV
         pu2Q==
X-Gm-Message-State: ABuFfojByVZxVGmiczuR2XWQ0BfWkmLk4gAmQywPeUJi4gXwBth7LB11
        Gidix5tGtVnvw7ItoiVmdUuMN9K/iVK2feGnXsmnEg==
X-Google-Smtp-Source: ACcGV600yRV9/+i3nZum43mAlfR52sSaVeGfqyAW31RyXcdLTdirgzo1ZYIqMHCo1CMsru79GdJJcxlKNGxnGJQdJLI=
X-Received: by 2002:a9d:420c:: with SMTP id q12-v6mr1305422ote.289.1537906685879;
 Tue, 25 Sep 2018 13:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
 <153622557095.14298.10281337300003012767.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622557095.14298.10281337300003012767.stgit@warthog.procyon.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 13:17:54 -0700
Message-ID: <CAPcyv4gmMwRAG=VxWNyeacxdsPCsaT+BtR+27+bHT=6heAZ3sQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] UAPI: ndctl: Remove use of PAGE_SIZE [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:19 AM David Howells <dhowells@redhat.com> wrote:
>
> The macro PAGE_SIZE isn't valid outside of the kernel, so it should not
> appear in UAPI headers.
>
> Furthermore, the actual machine page size could theoretically change from
> an application's point of view if it's running in a container that gets
> migrated to another machine (say 4K/ppc64 to 64K/ppc64).
>
> Fixes: f2ba5a5baecf ("libnvdimm, namespace: make min namespace size 4K")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

Let me know if you want me to pick this up for 4.20.
