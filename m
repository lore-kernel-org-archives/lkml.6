Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525727404-2-950965883825380340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525727403; b=J/WYPnOgcZq3jwKuiCu1j4dNNHVnto8lkFrOgrgaJ1WdLMp2Wz
    9P/jcgWoFt4rvsmIhmmEcjXuUqP7c6dnQY1t44YFg91EUZKrmqcDhCDtL7JYGtKd
    ikTsGIA92UGNZfwUZxLivJllMKXAm93HOF12zzP3YzCcRIby6iofwuDjjR9rEgsx
    2OFqvCMRGnSxVQtnCOFAozB7CzdHqWkbT0whk+NVdJbaEjnP4dBLGXaaVT10P+Vx
    m9icaHfqd8TCr5l2b93Yrk3nWte40GsfFEWD5xIDbJ1dA+3O2TLBYZavVWp1Gmw1
    wRTmhfpircE3fuid3Fwq+owXuaByL64GkE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525727403; bh=Xld6tRRKFrVXVG+E/5IXCgDR4ICq1pf4ebDn+9FYer
    0=; b=VTx11yUoJZ6TOYwrhlYOZwtsnA5aXSzgq86kFs37PkuDhkKCbsSlPXk688
    rQTTqR0jOcI2ib5RR4mqgjef8Ld1wY5TFDeQZB3u+bl/y3kiFaM2eFkTobMzHXLQ
    uvhYSZzSIqpFKe6YnmtNipRcwJLbXQUf0sxo9EVh8au4u9rdqrLx030P2Bf4xPD8
    Qz8hz2PJSp4hN+mLKCYatobuUzldXDaH7IhxHPJlMwzTseuXa3sPhlPaE0cExCRI
    jBZ7Im5l8vPS9P7V5G7qDLswW6pY2nW4VEzkmV9+EHb3C6ELuVcNk53rXgqtzUns
    PhxU5OzfCMxaPloU5eKv2eLXg2Aw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Kl7c5ULF x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Kl7c5ULF x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGQIBTGBZBS2DV6GXKTH/J5K8fJnbCdhGch/AdJUyxYZ3uUZhBO4vBRaoKzfcaj19MWTWfE0oJK0l8K0mWbsgPSER8+ySSU0z8Y8YyjlTodQfN9z8mQN
    L6RB+JksAduHHeMqt47ZyEmEouvWbpQwdFyT0VcE5i4MgaT2/+5wCWveii5EwCz4AyhcpwlA2DETKU/51fqDLRgGaytvnt+5LQTk++YuVpN7Gaik/ScEvj2j
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=mhZ87osAyOSdila4UxUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeEGVJv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeEGVJt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 May 2018 17:09:49 -0400
X-Google-Smtp-Source: AB8JxZrTGR5aUlX5MQgrhpIErjOTnKwOKrsyCIq2RoG8Z8wP2sdJ89rVicIKe3+8FaUk7oc+pG/TfosHa5ap+GptGvU=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-5-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-5-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 7 May 2018 16:09:06 -0500
X-Gmail-Original-Message-ID: <CANk1AXRsWsd++wjWH44CCWN+cmscy_WjLJhaGGgxmmNe-u1OLw@mail.gmail.com>
Message-ID: <CANk1AXRsWsd++wjWH44CCWN+cmscy_WjLJhaGGgxmmNe-u1OLw@mail.gmail.com>
Subject: Re: [PATCH v5 04/28] fpga: mgr: add compat_id support
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

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks good!

> This patch introduces compat_id support to fpga manager, it adds
> a fpga_compat_id pointer to fpga manager data structure to allow
> fpga manager drivers to save the compatibility id. This compat_id
> could be used for compatibility checking before doing partial
> reconfiguration to associated fpga regions.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  include/linux/fpga/fpga-mgr.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 802eac8..f163f22 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -147,11 +147,23 @@ struct fpga_manager_ops {
>  #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR      BIT(4)
>
>  /**
> + * struct fpga_compat_id - id for compatibility check
> + *
> + * @id_h: high 64bit of the compat_id
> + * @id_l: low 64bit of the compat_id
> + */
> +struct fpga_compat_id {
> +       u64 id_h;
> +       u64 id_l;
> +};
> +
> +/**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
>   * @dev: fpga manager device
>   * @ref_mutex: only allows one reference to fpga manager
>   * @state: state of fpga manager
> + * @compat_id: FPGA manager id for compatibility check.
>   * @mops: pointer to struct of fpga manager ops
>   * @priv: low level driver private date
>   */
> @@ -160,6 +172,7 @@ struct fpga_manager {
>         struct device dev;
>         struct mutex ref_mutex;
>         enum fpga_mgr_states state;
> +       struct fpga_compat_id *compat_id;
>         const struct fpga_manager_ops *mops;
>         void *priv;
>  };
> --
> 1.8.3.1
>
