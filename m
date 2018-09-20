Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F5ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CAD21530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjN7iqW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CAD21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeITQQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:16:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55587 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeITQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:16:25 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so12419201itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfLl56SUDzAfouqLb4WtHWDJfYidZQYeb0LPSWde/jA=;
        b=kjN7iqW1YnWmDqKFuK8KWrWJs+0Vgy/WxKNVZ8FMmS/UzYDOqH5hhmHA7b4HsJF6+D
         wMFiIcyxMeQeJoHBuB8gQO1P75CMJcef/8XMkErcyK+aG95W7e2cnnpMynh5T/i3zS17
         mLLA2tk5bmnBpeONhcARb57XCMpuEWYxLE1z6ig+iKc2J9wWz5+BlkR/xvLUyLlYQx6n
         hTi9/s8jHbL4WvCpjCUn6P0DSsdNa162WWug5pUtz5DrZTMgGYStnL+qn2CzxxideFVL
         pXrZaI1qWui2AV70V8ukj/rB8nEsHHsved1deVpF/lSWBw9273tV/yx46T/LqMT1ahWo
         IOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfLl56SUDzAfouqLb4WtHWDJfYidZQYeb0LPSWde/jA=;
        b=riukbF3KYt/p3kkkf5jZ8H2VxFxguY+GFnp4ZQGBoAKzl3UZ96Olj3plfXIoE5gcxL
         GOyszI410ZNQ3a5+TPZkjE9EoTQ+k7V8RpTSmrpID347s9GYbdvKZnbbMnhLqcD/Tc2g
         z6El7s5gPkM4jdrxOhPbgiH1bX7WTqaw5PprgwAoQdN4MW6NNTyopaxit9JEXvhTublc
         tMEZRjuFAc9QQRZ7gplYCWBGbIBRP9oCTQeiHOZRyv3Wrb0TEG1Wtgfo3L6mmlogM2yQ
         EoJ0MLzuRdCOXCdyEqHn77AQcGQPhzqN88cUJQWMx7WCvafbPTaTD60bpRn7HJt/9vKR
         QhXQ==
X-Gm-Message-State: APzg51CKWw+Vr1F73cPuEcNvXNfgfpAc/13OuYHZ7rtHk23Wrh9CdC9o
        F3KbzbYroQzeZmc6ozQ3UgTQ/wMmZmwrcP8o5M0=
X-Google-Smtp-Source: ANB0VdYPMT0sKYX5NzcHs9jQsxF7uUfQ9hPsuoKFjYgbao9Qga0xuhj2Q32RqOwT96yX8Z8MXsgiZ4dCzUSyOgzHYQU=
X-Received: by 2002:a24:355:: with SMTP id e82-v6mr1368493ite.64.1537439616034;
 Thu, 20 Sep 2018 03:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180917144334.18367-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180917144334.18367-1-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 20 Sep 2018 13:33:19 +0300
Message-ID: <CA+CmpXvX2iOhc4eR2mTK1V+5p_w0UbpkVOR+Fv8JkadnD8t1TQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thunderbolt: Miscellaneous cleanups
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:43 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi all,
>
> Here are a couple of changes which have been in my TODO list some time
> already but have not had time to make a proper patch out of them until now.
>
> The only change to the previous version is that I realized it could be
> useful for users to see the actual connected devices (including their name
> which is read from DROM) printed to the system log. Hence the patch 2/4.
>
> Mika Westerberg (4):
>   thunderbolt: Make the driver less verbose
>   thunderbolt: Print connected devices
>   thunderbolt: Convert rest of the driver files to use SPDX identifier
>   thunderbolt: Add Intel as copyright holder
>
>  drivers/thunderbolt/cap.c      |  3 +-
>  drivers/thunderbolt/ctl.c      |  9 +++--
>  drivers/thunderbolt/ctl.h      |  3 +-
>  drivers/thunderbolt/dma_port.c |  5 +--
>  drivers/thunderbolt/dma_port.h |  5 +--
>  drivers/thunderbolt/domain.c   |  7 +---
>  drivers/thunderbolt/eeprom.c   |  5 ++-
>  drivers/thunderbolt/icm.c      |  5 +--
>  drivers/thunderbolt/nhi.c      | 33 ++++++++--------
>  drivers/thunderbolt/nhi.h      |  3 +-
>  drivers/thunderbolt/nhi_regs.h |  1 +
>  drivers/thunderbolt/path.c     | 26 ++++++-------
>  drivers/thunderbolt/property.c |  5 +--
>  drivers/thunderbolt/switch.c   | 71 +++++++++++++++++++---------------
>  drivers/thunderbolt/tb.c       | 10 ++---
>  drivers/thunderbolt/tb.h       |  9 +++--
>  drivers/thunderbolt/tb_msgs.h  |  5 +--
>  drivers/thunderbolt/tb_regs.h  |  3 +-
>  drivers/thunderbolt/xdomain.c  |  5 +--
>  include/linux/thunderbolt.h    |  5 +--
>  20 files changed, 107 insertions(+), 111 deletions(-)
>
> --
> 2.18.0
>

Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
