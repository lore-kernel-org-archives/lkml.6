Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611D3C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E15B20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqn12IQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E15B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeLJUKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:10:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45317 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeLJUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:10:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so10799235ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIAK7EmLipzqGOIIw5gMsgC/ppeDPiWEbsqCY1yDQ4A=;
        b=iqn12IQUSBSGbL0+kLO5MuFLwUz+D+OYUgA6syXXJDsWNDqBE3fYoIr6BjD6Lr2hQx
         jioYrYyIT6W4CMuSqqniCgHnb68tMK7/pWXmeOYD+pCWygI+ECtUnmICw4Hg4vQvTKKZ
         POvNHkisATlh+AvmfgiQc9QT21W42XOc2ZEDbgK6f8oEHmvrindjo3fkLlYmDFmwxURB
         71gQl8Q32jcu6VOMUfyNHcyTj9yet1J3uu1+qCbHLInFCgB0Jv4IVz9Cof2fysAR4PX5
         25qh+pyxjTFlrAXSC7K+xH9t8E5jUaeMLAYdaE4a0oWGDYIyVfuMsnRBMNkNMwP5kvQe
         NMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIAK7EmLipzqGOIIw5gMsgC/ppeDPiWEbsqCY1yDQ4A=;
        b=Y/hK/FaRhiW8cQKtAnBH9uwoWSG2gToiQXfI3ayOs86o2Iu/rSkxVtOEVfaqRhSfzg
         MmHRZE6uKZmhmOoMY57eS4KpGMQzujzKA1SttQ4Ro25IaE27TYtxkm1yMb9uu97C80+5
         qpBIiCdpknehhl8qui0mH8dce+TK0F+e8yZD0MZvLAkBKUkadfmnkb+PP1mqtRPq8vwu
         iVpgZOJdf8crxV3169JajOgHqXP/+7tyK5MRDJf3Kxhu4m49jvjmOZnskGq6fbUrLn6P
         Ci3yhQviShOWv7DGsWslM9PB2mknhtEde6VcylTVKdUPr26Qv1yETKCKgBiZFl/352gW
         1fOg==
X-Gm-Message-State: AA+aEWbwWqP3sjbNSBxhqL8Q96VR5MEx2m2t5dq8OdibZ763NUfD1dGM
        OCjXjJnurcUt0EIsUiDiq/s8aTpo
X-Google-Smtp-Source: AFSGD/Xrx1U1MUTiLLC2ywyHNgydy97TuZBw3aS5micWvZvXDDwSbhKs6taMTIvoSNCm41Qq6+acJQ==
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr7788527ljc.94.1544472637266;
        Mon, 10 Dec 2018 12:10:37 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id r29-v6sm2238310ljd.44.2018.12.10.12.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 12:10:36 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 405AE460AA3; Mon, 10 Dec 2018 23:10:36 +0300 (MSK)
Date:   Mon, 10 Dec 2018 23:10:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gorcunov@virtuozzo.com
Subject: Re: [PATCH] ksm: React on changing "sleep_millisecs" parameter faster
Message-ID: <20181210201036.GC2342@uranus.lan>
References: <154445792450.3178.16241744401215933502.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154445792450.3178.16241744401215933502.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:06:18PM +0300, Kirill Tkhai wrote:
> ksm thread unconditionally sleeps in ksm_scan_thread()
> after each iteration:
> 
> 	schedule_timeout_interruptible(
> 		msecs_to_jiffies(ksm_thread_sleep_millisecs))
> 
> The timeout is configured in /sys/kernel/mm/ksm/sleep_millisecs.
> 
> In case of user writes a big value by a mistake, and the thread
> enters into schedule_timeout_interruptible(), it's not possible
> to cancel the sleep by writing a new smaler value; the thread
> is just sleeping till timeout expires.
> 
> The patch fixes the problem by waking the thread each time
> after the value is updated.
> 
> This also may be useful for debug purposes; and also for userspace
> daemons, which change sleep_millisecs value in dependence of
> system load.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Kirill, can we rather reuse @ksm_thread variable from ksm_init
(by moving it to static file level variable). Also wakening up
unconditionally on write looks somehow suspicious to me
though I don't have a precise argument against.
