Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3420873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665424;
	bh=nUSJQJtO9BLTvh1v50utYt+wrQTcDtXAy5C1rF6BNFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gg1P4j4bJdkJ9Syjppeg8irBzGw0NHwh+jSqe4clO/sIoL8R7FFxkWC9Q8FD+TVhH
	 UPsIFJWzMFgpSr4B2I0PFA5VfsciPqnVJmKPJI+UZq9YcqQ5Ccx8liPQd+KzNM6OkL
	 ILjwQLedVqNhnC9dcgSgQYijRe+3xir7UhfhwJ5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfAPTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbfAPTDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:03:42 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870412087E;
        Wed, 16 Jan 2019 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665421;
        bh=nUSJQJtO9BLTvh1v50utYt+wrQTcDtXAy5C1rF6BNFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CIETWKn6wjYiswQSfH9MfMxjdRaGJOBARrVFaP619j+pEgFw+lp1ZDEk42i7MKopO
         Po5xTlFnd05iLGy//ZSPcXHCewu7NP6f+d+uZD4V5ZPXl/owKPj7fey3buMOxNJ6+K
         AkfU6H/I6tuikY3G9HIadBOPVIImXiSQmvUAa5gc=
Received: by mail-qt1-f174.google.com with SMTP id y20so8403402qtm.13;
        Wed, 16 Jan 2019 11:03:41 -0800 (PST)
X-Gm-Message-State: AJcUukcG/Jy4uQ+F0zIWYu6WL2A97maTfH3zQk4XLc6X+fYRkJAvQH7L
        t5fyut1IDyqs60VFGWmY1Kz8ispD7A7VkbrHjw==
X-Google-Smtp-Source: ALg8bN4J04h9zk26LvZ6vG2ifxe9omR6/KMO1JZVN9PxrFa1dJ6rkTKx2PB8OtwaAxD75R+pUnbL7k9JiFEfRolv1Uk=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr8436396qtf.26.1547665420796;
 Wed, 16 Jan 2019 11:03:40 -0800 (PST)
MIME-Version: 1.0
References: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr> <1547372691-28324-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1547372691-28324-3-git-send-email-Julia.Lawall@lip6.fr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jan 2019 13:03:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+H_0=mQ3hMg2BWKMZfPo+is53zvx6kpSHUMfKpSW=zJw@mail.gmail.com>
Message-ID: <CAL_Jsq+H_0=mQ3hMg2BWKMZfPo+is53zvx6kpSHUMfKpSW=zJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] OF: properties: add missing of_node_put
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 4:21 AM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Add an of_node_put when the result of of_graph_get_remote_port_parent is
> not available.
>
> The semantic match that finds this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @r exists@
> local idexpression e;
> expression x;
> @@
> e = of_graph_get_remote_port_parent(...);
> ... when != x = e
>     when != true e == NULL
>     when != of_node_put(e)
>     when != of_fwnode_handle(e)
> (
> return e;
> |
> *return ...;
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/of/property.c |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Rob
