Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01887C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DBA214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="UiNj+Vu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DBA214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIBMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:12:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44366 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIBMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:12:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id c56-v6so21855337qtd.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sctNKK1k4P7GgEPQ8xIyWrkhaTREQiv+FG+722vNXC0=;
        b=UiNj+Vu37WyvJOuMupNejz6zAqB4SnuibURKTJ+nRiD2El+xQ8e+rfpigNOdAve6oL
         4ZPVM9OV1JcPbF1aj/yyW+jngOCXjMJuC40XGP6O6NvhzHRFiq0SvfWqQTwJTzoKDtgP
         fD1IwtgRFwP27I+nRNpfxCM/bWCwrkTdZjurk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sctNKK1k4P7GgEPQ8xIyWrkhaTREQiv+FG+722vNXC0=;
        b=Hi8yLBjxPrg3/IiHTrBhr0xXw9MlhsOm1rgYjUeQQqPSrBnEzGTZcun898PY2BQ5Ej
         q5Y/uxALVTZZ0ZszH/Vo/eCIqaOIHFHrS+nPK+LPdEiy8rdGyuVYE4FZ7rkuUEQs+tFp
         qZILWff3RdW1YKk912tglDU/5UT0C0kAqHjnr23vIbEXIzmcTKLFcAlR+kQYYZTQrxXE
         wXd8wRRIxpu5fTPOGQWjmvmHla6rMGXtovf9JXYnu49JGVVNDaZDlTDl0TI0+DiZzpoF
         glJvlPDABNM5GaShtll1j+9iwyGGtiZKKBZi2vr0W5EiyjrMDHd/6mQ8IgGfU9eC/+Su
         kzwQ==
X-Gm-Message-State: ABuFfogAOvStGn5vWA3NiBRvvJYrePd72vaubER1YhShMw9WTII5yxBk
        aWaGIy5e2LkBgSrWojF24JMCWQPYTkz+dVl4VuFbQA==
X-Google-Smtp-Source: ACcGV62jaSC/vT2kaCwPEd13S028jbtAbJn8jfwomIHql3HmGaj2pMlDhx0HvZgw03f13ZrGy4ss3l70i2D7XMXAkAY=
X-Received: by 2002:aed:2f01:: with SMTP id l1-v6mr20432172qtd.71.1539021550329;
 Mon, 08 Oct 2018 10:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <1538067327-5785-1-git-send-email-maksym.kokhan@globallogic.com> <CAL_JsqLtwy_odfY+7-Braa1vJFPxF-+P+UcEFNSJaQGFhd9qig@mail.gmail.com>
In-Reply-To: <CAL_JsqLtwy_odfY+7-Braa1vJFPxF-+P+UcEFNSJaQGFhd9qig@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Mon, 8 Oct 2018 20:58:59 +0300
Message-ID: <CAMT6-xiBrtRZYRpRFzqbSOG6=h1=OJpROeKArLBbZ-4H8kJgxA@mail.gmail.com>
Subject: Re: [PATCH 2/8] drivers: of: ifdef out cmdline section
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob

On Fri, Sep 28, 2018 at 12:07 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 11:55 AM Maksym Kokhan
> <maksym.kokhan@globallogic.com> wrote:
> >
> > From: Daniel Walker <danielwa@cisco.com>
> >
> > It looks like there's some seepage of cmdline stuff into
> > the generic device tree code. This conflicts with the
> > generic cmdline implementation so I remove it in the case
> > when that's enabled.
>
> What's preventing removing this or simplifying the DT code to just be
> "give me the cmdline data from DT" and the common code deals with all
> the combinations of config options.

This code (handling built-in cmdline in old, non-generic way) is used by
some other architectures besides those, modified in our patches, so for
now we can't remove it.

Thanks,
Maksym
