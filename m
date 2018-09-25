Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7957CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29551214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="BptB6ikQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29551214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeIYNho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:37:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39729 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeIYNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:37:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id w21-v6so5060119lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iqpsji6j4A6cga/cd7zd0zvPFpDSEmk69PB+6sevKMc=;
        b=BptB6ikQ9EDriSVhXb/h3/a8TNcha3eQisHXcNAqm8cixR7M6MIScjWuuuC5eVh1Ao
         tswJztTsBlk05keT4U2fYOP04e4/nH707Pl2XJq4xHvpVpe4Ws5UlQg2mkO6NReQleSc
         snvFZSyNW3rrRKvYMyv1YdH3C/kBD+7xvYsZ0sro0iX0HxNlkAf6MpEc3BEkTvsxjeCc
         OcCoEIhhhHN+tIrQQssRJzulo3aTc/orL17dnkUNPZncw/FRh8X9VMqpc+rnHNKq3ATW
         j5Cz0f4myDUs28Dcu89ln+hVmCdFc0JBOCEyS98+FqvX+to8jRScr7EADL20FxP3FBbN
         AOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iqpsji6j4A6cga/cd7zd0zvPFpDSEmk69PB+6sevKMc=;
        b=jrSlQBhuPuMWuXoqzYORom8KiJa8QjR4zucdzvhj/5VlV+/JGfv7Hoj1RSvrolrXdW
         PSa0KdDU15XKYM5eTwek5sLjm3SYcs6NxtBvlwc+kKCLGOku7Yl3CaPbJXBFYiU53B+Z
         AYvKpFBajrYUlOebEwBfYurubMN7uVyfjYJqQ9ikU7WkYO4SkK5V2YkE6uxXdZ3FE77J
         cXvxCg6Z1pmnvR1NLRwKA5jLcfStZBBtsSa5+uOateud97ryzzV4HW4DCsTDAljzG2WF
         7FX0qW+WN+hcieVaaX45mLNInB18sBciBiPBnbQdWI7WxGxFd1Sfx/qVP4O3t4U7Xfcy
         Qnaw==
X-Gm-Message-State: ABuFfojyfNQ+kMT/oTei6nuZP6j1v0c/xSFTM+5qz9INSc7PG957BF1G
        MErcuNOfhtl7gVwjAh6UgP7qBg1AKgTWXw7UuPfJCkEEHO0=
X-Google-Smtp-Source: ACcGV60L+b3vJSB3gM2F+vsjGJ9pRuOjs9iF1w6FhkjgM/71Y6MJ0/MwsbhDfo/gURiK+n+aGTv6iYfCnnibIF5wI5M=
X-Received: by 2002:a19:5a8f:: with SMTP id y15-v6mr1701205lfk.15.1537860688927;
 Tue, 25 Sep 2018 00:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
 <1537853328-1282-2-git-send-email-svellattu@mvista.com> <20180925070431.GA18765@kroah.com>
In-Reply-To: <20180925070431.GA18765@kroah.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Tue, 25 Sep 2018 13:01:24 +0530
Message-ID: <CALabi0E=hBjzxarFcvSTtod4x4=efM+HcHKR8J3-i-+K2ntH=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] treewide: use bus_find_device_by_fwnode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Tue, Sep 25, 2018 at 12:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 25, 2018 at 10:58:48AM +0530, Silesh C V wrote:
> > Use bus_find_device_by_fwnode helper to find the device having a
> > specific firmware node on a bus.
> > ---
>
>
> No signed off by?
>

Oops.Sorry about that. Will send it again with Signed off by added.

Thanks,
Silesh
