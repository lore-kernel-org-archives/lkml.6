Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E16C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07EF2543E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="d4+mMHRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8YJC6NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07EF2543E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeGBBKh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:10:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57889 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752676AbeGBBKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:10:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BB2121ACF;
        Sun,  1 Jul 2018 21:10:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 01 Jul 2018 21:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8YZam6lJmaF6kOuDSp1z1cynco9eK
        pZcmoE12zJ3WDE=; b=d4+mMHRurFPaBBLc+VgmmcrO9bq6iFmukPDJVKNBg3Pcz
        1V4W4liYVviT/0AZayMoZ5xbccC6jpMz0stRdQmVSmCUVtYAU8R0qMtjcwLi7gAf
        B85QZzcbr1QCL6IMZa8wXEc0+vF8goR8gm5q/I0kpjBgySIvhp59yBvGV7bQxiXx
        jDGnaLBpZYtQsROdSih5eYgNL/NRSAxMJttqxeQpZPt7kJP0eQ/jnW2RlFsfhSFJ
        1c55krPbAYvYoNAAf1GqKVv7rbWYqd9O38TStBhynKtH9tffv6NYYnwybtTrZ0FZ
        EIYVxMjt97vnkNieZCmaM7W0eWVMRLiRYLI2ESXEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8YZam6
        lJmaF6kOuDSp1z1cynco9eKpZcmoE12zJ3WDE=; b=T8YJC6NR39jC21CIXJn1zt
        go8vCP1jC7wd2ZNLfEZVHpnb3tNOGMFnlYhb/Twz8m+PPpARPU4gZJitWK0EwVLf
        76TqWoHq6hV3WHZ7rlkaEHq2df0iZUrKDAZu4v7/sjurfcDEBoyFuMRRuCYoBecB
        O88ulhX98CUTR0H0A0fiZcL2eFW6gDLeNJ7KNCUTGs9B5R0jaCxyVM/RoxA2qOwJ
        f6vJT/kh6VNoqW/fc8ZkeuIh0qfNLFo1mEolNKZAbKb2tXOA2+im4q2ZFnUR+4hu
        FyIgXyUTBW4IXDXUkg3MWYeDzzNx3Jl2iPQ/StoioAKik9qZXsuXPWflPplSQ29g
        ==
X-ME-Proxy: <xmx:h3s5W0TJwauupdwCcX1BgVV9ezZtNGB1hmpUm7VWnv_-ILxPuRnjeg>
    <xmx:h3s5W3H_eImxRxBswgdAYWaa6s68bpiXuk8CJn5iIWvFqVUpWtorFg>
    <xmx:h3s5W95A_hS1OZfEgS7rfx0ns3L2AqpYcV_F4Yx4RKQzJqmSRgrhPg>
    <xmx:h3s5W0n1vYzmZNRp8gyPjb71a5jFaZ0pxkGt2H_0YT-Z0155hsCUIw>
    <xmx:h3s5WzxH7gMgHkyN78-l1eDxIoFWgH3BwYBjgFfabYd7tprwJrA_Kg>
    <xmx:iHs5W44eJz6TnapfejR7sSKDwo8Pw-Dzfx2qUKKp7FWaxYD26a2uLw>
X-ME-Sender: <xms:h3s5W01g1RFwqXq-Kld0YeTpk70usyXhR5pR-LHXidXuRM5xkls6xw>
Received: from localhost (unknown [121.44.171.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AE6010260;
        Sun,  1 Jul 2018 21:10:29 -0400 (EDT)
Message-ID: <1530493827.2749.8.camel@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
From:   Ian Kent <raven@themaw.net>
To:     tomas <tomasbortoli@gmail.com>, autofs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Date:   Mon, 02 Jul 2018 09:10:27 +0800
In-Reply-To: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> Hi,
> 
> I've looked into this issue found by Syzbot and I made a patch:
> 
> https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425b1163

Umm ... oops!

Thanks for looking into this Tomas.

> 
> 
> The autofs subsystem does not check that the "path" parameter is present
> within the "param" struct passed by the userspace in case the
> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
> path is always provided (though a path is not always present, as per how
> the struct is defined:
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_dev-ioct
> l.h#L89).
> Skipping the check provokes an oob read in "strlen", called by
> "getname_kernel", in turn called by the autofs to assess the length of
> the non-existing path.
> 
> To solve it, modify the "validate_dev_ioctl" function to check also that
> a path has been provided if the command is AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> 
> 
> --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200
> +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
>              goto out;
>          }
>      }
> +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> +        return -EINVAL;

My preference is to put the comment inside the else but ...

There's another question, should the check be done in
autofs_dev_ioctl_openmount() in the same way it's checked in other
ioctls that need a path, such as in autofs_dev_ioctl_requester()
and autofs_dev_ioctl_ismountpoint()?

For consistency I'd say it should.

>  
>      err = 0;
>  out:
> 
> 
> Tested and solves the issue on Linus' main git tree.
> 
> 

Ian
