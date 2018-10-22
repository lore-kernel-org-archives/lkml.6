Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F36ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7942083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmlGKqqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7942083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJVImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 04:42:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34217 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeJVImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 04:42:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id p6-v6so24352343qkg.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vCJq7Y4sKG95JO9WfUG6NiU255CATvz3t+LKF6MWew=;
        b=ZmlGKqqLw/ivthcDakL+f2DMmODEC+zYXCk4nbGgyRVlisHLiPTyYbTiN0p9SGLfUk
         ipfMy6q1xoCU/+qvHTE6O2MfV6VvldKjIGQmElJZxB/ybK9gRpMPamtRf6YOuPNxgx7c
         71tw0xY2JFnxBjbkWs2r0D/QGDVAAYjd4pER+MzU6nGrqJ9tT8GfChbtHB/Q0Yoz4XOM
         cv8F1ZvVlVY/ZqHfD1tLsik0B5fHFyLJHWImFEQp0vEHT8Q1UxTpynPHz2tr+icJyIyn
         c90eGmBgLl3aPgJf1Ao4aUkJ97RVrQBdpKCqJJ+6DzuLuFTNCwYAIxvvnHW36/MHIdg9
         6t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vCJq7Y4sKG95JO9WfUG6NiU255CATvz3t+LKF6MWew=;
        b=Xuu9oKK2BsupFfa+QUjEvQ+aAI7Bl+U9WmXBLc/G+H5ecFmBiWjZMuiDtgDUWafOrU
         nDCjGFbDmOcNqS0kKrU+u7BpmIQ8mq7lrRZ/ZxKUjso9PSr+705RjIKFgVFWIxupHcMY
         dl4+idp7l2ZqR1yeeM1S0g5cJaXEsa32WPxUeH4JMp8WO3kN1w7SwzHTlBJXQqEsaCG+
         G5eSW0P1wKgIWvBNyyCu9VvcqZBgO4Y8kuF/NqmY4cuG7mGRJ6SPJGaSjm5BIRrrKf7C
         3rlLp6kJkotuGlGBOWcYlFjnJe5MsiPzlVF2i+pehp/Xu09a5UEiQHmcOkshtGc9lYyH
         iJ+Q==
X-Gm-Message-State: ABuFfoj6weX0KnMVbige1zvxOcUOczoiI8FRRUpuNo2Gh/F8f8YxJIrJ
        NGJTzuEF7mUrCRg+ET3WfO9ZEwngS0Cm/PHlkB8=
X-Google-Smtp-Source: ACcGV61V94CIQpUVOrBkEdbYpJu0h19WLmqRSCVy2ezIewflTMTUgXFSVZOntsWXe24QKayI/QDlqjZfGOfpzpEY064=
X-Received: by 2002:a37:3094:: with SMTP id w142-v6mr21264759qkw.131.1540167980365;
 Sun, 21 Oct 2018 17:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
In-Reply-To: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 22 Oct 2018 10:26:07 +1000
Message-ID: <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com>
Subject: Re:
To:     mtirado418@gmail.com
Cc:     Dave Airlie <Airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        zhoucm1 <David1.zhou@amd.com>, Hongbo.He@amd.com,
        Sean Paul <seanpaul@chromium.org>,
        Gustavo Padovan <Gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 at 07:22, Michael Tirado <mtirado418@gmail.com> wrote:
>
> Mapping a drm "dumb" buffer fails on 32-bit system (i686) from what
> appears to be a truncated memory address that has been copied
> throughout several files. The bug manifests as an -EINVAL when calling
> mmap with the offset gathered from DRM_IOCTL_MODE_MAP_DUMB <--
> DRM_IOCTL_MODE_ADDFB <-- DRM_IOCTL_MODE_CREATE_DUMB.  I can provide
> test code if needed.
>
> The following patch will apply to 4.18 though I've only been able to
> test through qemu bochs driver and nouveau. Intel driver worked
> without any issues.  I'm not sure if everyone is going to want to
> share a constant, and the whitespace is screwed up from gmail's awful
> javascript client, so let me know if I should resend this with any
> specific changes.  I have also attached the file with preserved
> whitespace.
>

This shouldn't be necessary, did someone misbackport the mmap changes without:

drm: set FMODE_UNSIGNED_OFFSET for drm files

Dave.
