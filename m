Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA893C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E35F20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDgbDAfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E35F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLFW4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:56:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46480 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFW4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:56:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so882061pfe.13;
        Thu, 06 Dec 2018 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPPFxnkhul+WXmB0ai4sAKLoMT/TZYvfs1nrdfg58HE=;
        b=cDgbDAfCjhDtZ+GxQaIr09IJywcBp0MEo0tG6utd61H+BNv66/97lhWAq9qArJ2Nab
         vLBCrpP0fMXBclaU3yIdc9MtDl6rrrPXjbPPiPBHt+qdkHWLYKMyUdI3CC40xQL0jI/Z
         y2rZMYYM4YhFJU3EfUVy+2w5V2KSmz+ZlC9+/oFdeult4lHtEa/oZPMEirCET0OUoZCm
         Dum+mJZqfgHQSrnqstToZVUEQk8n9gCmRk5XSXKrmfvWkNyMpDDF3cE3nakOewgPunEL
         3TodOp8IVJ9cbaXNweKs9HsRPZ+865Ul197Jl27+bMtNgOEYorpgrhJCeG2eIuGCzP6q
         W3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPPFxnkhul+WXmB0ai4sAKLoMT/TZYvfs1nrdfg58HE=;
        b=sbcD4mnUojCz2nj5xQVEGtTxlySWYX2TYu7/RJ2emvlmZIxF46B1iFHpzu0UurQ+mb
         D5yFqiJa0YYib9phh8SK0l9paGahIdYjHqXtDtDySCuP1g+nkw77jTJaOhek7nporhco
         H1tdAjLooBEvkxEW9Zedahtw9Zv9ZvG1BhVaT1CdQrmOFZXHIP24dpmD9VvZ4S6vzuK4
         ogj/AddvMOxsNWod3yWEL8PH3JVF1CtltKt+kizDPQPAfRp60kb5w9YrnUaz4AhrGDI5
         qi9qcCEg9oPNaQ5Zty+EcrfAUIGnhS4+OZ3f7cf9KQMjdCOE8WtzzglqlY5W9TgUR4tp
         KfXg==
X-Gm-Message-State: AA+aEWbluObQRqBaDf28LMTkeLpISu5NTqzwBi/lO6sDPgj03xI41TOl
        RbbJRmC9rkIrJ18igJrH3gA=
X-Google-Smtp-Source: AFSGD/W6yrie/j7NnS8q5O1IEBtNAdl/88ZbRk/dV72Slloju1JyPHxxKslbCXeJovGkLReC0GgYCg==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr26144849pgh.197.1544136982600;
        Thu, 06 Dec 2018 14:56:22 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g15sm6006539pfj.131.2018.12.06.14.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:56:21 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:56:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
Message-ID: <20181206225619.GA34001@dtor-ws>
References: <20181205230336.GA23462@jelly>
 <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
 <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
 <20181206224605.GA27899@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206224605.GA27899@jelly>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:46:05AM +1000, Peter Hutterer wrote:
> On Thu, Dec 06, 2018 at 10:24:11AM +0100, Benjamin Tissoires wrote:
> > On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
> > <martin.kepplinger@ginzinger.com> wrote:
> > >
> > > On 06.12.18 00:03, Peter Hutterer wrote:
> > > > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > > > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> > > >
> > > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > >
> > > Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > 
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > Dmitry, I do not think this one will conflict with the high res wheel
> > patches, so I think it should be safe to take it through your tree.
> > If you think it'll be an issue, I can also take it through the HID one.
> 
> fwiw, patch was made on top of v4.20-rc5, so it shouldn't conflict.

My tree is behind that ;) so I would actually prefer if Benjamin/Jiri
would take it through their tree with my:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
