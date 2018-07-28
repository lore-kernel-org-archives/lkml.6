Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F324DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34382088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34382088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeG1Epq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:45:46 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35862 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeG1Epq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:45:46 -0400
Received: by mail-qt0-f179.google.com with SMTP id t5-v6so7099856qtn.3;
        Fri, 27 Jul 2018 20:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8e8neHf7h6PTKM56fJp0Ous+nDSq0s5iAddde67sC2o=;
        b=BmUnLqXA4WVPAr9epDKxsGiSdO/ZSG//nByo53XpmkyLPslPHUFdLcgxiCxjnHFK/l
         1MGzwgbfDlZmKqcexxWsGuX4/I7NcCDNH1lkSOwA3kzfmeK4ezKZhHAUW1IFsM58M1I7
         3HQTiqu4VdKsw/ZfbUA0Ihfdzp8auzW/HfOnTJojf9NLY95aHRuf2q/xXJPDYQum30NM
         CTy4PhJWaEnJkL1JXwfJxAWXFdixCZCKt/JZcsdlmZT5AZfJwY2VlxPyjVsgJr8/324H
         ST4VCgat9UWe+I75jH5ysokDulUyUDMb67aByJrpeYNfKDFl4WGJENuqde8EaRQmEHPb
         uypA==
X-Gm-Message-State: AOUpUlHyvC1bMyCy18yX/CEe3TPuSVb4nb+Pv2aej6/09yXCEy4TVTIl
        Ylcxr6XqTv4DMaS0qT9WgOB4/bR/1S11Am58wmE=
X-Google-Smtp-Source: AAOMgpfTsBfZhyvbiiCJ35abYQ41QUGQ+xKVsfZI2RLENn7NFaB65S0k1T6zAG/kDgGVezGqJiRcvgGHsHRWuXdXW0g=
X-Received: by 2002:a0c:ae17:: with SMTP id y23-v6mr8050586qvc.157.1532748058282;
 Fri, 27 Jul 2018 20:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
 <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB32@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com> <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
In-Reply-To: <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 27 Jul 2018 23:20:47 -0400
Message-ID: <CAJvTdKnpdJA10LMsKVjKqf5bJSQLrRhbLO1E6LrAEEd9aP64xg@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     erik.schmauss@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux acpi <linux-acpi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   ACPI Warning: \_SB.IETM._ART: Return Package type mismatch ..

_ART is the AML method for "Active Cooling Relationship Table".
iIt tells the system how fans are related to temperature sensors.

It is likely that Windows uses DPTF on this platform, and since DPTF
is not using _ART, Linux may be pointing out a vestigial _ART.

Anyway, if your system doesn't handle being hot very well -- this error
message is related to that capability.

cheers,
-Len
