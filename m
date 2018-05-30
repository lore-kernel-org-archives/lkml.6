Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3012956-1527648034-2-8357424004727232643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527648033; b=IAW/O00ZCgMLc3nH3QYAlfd2ztKvpBUInSXG2iGtUn3uUUGUyn
    u4dYOeqTM7ZDI50dCFiJ704JiJAdl/RfwevfQHFhDqqberkPWlPbM1kJI87CSMUt
    qZTC7T4ZGqdtOd3+pWaHKfPyGFxUbI44FOZZ4G7fQ+phfNt6Fo52hFmH/5BzsAs7
    WvaqrFHIBUXfLg8zXjH3qR9Yx1m6UghGmIGSZm473pqcRmiFQX/j6VS81OdyhMO4
    HYgpttTOjY6DCoFa+g/MEGltA43Dj6rYMgpEX5gefhLnM9Kxa5LiUCdGVar14tq8
    ZODT0Bpz2bSQ6iI9wNkdguaIt5YFHroYH0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:in-reply-to:references
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1527648033; bh=/b0nm1uhxlm7r2sORnbTxBc4Iw4zlx
    1CmExqFDcCxV4=; b=DJz1Jmvl1aeNkiFWN7wIBtN0soC5yRqAT1zkmY2iHkbb//
    /pns69I44A8zMAv2PmH0mkQFtOjqd91vmJ/jIm+h4nmkvAPR8B5dtFPlN315F6Lk
    HJLczGfngaVJXVMwvGKvcgaCOcdT5tovWuu8IvD89vBxmTvOlAiZlcbKHNE/7Txd
    eseBcWTxZeZJCqndRTdnWGvkqn049efDirEre+2ktINlez3goSOMXfpmJLlkJZD2
    ElygkZ2DUqnKi4YmvIZoes52zNIfhbM7b+SEO1fPa69IQ5SFEX/4xOdCBMpvBJSf
    T3iCDq/5vmaN1SSDPm3omkQeMDIRhTxRhU2mh/3Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNhVg2VZRdBWQQFH/R7YGgjD/cqlFqBjaWIW6oEhJExcdK/zsDhGxyyAHb+aOmba2H/sKkMDMib2ygl5Le2TMXCJgm+V9l0MfL/iF80yuLKUSB3I0JUA
    RXEtu9spqB1rW/Kz7b3AcIiY737mBuk9nRr2DWwMvQmHTa5fy1YKj+mvKz9tDRuUVWhVTND40X1bl4QHhftmnVSpJ1PWHlBnLKrufLOi+3DWPuYfb5YRRlg9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Uh2GUmArLA0A:10 a=VUJBJC2UJ8kA:10 a=2p3mFmOG_n_8UouoAbcA:9
    a=56Y3Tnyv5Ko6elOk:21 a=Ybb1DAZpOs82FocZ:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755548AbeE3Ck3 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 22:40:29 -0400
Received: from mail01-md.ns.itscom.net ([175.177.155.111]:59134 "EHLO
        mail01-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbeE3Ck3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 22:40:29 -0400
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: Why is the length of max mount option a page size??
To: Jungsub Shin <supsup5642@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180529035703.GA32550@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox> <5670.1527244930@jrobl> <20180529002456.GA30767@supsup-VirtualBox> <20180529011412.GE30522@ZenIV.linux.org.uk> <20180529035703.GA32550@supsup-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5877.1527648027.1@jrobl>
Date: Wed, 30 May 2018 11:40:27 +0900
Message-ID: <5878.1527648027@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Jungsub Shin:
> Do you mean using symlinks or bind mount to reduce length of mount
> options?? I can remove "~/tca_agent/image_layer_dir" string. But the
> other character means unique ID of layer and i can't compress it or
> replace it to another string. This is not fundamental solution. Docker=20

Can't it be a solution?

# mount -o bind /long/path0 /br0
# mount -o bind /long/path1 /br1
	:::
# mount -t aufs -o br=/br0:/br1:... none /mntpnt

or

# ln -s /long/path0 /br0
# ln -s /long/path1 /br1
	:::
# mount -t aufs -o br=/br0:/br1:... none /mntpnt


J. R. Okajima
