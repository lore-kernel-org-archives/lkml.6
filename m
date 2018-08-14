Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDA921741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDA921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeHNH0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:26:33 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:33129 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730698AbeHNH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:26:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E81BD182CED2A;
        Tue, 14 Aug 2018 04:41:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steel97_613a2a7eef721
X-Filterd-Recvd-Size: 1451
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 04:41:08 +0000 (UTC)
Message-ID: <a5899fe3c616db608d45303e9ac4563df6546333.camel@perches.com>
Subject: Re: [PATCH 6/9] platform: goldfish: pipe: Fail compilation if
 structs are too large
From:   Joe Perches <joe@perches.com>
To:     Roman Kiryanov <rkir@google.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Date:   Mon, 13 Aug 2018 21:41:06 -0700
In-Reply-To: <CAOGAQerZ9D2gs+dmv5VKH_0GZQvnGY=juQLQa3qQ-cEm4qn1tQ@mail.gmail.com>
References: <20180813233839.190855-1-rkir@google.com>
         <20180813233839.190855-6-rkir@google.com>
         <a7a81091a1856bcd2ec7dd6a17270dd999058475.camel@perches.com>
         <CAOGAQerZ9D2gs+dmv5VKH_0GZQvnGY=juQLQa3qQ-cEm4qn1tQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 20:47 -0700, Roman Kiryanov wrote:
> Hi,
> 
> thank you for reviewing my patches. I decided to put BUILD_BUG_ON
> close to places where it is important that these structs fit into a
> memory page to give some context.

And you make the reader figure out what type dev->buffers is
unnecessarily when sizeof(struct goldfish_pipe_dev_buffers)
is pretty obvious.

> Regards,
> Roman.

cheers, Joe

