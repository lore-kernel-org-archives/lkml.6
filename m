Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8360F25F70
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8360F25F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeF0Qmx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:42:53 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:33994 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965580AbeF0Qmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:42:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2DA791801C5D2;
        Wed, 27 Jun 2018 16:42:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: angle37_6fe7688fe155d
X-Filterd-Recvd-Size: 2677
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jun 2018 16:42:48 +0000 (UTC)
Message-ID: <38f16dbee8612fc9c8115177079adeb8981276a6.camel@perches.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jun 2018 09:42:47 -0700
In-Reply-To: <CAHp75VeEUFEn5zih+2hntU7GCxx7U5rW60DMjRBRNo2EXhSdpw@mail.gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
         <20180626081409.9518-3-straube.linux@gmail.com>
         <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
         <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
         <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
         <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
         <20180627083306.rk3niwazi332rqs5@mwanda>
         <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com>
         <20180627131158.xttl27awxie2w6ia@mwanda>
         <CAHp75VeEUFEn5zih+2hntU7GCxx7U5rW60DMjRBRNo2EXhSdpw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 19:14 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 4:11 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Wed, Jun 27, 2018 at 02:56:00PM +0200, Michael Straube wrote:
> > > Should I add a thanks line to the commit message:
> > > 
> > >     Thanks to Dan Carpenter, Joe Perches and Andy Shevchenko.
> > > 
> > > Or would that be considered as too much?
> > 
> > You can write whatever the heck you want...  :P  No one cares.

I hope that's true.

> > When it comes to credit, I do appreciate Reported-by tags because LWN
> > and employers do count those sometimes.

Which is likely as useful as judging engineer
productivity by LOC counts.

> In some cases Suggested-by fits better.

True, but meh.

I think all the Suggested-by, Reported-by,
Co-developed-by and such are mostly unnecessary.

Who really cares for anything other than
signed-off-by, acked-by, tested-by, and
maybe reviewed-by ?

Maybe the kernel should add a signature for
"Co-authored-by:" instead of "Co-developed-by:"

Perhaps another option would be to extend
the git commit "Author:" attribute to allow
multiple names and addresses.

