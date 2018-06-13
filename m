Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EA6FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB513208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHJUlyT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB513208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935307AbeFMRl7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:41:59 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42293 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeFMRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:41:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id s187-v6so2024220vke.9;
        Wed, 13 Jun 2018 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hdfke7xyHfX+4uznM6VQtOrySiq8rWl/NTKolzN4WIM=;
        b=XHJUlyT5cMAV5qwgXQyV1PuaptE2vrhaIg1s8fzTw6Huv2h26OaXxjPLs1YUSYXVwr
         efSuoRp4Palj4OUYPpB8l0sqNO8Ve7oqCMRC1F7F+CCj++TNubecrch/H6js3gf6LKB9
         3Idh5/3PLiALi/9yjdojQXnaM1xMYcvkobUcNpjDfxst4cdG6Nv2CRWwpFR7v8SRk/zm
         vM9uuJdm729Otw/LyeJrEgBXNwNR38bNGylMjnSW5IGIAriT1ESFvhbl7mKrwdMyUjlB
         R99Qgq392fJ9rrdpNLkySEcJ6CsVDLKWyngbln4x8embYlDNB2kp2Fvt6zHDyoB6sO1F
         Bbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hdfke7xyHfX+4uznM6VQtOrySiq8rWl/NTKolzN4WIM=;
        b=tjnT3jvm5ZuKRI3HeKQ3bTF8CEuSmEKV1DpykQ1AbRhZiBEW17gA14GM8c6b5XwaKh
         zJQyUML0xdyMUjMENF9wiOqh9kV/pNgJdQEdO0fUpg5MPXiiJtpD2kOCIg9sofSH/4My
         lT1KNJBORHiocau18WC+SAOmsA8nHTQRxStmXaSdd1xdQUi0gPmU430T4IyHRxPUVR5S
         YSz/76DQdq0sXSmAIamfp/yLRMJ3j43DXk7dm2F9gMa0tuhe0N12SWYYi6S1+1IRzlLj
         IM1yCGjb88YPv5qV+7y93KHCRkAm8Jv61U8PmXuNPiGzY/AYdSxps70WCZxTKjTGIfGW
         5BKw==
X-Gm-Message-State: APt69E0xnYzRh3Z+JrvX5zOqM3qrjGC3N/MLDwWP5OTjqrqxSQJctnk+
        6jIrzZVRkADaU05XA0kCuLDURmPfQysQFJC/OMM=
X-Google-Smtp-Source: ADUXVKJktFTikfJeqzNPLqYY566tx9M/vXyokaKYNk6LNBfdSbmL4T68YuIG9OMDb99wGzwyfD8Dip29Hd1Bcb/DOEQ=
X-Received: by 2002:a1f:ae96:: with SMTP id x144-v6mr3652647vke.52.1528911715846;
 Wed, 13 Jun 2018 10:41:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:549e:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:41:55
 -0700 (PDT)
In-Reply-To: <20180612205619.28156-3-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com> <20180612205619.28156-3-anchalag@amazon.com>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Thu, 14 Jun 2018 03:41:55 +1000
Message-ID: <CAKTCnznqA=RcA1VWePn-Yt5AYn2-FKhXRJH8FgHjcG2Gjqc1Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] xen/manage: introduce helper function to know
 the on-going suspend mode
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, netdev <netdev@vger.kernel.org>,
        jgross@suse.com, xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kamatam@amazon.com, Frank van der Linden <fllinden@amazon.com>,
        vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, cyberax@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:56 AM, Anchal Agarwal <anchalag@amazon.com> wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
>
> Introduce simple functions which help to know the on-going suspend mode
> so that other Xen-related code can behave differently according to the
> current suspend mode.

I'd squash this patch with the previous, the previous one just left
too many open questions about how suspend mode is used. Looks like
suspend mode is a state, but I am not sure if valid transitions are
defined/checked?

Balbir Singh.
