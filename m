Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3392146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9WZxSyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfAHWKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:10:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42619 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:10:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so4750335lja.9;
        Tue, 08 Jan 2019 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PCL6SPpxh6oJrJWKG6CXu3MXYNCgU8onwhqQd2u91k=;
        b=F9WZxSyd4KRouDh0sH0eLyvGsEIWlIk9AUuOwZvDdLXMwcov1QczghHVs3c/7/VmQd
         BD7/vW/Cb4RMsyUR9R1q9s7ghr4DDLse10IBxdq+umEE+yBsvvf+PBqmBSaXY9F8jBQu
         EXoebQjbcjQhFpPEddf4sv32kEsfgEX6WnLl532XYjgvMd9YrCii4EOywpPht3SkQVGx
         NxfcPmxTv/DTw13Kaw/8tqTXT7wEY4TKxwKJIW7BCTgEryo3HfwSumUoNjXBR3cjN9Hu
         vIQabCzF48Hz441ul7hv+6PthVILE3MhZNqjIMN5Z/p+9OHR6iEZOvJd5qIAvbAk/Ai1
         iZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PCL6SPpxh6oJrJWKG6CXu3MXYNCgU8onwhqQd2u91k=;
        b=dXgEQRvVavRMNfyROtPVTxUBHzqfOCOnnLwStvWziMBrsuRqHWd+5xXm8L5tLMludW
         BgZWaL+sYD+mPdVINDdbCingqyG70e5ybOWbbRoWq8HZHCKjdQUHzQm5c4/bgm5sOCq3
         P7g7vtjeCMwQDQg1PJHN/zgVbPC/Y6YUUJxvBNyJOnLDksXWFpa/LAy5apwBqOGMsKDB
         9rjzs/d23esd74ZuhT/J7BvxlCjR+yfle7Yjw7uFJXu3En0kQ6zrHFqa/CjNWS4TL76Z
         kJ+2Qa34VKLCYj1ny6nzBpMqVgnxd4+9WaA1FBN31zQS2YYYioFnyzHkIz5TxS3oWHM1
         Gp8A==
X-Gm-Message-State: AJcUukc4auVCTOxo2EAQeKLXqc7W7CI5gQG+RBTyUpor5MaFCN4xNkIu
        nUSTUArJhffm84Y75aBUI3wiZEvmxVzzaDUoEEHw7A==
X-Google-Smtp-Source: ALg8bN7rHdaz/xuJmrRYVPxp8Y/0Bwq4Nnll0v3UQEGdW94IbgfSZvN9DTjmQ3iDSpvfExe4gVMlDxTf4UJzXLAYxj8=
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr1737897lje.115.1546985415412;
 Tue, 08 Jan 2019 14:10:15 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
 <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
In-Reply-To: <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 8 Jan 2019 23:10:04 +0100
Message-ID: <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in 4.19.13)
To:     Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 6, 2019 at 11:21 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> [Sorry for the repost, screwed up the netdev address...]
>
> Hi,
>
> Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.
>
> My firewall (which also runs the dhcpd) runs VM:s and it does this by
> having physical
> interfaces attached to bridges - which the VM:s in turn attach to.
>
> Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
> seen - a response is sent but
> it never enters the interface attached to the bridge.
>
> Basically:
> VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
> dhcpd eno1 -> siwtch and... gone.
>
> Any clues?
>
> All the nics are handled by ixgbe

So, doing similar tests at work with other drivers works - could it be
related to the mac address filter that was added?
I don't *really* use VF:s though... (can't really find anything else atm)

Will try to test, but the VM:s on this machine is in use.
