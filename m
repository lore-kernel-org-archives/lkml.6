Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFECC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4F208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU+gt1r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeJPCfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:35:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42268 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJPCfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:35:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so18478533lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRvcjnh4JTfyOJjTUNxFpr2FULfnmHqOt/18Y6SXcDg=;
        b=UU+gt1r7eKsHgKHocUsAqseEtyNK9R2PoP3kaUauKB4/uRtarx2Z764JFmgai4FY3l
         xhjN9/j3tLMlaLqpoqu4pL8vOl93bUpFnAldtxPS6SUTtUNLugdKHj2uOpcojOyBTixO
         IQT86L5xOSJWvw90OQ6DjJO6AZyVrUkMt6utFfx02LLmEpx7hXz1ws7Ojw7cKcdxiicp
         uL9OWxaeViTlRm5xfGjF8rA7RPJbkmScate1CyIu+1Q/avZRHTqYedTe5OxaTAutheD/
         OSThaDNkTR3EZ6xeyk6xBujHUOn5ve7cIy7jkdydQNitOtcN9ZcjgUu1ItMjx4SxWUiN
         EMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRvcjnh4JTfyOJjTUNxFpr2FULfnmHqOt/18Y6SXcDg=;
        b=jYiAlLKULxE/ThRP5wfs5vHtM7uPqOV+/lk0RCM4WqlptsK7YcbPlVFk2sd5fBBOFr
         y+zUYXESlxQXDNHNiIBWR1HN+yVwJm9Wlg/wVD+KCjwPU6fCwzGgiLi6woUMRZXvcTFv
         rEp6Sdyz2gfFXbxwDpOwuUYApklCpJIPZyvIjVyTCx1+zjOeKaG1iE/8dbhERV4BcH2Y
         pCBvJK/5D6HoaoEyzhMK3cI+EKGf1c5Vw5aK8xb/Lu79Eky4K/eZTudsUwoqQ1e3Fw45
         mTBqYGH795aQ9e80nJ4zm/zXyrk8OqMoahiu9Z2xg55J86q8ybjHqLkB3Jcwx51y0LBD
         9Dqw==
X-Gm-Message-State: ABuFfogxsgyOsUxCDvxw48LsEyWtGfTeih8vzKmVeKkCsNB980COhDpM
        2dHCTvGGjD/hsmnZjBR2FYpFxNIibFKpOrevLxnZ8Kal
X-Google-Smtp-Source: ACcGV61Mm5qR4C4rxf3jtafXgxdoJ66Ufsa+YPenJcyhneadlIQfUbB8HjVQGPYmUGRgs6FHs7WW3vcGahETdElNWo0=
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr12746935ljc.14.1539629320760;
 Mon, 15 Oct 2018 11:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-6-rkir@google.com>
 <20181015183458.GA28454@kroah.com>
In-Reply-To: <20181015183458.GA28454@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 15 Oct 2018 11:48:28 -0700
Message-ID: <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory allocation
 from probe to init
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You should only allocate memory at probe time

probe does not know what memory to allocate. We have several versions
of the driver (with different init) and different versions allocate
different state.

>, not init time as what
> happens if the hardware is not present yet your driver is loaded?

init will have to rollback what it allocated.
