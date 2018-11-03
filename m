Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C7C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C002082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOXY123r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C002082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKDIRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:17:39 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45022 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:17:39 -0500
Received: by mail-lf1-f45.google.com with SMTP id m18-v6so3636662lfl.11;
        Sat, 03 Nov 2018 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlvtpZ8c5PHQOj0n2k3fMYSoxofMOpQ0yzfegYW+U6A=;
        b=NOXY123rzMwAA18vCRygQ7t7Be9w6KXYmLJrPCPCwf2gjAyi6wJQeRApS+nLiMTpbs
         SCY6v2sGo3CvoFMpOsxOMaJS1kt0DWxUAEFaoQGeLlceZTDRVvVIUMUViMt+PJ9ts9b3
         baa56eftuq1JsDANkocr3acCGr2jZQOLaX2SBneB1mIx3QihJsjYkPhmjm3NLLJOK1vk
         Ab/lMWZQk5G5A0ypm+GRbPymlDTWvYfYlN6oqNWpnN8ESGMzvRdvb6UYb3pX9LGZuYJ7
         wEgf271Ln+pu/8em1BuMwiQzaUs56GMaW1zzWi5oaYMsjTbporGDyvPDye4qQD84n8BB
         xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlvtpZ8c5PHQOj0n2k3fMYSoxofMOpQ0yzfegYW+U6A=;
        b=VbzD51XSlqCsa/QbqyhY+/RRRBmWHMF2Nvjs7hUywX3971l8ZSGIraG4VmitQCKF/s
         jeCae+mjh+T5wUQY74uScguh9RdY75H/UsSka4c75gr0nU4aNPoa/9NKiDnIMfG8/PgZ
         vBvO/eDzFi7g6P55M3J1aAsDxKvqQiJtwwOtgAW+W1DsgH5uKiwyYHLGlgBFeSfnu91H
         MIBSm5FlHvHQea3BKy/ZcW5dvYOZP+u/iLvIxa7ai+aoTOOi/+Xa/DB/I0gndeo03h0/
         igqWsRp/zWBHKUiHV2FbdCPPlPqjbnP4p2LW/+4H7V8wv8qgRMR6jzA4s/k4S2dhOFsv
         tAXQ==
X-Gm-Message-State: AGRZ1gKIgr16aUJ7DjjwCA3fO7qlNwDyAveLpdKCKLR9CzS47dTWitn5
        in7O68mUAsPWJhiySPqQxXCRmWJaIP5uH9oWLhU=
X-Google-Smtp-Source: AJdET5et7s6U2D8afL7G8gRYz5AqkfNxXQeuNHHFM3LwwKUKCYDOfkHtKJipaQUzn48a6AxOzMpLlmrLWUyrOfZUETU=
X-Received: by 2002:a19:aace:: with SMTP id t197mr9443693lfe.7.1541286295023;
 Sat, 03 Nov 2018 16:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181102143018.09feb051@canb.auug.org.au> <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au> <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
 <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org> <CANiq72kBx4+R4SVFZ_iTfk61=oHMLwvhHdmBDe=cBFP5Lp7bSQ@mail.gmail.com>
 <6ecaed34-eb66-24ed-e6c7-e33f9583be5e@infradead.org> <CANiq72mqO36FotJ6pHQpAB18DLEYV+kSL64Sc+A6yoqDu47bAg@mail.gmail.com>
 <36ee26a8-af2a-823a-1aa0-f5531c612ff7@infradead.org>
In-Reply-To: <36ee26a8-af2a-823a-1aa0-f5531c612ff7@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 4 Nov 2018 00:04:43 +0100
Message-ID: <CANiq72=uwG15kUff+b03p2B9KQi2vQpdXiV+9NqPzZ2K8osEQw@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 2 (compiler-gcc.h)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wolfgang Rohdewald <wolfgang@rohdewald.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 12:01 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Thanks for digging into this.  :)

You're welcome! You startled me a bit when I saw
compiler-gcc.h/compiler_types.h there ;)

Cheers,
Miguel
