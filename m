Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9114220874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIniUjy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeGWJx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:53:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:53:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so16191107ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/BB2TW9mWJZcnJnzpBwv8OGSi8IWugNKcT/yX8Visk=;
        b=gIniUjy5a1XbgP6efMgwH+1OdbZKLiF2p6SipuyceZGVypCCJp74C2/WhQ+vR+4LuL
         NPSpBRqtoab2nFeuQh0dsDnWyB08LuuCZx1Xy5U9B+He1xxj4Zmm+v2GWybg9kpPG62u
         ZU2aJ9fJ/9uzmcbI4g9tUCNvS2ad4DdsE34LcAHGJT2fcnPaVDeHQu0bPN4R29q+GpGU
         2ffqeX/1bb/l5jWmeDpzn8eB9AbubBBwJoJvdzlbbJl2x3omHWH9d3GC2l9n09aLfaAZ
         oBj0y2DAh/5mEo1PjVmsfnX0Zj4AoYZMGz17HPBi3lV56hvA0mQ6WkjS/Km8H37fEfvp
         Ypvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/BB2TW9mWJZcnJnzpBwv8OGSi8IWugNKcT/yX8Visk=;
        b=O9D2b+V8FnDI2PLbe/3aEholc3Skw2hpvtgXtZvDKXSG0dxZQX0RQE+X1LLiAQ3Z9Y
         1g186P5+Zs8vDqlRyzrrPvZuu6BN+FSuk/ZU9MPP2sc0dSzJwv/SCVeJ+htYMzm6O/GT
         NvCiaIww+cHb4LHc39vl0QW7fNt/3aukEHg0QvK9L3WGTp+yU28V/eBOL+HaFqunONGJ
         oFQOi5gnQm1OyDyLm+RPyBD818vLqhHWLGQOEmt8tj6/Oj4RKcUWwR+uiShgAzgYHtoL
         qnPCoai/+ptScWpR4uX2hbAQOxYuUAYZDduGkmJUa3kGeVgSBnmN2VudnwYK+9ApkArm
         /8Vw==
X-Gm-Message-State: AOUpUlHPd2gAaSjaSOw+X4Lu/gNfQLN9bU8M+KYkbz7twS0X4ebF5suX
        Z2iiqwjQgSHD4k66ncBdKuNJXRT4/XD2/Cfljao=
X-Google-Smtp-Source: AAOMgpdw9HMdYrRcRB80FeytXa/WOT7zFKIW0f4Q8Dn4LWozuCTsX8GtjopOcLTwSfAXASGIfyJs0wf0adH3552OLGw=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr4707381ljk.42.1532335995941;
 Mon, 23 Jul 2018 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180723080208.44235-1-yuleopen@gmail.com> <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
In-Reply-To: <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
From:   Yue Wang <yuleopen@gmail.com>
Date:   Mon, 23 Jul 2018 01:53:04 -0700
Message-ID: <CA+C1jua9ZVDStQwwRBw7mQE4CTZkwfED99oJNV1Cwo=6Hgim6g@mail.gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
To:     Jussi Laako <jussi@sonarnerd.net>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Mack <daniel@zonque.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment Jussi. Let's drop this patch, and I will send a
new patch with this generic approach shortly. The new patch will have
a different commit title and message.
On Mon, Jul 23, 2018 at 1:26 AM Jussi Laako <jussi@sonarnerd.net> wrote:
>
> Hi,
>
> > +     case USB_ID(0x152a, 0x8750): /* Topping DX7s */
> 0x152a is Thesycon's VID and if it's based on XMOS I'd recommend to try
> adding the 0x152a VID to the generic DSD capability auto-detect list
> instead of this old device specific list.
>
> I consider it very likely that it would work that way and at the same
> time also cover all other devices with the same firmware and Thesycon's VID.
>
>
> Best regards,
>
>         - Jussi
