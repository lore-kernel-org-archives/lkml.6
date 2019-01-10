Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D1CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFB6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehuMfMdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfAJBl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:41:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34659 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:41:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so7146027lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTG3nSAEQevjTg4TDU41T0QBWcKZR0U6dmni46XwSaY=;
        b=ehuMfMdr11yj08StauhvAaCs8lIR6aZIyj0WhUj/Iko9EFmBzagL8Zau0ugixZT9Yy
         yUT+uZgImnnDfY29o7Chqn5fI/rfk9Q5I/nCKDS/FXGeomX7tpCxzqedKZp5IVrtkkF+
         cRvFMgjv7N3gooLBeqGqyhz7o2gX9+AewxYOdv8amTdgu2UCAhwXLMjkSnt3Z1BE2zEW
         urZG0uKna5LPuV1d89Ffusrlk4j6oYX1f5EJZ9tt5JPkev6mptVY84p1s3ZWXSBgGUjz
         zSNRha5OCcKfWPpUbrqau39BeCbIQGdI7jZVzVZ6M1UCX3aRJWhH6f/5HIkdCqI9lmMv
         DgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTG3nSAEQevjTg4TDU41T0QBWcKZR0U6dmni46XwSaY=;
        b=G0HcjmpEaVAIxPM5Iy48qNOrdPtB4jHbj+7XAoRucykXrHIwZIxi0VoxgZMizPUqf3
         qv5+gWoXH9wwxTe+V6M59CD08jk+dhdo0QBehw7cCGTK0bmsYYmzNOuLllUdb4oVwitQ
         zfpWqi2CKxvQbKjePdIgaDon94W5M96c4XsioMleVijztBjBPiD+9zmHCE4b8QnxplUL
         wruR+W6y0d5jD+TO7kV446neLDO+hs962yLKX5SQ+Xck5l24ugN6aqiN/ic25QEYP6kv
         nr3zZYYE5r+hctEa3DGiOHN0EjYUKlnKJ6AR+Sq5sdFg99G83H6WxOARdRWQibvrNUSB
         6byw==
X-Gm-Message-State: AJcUukfk7n3upv+b2aIQnCHWRXRG9DX9ILGiPvPr/weVyzkola1i+sjj
        PqIo1490b5ghB8+xoa5J7klp9anfDkPyg+PpwKCGyFMPYrfVEA==
X-Google-Smtp-Source: ALg8bN5yW7LQXjvU9USJvvCiW0jRVq5NWf0dy6NfPgDv25/O2JLUa05GH39QmLbnhGb/K/BRIgcHBnGLllUJFs1FbaA=
X-Received: by 2002:a19:c18d:: with SMTP id r135mr4325447lff.59.1547084516792;
 Wed, 09 Jan 2019 17:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20190109021112.5836-1-rkir@google.com> <20190109021112.5836-2-rkir@google.com>
 <20190109083109.GA24501@kroah.com>
In-Reply-To: <20190109083109.GA24501@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Wed, 9 Jan 2019 17:41:44 -0800
Message-ID: <CAOGAQeqrdtgwoETZcEefneXi0wnQvZfKZX7=SUU7PfA2nOGzsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish: goldfish_address_space:
 add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have a pointer to the QEMU commit that matches up with the device
> that this driver is supposed to be supporting?

The device code is here:

https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c

Regards,
Roman.
