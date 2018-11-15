Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54E20815
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCthGLAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54E20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbeKPFQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:16:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeKPFQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:16:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so9431655pgu.2;
        Thu, 15 Nov 2018 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=siHVINceXRkNG7QTcAUlbxx1/G4fzLWlMHSnF716idk=;
        b=lCthGLAdqoLm7EhLbIxsJYtqIgwblUNwiSwQ+unIP6h9e6PfNJbtuJSz4VGfAyDl+j
         fAFtSW0BO/6UKTU0FFlfFAoAwEVGt5oADE/F+WiZMklCJZXNWE6jTRJWLNw4z8MeH8DT
         hH+EGSKjreCwFEamoFEDYydFz1fsnwheJt1TDCSYbECxXaWPFS7vnHxR/HVs8i6rlj05
         tGEON4BuSHXIkd12Wswa2d7TDMTU21d/sFJKGi0nYjXN67LieniTz8Cpow9GzLBbipVn
         HCgUTHz3/jRjAc1Wk7A8Pvyp0ZiAI11QvnjdzpoKNAReV9xGL8WczNV7uqb5L+QX62Np
         gtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=siHVINceXRkNG7QTcAUlbxx1/G4fzLWlMHSnF716idk=;
        b=nlStPht0V1TGfHE+uYCswe8t22p00/q/Uc1/a3eG2Pq8OQaiQKRsS5oEVpAyvfwt8I
         f4nkx5F+HrGhjxGWwfW/XtqaM7vMNpiqwcpnBSAM7Q/67aqtyu3o9UOz0C5yCPpcmOVm
         QycP23lZ4xu5EVioBOECYEdOtTux/Wvle2cRLIFxXmWyUinnsF2MMPILlBz2fWaYIlxc
         V72DCVROGZDA2NU/5IOKFntJRplzM2EX0BGk4OExQfnN5n45CQhgQUYIomKX1KvkcP3g
         8JXzFB8CkTN+kmrxWHLknWoc5bh+j+xE3LIjf+3LrLLtJwmjM7m9rJl/lm6uq/BAxTig
         m+nw==
X-Gm-Message-State: AGRZ1gKFF3EFRWa0OM5y2tcG+XxFiI97CjNNiDs8g3Yrs1T+baCXn1Qt
        uKagsI3jr8jAhnFrqj1OT5I=
X-Google-Smtp-Source: AJdET5cFw3FJTAS7OfGR1nlAbR4+HIOQQxMRj3N9ULTnTQ/dfoM950MZ0LjKkgc/s4BCXDfdpwxKyw==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr3343034pfn.220.1542308868142;
        Thu, 15 Nov 2018 11:07:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r81-v6sm59281485pfa.110.2018.11.15.11.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:07:47 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:07:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] hyper-v: Fix wakeup from suspend-to-idle
Message-ID: <20181115190744.GA212221@dtor-ws>
References: <20181115180933.396-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115180933.396-1-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 07:09:33PM +0100, Vitaly Kuznetsov wrote:
> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
> 
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - It seems the patch slipped through the cracks, resending.

OK, so since nobody else took it I'll push it through my tree.

Thanks.

-- 
Dmitry
