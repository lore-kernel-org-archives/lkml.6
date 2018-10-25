Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F892083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHuidPf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F892083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJZGXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:23:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39128 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeJZGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:23:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so4638324pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDSXPYbgO5LmngLCgtD5Rji67KsLIdRzuYkjxNqJZ2g=;
        b=fHuidPf3oSkpaR1R0B4yUr0NMLtZmY5ZuiiLBnIIekFxT9OmNzInR5VRdLr3bS2shV
         H475rLOYNSY9IqDVkMST7UDTZm+bMFrVVO18yAZkcSDZHu2BUbQOryRr92RXZMsxmD9d
         JBCQ9om7KrLWyLga6cPHKqkg8eEg1JBe3QmgVJkKzfjn4+BmQI9bNtxoGx4l+7gVs5aI
         NfGmPefErNbXUJvCTQR+xL/87yrlPOGEgNYguAfYwieWCcBU87cQX9hEFjBGFeKSiSva
         Lp6c5/q5We7RyTG1qFI8+qxdbn6h3hsmcLAIxL8bcdp2oT2pWmpFL0YIgJgiGuuMM3/F
         AOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDSXPYbgO5LmngLCgtD5Rji67KsLIdRzuYkjxNqJZ2g=;
        b=Qhv2Qx9HHKFay3wx+vC5/D9HpdkbFgHq3WdBCYtOdYBV4kVaOZc1edC4cy/l6UxsSH
         q8KtmzNI69y57bgHdJehMi3O1uMvhcoQQeBKDfFdO37rkSSXXPCLGasrzhKZPk1OsySo
         sjHvsbtSZiZPGdCUL8cYjyx7UJBgyuom8M1Ul/bvXozfcxwdgqmOsU2q6eI92mmvEbpU
         w1cB+OpwEOTBRNlqoKKzq8I6LsAcqdrTDbWsn0SPAWhlZ+4V8hVrh1D3GaQWUiWaKt2z
         2ueegakX+yJvgkVG+BjCfrWdV1BHAxTjGHEaf/4+oKpfphfNyhK5dfdnb+rAW16PBYNo
         hDMw==
X-Gm-Message-State: AGRZ1gKgU/tUE8YoEYgiVfGDjXxwQ2Ucxxj58Dg2J636WkejmpATQkfg
        sZbCFWjI5uCZsBacnXMnku4eu+D6mC1dfJgBH9PX4IF4
X-Google-Smtp-Source: AJdET5frzyQ5hXPNpvX0hAiIMSLFfOZIXxKLBcNvrVkiQxBWehU4LI7sZ0HZrLi/9P2ORTDBCEA29NFVgZi/U8MzCow=
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr903696pfh.160.1540504163509;
 Thu, 25 Oct 2018 14:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181025201221.Horde.1UXSw9cRIOdmNlpjDXbda3Y@aws-it.at>
In-Reply-To: <20181025201221.Horde.1UXSw9cRIOdmNlpjDXbda3Y@aws-it.at>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 25 Oct 2018 14:49:11 -0700
Message-ID: <CAM_iQpWK7TbN10nC9QyUOacpXeiOkMP2FDiZ-1weAfgfdpqSMw@mail.gmail.com>
Subject: Re: tc qdisc command partially broken with patch-4.14.76-77 up to patch-4.14.77-78
To:     astx@aws-it.at
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 1:14 PM astx <astx@aws-it.at> wrote:
>
> tc qdisc command is partially broken after applying patch-4.14.76-77.
> Applying patch-4.14.77-78 didn't fix it.
>
> Test command:
>    tc qdisc add dev eth0 root handle 1: hfsc default fffd
> Kernel answer:
>    RTNETLINK answers: Numerical result out of range
>
> I have identified the problematic sub-patch out of patch-4.14.76-77 to
> be the problem:
>
>     diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>     index 22bc6fc48311..cd69aa067543 100644
>
> Without this small patch the above "tc qdisc" command works like a charm.

Should be fixed by the following commit:

commit e72bde6b66299602087c8c2350d36a525e75d06e
Author: David Ahern <dsahern@gmail.com>
Date:   Wed Oct 24 08:32:49 2018 -0700

    net: sched: Remove TCA_OPTIONS from policy


Thanks.
