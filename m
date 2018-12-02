Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01505C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B454A20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWoUDAiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B454A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbeLBERD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:17:03 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33082 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLBERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:17:02 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so5424489itk.0;
        Sat, 01 Dec 2018 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqvEV8XxwFoGIOHuTsV0X2foFHesnEZmB8j9hIWGeM4=;
        b=KWoUDAivy/GpybL1XPwJsDjRKd24KzxVwGYbzW35RRM5H/Msf+05esItXZmZJvz1pR
         iCAtvzy9PHmbGKI0I/w/ppRE2rlDr0HC92eWumL79zNe3/+5QqzP9ss8C0HmMD6pm0Uz
         mTXUkk4b4/1p68S7K8njpJ9hIhOkDE0TRjYrTM6LUVPL/Fper6BzjBBtJV5pqiZHpaBl
         waJUAFNNDA5ED+KErTTLA3IhhxB5byLv3NH04WF9uxq/JKh60Bx45QS9ywmxWBXAs4sc
         qK58LkgRMIC+X3JIbBmn9o3vYdAXuz90+GqGGKRDCO37CewBBawvDAh+fPUzUEMPmEBk
         NU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqvEV8XxwFoGIOHuTsV0X2foFHesnEZmB8j9hIWGeM4=;
        b=AJlYIRGHdgirGJ74e8X5HpWRzg36g71IPm/Y7WXwr11slaWiuRVLnCVm/uFeybX+U/
         BlRksVv0a3nfmGT0ikrcQrVBeY9UKu/i9/eP80n7/VJw+Ga6gr6sBDHmaNmB9eRi19jt
         FTBQ0gH5wL6eeRqU7k27P7aRJIM0CgnqUTc+hIQhV/D6pnwUsydY72MC/nXyhBGv6XZ+
         zLgmhx83D42DO3Y9u8HqCYYbgQvqal0WA2Q7YVlN13lKfpAOHxetKnZgrVskvnQIl9+t
         Ls4RbHsJqno3zi/0JrnFUsAPXzTwC5v6pGjn1h1GHia5IVki5z6L0D/bCtkRArT28Wvj
         2Qdw==
X-Gm-Message-State: AA+aEWb8Pued7l2eRcA5wyHSeCRXqMt/kUqruZng2kjDcW0lz7OeDI81
        i5sIrbHm/xgHP8jJilt6DviOQ1zHiY9V9aJG280=
X-Google-Smtp-Source: AFSGD/VQITpTLjd7SzfpOJG/tTqI5LPWLYstR1TwI5ufMnnBm/spGn2JucmKBPwqTLLS3Bv6w2qEiEEvzlRtPUbXTjQ=
X-Received: by 2002:a02:5184:: with SMTP id s126mr9890032jaa.12.1543724219596;
 Sat, 01 Dec 2018 20:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20181202041448.10049-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202041448.10049-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 12:16:37 +0800
Message-ID: <CAEExFWtu0LLgNgNtW9QM16cZA337A7QGQc+XKd2fnX-7tfQTfQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE
To:     b.zolnierkie@samsung.com, fengguang.wu@intel.com,
        mchehab+samsung@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 12:14 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
Changes in v2:
-Add a missing edit of dss_fops
---
