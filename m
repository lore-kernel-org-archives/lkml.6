Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58522C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97427F89
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgwHZ3gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97427F89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936629AbeF2N6J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:58:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54029 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2N6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:58:07 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so2959220itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8tQkYgcqjql2ntIIbeJqo1KDhCYyMtXtM73V/Y9oZY=;
        b=bgwHZ3gfNW9FUGAwLRcU23vMA84MIB+GOKV3cINrpuW/JOHjo9enN1LNWG+lXeKKRi
         7lFmkxh8m4sQfUqDIJcLWsSD0TT6XW9m/sjRnQ7D8JIyXdNzf1gSHM3FA1WC4vFzgBj2
         PH7Q6ufmdJcc/UfKYrtDyTBXiGxdGhFZHdgSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8tQkYgcqjql2ntIIbeJqo1KDhCYyMtXtM73V/Y9oZY=;
        b=b8WbLIXh5kWNEjI/Kko0CONXiy4RsvRa2+QxZUDBXitXjQ211HMiYUpjWwdQINsjPW
         4SNHOcjJI+ioPStnlKNsCKwAtY2G4ibZlo55WtqH4oHi7sDs2MwS6bml7LmhFlCwEbFB
         OKC3RAIJ8z5QGHhpjyI4VFSGyKTqvH3X85ivHt+ZmKkYIShP6zkp5Xl6Oei/5rnSRLjs
         RhNslEeZk9HQoR4lo9x26VzvAEVXccFsti8ssQlI/m2reeA+gm2TjU0XgbtaZOxuUCp2
         6Wi85z0lmQ7GCt0ZjtyNtYgB1UQ0ilm9b4y+96dzLSgA2/Dz1NFz4FHvoADq09YFL2I+
         Zzfg==
X-Gm-Message-State: APt69E0/8sQjLxWry7TkCIhUDqkQWiks/WW3tsUU3A/48DcyuNTT4J8C
        N0m3lBukawTjaNP4FumXdDb/CXPIRSbanV6YAyM=
X-Google-Smtp-Source: AAOMgpfGy/pfEzj4jqAeJ/OPeey+M8m+yXf0X0J7VSVX0BhvmPusu3i8Uv1BwKVvM5q/fynI1EfzCLe3cUzhj5c6Mg8=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr12614248jaf.70.1530280687171;
 Fri, 29 Jun 2018 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org> <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
In-Reply-To: <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 06:57:56 -0700
Message-ID: <CA+55aFzwFUfzF8dFdfczqngZMEofDUAUzWGrjd-tjeOLS=Z5yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 6:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This patch seems to make patch 1/2 pointless. No?

.. well, maybe not "pointless", since it seems to be a good idea
regardless, but you get what I mean, I think.

             Linus
