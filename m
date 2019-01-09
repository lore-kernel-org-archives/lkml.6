Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142321738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547027929;
	bh=tSq7nIFqmdLZc7mxDYHoO7LNDmn2Wa07R7qc+Oz33aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MkBdVLKa5n/XDtMg9biWWIYbJxZPqsHkEpjctRqFar1xhO6wsPl8N4o95dzxY4ez2
	 UwVDYg+B7eLw+Lq+Q7Ktd8eJ9/bvz2fmStlC4w5L/BMnJhbO6TERtERXgBV1W2lFsp
	 Bmx2BEDhB/X291iXK9Gx3uHD3ekRtwe4isJjyPbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfAIJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:58:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39068 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfAIJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:58:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so5824801oia.6;
        Wed, 09 Jan 2019 01:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSq7nIFqmdLZc7mxDYHoO7LNDmn2Wa07R7qc+Oz33aU=;
        b=pspSY3T4ABeKngwdvazVmsWaVJyQdkIgpkFPSWX1AKpdTdQm1bUlqwTx/c+a+vIiOu
         ClZIucYNWHvX2NnD5bfihTKNQ9hB3IrXLb8EvRuUaUakU2V9mtEJdulkGmkijhQ2cGyd
         VvsoOGdYRRCxKoC2HaQ7JU7UGz8viV8BPg1Ic1DRZaWXlysIr+Upko5KWXUPninIKbwH
         e+BvMeZ6bVeXjYRSkq2AAPhFHkFMcZC6HDQL9AGKKiMyvpBGiFDrjBz7A6wUXKZpUfM9
         MgKeDVft2iBEMWDRyIIFiBuW4Fmf0j0oSVjulMNowK26rSlAQeRM92LguUlr8yfXjdsV
         FBwQ==
X-Gm-Message-State: AJcUukdcxLme3i+ntACb+ErvJ93iGNN466SV5KEv4zws7QankRBkWk/f
        mvnzyeqz0aXziZtN+2WaJykM9tZdaLZushxPxkU=
X-Google-Smtp-Source: ALg8bN7ogtXbgMFrP1+KLEYggHvKwZriB2a04M4Xkyffjnev0hpka2pd+G/P4Mh+fnGDGq8b3BQSnp+dC7j6FjJOOWs=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr3599503oia.95.1547027927422;
 Wed, 09 Jan 2019 01:58:47 -0800 (PST)
MIME-Version: 1.0
References: <1545112965-2692-1-git-send-email-shunyong.yang@hxt-semitech.com> <dc56c63fba6c410b9fd35a4ebe11ce07@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <dc56c63fba6c410b9fd35a4ebe11ce07@HXTBJIDCEMVIW02.hxtcorp.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 10:58:36 +0100
Message-ID: <CAJZ5v0iEVUXZ=jV9JosNM+UwEC4y-i-GzJDJPyCiEXJPY8-h+Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 3:41 AM Yang, Shunyong
<shunyong.yang@hxt-semitech.com> wrote:
>
> Hi, Rafael,
>
> Gentle ping for this patch.

It is in my queue, I'll get to it when the most urgent 5.0-candidate
fixes have been pushed.

Thanks!
