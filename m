Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF73FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826BD208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="J8+YeT5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826BD208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeIOG4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39660 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeIOGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:43 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so14441290oig.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tZXgHBQYHhBgVHRHL/h8xDhmBbiWwGy8Wgx4X0K6TY8=;
        b=J8+YeT5U9wV9/JyPodmuYfQE1jpW3ka3uO+878to95Rl1JABePFoZ6xE0FjoeGZKBw
         Se8tqkmwXYsSlD3rPnkF/yFaSgosUkH5EEKHFzxMFG1Zgw4/zuRP8euVhALruXMsBPHD
         taAxaE2gpEUQ12EAm7aNLnsssTMr66ID1ZGU5V8d3RrqxKYsaVau40SVz4SPbv/QqHM6
         9eTbyzIoEKTq4S+rXqsSYIVkOiEwppIyJTlwfKCNv5q6LP6jI2BPFx8btzE16vkOmjgY
         W6dz+qIZCnwi8PLSDRTJ8Vn//5IXhjOKsuHsxD4Dnm8S51Oadqkcwx+/nclD1NDEyrlz
         4KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tZXgHBQYHhBgVHRHL/h8xDhmBbiWwGy8Wgx4X0K6TY8=;
        b=rN6xyNA3x1MxS0ExN00BYChdsWnvKMcCzfb2zymLaiYxCX8vWWgkIUpzS3rqAZYbpV
         rp98Jn7vD/ISbMpf4v7ERJ/R/7WX+p+D4Kl0hGXRp4l+vRWXFyJd1CdlnyABM3pqEl1Z
         NQMK/2/gy3rmGF7P+iqxl3Pw98JUZoKEywJBrrKeCV17xJ9YWtokuz92Buvc7y41/adF
         S4vup0sxY1ECvgkYgIq4WExn2gQV4PRJGGieA+jq726oTjNs6tmORderf0UsH6PH2Er+
         vyG4t8g/jvAQ/17Nlz+z34KysfcylEIlkVRJUPaoxvsTQvQ129JyNLfoyiz4R/T2WXVc
         n8DA==
X-Gm-Message-State: APzg51BbxgHcPplMPC2FojQnzdFM9kRiFIphJEK2lCFr+dJXGR0gcQO2
        hSWTn1ytBKltqzUal1Y22zRclNeqKuu7brmlerfxAA==
X-Google-Smtp-Source: ANB0Vdaow6ykqahVNCtOwiGME7B5og/rauox1Lo1jOpfgXcgfeLolgxPobSmbNjz5FB/DPDA7tSGTvja4WF2N9ZxhcU=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr10678011oia.167.1536975284378;
 Fri, 14 Sep 2018 18:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 18:34:43
 -0700 (PDT)
In-Reply-To: <20180915012944.179481-50-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com> <20180915012944.179481-50-alexander.levin@microsoft.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Sep 2018 18:34:43 -0700
Message-ID: <CAPcyv4jbHivBtLMD0uQ6TMMhObPQ_5287Lirus=RRD5O2GjB2w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 6:30 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> From: Dan Williams <dan.j.williams@intel.com>
>
> [ Upstream commit e5d772fbe7685aae0dff99f3b54158a0ec32155e ]
>
> In addition to populating the value the payload also needs to set the
> "controller temperature valid" flag.
>
> Fixes: cdd77d3e1930 ("nfit, libnvdimm: deprecate the generic SMART ioctl")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  tools/testing/nvdimm/test/nfit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index e2926f72a821..94c3bdf82ff7 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1308,7 +1308,8 @@ static void smart_init(struct nfit_test *t)
>                         | ND_INTEL_SMART_ALARM_VALID
>                         | ND_INTEL_SMART_USED_VALID
>                         | ND_INTEL_SMART_SHUTDOWN_VALID
> -                       | ND_INTEL_SMART_MTEMP_VALID,
> +                       | ND_INTEL_SMART_MTEMP_VALID
> +                       | ND_INTEL_SMART_CTEMP_VALID,
>                 .health = ND_INTEL_SMART_NON_CRITICAL_HEALTH,
>                 .media_temperature = 23 * 16,
>                 .ctrl_temperature = 25 * 16,

Does no harm, but also does no benefit since this is just unit test
infrastructure. You may want to blacklist this directory for stable
checking in the future.
