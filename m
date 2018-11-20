Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B22C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D11205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="jhNnycJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D11205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeKUGQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:16:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeKUGQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:16:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so3250118wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vVprXwRXv5LDaHl3diFepqVNNJ8b7iqUd3Gf8qAT4W8=;
        b=jhNnycJkhfalgae2wROZkxnBUAtuN0QQVUbhBt0ANAzZB0M9xblOiSAKhxRLplEYjP
         U3o9w5GvaOBmj7zseOsdlyNzYyIHXCZ5/VNQkQtiSxntMHC9Eq4dVYkNLpcflfcK1A01
         LrlPBMZ4a2wIILSlXY9APjGfwBaMz92gmFSRd1pR/RBduS2svSQkSagOqlif9dUllvfw
         zdwHW78DfOIQg2RwLOJEiYEl/c7S1FQ9E7U0Ucw99zYT47A1q289DLCUxliP0lcGXJl2
         k2o44CaruegpFDLBtp9vTqAAzcHsvJcf9xAEz+S8vXNzjYGnUfdfrv9pI6/jMvrJeaik
         rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vVprXwRXv5LDaHl3diFepqVNNJ8b7iqUd3Gf8qAT4W8=;
        b=Zf7SYFEgRvpIBRdiJfGWnhrTVqTka9rkNPq59BlSdISFqa6DBP/ZNnQyKmt1UAQMOP
         cy14mLZAd1NXbyzzwDzWdci7sf2EvLbaOTfYgEoi+0aRy4nkHapekHX2JIR0qImUkFDC
         mf7SoUo3bmtmUEVyZcsVWmysaOGem2TOSJj9/5Ut0DRF9nG7WujfkJyQKDnELsZKJyEW
         yTHlEIuPj+Fgi3ZMjFeUOixNZwgR8L9Zf0wMvtpkGFPjzBVF5o0Od5K8BH/gK80IRjU+
         l3KuDRWbwZAQDTBUzKMilx4bht/v1qXIl/MywOispwI4qZXbtqTo6c6EJRvWBnLxb3zb
         1R6A==
X-Gm-Message-State: AA+aEWYNZdLFfZ7i+m6NvJWvgaC3mokd8KdPitXp+FTXNFG6o/Faiy72
        Cl9oOXm0u+UX0TXfKtY8aCp75w==
X-Google-Smtp-Source: AFSGD/XyV6laC+AnagfYPDqsgTH2o2XAWERtiMf0vJ0YsEBfgLj9lSsPsair/b0Suf4D4/Z9DDWZVQ==
X-Received: by 2002:adf:9421:: with SMTP id 30mr3436183wrq.54.1542743120324;
        Tue, 20 Nov 2018 11:45:20 -0800 (PST)
Received: from linux.fritz.box (p200300D993C74C00FC5A0EA9BDDF9934.dip0.t-ipconnect.de. [2003:d9:93c7:4c00:fc5a:ea9:bddf:9934])
        by smtp.googlemail.com with ESMTPSA id j124-v6sm1520352wmb.1.2018.11.20.11.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:45:19 -0800 (PST)
Subject: Re: [PATCH v11 1/3] ipc: Allow boot time extension of IPCMNI from 32k
 to 16M
To:     Waiman Long <longman@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
 <1541794292-19425-2-git-send-email-longman@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <f9e476ce-9381-3738-159d-2c555580961a@colorfullife.com>
Date:   Tue, 20 Nov 2018 20:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541794292-19425-2-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 9:11 PM, Waiman Long wrote:
> The maximum number of unique System V IPC identifiers was limited to
> 32k.  That limit should be big enough for most use cases.
>
> However, there are some users out there requesting for more, especially
> those that are migrating from Solaris which uses 24 bits for unique
> identifiers. To satisfy the need of those users, a new boot time kernel
> option "ipcmni_extend" is added to extend the IPCMNI value to 16M. This
> is a 512X increase which should be big enough for users out there that
> need a large number of unique IPC identifier.
>
> The use of this new option will change the pattern of the IPC identifiers
> returned by functions like shmget(2). An application that depends on
> such pattern may not work properly.  So it should only be used if the
> users really need more than 32k of unique IPC numbers.
>
> This new option does have the side effect of reducing the maximum number
> of unique sequence numbers from 64k down to 128. So it is a trade-off.
>
> The computation of a new IPC id is not done in the performance critical
> path.  So a little bit of additional overhead shouldn't have any real
> performance impact.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
