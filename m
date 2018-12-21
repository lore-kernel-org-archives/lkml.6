Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464F321903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unw4KZIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbeLUQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:41:30 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:37413 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeLUQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:41:29 -0500
Received: by mail-it1-f170.google.com with SMTP id b5so7383970iti.2;
        Fri, 21 Dec 2018 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=Unw4KZIVYXAycrYTdGJ2Lhx11UF/FJBOYvve8zgX3R06sf4dXKAJ5ow+CbX9ClNOWF
         CgIjWUaEc7Gr7kADzc+idaE7XP0q0vRoWhYgY6Pywc+WdQHX3AP9CqYo9UVIc9cCpo3W
         UiX12yOascIZHUU8Y55RkqJLv7QvzmB3sOmEv90IAiy3OADWnn8Xs5nTJjxV0T2ij8Pi
         RJzYupl+Sf5pjfmMOVvE6GZ49nixS3zkOhqCO5u4fLSOrVu+tQN3hCvcMSu98y+OlZVr
         bpkyC0zfNCkXqrH5tF9glgSx/VQFoOyM2Q9pi3BROJCQHJ267oZqZnG3KcLJNxKE+TcR
         JlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=cG+1g7hW0mdvnvHu7DrN1H+4DlkSow60kTUITO4SWcnDGTvaLLJY0Gzuu3HcPaNsyW
         39Lm8FsI+eET8brXhVP8GhTylU+M1xdGJIXkfWmbH66cJtLH2yL5krAFzjfz6xTsS3H7
         5+sV/LZYRls8Fg7UK+IsnxwboAFQFKoj7ZcePxH1Nm3XRCwsbE//Lj3a4sKohrbshEX2
         mQzhK/wLKQTMyO/ADWCpefRajIDEQUPuCw5QZF3tjW4b89jctTc/o9Bjhnrri5j9w80Z
         jFtFRcfTut60DsRGhYK5yV2loCkk35MibrtiPrO2L5TISowQXZJ69sdP6etpd46Wvig1
         wOnQ==
X-Gm-Message-State: AA+aEWbDdg/eUBGnPa/WbdZFQYfBQDDh687u802936y2uWNkYqmzSdcF
        +zcsIC7euwMqQ/9IqByWiENsBeosoFGzAo/YoVaXLRpq+ZI=
X-Google-Smtp-Source: AFSGD/WWLVTtwmu8Ye2VUtP3PJiHkq2GeKwzfhSEJ0pB8ogItMNQw7Hhxk4ms610wH8qPv92aT3UfaV9o5YSKZOWfDs=
X-Received: by 2002:a02:5184:: with SMTP id s126mr1934864jaa.12.1545410488743;
 Fri, 21 Dec 2018 08:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20181212160145.23117-1-tiny.windzz@gmail.com> <CAEExFWuoJZfHeVemcLz9JhrQ_RBMzjsB3CopymBMWhEyWVR=rA@mail.gmail.com>
In-Reply-To: <CAEExFWuoJZfHeVemcLz9JhrQ_RBMzjsB3CopymBMWhEyWVR=rA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 22 Dec 2018 00:41:18 +0800
Message-ID: <CAEExFWvmMRCi4OFhRRwoEftONF8OLACnqq=xOEFV0gP31MTsHA@mail.gmail.com>
Subject: Re: [PATCH] serial/sunsu: fix refcount leak
To:     davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, sparclinux@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
