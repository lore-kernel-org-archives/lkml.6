Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0688820854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k+TATX9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0688820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIKK7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:59:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43288 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:59:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so44931507oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZyFHSP1NmOjx8jUQRfdGgK1zMkFpUqXcebv0Mgsx+Yc=;
        b=k+TATX9h4LNO6kR5jQ5VQQ4uJP/X+mEcSbSGWiSxuP0fSqVlK4UKZ31DB8VOidZAtG
         aXARfooomdtfSvG5BrGS7YqUI5cqckVoRFDYIBXrAA0fLNvhsdm1AGY4+StQ3SLwPOZk
         ruZ0zp2j/o8VS/5tkObq+Z15wJCbuuYMKiCWasNqbyukRDKywYDZKLpJWh6AZRQgmdYN
         9vDaXez6ISdeDRE+m7nwK9WS4gXwV7HEqUCtjNLBitMCUoSzFQ7T5Upt9SrBlSDWoswM
         6J5Q8eQStQmx4iUefz5SqGaDMbUnPDBVnWPVgm3n4x0IGpBj/RyHcUewx8HzJSvv9K5E
         18rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZyFHSP1NmOjx8jUQRfdGgK1zMkFpUqXcebv0Mgsx+Yc=;
        b=SGRak3bMs8Nt077gQ4LIr6SfohlrhEDHJaqzfXMhe8Vzz4MwwzYW4m3kWabettbQwy
         9ZSLgzbkDQUpPs/CDbIdO1ePJXk1WES2lKMyOd0+jjcJghfsve+mE7+3HHLeZxAXYXIO
         gSKEF4zUNnrFxgYnOuubSAe4SiWv8hzp4P85hiknE/8X4fu54oV8t+WyT3k2yvnJVKRU
         YeK833N52ok4/GcunXHPs9xsk5Y5VesH34OSGdzA99VkXxDQ3ZEJHY9G3B96j/g/jKpK
         gTlv8h49jSYflbxmzm+cCfLFZWsTGim+PHw+OsiZHx96AdDdU4iuYmRd3mDeqhBmAai5
         H6Og==
X-Gm-Message-State: APzg51Djh9/CcxGtMouojLsu+vGoCN9C7ZXRQtxKbXgKDl3uOscRZjaZ
        kDJstE3JEGJ1nch9y8TjVm0YmRSMhctqnTsgIt1xXA==
X-Google-Smtp-Source: ANB0VdYaaDkJ/qleZQ1moZQ5SKAD1qN6sK/sSgakKHlWbob80blBmOdrKRMdaCukOOx3LLCkkny2xZcyZOs6bzE+jTw=
X-Received: by 2002:a54:4d9d:: with SMTP id y29-v6mr26445059oix.273.1536645732390;
 Mon, 10 Sep 2018 23:02:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 23:02:11
 -0700 (PDT)
In-Reply-To: <499a3093-3781-7a8a-abd0-8b240db11dce@intel.com>
References: <20180731143246.16915-1-stefanha@redhat.com> <499a3093-3781-7a8a-abd0-8b240db11dce@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Sep 2018 23:02:11 -0700
Message-ID: <CAPcyv4iPCwRCun_w+dE7P86KUC73f6G++sSUS4BFzBzDcsBOpw@mail.gmail.com>
Subject: Re: [PATCH] device-dax: avoid hang on error before devm_memremap_pages()
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 5:26 PM, Dave Jiang <dave.jiang@intel.com> wrote:
>
>
> On 7/31/2018 7:32 AM, Stefan Hajnoczi wrote:
>>
>> dax_pmem_percpu_exit() waits for dax_pmem_percpu_release() to invoke the
>> dax_pmem->cmp completion.  Unfortunately this approach to cleaning up
>> the percpu_ref only works after devm_memremap_pages() was successful.
>>
>> If devm_add_action_or_reset() or devm_memremap_pages() fails,
>> dax_pmem_percpu_release() is not invoked.  Therefore
>> dax_pmem_percpu_exit() hangs waiting for the completion:
>>
>>    rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
>>                                 &dax_pmem->ref);
>>    if (rc)
>>         return rc;
>>
>>    dax_pmem->pgmap.ref = &dax_pmem->ref;
>>    addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>>
>> Avoid the hang by calling percpu_ref_exit() in the error paths instead
>> of going through dax_pmem_percpu_exit().
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>
> Applied
>

A similar problem exists in other devm_memremap_pages() users. I had a
more comprehensive fix in-flight that I will rebase on top of this
change.

    https://lore.kernel.org/patchwork/patch/961576/
