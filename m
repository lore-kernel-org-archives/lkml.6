Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C691C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039B320685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz6C5jQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039B320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJaSnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:43:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46472 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeJaSnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:43:47 -0400
Received: by mail-ua1-f68.google.com with SMTP id z8so5641146uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FSkhAaaRYQ810JuigKdPIuYFjFvfKU35f3b681oNGE=;
        b=Dz6C5jQGdkscY2t9rjjvBqtZt5azT0AQ332qFsrw2ScnkKsiUNPBtVWo6FSEmAb1nl
         3KEUcKsj4oZVi4GvHz3sCSJjvqeqCkF1u0g/33qYk5UjWbc82pzXju/8TldE2AWoPptO
         wU5GNKoV6myqpPypTzTdSFnylAZkrd13wB4wYFkp1+JS1/3b9uPtPGjChyRAt9IfYmiz
         5CeHygDtkNtOhh0ddy/EFVVMIKHmiAx1UNpJIuGfBDbsFLVEfCGUpW+BJJkwxnbuyaPt
         HMeYWOg12vJGqIQBHeROncJ0Kbket+gG0FL5tCq/q5qfGyhbK2mkPQGAK8o14KKPRGod
         L/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FSkhAaaRYQ810JuigKdPIuYFjFvfKU35f3b681oNGE=;
        b=bvP7+k1KgH/BCUZAkXsCdo+iBg9F39m8qRF0o1fEaL75h3Fq4DoKshNYnY3o291pog
         zxErOnkA1TLzd4dLKf39Wthsb2IyQqHNbzC+xQT0k169T0QET66gMxCW1oB+toCu+Y8X
         Zf0DGVAi0KzQdnvqTO8hs/pmqGsTosZO8Bu2xXKBnmuEKdcyMualOiOv0A+h5JYzY2Ch
         /NvzSAoSW2ttQZYx1CKi5CETpW9Wz3gnh3PXC/o4Ti/rtZ1aCb1AF1VD2pNmwbtLBczL
         fApfVSnV7ewZIfnGbKec+GzmownYRtmHIE1735Tydq7jMfGG+mKmYZJKpLepSXqkCHqr
         iYPg==
X-Gm-Message-State: AGRZ1gKMWCGpNBoHWBlkBinHU+MW86gnjxxnbE5MGue5MapknthSTuHq
        Za3ItidyAZHUHNh9Po9Zlg4gpHXUv49mOwZRbFA=
X-Google-Smtp-Source: AJdET5eIsNKNOsErzbX7xRwhYdVIZ3ALB8y5qrnGt9Aw4CqoDIvSD4gOGE8dxkku4ZdkDuaJkB2F9yaGKJ+deMQCqeY=
X-Received: by 2002:ab0:7055:: with SMTP id v21mr980814ual.1.1540979183303;
 Wed, 31 Oct 2018 02:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:45:05 +0000
Message-ID: <CACvgo50dph07XsrbeNJ_WcL0cTuiPG-viX9oczaVbsP9wKb9xw@mail.gmail.com>
Subject: Re: [PATCH 0/5] virgl: fence fd support
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 25 Oct 2018 at 19:37, Robert Foss <robert.foss@collabora.com> wrote:
>
> This series implements fence support for drm/virtio and
> has been tested using qemu, kmscube and the below branches.
>
> Rob Herring solved a reference counting issue and
> suggested a context check for the execbuf ioctl, his
> changes have been included in the below commits to
> keep the tree working at all commits.
>
I've put forward some mostly minor suggestions.
The patches look pretty good but there's one piece missing:

>
> The linux series can be found here:
> https://gitlab.collabora.com/robertfoss/linux/commits/virtio_fences_v3
>
> As for mesa, the branch can be found here:
> https://gitlab.collabora.com/robertfoss/mesa/commits/virtio_fences_v3
>
Namely: This should be out for review. The kernel and userspace side
of IOCTLs should happen roughly at the same time.
Otherwise, there's a huge chance of merging one side of the component,
while the other needs architectural changes.

HTH
Emil
