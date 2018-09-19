Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1088ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2012150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7+oUl2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2012150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeISRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:48:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46420 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeISRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:48:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so4820497oie.13;
        Wed, 19 Sep 2018 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JDRXpzUiQ60eJ9kUT2tFKKpoI402+Ps8O1F9PhMjUgw=;
        b=i7+oUl2Q1J1BvaaHw6y0+C9WmTXPP/qGw+1FqHmDIq6NVzZJsuo548peOkOQ+uTqX0
         +uZ6vdOCX2AfaOUqIERCZQzCqKjmSIvyEOHONQb7T2/WKEFFJw59C7NJgcdx6CDSkKlR
         oOKN8+fAPef7gmSEGKHEuJsyiyYNMMfymCE16SOs3IRO8UFjOL/DArh5TOW0n4UbEmDn
         ufJqjcBtJD7bMF2qgfyb2Oj6L8Nruc5h1W7+MnTL6Yu1Z4gOefVaMM/mILlUld+x9Thn
         /asTj/23wRjxIGTgHxD8g0n8c5rX7fWfEbZh/nTlOfCq1Yd5TGIUZLXyB57b6SH0+r4A
         RDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JDRXpzUiQ60eJ9kUT2tFKKpoI402+Ps8O1F9PhMjUgw=;
        b=SK9UpHGm4tfbib8hrtfLR/pTr8Rbo0WNaNr18wSfD5JnJidE7O1KDlEGiA6rPxnEyu
         zFYl/UnYQcHKm+cmGcSI5SZCfrFP7uYVnb1RsMeBOohyq5Gmu/bE4MP4w6p3ss8b1cNb
         pHvpMNR1Cfb38VJWMeskfLKdRZsA5qB8LgxUoAxCkIA6MimY+mdAPVfM+UMMXKbh+feK
         JhHegtbEO0/M2FuTfg/VWsO4PbaRVzf6KgzcQNj8ZcWMY23J9uP5sd4ZgSxBcKQ+IT+x
         F7OVntv4xMNeJnchNQM92+Q5lYcjlfHBMkNJSV/+T8NVM28+/3faOAtEmRfjLxxxdQFu
         qh8Q==
X-Gm-Message-State: APzg51BXQQfcIgA+LOzxbSpxPuokTnQ28nJmyfleJeuALnfas0aGJQhh
        DQ4FbHVfKdHOEvE2r56xhu+q76w9vKtSF1to4J0=
X-Google-Smtp-Source: ANB0VdaQKh0F61maoRFCrC63nD1iOwMifTf88GQaK6cFDA7n2UaCxwvF/bI6xBNeh743F28pmpNk3ro5lkQZZRZh1lI=
X-Received: by 2002:aca:90d:: with SMTP id 13-v6mr1483961oij.300.1537359064364;
 Wed, 19 Sep 2018 05:11:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 05:11:03 -0700 (PDT)
In-Reply-To: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
References: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Sep 2018 09:11:03 -0300
Message-ID: <CAOMZO5CEh-UQA=QiyWMadkpp=LcWbGs6zaaXXqa9cYQgrTLiDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Sep 19, 2018 at 6:18 AM, Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft=
.com> wrote:
> The reset signal can be produced by GPIO expander that can sleep.
> In that case the probe function fails. Allow using GPIO expanders for
> the reset signal by using the non-atomic gpiod_set_value_cansleep()
> function.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
