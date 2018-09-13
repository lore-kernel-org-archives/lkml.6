Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8520866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVRvzIbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A8520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIMOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:53:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37233 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeIMOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:53:50 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so6947596itf.2;
        Thu, 13 Sep 2018 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5osfHXQpDJqePztuOB3yRYFBSJoDe3of8C7lZCFRfo=;
        b=nVRvzIbVUnF3kfEjaBH8hK7p/EOry1kakHitm9jeeFe+URvUqnD2eFm+5odNeu3U/C
         BI5SIRIi1zXxaNF1vvxnjZKXFzUIPdlxb4ZBH/T3q48Qo6pF+uixdFgilFuLa9fOxGWE
         o7Yx0MLTKYcXCzh59QrD0QheWDQWS7ZYzAdVVemudlmBZNYhXCpMZWF+QKPgZzca/Acs
         dIbrEEjP5TO0BPz6CZnSIcnj1IrmHUOjx5vJaV4tdytOmgQofeTRhxsPz3WDK4RAOs+b
         wtjFWl+hbfTM9CFmSy2V/5oodUu+s7bY9uGQp156c5CPCb7LlWShkZweoi7y2EA/PCsE
         JGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5osfHXQpDJqePztuOB3yRYFBSJoDe3of8C7lZCFRfo=;
        b=osYIpNn2O+7Q7JSXsdNe5rqAIm5vg5cdBDwMA1TIfXRWUADsUX5z3SriuL8nHl380e
         wKpL0KQ1V4w096wv9TM3SDGG9VKrvGyhKNm4Y2Q14xGjhycCVEuRpqv+B6zKTjOpelW3
         AZb1b6Zae+vPyfXyJkm097TXLY/rgy35hTBbmjKPb8gAYUWUonNFUdf8Bu843GuhQNmO
         fNexBLbqm8yFyW7CcXBB1g3WRXlb/zpujYXwAjqCNcYRdSvxsF5LtPolqi1sTMPIORlG
         5W7pGmx/cPcNWHN0itjqEHxJepidn4lwbiWaSoP/deaFMhmOGIVEaAGnLxIektuxsvJB
         e33g==
X-Gm-Message-State: APzg51BaMkFHFTuqdMlplcCHiLvpm/3wm7HCezkkAWhOoMFXtb0AMEf3
        4U+S/zSgyduRQK8Nlk4mhi5pWorovTiRqa5vseU=
X-Google-Smtp-Source: ANB0VdbCnknfYqbZ9ak2xTody5H75jYFWFjMfhWswH1MjJgjCYMv6fPt9pjWvw7A3M/Va1TuctxL0OU5V02deYf6H8Q=
X-Received: by 2002:a24:400c:: with SMTP id n12-v6mr5458744ita.131.1536831907665;
 Thu, 13 Sep 2018 02:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost> <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com> <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com> <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com> <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no> <20180913091753.GA3443@localhost>
In-Reply-To: <20180913091753.GA3443@localhost>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Thu, 13 Sep 2018 11:44:56 +0200
Message-ID: <CAKfDRXjoX-2TH7wAaAxhZabXjTcHEtnfekY0xVKEirfbtFK0cQ@mail.gmail.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, dcbw@redhat.com,
        Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Thu, Sep 13, 2018 at 11:17 AM Johan Hovold <johan@kernel.org> wrote:
> Kristian would you mind giving it a try?

Yes, thank you very much. I will give the patches a go during the day
today and report back.

> Oh, also note that I dropped the RSVD(5) for the ADB interface in your
> patch since it uses a different subclass anyway. I'll submit both
> patches in a series.

Thanks, I completely forgot about that.

BR,
Kristian
