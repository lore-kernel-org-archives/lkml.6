Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC9C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5/hDxO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBTOrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:47:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44002 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:47:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so12015979pfh.10;
        Wed, 20 Feb 2019 06:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3dQ6PTUBIGS+KwQyRlyF1SjNK/XkYnHi08EauzmhstQ=;
        b=Z5/hDxO82U9cMtCJr+nql8aFzoZR1NZMIP7HYay6q3Udh9BHztBspFmDm62osbpdPm
         hNmjniSGAl3FOgmoJF36V54SeKRvfC4y0pgAyfoH5GP4NO6Q6sHvWSlGMu9izGvNUAUL
         rmEQmi33dcyYne70PX79fBP9F6Qegioy+FOb5oyXFnAKiAhs2vPelTMs8+vnhZQgFYnE
         RoKTaaBba17yFU7qyrj2132XZsZo0rnT1g9+xDcLcCqDJZ8SyE/XZpVIteoEchR9kqWA
         ukapdkEsumExRj98RasqigOAh4FcWmKpCiExKXTTbbw0tFbgkQpcs/Qj6QVWdUJUskh4
         oUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3dQ6PTUBIGS+KwQyRlyF1SjNK/XkYnHi08EauzmhstQ=;
        b=BJMe9a3A3lik924SHXoswRxVwIhVHkv03naExLmwyD2YAmF/cGTYGiiE3Wf3Rh17wL
         7ibAoiDmpNQO+QOOZG79bQ0F6C8nQvNdPZ3aifnNfIO8S2huW0kwT9rA5RcT5UnqY+4o
         0mWJZ1Vjc9EhZYDCM6qsc7ClVlPS1EmdBI+SO0elJd6EQS+hLjVCIbVvv+8l8jf+GM2A
         NdtF3KZlInMWQS/ltGFhI4Ql5D/VGIKLXbKFhA1wya1ZCVAVT5HMC0d37wXSOMdSbyqb
         91qbNSJiqaeVBELJoDhslmQGVXFlRfpxWE8ujmsukPu9HgTBk121R/Q4UBtOv/QvjrnM
         QpDg==
X-Gm-Message-State: AHQUAuZdUhgHL7LtStdpatREh0z3l8Zx+cJZaiXM6C1soqdrEvkQ4MaG
        lzIw/uEcB2RUEnYKJNQXHTfcHUdexIM=
X-Google-Smtp-Source: AHgI3IY2e2zJzzJ1kvyatwljWGLAqUiE4Un3tc39zExi7iFlzzIziVDinHig03/X5YOaWA6s/YNtlw==
X-Received: by 2002:a63:f648:: with SMTP id u8mr28884574pgj.91.1550674025167;
        Wed, 20 Feb 2019 06:47:05 -0800 (PST)
Received: from dhcp-12-139.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 62sm23360807pgc.61.2019.02.20.06.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 06:47:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 22:46:54 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
Message-ID: <20190220144653.GJ10051@dhcp-12-139.nay.redhat.com>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
 <20190217164809.GA24091@kroah.com>
 <7978727a-eacc-779c-771f-f4c3013237f3@newmedia-net.de>
 <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
 <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:09:21PM +0200, Nikolay Aleksandrov wrote:
> On 20/02/2019 14:48, Sebastian Gottschall wrote:
> > *reminder*
> > 
> [snip]
> >>>>>    }
> >>>>>    static void br_ip4_multicast_query(struct net_bridge *br,
> >>> Is this also a problem in 4.20?  This patch went into 4.20-rc1, so it
> >>> has been around for a while with no reported issues that I can find.
> >>> Any pointers to the reports?
> >>
> >> i need to check this. i found this patch in 4.9, 4.14 and 4.4
> >> the rest was picked up from the mailinglist. according to the git sources of 4.20 and 5.0 the same code is in there as well
> >>
> >> i just got the report from users today and was able to reproduce it with iptv streams. just by disabling the code it was working again.
> >>
> >> Sebastian
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>>
> >>
> 
> Could you please include more details about the setup that's broken ?
> Note that we were warned[1] of potential breakage from this change

Sorry I missed Linus's reply after Ying Xu replied. I will read it and
disscuss with Ying Xu.

> after it went in and regardless of the suggestion from the RFC we'll
> probably have to revert this patch.
> 
> Ying Xu as author of the patch, any thoughts ?

No, we are also waiting for more details from Sebastian.

Thanks
Hangbin

> 
> Also adding Linus Lüssing to the CC as he was the one who warned against it.
> Note that the warning was sent as a reply to my breakage fix, but it was intended
> for the original patch.
> 
> Thanks,
>  Nik
> 
> [1] https://www.mail-archive.com/netdev@vger.kernel.org/msg272944.html
> 
