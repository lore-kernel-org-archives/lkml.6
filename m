Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2DB208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3cfCv3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2DB208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH0WXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:23:16 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39289 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:23:15 -0400
Received: by mail-oi0-f47.google.com with SMTP id c190-v6so29083838oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AA7r9g5a+FMNzntEACFIQqHti3WXKNVxlbAwNujEYKE=;
        b=l3cfCv3vNRBIEURJmqa+l7xiDX22btwJidUzUu7MITO5V0ppPBbwh9AhhDLT2pG9sI
         C3rgZdQEwRTuky97GB9KtEBOFnGJUsmDWNz4oSjgmd2QqjeM3d31HQ0siCHn/gYpYGoK
         JeJ1L2waouYTbBwunzDcOmD1fCFxHyOXd+TcVVvDJzCT1pnUcy0BvLK25YitGDXu0k15
         9TiskJbsgptmAUgR0xb/QUdkSWurn2DcdIRNtubc/RgqTZHQ1Yn2DnrUwZRdo6lPXOUo
         9FkzEDs4W5HEP5ZbBQYjXpzRkZU95gF6PBSkU/LRC4+YFQMWrZnXW+cRSAVjrj0MJRa2
         IaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA7r9g5a+FMNzntEACFIQqHti3WXKNVxlbAwNujEYKE=;
        b=TZvHazqItCKou+qwB+EjI+PJdtLg0uT/BhrzvdHdJx7z3E2+g2/BADUHmIiB3f3B6f
         xmy1yG3AQ6fai7m1Xf3tK4+w6fK0AkfNZoFYG3Vlzlr4AtxpGXE7X1hKnYH3qgJ4xix6
         bA36xHd1IbES7bKAp1+1QS6gK2VE0oSnKsoUOLJa/xihuQ01/t2qPZ37y/og0ZVZNUuo
         ByKF0gLCzBa/DsP7j94H9rMqijl90HKYHqMIcJ1z/PEdtIm6bLmkdC1rGlfE4q08Xbxh
         eL8ZW8N5MmwYI23+hhupQNJcg66ei+2Z0FegHc8bYnG9Yy4o1yZtxcDXNNspbDC3Yide
         ultg==
X-Gm-Message-State: APzg51Crk8TatYaRMbRk+UAd45D3qf1AxfcO67vkgRtIXVZODYPgVlwk
        II/cbCTIlBF/4K5kc/YpqFRhunJRuA7yzy3evjdYzA==
X-Google-Smtp-Source: ANB0VdZGGM1bd2FOrqlXGYomCuAPv7yhvf/9s+dZrLUDlIfsIXFrHybZcpRLV5p4smAAl2sodXQhVvSleIIpmdrON6k=
X-Received: by 2002:aca:e80c:: with SMTP id f12-v6mr11918491oih.38.1535394930943;
 Mon, 27 Aug 2018 11:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMnawtqVnT2ux+VQzaPhyqHvYMp_Dm0sbeoWQcpYiRM-9QE2A@mail.gmail.com>
 <20180827183335.GA22829@kroah.com>
In-Reply-To: <20180827183335.GA22829@kroah.com>
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Mon, 27 Aug 2018 14:35:24 -0400
Message-ID: <CAPMnawsfuQxF14j=zHUnfNG4rduWTAVLUhGh48-kXSNhya+U6g@mail.gmail.com>
Subject: Re: Question On staging/drivers/staging/*/TODO
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great, thanks so much for the quick reply!

Ray


On Mon, Aug 27, 2018 at 2:34 PM Greg Kroah-Hartman <greg@kroah.com> wrote:
>
> On Mon, Aug 27, 2018 at 02:26:48PM -0400, Ray Clinton wrote:
> > Hi,
> >
> > I'm brand new to kernel dev and after going through Kernel Newbies
> > am trying to find a good first patch to work.
> >
> > I just wanted to know if the TODO files, mentioned in the subject, are
> > up-to-date. If not, would you have any suggestions on where to find
> > a good first patch to work on?
>
> They should be up to date, if not hey, there's your first task!  :)
>
> good luck,
>
> greg k-h
