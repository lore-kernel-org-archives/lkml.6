Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72227C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3A21736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="M/lYG71s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3A21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHHB3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:29:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39814 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeHHB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:29:30 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88FCC57;
        Wed,  8 Aug 2018 01:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533683568;
        bh=5GryEQzxl+KIVepX0826eELusa0DuSAi5e61v/9ehV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/lYG71slI7zvR3dMdySR4T0J3O18KcyxaAajG9Bp4RGF8920TfIHmJpm0dUzOqgX
         Hcz13dLXRgtP+m2O2qplat6oEPcAAOYNAVy6+NVZSrhWNbM5uNJefmJ+WQ9qGIiuCU
         p3OrPjI4ikt7ml7x99V41PiCkKkxTFyZ8VndWTUA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@google.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        g.liakhovetski@gmx.de, olivier.braun@stereolabs.com,
        troy.kisky@boundarydevices.com,
        Randy Dunlap <rdunlap@infradead.org>, philipp.zabel@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Move decode processing to process context
Date:   Wed, 08 Aug 2018 02:13:31 +0300
Message-ID: <15196240.O2E9MK7q6s@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com>
References: <cover.3cb9065dabdf5d455da508fb4109201e626d5ee7.1522168131.git-series.kieran.bingham@ideasonboard.com> <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com> <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Tuesday, 7 August 2018 12:54:02 EEST Tomasz Figa wrote:
> On Wed, Mar 28, 2018 at 1:47 AM Kieran Bingham wrote:

[snip]

> In our testing, this function ends up being called twice

In your testing, has this patch series brought noticeable performance 
improvements ? Is there a particular reason you tested it, beside general 
support of UVC devices in ChromeOS ?

[snip]

-- 
Regards,

Laurent Pinchart



