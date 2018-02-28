Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1320226-1519859261-2-2642744985106278474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519859261; b=oZ+Ebjx55Ref8tw6SYdj6ZvKHb/bV4o7G582zdYvLcbHaol
    sl69HOPQaklZerpe6Ai9Rx4Yk6yuoWq0Q1fpnB+pFd530iGruttgJI2lgUYqd5cv
    /+SZyMi3EiQ8nwhV0+R3SdM9swCSlNum0kcKU5fjK/24Ys7JDGjOfeorP+llzXqT
    4dg1J+hRBqc8LWwMjKfKXEsPK9ee8McdkkH+jIiwK1aQFWeubD4IJdRusS48wGal
    KtMZAlkDC2S6npyIx51YJHGa/VQGKB1ShWTlsWlSURQIWwt1+2wu3GJP06ezjsn0
    DxsNJzN/G3J7pEXneFpLw7OOL3wMagVKs8YaKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519859261; bh=sPKRqnDkXul0pbSyRhFaBn7G/kr7P5qsfswze3
    CTwMM=; b=bf2Z9aknM3y4UDAA786r2Aj8+uzHXiNj+7G+s7pdTNi+WgunRaNphd
    HQ+goQulwkb++XN//JHLgKSApN7vNq8shAJsf+6x5ZHa5ZH4Gcr337CGOrx9hGy9
    C2avJ2202XcmNzVTt3wHoUgkPJuz7pAD9XvBWVCadNKpbB+RwB3Cw7KRKprqWVeQ
    2AcHa2pumLrD+WMSvjcMirc7tmxQ2FKLD7uZraQf6PKjofAjZI+kgktO4bZYKYU3
    yfOhLnDvO3bDD0Su7bMfYwFNPhqO+q/hJ5uT3tDiKrEo3mzkrBdFoG9WfuSdoRFi
    QoTG4bAH0js4RWbkkLUCt1a4JvuWsLQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935623AbeB1XHk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 18:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935541AbeB1XHj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Feb 2018 18:07:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F7221782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELsplr/q67yNnrsAX1700nEqbxgSyM77qf8NZofF3ilSzp098bpKyqh8wZDOW3MAFSyO4cc7iOhH9lmrXV/C8PY=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-16-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-16-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 28 Feb 2018 17:06:57 -0600
X-Gmail-Original-Message-ID: <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
Message-ID: <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] fpga: dfl-fme-pr: add compat_id support for
 dfl-fme-region platform device.
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch adds compat_id support when driver creates the platform
> device for dfl-fme-region. It allows dfl-fme-region platform driver
> to create fpga-region with correct compat_id.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-fme-pr.c | 20 ++++++++++++++++++++
>  drivers/fpga/dfl-fme-pr.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 526e90b..c17170b 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -314,6 +314,25 @@ static void fpga_fme_destroy_bridges(struct feature_platform_data *pdata)
>  }
>
>  /**
> + * fpga_fme_get_region_compat_id - read region compat_id from hardware
> + *
> + * @dev: fme device.
> + */
> +static struct fpga_region_compat_id
> +fpga_fme_get_region_compat_id(struct device *dev)
> +{
> +       struct fpga_region_compat_id compat_id;
> +       void __iomem *fme_pr;
> +
> +       fme_pr = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_PR_MGMT);
> +
> +       compat_id.id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> +       compat_id.id_h = readq(fme_pr + FME_PR_INTFC_ID_H);

I tried building for 32 bit ARM and ran into readq and writeq not
being defined.  v2 had proper '#indef readq/writeq', so looks like we
need that after all.

Alan
