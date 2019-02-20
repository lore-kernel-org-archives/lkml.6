Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880492089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656257;
	bh=8rDR0ZLhNhc7fULpGvJScaFDBgadh6Fp5E9YsMd7jj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PI9Ui+E293UoB7+e8wMjvkQhh/vMciRjAcL63aSFXMWsZJwBdyQfUvoYfraQb7yF2
	 gEqob0hZcrFHdVEFGVpwKaVmTfbXDzoz3FErG6QX6eSwRpeWOd3ZNd3r8BrgaMNVxt
	 ZVB150Cti7AMcwEhMZL9SXNCGJl4gTq7opNIDF2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfBTJuz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:50:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34081 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:50:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id 98so39259630oty.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7ycj9SXZ5xf/DqvlVK9gKU0ZOhZzRzM/f8jp1kRiSo=;
        b=Xfp9mWG6Cj5EsiF7WebXSsYi8QtFo3j+EQieawgYnaNd+fm5GXe/DmWfGWKOM+0Nlt
         cwWMOJboIeLTJpWELg3XObsaC7Kq78smN9jk+izsuq862rXWWE3WJjvPiOjzWAzalOT1
         NCC8LjqCaLWjTfYNBltGZV0aVimb00+R9oZ4k3s9zVqZ7Jl4AHMTiyqx8JibXT7J/I1Z
         SPRBscQfJRYZ7qZ97IXH6SA/V/90/SEO2h33vAi7OTBp4kqiCPhrki98SxmdH5EUmg7Q
         mca+4qO/feEAgsI4Gul76w9XJLJwur9anlQEBAVIChpB1sc3IzmWnC8cqclFywY7pDAF
         QSwA==
X-Gm-Message-State: AHQUAuYec/QoT9W577sNOoPG1MKJcQ4ifCk22aA/7jWlYaR6Lkk7gDQU
        yrt1WkHURhSKJwT/Q7d05DDHdLGd1dk2BiNJK3E=
X-Google-Smtp-Source: AHgI3IaJlhuC7XZP+1HMYaGKYvvikJkKu3NRH/P90fNG1knWTECmaOiQURfbwCwFMyddnDH8yD/Lnv3LknaVEx3zhOs=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr5351499oih.178.1550656254497;
 Wed, 20 Feb 2019 01:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com> <CAJZ5v0iZHfU=mE3JGcKqbswGGert7CvpKPkVE1s+-X1zXKJiEw@mail.gmail.com>
 <yw1xk1hxxss8.fsf@mansr.com>
In-Reply-To: <yw1xk1hxxss8.fsf@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 10:50:43 +0100
Message-ID: <CAJZ5v0gG5Rau71YrmUL8V7EpZjHQNOzLpEJHCJjXdgaDm4TrSw@mail.gmail.com>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:10 PM Måns Rullgård <mans@mansr.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Sat, Feb 16, 2019 at 5:50 PM Mans Rullgard <mans@mansr.com> wrote:
> >>
> >> If the provided fwnode is an OF node, set dev.of_node as well.
> >>
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >>  drivers/base/platform.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >> index dff82a3c2caa..853a1d0e5845 100644
> >> --- a/drivers/base/platform.c
> >> +++ b/drivers/base/platform.c
> >> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
> >>
> >>         pdev->dev.parent = pdevinfo->parent;
> >>         pdev->dev.fwnode = pdevinfo->fwnode;
> >> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
> >
> > of_node_get() generally does a kobject_get() on the node's kobject, so
> > when is that reference dropped?  Or if it doesn't need to be dropped
> > at all, why is this the case?
>
> platform_device_release() calls of_device_node_put().

Yes, it does, but this is the reference that's already acquired for
devices added while parsing DT, isn't it?

Your change adds an extra reference AFAICS.

Also, why is this patch needed?
