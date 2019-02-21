Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758CF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyHh7pdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfBUF1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:27:24 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42048 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBUF1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:27:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id j195so1875859vkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpYGB66TjbeUebbhVLA6Dk751WzEJE1cj78afr9Nnww=;
        b=PyHh7pdBjYv9lxosfSE3mKnnPoTwim6f2rm42CRShaAHZm4LpCVFty3PlbAQq9MAr1
         J1fdVQpP0Dy8CmN17ILDsPobAhUt37uIu0z9IibV8rCBKxuZPCsyhAFv8OShj3H1b0yn
         Do/nrpUBVDuz6Y6tz7UM1kPxMElHVn4kj3UxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpYGB66TjbeUebbhVLA6Dk751WzEJE1cj78afr9Nnww=;
        b=m5URZ43bBQz8SPXMwyC6IVELWDGV8E5v1rE+uVZ36nSL6Vmd3GTG5v+wef8jAaSRAV
         ssgTwY80vbaiSf9Kb5l5ET9qLRsCVj5TN38gXOS5TK3KQBli4ybfefSPO67EEeQvvNWt
         j1aUvnKGbrKANBU3tuA5PDQPTsZGj5pPi/JKykOMwE7b/WaLhHYZk6LUA8YxDHSPVUU6
         dK1HGnBEoqtTFt4vnIYjboeJ5pTJJS+o73AHM3iDlDtRlI6xwjEPyz9IDQWxzjqdqWNE
         UytVa/Tf+HgDBbJQl0Pcncp1Fna2Gv9zZvqhZw1+kqN4ayX0lIIzjT/EOkppOWH2TWAJ
         vfDg==
X-Gm-Message-State: AHQUAuavvPQ5a3Mxvk6bszCoT484VeXqvpe219yUh/zL1D+i5BoPWlk1
        IcRFsQweS0iM9PDCzqQ/g1lh0ZVXGKQ=
X-Google-Smtp-Source: AHgI3IZ1W8YCrmJumkyVT5G0hNiXrKLPp2XYFWcNDLaOpcYTIUxfED59O82qQzDaHYKNNFpcc6Ye5w==
X-Received: by 2002:a1f:2912:: with SMTP id p18mr20895596vkp.38.1550726842088;
        Wed, 20 Feb 2019 21:27:22 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id d73sm3361096vsc.1.2019.02.20.21.27.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:27:21 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id r201so15433876vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:27:20 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr18954760vsc.222.1550726840479;
 Wed, 20 Feb 2019 21:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-4-tobin@kernel.org>
 <CAGXu5jJ++_VufY8t3WYsGW8VN-3yJEbVpOi_67RxHPicCC-K6A@mail.gmail.com> <45959376-49a1-467b-835e-f335fbd1c470@infradead.org>
In-Reply-To: <45959376-49a1-467b-835e-f335fbd1c470@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 21:27:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLtQLfB=XvffTVwBEHghf1xJBgFpBp0njuyHghFoAW_bw@mail.gmail.com>
Message-ID: <CAGXu5jLtQLfB=XvffTVwBEHghf1xJBgFpBp0njuyHghFoAW_bw@mail.gmail.com>
Subject: Re: [PATCH 3/6] lib/string: Use correct docstring format
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 8:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> It's already in Documentation/core-api/kernel-api.rst, under
> "String Manipulation."

Ah! Thanks, yes, I missed it. :)

-- 
Kees Cook
