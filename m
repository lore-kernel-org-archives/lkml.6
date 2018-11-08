Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6592DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D32081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSWJL8rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264D32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeKIEAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIEAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:00:48 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A3F20827;
        Thu,  8 Nov 2018 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701443;
        bh=ALebZhLDWLc5sRvNg042eAW12epw5DNWO3LvUxjU5DI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OSWJL8rzGVlcaweCxD5Cx90ZEPFdxS/csg2X5VmDHIYT7D+WQ0HCeNlbUQyam71Sk
         wgbUgfR+FnOuktUH270k8NjQIELDq7sfJ8J748g2UMULh3S9aDfUo9PSw6fsa3zwuo
         N/UlZIHXWi3f9WLdEsKQJrUSVsPPWWB/E7ndka+g=
Received: by mail-qk1-f173.google.com with SMTP id d19so28195889qkg.5;
        Thu, 08 Nov 2018 10:24:03 -0800 (PST)
X-Gm-Message-State: AGRZ1gKjiFxN91az/VnvX7PftkqzFN4Yax6tAMw3tNCtZYui3w2ibqos
        QR8GYLgld5JnAD0mkBoFWYVR41HSGtCR/iTM/A==
X-Google-Smtp-Source: AJdET5dzF9bTLiRMZfrwIK7uba/LpfuOim59V0rH36YmXnuHqlruneMNCXhtlzUgE3UKb5vmpcQ2ELkugRPWxjR2Njc=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr5068273qkg.184.1541701443010;
 Thu, 08 Nov 2018 10:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com> <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Nov 2018 12:23:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
Message-ID: <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This implements get_name fwnode op for DT.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/of/property.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index f46828e3b082..9bc8fe136fa3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
>         of_node_put(to_of_node(fwnode));
>  }
>
> +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> +{
> +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> +       size_t len = strchrnul(name, '@') - name;
> +
> +       snprintf(buf, len + 1, "%s", name);

This can be simplified to:

snprintf(..., "%pOFn", to_of_node(fwnode))

But that presents a problem with knowing the length. Not passing in
the buf length is not good design because you can't tell if you
overflow the buffer. Either you can pass in the length of buf or do
the allocation here. In the latter case, then you can use kasnprintf.
The downside to doing the allocation here is then get_name() has side
effect of allocating memory that the caller needs to be aware of.

However, I think the current API is better. It leaves low-level
details up to the firmware implementation. But as long as .get_name()
is not exposed to drivers I don't really care that much.

Rob
