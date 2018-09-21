Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3537C21557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5o15cXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3537C21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbeIUXlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:41:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46362 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390820AbeIUXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:41:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id h23-v6so5136617vsk.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP7++yJL5J5YpVwbAXbhuGpJ10eOgWNvRuLTZ3I+3to=;
        b=j5o15cXr7qZdiD0n9M7qZ5NEYavtENX7oNO8MnGtYU/OimVDAp4f4iVSzWAXcl5Ooj
         SRFgSIrOPXJchkOFmPOAc5vLeJnmD58pLSav/3raYCWbhl/8hH7GsD/SoLFYuqAAFWJN
         0YbN2mtqjaYMzm3e1c2BAxH1DNG++1Fciq43g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP7++yJL5J5YpVwbAXbhuGpJ10eOgWNvRuLTZ3I+3to=;
        b=n5AQcaRt2b4uZUeprJGlSdsBBD8zAP48LbPL9IwENHwTd8s8SajTgP2K+/jjnWhPHo
         kjgzGd9B8ACXLu9cCRSNxsr2jxSkf77LMw82k9MetikwI6urq5P+JwSgVEDVDW3HP+L3
         QoSkmwXWTW2ZY5SPIuP26GuP496b7sPqiRPZJJeodBbxQlyNfLW0v9UwW6iTNdclYw6/
         qLzytlMW2+cQa9qNoHucMenQZJ0VTT4yM9wkyyar0VhmjoLbcyVtafoBi4A46vdOODev
         q+IgJJ/uG0cQ/189oGc9mLaLOGCNT9zpHg8GweZ7YvDRFyRfow8DrTm9GvQ+piYv4ygX
         ZsoA==
X-Gm-Message-State: APzg51CWgpsGG4wHZypg4rOl82FSMcQvem2gaHtqXk41nRZUHotuOA1Z
        OAjGJApKB0zl02jk/x2ZCOwHzRTZtMB0TvAG00kSJg==
X-Google-Smtp-Source: ANB0VdZZl+9yQBX0SN9wxmLmP2U03Vd6Aq/yU5XMKIDFnE6vM6arom3FuNfXmIL/59wVTxq8RnAvwWZ8ocvKvFCZE6U=
X-Received: by 2002:a67:7cc9:: with SMTP id x192-v6mr14164651vsc.9.1537552266891;
 Fri, 21 Sep 2018 10:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536744310.git.amit.kucheria@linaro.org> <20180920190243.GF19253@hector.localdomain>
In-Reply-To: <20180920190243.GF19253@hector.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 21 Sep 2018 10:48:45 -0700
Message-ID: <CAHLCerN0fjPS+3Ydak4tcxqVFzn4sSokYhiG_=2Vi6q_qmEprg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Another round of tsens cleanups
To:     Andy Gross <andy.gross@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:02 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Wed, Sep 12, 2018 at 03:22:45PM +0530, Amit Kucheria wrote:
> > This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.
> >
> > Patches [1-6] can directly be applied by Eduardo.
> > Patches [9-16] can directly be applied by Andy.
>
> Eduardo,
>
> I ACKed the DTS patches for this.  Can you take 9-16 along with the 1-6 through
> your tree?
>

Thanks Andy.

Eduardo, I've send a fixup patch 07/16. If you like, I can resend the
entire series
or you can find the entire series hosted with all tags applied here:
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4

Regards,
Amit
