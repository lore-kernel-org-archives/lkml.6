Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59580C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031692075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEWi03GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031692075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIEDWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:22:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38496 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeIEDWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:22:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so2313995plq.5;
        Tue, 04 Sep 2018 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYJDgOv2HWSs3MfcGJiK9WDiPLnBj21A6Plh583WEGY=;
        b=HEWi03GUMtc5/BXgAzDlBYlqMwUlrOWYXkuBMdFp18O3VXixPsm7tPC9o+Pi+Yr0zM
         BqUHsW1O5FirtPhH1u4AnKwCMAwT22SfAusyq2nYlpl3niiirJqg89dsMiEu5nmeyzwe
         EykaYzyC5RDbInU+WpI0YjSq1BINzxFKmtoga0quDV5gnnSJJkk6LuBTD+he04vXuFe/
         VyH/Rc+2wKQYgrajZfl68lurw+kkxGpc37v9TiV41yYv5VOH6ZBgCIIK5D0CWnFo91Ny
         tRAojVdv+30T6pFwBs85h0vq3BlJismuavjykHAnn8PjyHSNy+TPrmmPQL02TppehB3X
         FqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYJDgOv2HWSs3MfcGJiK9WDiPLnBj21A6Plh583WEGY=;
        b=aSOwOaSvIU4fyZz38Iljx/fC5Pzufz3bFIyPXhHH/z04VvGFPAhbpW0m7osAiPTK4w
         gwbcgs/y3ej9naMpXcGHrtSShIg4zr6gY+6+A3UeoZo+yvgA7hOpIDsXDG7oEDzpU8+E
         8XaHP3xlmgRAtOWdHEb7KyVOB5QHAaPdmIinstpp1seyryVDYeDtEx5Xp4M22A87yji7
         qHSTZAKK5jitu2l97AR/bN+NSaHpxboMFgWeP1JJLFiAxOcc/4XmEZvLX1jibP/Y0AFA
         /ZFJDKPMLZp7Top6+5G0cHjPL0GWuhdtdu+Usihhqk2Dv8sSRpbhLwSUfUmhz7JqLrka
         w2rg==
X-Gm-Message-State: APzg51DCz40IhZuAolGFZdNyNQkz2DKvl2tbRj68StCKsHtqXqtjmXsb
        B/2fESg7dM4TnvkNdXiV6L7DXG2EdxWcHR8ZEZ3FdtAW
X-Google-Smtp-Source: ANB0Vdactn1Twly+U1b/23urkAO996C4nAsUPeGJezKuLM5rjnlXMY8PEoQu83y9mcEcIRhCpEx+vNhkhyWI8gpEJ48=
X-Received: by 2002:a17:902:7488:: with SMTP id h8-v6mr35500047pll.16.1536101694584;
 Tue, 04 Sep 2018 15:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180904014559.15765-1-gagallo7@gmail.com> <529ce419-bba7-7e90-cb7d-e9a94fe64ac2@xs4all.nl>
In-Reply-To: <529ce419-bba7-7e90-cb7d-e9a94fe64ac2@xs4all.nl>
From:   Guilherme Alcarde Gallo <gagallo7@gmail.com>
Date:   Tue, 4 Sep 2018 19:54:18 -0300
Message-ID: <CAF2jNbj+MJV-U9JbwRmfw6Qwbow1n8JzHzP7ZRaMwfqAcHSO4Q@mail.gmail.com>
Subject: Re: [PATCH v2] media: vimc: implement basic v4l2-ctrls
To:     hverkuil@xs4all.nl
Cc:     Helen Koike <helen.koike@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 3:40 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Guilherme,
Hi Hans.

>
> On 09/04/2018 03:45 AM, Guilherme Gallo wrote:
> > Add brightness, contrast, hue and saturation controls in vimc-sensor
> >
> > Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>
> > Signed-off-by: Guilherme Gallo <gagallo7@gmail.com>
>
> Looks good, but you have (probably unintended) two Signed-off-by lines.
> Just let me know which one I should use and I'll drop the other one.

Yeah, it was unintended. Sorry for that.

Please pick this one:
Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>

Thanks for pointing that.
Guilherme
