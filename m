Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036620BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeGPKNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:13:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41424 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeGPKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:13:24 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 6ed516ad50d648e0; Mon, 16 Jul 2018 11:46:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        pascal paillet <p.paillet@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] base: core: Remove WARN_ON from link dependencies check
Date:   Mon, 16 Jul 2018 11:45:11 +0200
Message-ID: <2043787.xsU0OtZjGC@aspire.rjw.lan>
In-Reply-To: <CA+M3ks5nj2gfc+ePYg1y2w3P0cW861YkRqpuHh49n+noktPVUQ@mail.gmail.com>
References: <20180712080623.21203-1-benjamin.gaignard@st.com> <20180712085501.GA25313@kroah.com> <CA+M3ks5nj2gfc+ePYg1y2w3P0cW861YkRqpuHh49n+noktPVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 12, 2018 11:18:26 AM CEST Benjamin Gaignard wrote:
> 2018-07-12 10:55 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:
> > On Thu, Jul 12, 2018 at 10:06:23AM +0200, Benjamin Gaignard wrote:
> >> In some cases the link between between customer and supplier
> >> already exist. Do not warn about already existing dependencies
> >> because device_link_add() take care of this case.
> >
> > Why would a link already exist that is asked to be created again?  What
> > code path causes this?
> 
> It could happen that the link exist because a device use it parent as supplier.
> That case has been describe by Marek in this thread (I forgot to add
> it in the commit message, sorry):
> https://lkml.org/lkml/2018/7/9/356

So please add this information to the patch changelog and resend.

Thanks,
Rafael

