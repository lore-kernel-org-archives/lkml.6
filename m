Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B469FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816A82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XF77MV1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfA1SnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:43:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38968 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfA1SnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:43:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so12645311lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBn18MogPQugOMESahPc03MNSoYd3OBnYM/KuVvsEuA=;
        b=XF77MV1qcxMFv4YSzyvS4nHQLV1tqLKIOuPHne0F/qZVN/eKyw8C7/1SIlJAkOeSkm
         B2hFhBYD7rAoWwLhflfirZOtXIBtrh+5FcF/cNCgQiRxq+IqjlgLR4pAYldlDhYsrKIL
         O2KHJw224sTWaaixrGo8NC2iELGcJF3AIrtO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBn18MogPQugOMESahPc03MNSoYd3OBnYM/KuVvsEuA=;
        b=FfF0JptnDeicLUP3gnlH/FKJ5ay3QEtcbEgqNyalTJpGh8JITmS1+GeEQQOGZUFYhP
         QZlG4WZK1q8wxuax5l6X2YVbtz8JgOvesH7yyXP4WidBl2wL0GEQuIY3kMnIA4UpkpuK
         cJ4lWmGKBu8MSeY/fo8fgdHbDSSzOj0G/Up3oNmY19Mlr1PSHIEeTQO/EmCk7eGx+aEC
         U1RaCRfPCeLbEAoTVgOlbD+YEq839cIMbGam7b9txVVRzLirZOrRoTFLDFXW9ANlLZYu
         b+HayLu4Pv5234QuahSNubyqAzaHsg4OGjbzTEMlqzHB2aS+JGzfG7egMi4bmMkLfEB3
         54qA==
X-Gm-Message-State: AJcUukeBNVX2VGXyKmU26LV0+ya8kinwXCpqCV+IlqBZEQem5/nAfD0l
        W/AqQxGpzDvZWixmT7sEHubJoiFKSs4=
X-Google-Smtp-Source: ALg8bN6OFwknTO9T8kHVHCqAP7UT1m4J8RuZ5BICPaxKI+WpsbGvkFN+4+ouXGptb0cq0R+WP+P8SQ==
X-Received: by 2002:a19:c995:: with SMTP id z143mr17053471lff.79.1548700984206;
        Mon, 28 Jan 2019 10:43:04 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u65sm3214606lff.54.2019.01.28.10.43.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:43:03 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id i26so12697919lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:43:03 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr17226328lfg.101.1548700983150;
 Mon, 28 Jan 2019 10:43:03 -0800 (PST)
MIME-Version: 1.0
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com> <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 28 Jan 2019 10:42:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
Message-ID: <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 11:08 PM Avri Altman <avri.altman@wdc.com> wrote:
>
> Add this functionality, placing the descriptor being read in the actual
> data buffer in the bio.
>
> That is, for both read and write descriptors query upiu, we are using
> the job's request_payload.  This in turn, is mapped back in user land to
> the applicable sg_io_v4 xferp: dout_xferp for write descriptor,
> and din_xferp for read descriptor.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
