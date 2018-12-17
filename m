Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96816C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603DB206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545039120;
	bh=7f6C0sFV7sUOhNQ4pdKV7YQmnGhn5ZTKlyix7CyafjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g5ezkqW3oMkEhO1BTMo7nru41wp7hqeh8Kae6z9RlYqVxKldBqI1bz1fAlbadaN4W
	 eEEj+exXsWo1cbhE1Lm0QDiBMcYlbpUoLHJ4kfQKr5QIKVMR7Vsq5k4xBg1SRdzs5x
	 KPOKRoDx0k/hFm1l4G/IGr8I9jgaXP8bPHl2lN68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbeLQJb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:31:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37540 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbeLQJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:31:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so11533683oth.4;
        Mon, 17 Dec 2018 01:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw9K5vgg5Ftd32kKuQpBdpuBlR26+uozWA0kzMGhis4=;
        b=X6/uAm7oew3mgOAPC0mE8uWVilUG77ri/zxDEcpdLRPzovUNk8e9tYb6YVyib0C25j
         nQ3LeJlu0E956YQOeMNovfoD3GfOlBZ6ah7G2OZEchIInoDQRcCL60BXqrtSpxwmi2on
         FO/It2o08Mt02f9v1sP6L4MtGutdpF2Cx+aZXQV4oL9MReZ4Q1H2NPBtpuYLaxHitv55
         OMEKzzvV9QjSuf4eggtVqeBXCN7gALwnm+Vrslff6l1Z7SiAvcLQc2VelVPUP7eHZxOE
         NBDEt5Rn67S08lO7sfD+zfG133udPP6WVh3IpDsOpV9HjbFXVPHWNQ/cdZag1GPP68VN
         GD7w==
X-Gm-Message-State: AA+aEWZ9vQwrrFlY51j7BLKckd1lz24ZbdRDw9obXMLEwOaSUY8kI91+
        /BMrWNXYK6GvcrnlqC80AQJQF1btcOYbGZYvYcI=
X-Google-Smtp-Source: AFSGD/WBSPh0zUx2bFGghJivItDcd+BV0QN5hJCZW9ZH5vsf49VcvCehQhPuh1P7RAM29DwsD1j01cIpqPZmKLIHXSc=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr8493396otq.119.1545039117971;
 Mon, 17 Dec 2018 01:31:57 -0800 (PST)
MIME-Version: 1.0
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com> <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
In-Reply-To: <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Dec 2018 10:31:44 +0100
Message-ID: <CAJZ5v0jWROTTSRT1FFQWXpWn2M=uMRw5SKbwu0doKaeMjSOEnA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
To:     shunyong.yang@hxt-semitech.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yu.zheng@hxt-semitech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:18 AM Yang, Shunyong
<shunyong.yang@hxt-semitech.com> wrote:
>
> Hi, Rafael,
>   I think "override" is more accurate. I just follow the existing
> description of "ACPI_TABLE_UPGRADE" in drivers/acpi/Kconfig.
>   Should I change all upgrade/UPGRADE to "override/OVERRIDE" in this patch?

I think that this would be better.

Also, there is some documentation regarding this feature in the kernel
tree.  Should it be updated by your patch?
