Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F85EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8CB2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544780190;
	bh=eW+iAfCmV40wB+DCajt/DYDRG93kWUAu5HvzX6I1XhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=brUTb+ekQMQBwzHAFxUguZtSRJARlaBdS8XQEFYs1AF9SnBg0Fb2LfUXpdofTfZ+1
	 Uhok94Mr2iuxNuZskc5sR8MiSLXKrUTFgcWBJO+EIwN+vyYg4ynVG+RT7pVHaOAYuV
	 hUqLgo9BC7vI5/ogcsxGmiBofWH/X0Css4mAqCYg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8CB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeLNJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:36:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39955 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:36:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so4795901oth.7;
        Fri, 14 Dec 2018 01:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m5vAoc783NrJ58o5paazB5KjaN9cfld/AKqk8ZToWs=;
        b=tbgVlN4jjljRkCX8NnZadf4V9A885SroGbI3saRHMsuAq8p2ZMUHky8zr2vf5IkuIj
         ffDWEhCuTvC7at6z9g71iM7PNqC6I0yCBywiqRtP0HeQDmjPybVBvYWPuhlT7ykDca8K
         YFcyIv4NNCnd6ixnoCM9qzkcb1Kdly7Hc+g6hrriOSRkCuF/ZJ0DoeL12Cfe5XUSChDr
         1gNZeJcpiTpOh4VtxN4E55qJiiPQ80sCs727h6E2NN3yPbqq0+1cZWgsGRRxCugng0TT
         iyYhuwrpAXKX1y+hjI77++X6p/nunOEiBHunu7CIAAGYFldPk+me6hM5CGblQVA9MVxl
         Cp8g==
X-Gm-Message-State: AA+aEWaHPxb3QB/Be/Xq9V8wHHPSGVXuLqCRcKb9iKE8CBZJkW03SJoe
        83ptUGU6WQ4Dh1u/CYFZzqvRDMcMPXc3LcmCJY0=
X-Google-Smtp-Source: AFSGD/WmZN4AOHKZBIgYalIVYIPX+L3tQmO1kU5AsIjVOxw4k6JsTIqCK8avTvDQsvPoeNZK9oNgAUgkspeR+taeuwY=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr1636059oti.258.1544780187652;
 Fri, 14 Dec 2018 01:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com> <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Dec 2018 10:36:15 +0100
Message-ID: <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This implements get_name fwnode op for DT.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Rob, any objections here?

> ---
>  drivers/of/property.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 08430031bd28..5c10fdded473 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -823,6 +823,18 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
>         of_node_put(to_of_node(fwnode));
>  }
>
> +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
> +                             size_t len)
> +{
> +       const struct device_node *node = to_of_node(fwnode);
> +
> +       if (len < snprintf(NULL, 0, "%pOFn", node) + 1)
> +               return -EOVERFLOW;
> +
> +       sprintf(buf, "%pOFn", node);
> +       return 0;
> +}
> +
>  static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  {
>         return of_device_is_available(to_of_node(fwnode));
> @@ -987,6 +999,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
>  const struct fwnode_operations of_fwnode_ops = {
>         .get = of_fwnode_get,
>         .put = of_fwnode_put,
> +       .get_name = of_fwnode_get_name,
>         .device_is_available = of_fwnode_device_is_available,
>         .device_get_match_data = of_fwnode_device_get_match_data,
>         .property_present = of_fwnode_property_present,
> --
> 2.19.2
>
