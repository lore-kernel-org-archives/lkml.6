Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D63C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E172171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Ow4ue2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeLOVBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:01:49 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35234 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLOVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:01:48 -0500
Received: by mail-ot1-f41.google.com with SMTP id 81so8788308otj.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 13:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1hfTSngbCEYeGR9eS7dEqlWuAajCHRtCG3FbI3LHTIw=;
        b=Q4Ow4ue2EWwUPu7cneTIomb39/9HhQZ+5PAsyYJQMo9QfnwWIMPLcDf9JHv8FLVtmJ
         dEr+oWLx+usynzMr0/oJjFURdKGUPCh497pCmhYkm6y2QqDTt+C9ViVew+6KIMNP2ru1
         vn+rMtiBdlQaqqQxcgXM1+tvhTP2XO3FrSPWeoc9nas35wNkm3sKNRtEDDVZgv8ZvkHN
         oXlvcDhjtGFcVK82STkKbCpZy3tT6nFDc393WB+9yIIOpKjZLLTcheGPuN8oo3yZL+ow
         7adCwKaxNuPKPsaxbrUJsdlmn7yP7H4+MCF6q60VBcjDGzDpb9FAEBDtoKTWq/epP8s5
         UMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1hfTSngbCEYeGR9eS7dEqlWuAajCHRtCG3FbI3LHTIw=;
        b=sPjvvF4r+1NHqR2cPdimWwdneaFuxQ+rahrTU+LdiXxjnVMSEi7eImK1ma1z71Q4rt
         AxUtWrLLHwpbx+VAfBWEjIAwXRCTCI9AlUn1JKreMBRnYsHRZmzVRpeto6rKocBVkJod
         IUi2ItEcQi6L0QhwHYwjWocOyThLXuDeJjBvgcnHcJZpyBHJeZLMCrt9vuHRSWqAEA4S
         DU3ox2djnsCNwNNH6i/bexg6rs3IhjK/gtEu2CPGQ6JpdJdcCEem57GFLbYzHZnwIE5Q
         E9qLulQVZsDvY6YEa1IimaiKLOEhRDG/vryH9Z3ac4hre9srsB1+2Lx6g8VZNavOFC+V
         BKog==
X-Gm-Message-State: AA+aEWaRxIqrr5PKcngMsjvfGI3ipFekcd6WSd2Rg3MyGsJyCzC0Y8gx
        2bj4+k/O8Cz56G5vAip9wQXreuzvRK+DfrPLUqUwdA==
X-Google-Smtp-Source: AFSGD/XlPFU0gqW50z/9rxIsV4lk+Zn+S28Ook0oYITgn1nNVThYU3plzM5eYF9lOKHqx0muOGFNGaIaqS8kog7zXj0=
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr5261000otd.190.1544907707977;
 Sat, 15 Dec 2018 13:01:47 -0800 (PST)
MIME-Version: 1.0
From:   Raymond Jennings <shentino@gmail.com>
Date:   Sat, 15 Dec 2018 13:01:11 -0800
Message-ID: <CAGDaZ_qi5xVPG74RJo5ims54oqb5rgqA8N2iMVrcF2RjDCn9xA@mail.gmail.com>
Subject: Time zones
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to tell the kernel what time zone the RTC is in?

Right now it appears to assume that it's always in UTC, and this
causes a few headaches during the boot process.

As it is I tried to file a bug to have openrc activate hwclock
earlier, but it was rejected.
