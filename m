Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E94C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD1B2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De5BHr5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfALVXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:23:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43728 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfALVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:23:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so15037828oie.10;
        Sat, 12 Jan 2019 13:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hk2D+pqpShna03yKmbFtRYq1L/GrilpEQ+16JuMgBbE=;
        b=De5BHr5cX45P+bYHhYMghfKWAxT4Qmx2iSXouxETlabI+GHtPop/aREm15iV2dmCb/
         XQghPSXo7ABDE+9H/wlNNa/C10ffID9PXgjjTlispU59GfIbV0PycdyZycl84RNwMKFl
         /vTbcT0Og+gcpDyi8v6KsZMfW83BQGDK7t/RhaTbc/sFbUS4/nHvfhbm4trPww3EUjCm
         Vk/R2SUm2L12cKjHweLlVg5fzI/TVTJXJ2bvrG2d1d3E6FHweUknHswkpiBfuV5ZcnLt
         ZdC6Xxd4s5iYXDEoaLT78k539Lg6SUhKeCqAsdi/NsEydVffNIKGgX6jxX/UFwncSVOi
         dOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hk2D+pqpShna03yKmbFtRYq1L/GrilpEQ+16JuMgBbE=;
        b=LZQAwcVB5BhNWOtWQq+ko2a+uQ8yZw2Pxh7dmsoVH7JuEsWYuIM+zHhGBNo7Ua3gfm
         SusWbjvSPQOHzWL0RrpxF8M5sGJ9UHw3fpHyeDQaf/bXPJ1QdRaDvB6+xy+4CcrDVWDU
         syYZWkea3e+MBs3DIgIcR96MMuuTJ2u9c3j6e2eeoPAMFtP+LoxuplowWhDe6ibDBTGs
         GfzqbrAr3B5f52ak+GuO47cNQXxUCIBMNuqwL07DPAI8EW3Ndqg4yQLHBi/PgAlUx/8L
         f1d5rXhPDFSOVajYnAOYQ4SAkXc+/9iIC17goCxSrYmQIbU2en4Up62yEcxKzOvJDjVZ
         12KQ==
X-Gm-Message-State: AJcUukc/nkzql/yxSWpHccr4bhBWef1e7zWAoIQHNRMfumIJFrVeaLxA
        IfFCxOIY/H1Xl0hU/8I2aeclt+JcmQQT+0js3Sc=
X-Google-Smtp-Source: ALg8bN5thL1SxGuG4UEG+lDLCmayG5dEpymxlpZ+O1gwWH7smJweQD8L4ZiYnWrrTqiQ7G5Gw/EQg7efYo+rHghAAJs=
X-Received: by 2002:aca:4ed8:: with SMTP id c207mr12881785oib.276.1547328196000;
 Sat, 12 Jan 2019 13:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20190111131102.899065735@linuxfoundation.org> <20190111131105.377370861@linuxfoundation.org>
In-Reply-To: <20190111131105.377370861@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 12 Jan 2019 21:22:40 +0000
Message-ID: <CADVatmNVbJtnkgXrsEy0=pB3+H-ap4zdpOdD=mPonxjvVZM2Lw@mail.gmail.com>
Subject: Re: [PATCH 4.14 024/105] bnx2x: Remove configured vlans as part of
 unload sequence.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 11, 2019 at 2:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> [ Upstream commit 04f05230c5c13b1384f66f5186a68d7499e34622 ]

This was fixed upstream by 38355a5f9a22 ("bnx2x: Fix NULL pointer
dereference in bnx2x_del_all_vlans() on some hw")


-- 
Regards
Sudip
