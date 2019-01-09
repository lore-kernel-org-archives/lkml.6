Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C74C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868962146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7KWWTi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfAIAsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:48:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40956 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIAsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:48:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so4352412lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJl7ZF1O89Lnb3lxlwGU3Mmcs/5rLFRXinlQbrNI4MQ=;
        b=V7KWWTi6AcJZb9vb6CODi8wlF6sHPAMJkVxK1qpz9R1JxPiFkDnzqDE+CXDfWLJoPj
         ooWxnmNLBD3ccnydxHsHFMFlwG8F55NlNPQU7NZcI71phOY5GAHUJLHHYFRFkBRMLfI/
         NBKnEHVvivyiK1Mzjl8tNEBUHpnVmATMSB8+OBBTzjjudVmIGmJitidMvEEj5L5djg90
         QhESFOYLJx3lVCet0G37oOo7vm7AMAi92LCjMWgtE9N7uH4LCrGwXpZxpVQgwcXPqVpj
         kXZmddadrWWrFCjXoDagbM+DUpXyzn/812vSna3wh1l/hBN1S46j/wzWJ83d3eBA4/Ep
         +Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJl7ZF1O89Lnb3lxlwGU3Mmcs/5rLFRXinlQbrNI4MQ=;
        b=pi4dfnm2wn8HGLSnYPEDLu6UsGu7S11fyCxbAZjPFB7r4EQaccrdikYsXeCKv0Isz+
         HxW+f2S8XQ+EKPyha1aZRmrsWrDIG8evzHV5PiB3dNZhVqCr/Al427/tCVOXt16WzwXt
         V9R8UKuQUw+k2Fyz9QhsFy7LbSSNXq++qdBqtOmqBGf3aG+b+9qfoc2Uvk/izJSmphDS
         3+W5OWvQeLdISZz8w4p5QO4u4KAMl1tkHBpfvDxwP+YJjT+nbrOPfGTChvCCLr6B0kop
         Brm9rm4osLBq0WEaSTxlGh/Qew3uFpQWvGe/rj2a2zUX6scTKOGdETsuuWfpz/cMrgjA
         EkCg==
X-Gm-Message-State: AJcUukeGOAKjU75EcT3y4u6nrSoPx8vxlPSrHX723oEIIooTDFZ5wm5E
        ZWIs70rAqDUCYzaO/KzUXG3IGYP8B+j7ypLRPIG4KSdJ6do=
X-Google-Smtp-Source: ALg8bN6bwpCfdDC4U8pBKbPDCv11vfYSgJw5zMFlLLu5p4N9c3B+4LHUSKOwVsQRwjK0FovQAAiARxKcyvRW1mg3W4Y=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr2346016lfe.87.1546994893616;
 Tue, 08 Jan 2019 16:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20190107185039.190919-1-rkir@google.com> <20190107185039.190919-3-rkir@google.com>
 <20190108121335.GA3349@kroah.com>
In-Reply-To: <20190108121335.GA3349@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 8 Jan 2019 16:48:02 -0800
Message-ID: <CAOGAQepF4R8ry+irPxeL=G0yFqhxRmkMWd_iPGYOTFzdZSj6iQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: platform: goldfish: goldfish_sync: add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You have a number of WARN_ON() calls in here that are not needed, please
> remove.

Thank you for noticing, I will remove them.

> Also, why is this driver needed at all?  Why can't you use the "normal"
> drm sync api interface?  Why write a custom ioctl driver just for this
> one kernel interface?

This driver allows us to talk to host's sync api.
