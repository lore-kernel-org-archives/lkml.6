Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F79C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0742175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4VR4GXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfBGVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:08:00 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43002 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBGVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:07:59 -0500
Received: by mail-wr1-f51.google.com with SMTP id q18so1364137wrx.9;
        Thu, 07 Feb 2019 13:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxNIsP3PcTH7Hh4ydPkxr53c5fH205ESLut1xzmlh+E=;
        b=L4VR4GXqzUDUNhcwirOSyk61ng39UpnY0iNKFFuZbAQoVj+svr6BmkcNJVp4Qm4iCU
         qo7K0KUonhZGgb+QpbC9d+2n4kVnyf3fg0lQ9rOJnpMgQ7VYDk7+gxBrFOwZ2QDKYhfD
         PDcp0uIHiR2yrEDlRoKgIycq487KdnK7ft4tYmrPKiAvAfDhjRDHnzSPCAsHq+TALi6J
         R7ayMy7gOcjNWRbAVmpBfOugZ6sQVgTELO+jMRAZJdtio/VcnYu232cHoZC5OonQui8x
         g6mbytimK7e+vxZ6SePZvAlnvHs5MKLlWLv9FS0E8xAS6NuER1EaLj7m1Hy1IAAmxD8x
         rTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxNIsP3PcTH7Hh4ydPkxr53c5fH205ESLut1xzmlh+E=;
        b=EAtGytP8afalM1IpzuCFcOcfQkhSjC7uF9ob0GUDOJKmB4za7PUrMqZ3c+eFJjOx5i
         NomlDY6Q7LsUEncAAwEmTZH916GGONpL0ITqc6fS6Em7utVsHKqo/MDv6Fh6JpJCg5gq
         yFgxeUz2vwMLh7vWG7iov7dwojfsG276jIuhP7aCl17QHhsOI0kVgoRz8VxjK5E8Jgyp
         AC2g7bcHLZfyi0/FTlPxW0QnLbU44WFxlSFv1w06ZtGSu5cppfeqfoM7uAG+pNarsV2m
         yelAuLYe0gXDfOs5CRkx1ZXoQzxUvlQxCDwxUgIsNcmplt7az7OpnRg59yGl9FgeXGbC
         2d5A==
X-Gm-Message-State: AHQUAuY5yp3K/jbsqDIdwgMs72YlQ1ezasf7JTUJDuLqf+ZJ9NNhPF/f
        EjXAhk6J1t36f/LVMF7Q8KxTg0tKEvFEVpXdV4E=
X-Google-Smtp-Source: AHgI3IZ/G5oc2mqbcIe0pJ7DAClJ+mn8rfjWFIM+JvZqxKBNJxE/m+XuXKdWDlZVduxez3gjqiJnzrBe9Cn6leJJuTU=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr13282808wrq.5.1549573677650;
 Thu, 07 Feb 2019 13:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190207000331.7547-1-andrew.smirnov@gmail.com> <1683ed6e-c798-3a5b-341d-c0a7901887d0@cogentembedded.com>
In-Reply-To: <1683ed6e-c798-3a5b-341d-c0a7901887d0@cogentembedded.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 7 Feb 2019 13:07:46 -0800
Message-ID: <CAHQ1cqHia75RWT25T2+QnZdd-wVkdyn0QciVo3b1w=BLN35D2g@mail.gmail.com>
Subject: Re: [PATCH] xhci: Drop superfluous initialization in xhci_queue_ctrl_tx()
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 8:44 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 07.02.2019 3:03, Andrey Smirnov wrote:
>
> > Simplify filed's initialization by directly assigning its final value
>
>     field's.
>

Oops, missed that. Will fix in v2.

Thanks,
Andrey Smirnov
