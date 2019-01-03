Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C97CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="USsG6LCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfACJyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:54:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50922 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfACJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:54:51 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so44549922iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=WEqdKr8/L5aOSsQRzzaUeZuizRwrzbajRX/gzpiU8sw=;
        b=USsG6LCu3cihaIo8iF+BHZq+z2MWr23j6aZbcMb5P6OX4b4LzWoAj5bwKKhGCJIEV4
         mt8LYcDbkB3xUmai4udfX+V5iuDlc8jQ+69vcwbwQpvEhg5PTCoCpc96lmTCyT6Vqpyb
         qSB0D4x9L2ggppGTcLYgKR500SgQ+XkKaU5Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=WEqdKr8/L5aOSsQRzzaUeZuizRwrzbajRX/gzpiU8sw=;
        b=Df9lylM9Ng6Z24mh2SH9FI3ICURdpW2wMXDRJupNfZ22nLPbVT85dnEVE+4poILT3y
         Prjk1q3hMyrFBYoh0JKVqy4fOYPO8Vs24IgNlItdT6trZuly8LqkXvaBrfId/d+Um0hM
         QMgegaoWoTRHC+++O8kUSEn6X+y5OisGbVc7fo/wnK5FBYB93owP8f8ibjKl+lxnOtyv
         pTR0YwaBtrTYp8QIdgCkMM7Bi6zYR6oMeGp4DSkUbPUYe2z8R8EQwnRkm+3VlmeK/iPx
         IjpMbDcxjkA5AkwkbCk9jm0vYyfSVwkztXezT2hgJRTRPbL7BTi1KhXa1FU4EIHM44DC
         Z8pA==
X-Gm-Message-State: AA+aEWYY6mUwJZ1Wrqz/Ag5ZCsOx/fTicIKC1oztPvH0xphxiPLDfp8f
        LvcG40AjRL/k3mA8lbw74E/feQe00LmNmjIaEwPq+A==
X-Google-Smtp-Source: ALg8bN5GTL3TYO1fVOBWDOUQqDhFqdkKdauRNmFGkXNPYOW2isjPmCLfmywBztxnwRyVC1aqfbjlZMxGTN32TI6i1oc=
X-Received: by 2002:a24:f8c2:: with SMTP id a185mr24972546ith.145.1546509290252;
 Thu, 03 Jan 2019 01:54:50 -0800 (PST)
From:   Murali Krishna Policharla <murali.policharla@broadcom.com>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <20190101083450.GA17613@lunn.ch> <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
 <20190101232443.GA22737@lunn.ch> <b6ff97415cd415614393e35793972ccc@mail.gmail.com>
 <20190102131657.GE22737@lunn.ch>
In-Reply-To: <20190102131657.GE22737@lunn.ch>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQDi+mxIHKhl/yIiH43SW54sVYgmegFJi9UIATpxsa4CXZKPHQFMCl3oAiIRtJqnPh74gA==
Date:   Thu, 3 Jan 2019 15:24:48 +0530
Message-ID: <50f99989b763da1cd630e0abf3ed940a@mail.gmail.com>
Subject: RE: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, davem@davemloft.net,
        amritha.nambiar@intel.com, ecree@solarflare.com,
        ktkhai@virtuozzo.com, alexander.h.duyck@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew/Heiner
>
>                                        Thanks for the feedback. This
patch
> fixes a case where ndo_change_mtu function is provided but the callback
> function is not storing mtu to netdevice structure.

> Hi Murali

> At the moment, any driver which implements ndo_change_mtu MUST set
> ndev->mtu. It is a nice clean definition, easy for any driver write to
> understand.

Hi Andrew
                       Since drivers implementing ndo_change_mtu callback
function are following this approach. Will go with the existing approach
and modify the ndo_change_mtu callback function that I will be adding to
store mtu to netdevice structure.

Thanks
Murali
