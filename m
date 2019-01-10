Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECFC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD60206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzzMx2lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfAJWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:52:47 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42462 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:52:46 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so2866800vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P685nafa2zAhgI9zC6sdbujL0xwAtvqi0aNgLLph/TI=;
        b=YzzMx2lDiGK3NMYbzHeZe/msuEv9PiHkTHo2YTKzNeomHQBc6chIBEacJmMxVoLYhE
         6P9xQTbDSaNsJDgITFuNhAdzGuU5hwxYayRUDtv3WCSTag+Zs7KhoCdUFeWxusC51ESN
         Lo/RWfH+aeq6cXTFCMy2ed5O38BxapTXpaeWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P685nafa2zAhgI9zC6sdbujL0xwAtvqi0aNgLLph/TI=;
        b=akM75QJ07ykNN9hEMUuR57bW65BADwEyA0gcEFUP9CKOx+e33HRKM9jyodsOroWfWd
         Be2DWzmhjhL5uq5p3CTbyF1Iy8eXYdRHGAAIomdxdyBCcynabzNeiy6DR624s7kAKpwy
         9dMYhg+0FZG4qp0XavedYnj3mWXpGCxSUYVvVcsf62SPtj1t/NNpzyzzCe3aONH2X2Uv
         NsfLVdSEe4CwYBLXFn4f6G39Of3Actjr7T0825VEr32p81zKl0oX4dQJcWRs6URDHDyP
         01zyfWo4qwO50HgxOYOQH/bgLytRGByHdP9+gkvt+LR/Xw8HsjYUvf3kK6Pq0HdyYyp2
         o07w==
X-Gm-Message-State: AJcUukeIWZk2tlELpie4IXOqeer+8VwhRZuZvtbtXC4Yr/xarxvrISJt
        Dlp9F/4OfrgXRq75W8sAZbi/Nykqcc4=
X-Google-Smtp-Source: ALg8bN5HkoSJieBIJAcETlaCzC1WW9GmeySjsnNRjQOBZxjZdf1aJlrM19G+B+AaqpZ4kW2wdtwzPw==
X-Received: by 2002:a1f:16cb:: with SMTP id 194mr4552555vkw.76.1547160764561;
        Thu, 10 Jan 2019 14:52:44 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id l22sm33618807vsa.25.2019.01.10.14.52.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:52:43 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id x28so8050820vsh.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:52:42 -0800 (PST)
X-Received: by 2002:a67:208:: with SMTP id 8mr5164430vsc.48.1547160762534;
 Thu, 10 Jan 2019 14:52:42 -0800 (PST)
MIME-Version: 1.0
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190110105638.GJ28934@suse.de> <CAPcyv4gkSBW5Te0RZLrkxzufyVq56-7pHu__YfffBiWhoqg7Yw@mail.gmail.com>
In-Reply-To: <CAPcyv4gkSBW5Te0RZLrkxzufyVq56-7pHu__YfffBiWhoqg7Yw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jan 2019 14:52:29 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL1sivv70_Uahbg=cMZP2UM=eYBn4u8nx3NU5ayzHf28g@mail.gmail.com>
Message-ID: <CAGXu5jL1sivv70_Uahbg=cMZP2UM=eYBn4u8nx3NU5ayzHf28g@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:29 PM Dan Williams <dan.j.williams@intel.com> wrote:
> Note that higher order merging is not a current concern since the
> implementation is already randomizing on MAX_ORDER sized pages. Since
> memory side caches are so large there's no worry about a 4MB
> randomization boundary.
>
> However, for the (unproven) security use case where folks want to
> experiment with randomizing on smaller granularity, they should be
> wary of this (/me nudges Kees).

Yup. And I think this is well noted in the Kconfig help already. I
view this as slightly more fine grain randomization than we get from
just effectively the base address randomization that
CONFIG_RANDOMIZE_MEMORY performs.

I remain a fan of this series. :)

-- 
Kees Cook
