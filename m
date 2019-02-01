Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450020863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FClNe0NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfBAELX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:11:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40643 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfBAELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:11:23 -0500
Received: by mail-yw1-f68.google.com with SMTP id g194so2326244ywe.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FtKJqxcqR+APmgWZxYnFePCXapABjOJViKC9j/0nP84=;
        b=FClNe0NZWiv+JoBwKt8itY5ZWl06a3dQZ7Iu9oSzwkGCGh6PjmUPqp6r5/IAldM7TK
         87jMszvmCwJU4hYcuAqJETrFYIalzf7sT4nA/f9mcbqPlLG9vgb17N75xWBEf4+bRQCb
         3NP05vl/gx2TB3HXpE4oCK4zwQvZBZ8imMuyn8wXDVFDLL6znS1yyZ3uvMyJiEK77ySM
         JCi6GKG7sGz6qdH0slEr1pjxKy6u14rc/IlsItsAEVw7cOS0Tw5itP9Z8tRbC/erfdPQ
         SV7WF1vpwW6/In2m6OSCFj3E0iB2XGxHKzXjvMnW6bc+08XgCeACFoNUWstpTAOnQafi
         VnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtKJqxcqR+APmgWZxYnFePCXapABjOJViKC9j/0nP84=;
        b=HyArd0oET5LDaWHTUTDdqNLhFKZw9Kf/7LtviedeDDcqaGH5vYtbAPXdObSpqkCB/b
         U2nVPumq/sGtWVaP5jIaplT5E8IBIZ6LU5ZRwUU4BBJbOPI+lrp81l4Zg7RBiACgINfQ
         3TesykoWAAQDG5d18EmBOjEwDp9xVlzXQFMYO1T/Ot1Sx4ppOAPPlDIHGNMzjA9Xh+eS
         ZOfV5gVBvuYC75yrWGiQ8Tx3gzpoSBbwoehOYHprKEIxFUcxNqXkEGCgt9JKSsWjvDR6
         cVNzInuCjI7x/VHZcft/9v/h/85kJ0ePWBxYGxWBs1zmWaLfkorPjSdAzeu1Nrffn/Jv
         1ZYw==
X-Gm-Message-State: AJcUukedQgjwRN/A31Hgs6XteSy+n/+VYKdeiZR+NXGt4aSGlUGpxQqX
        Dsl2DthL57V7yGuYAb0VSA8=
X-Google-Smtp-Source: ALg8bN5QfLRkMdP0dcjUe+h3Isxld/pQ/s8y1OpsIp6uFNDdHihte9/C4BJmUwaGhVPQssEJjkA/+w==
X-Received: by 2002:a81:27d6:: with SMTP id n205mr36357665ywn.305.1548994282218;
        Thu, 31 Jan 2019 20:11:22 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id u4sm4704746ywu.92.2019.01.31.20.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 20:11:21 -0800 (PST)
Subject: Re: [GIT PULL 3/3] bcm2835-drivers-next-2019-01-29
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <687d6f9f-f64c-3959-5561-5f606d2d90f7@gmail.com>
Date:   Thu, 31 Jan 2019 20:11:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 10:53 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-01-29
> 
> for you to fetch changes up to f494caa480f7089ff9bba16dd865e190cee7e545:
> 
>   soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)
> 
> ----------------------------------------------------------------
> This pull request brings the new BCM2835 PM driver and a workaround to
> avoid network boot failures of the Raspberry Pi 3 B+ BOOTROM.
> 
> ----------------------------------------------------------------

Merged into drivers/next, thanks Stefan!
-- 
Florian
