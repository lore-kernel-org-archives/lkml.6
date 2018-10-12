Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4964F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwODQmda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4964F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJLLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:24:24 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45203 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJLLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:24:24 -0400
Received: by mail-qt1-f178.google.com with SMTP id e10-v6so12492197qtq.12;
        Thu, 11 Oct 2018 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TT1lQrUQZn3Q+1bqVQ35tULEvkCg85Cl2xav7Ft5zN0=;
        b=KwODQmdabbmyrKe85JvHd8TqiGd+njDHGCwlQiuCe8FCaUvIZsX9vNtfPjdbPBuOJs
         wiY8R+En+IDCXy8rjBrLz04hTnDUprn+DBBBPfRLopq016At4GU6acMzUs5AYaFimzD6
         glJ8v0iJnWuquE/pXFXaGjz+xnTpAL8OnWQn2OXIBSDUkSxYeVb/D9EhUsVRJwigYusG
         nt93n4ggjy3RnRgSxt680ICsPWRdxbPtLiUDbGbei0DDvFxBg1UB8CP49ypwpcngvChx
         xu2DX9qeJpQdBI4NfTNWCFhuFzU8ElQ+FwaLOLo2YHterCpE6DShRnkKSEJZcGFnd6tj
         AK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TT1lQrUQZn3Q+1bqVQ35tULEvkCg85Cl2xav7Ft5zN0=;
        b=lDkBr2zHlrSgoVcGUBbRD/IeIrBIswEoKqmOR56J3D80gMPLAsZoTkuXt0X2pTSIi5
         iJDMjGD4hjMNyKBo3aa/RF5+fZEhNKlWoHbBJwoVkKW8CKau+U3rIpnmz0DWfxMM7eCP
         Ak/C5e1mrqZ7QwH8Vw7MWkhQqHG9y+J/Ds/sW0UmgzamhOKqARx7p5yV7nl3xTt9nBNm
         Tb8Oxk8mcdnbFJPvbX982O3AdHgZ9djR1oWSh3D8tOxj9TtEbPy/TnRg8iKKvC/MaQzV
         EKtiJaAEZf2yLEt0tVoRlok7v5Yh1NrMRFpt0j237kmOXScacEvIPcEjBRqRq1YX4fw7
         QWvw==
X-Gm-Message-State: ABuFfojCvZo/NsMvstVqFd3LzW+cCg37aMEr8yI8mJ0lSVz3EGxJiaxg
        br75R6jUlW1bcKrslD7foogA9Xte+i/rK0jPX+Q=
X-Google-Smtp-Source: ACcGV63rsLAzC2PXbQlrn3ein8YZ34c4OyCWkzy3Z/Ksv/u7krnIscFGwHh3Bmq28IH4axMIxLasACb2YlQ0Kw685co=
X-Received: by 2002:a0c:8845:: with SMTP id 5mr4262562qvm.236.1539316440539;
 Thu, 11 Oct 2018 20:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
 <83856420-af5a-e469-5b5b-e24634fc290f@huawei.com> <20180926202121.GB23881@kroah.com>
 <20181011140735.GA9507@kroah.com> <CAPACB-yF16qtiYn9e41_iFNRUzHB349NEiAGubUvW-kiUwpRMQ@mail.gmail.com>
In-Reply-To: <CAPACB-yF16qtiYn9e41_iFNRUzHB349NEiAGubUvW-kiUwpRMQ@mail.gmail.com>
From:   salil GK <gksalil@gmail.com>
Date:   Fri, 12 Oct 2018 09:23:48 +0530
Message-ID: <CAPACB-w-ckprnaAMZ9dtL9ZCfH4UwB-gmSmRBi1W51d6U4F78Q@mail.gmail.com>
Subject: Fwd: [PATCH stable 4.4 V2 0/6] fix SegmentSmack in stable branch (CVE-2018-5390)
To:     maowenan@huawei.com, netdev@vger.kernel.org, dwmw2@infradead.org,
        eric.dumazet@gmail.com, davem@davemloft.net,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking for fix for CVE-2018-5390 and CVE-2018-5390) in 4.18.x.
Will these fix be available in 4.18 train ?

PS: Sorry for sending again - I got a rejection message as my previous
message contains html tags !

Thanks
~S

On Oct 11, 2018 7:38 PM, "Greg KH" <gregkh@linux-foundation.org> wrote:

On Wed, Sep 26, 2018 at 10:21:21PM +0200, Greg KH wrote:
> On Tue, Sep 25, 2018 at 10:10:15PM +0800, maowenan wrote:
> > Hi Greg:
> >
> > can you review this patch set?
>
> It is still in the queue, don't worry.  It will take some more time to
> properly review and test it.
>
> Ideally you could get someone else to test this and provide a
> "tested-by:" tag for it?

All now queued up, let's see what breaks :)

thanks,

greg k-h
