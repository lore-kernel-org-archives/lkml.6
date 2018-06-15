Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7950C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D3A208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D3A208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965480AbeFOClo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:41:44 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:41306 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965072AbeFOCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:41:43 -0400
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id TeLlfIxzF6gX8TegIfEpOK; Fri, 15 Jun 2018 02:41:42 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-03v.sys.comcast.net with ESMTPA
        id TegFfV1Mobew8TegHfutEC; Fri, 15 Jun 2018 02:41:42 +0000
Date:   Thu, 14 Jun 2018 19:41:38 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        roy_lee@edge-core.com, rick_burchett@edge-core.com,
        quentin.chang@quantatw.com, jonathan.tsai@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Xin Liu <xinxliu@microsoft.com>, steve.joiner@finisar.com
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180615024138.oervj67t4zgt6icm@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <CAK8P3a2aPshgrAp6=e62mvEpmmLYCAwRa_HxG_A1YKJ5we5XVQ@mail.gmail.com>
 <20180614004044.jjz3ws3zyns7x4x6@thebollingers.org>
 <CAK8P3a1Ke5OER=UFQfoTLppM-4MNWfCmkdWDz_TyWTzbX3WWvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Ke5OER=UFQfoTLppM-4MNWfCmkdWDz_TyWTzbX3WWvw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfHPL9m7EWh62Ayu4f2p6qhkzzdvs76fb28Djr4SxkwzWiNoDKQCx2a4/hv52YPmmErRzAhDludguevp3QpU/R2wA6lF6tSdyOtmlzSO5KbaICgdDjefE
 PUYVin13iykXWgseBk3gROgjqmYw2ZV6/NTY0D6dcyHXNjjKbwb4Ri+LXxLWYg+oOv4mInbLSDOBcHDyk1W9Ha5uqL6Sh4AMxXd7Q6RvF/jj/zei3yRPw4Mt
 Aha3NU7bMEMHZP5sUkwpF0tktCCtJ7VLy8iXvoNIBfkaQbNsndpKDBugKP3SFAvFcP5B+49HeBsRohAJDK4dxYQ+b7SY1buzeKliIO3io2IzeZC8g3DixwGa
 GCHU0Kub6oFcNNZ+YwjnX+uBrVpxRuV/vXzkT09BzNqvtg3oVo1ZE3J7B8ZnGimcGps3IPmWCLDOZXL3g0FWMsxwyuPD2jt0X5PuLNu0Zwk3fc0gQX+Ij10V
 f+dy4aMJCf4weXV3os1vcBcECXWsUAbvBjk8GM+YfMvv/cFV7Vyb54hGQsItUpCkgBnYsWYyHqdhWCtJMPl2OCZB/rkouTMgxaPW6XCfe5XFgbXqTgH8B7lZ
 Ty8vLXuzQ89hMZSv+QXbCgQ3WKFEovDdjewjocgmB8FMdl26Wk6EuH2lPEc5Bkzm6p0NFZrTsPi/waN4IvW1569qYEAoGbzZWuCHOnz1UjJ6Ln0qQCAONytK
 b2pdyh+nPvoMrSNaq7vV+un5IflWyEqx0Uq7D979Fz8LBrQjdCxUTRB6LG+IZzfpiZk6gquYzBi6GGAaS0oIw0XCuO8MNpB0xk5PsnQV8rDRc3y9JIaYfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:46:36AM +0200, Arnd Bergmann wrote:
> On Thu, Jun 14, 2018 at 2:40 AM, Don Bollinger <don@thebollingers.org> wrote:
> > On Mon, Jun 11, 2018 at 03:43:02PM +0200, Arnd Bergmann wrote:
> >> On Mon, Jun 11, 2018 at 6:25 AM, Don Bollinger <don@thebollingers.org> wrote:
> 
> >>
> >> I don't understand this part: I see some older patches introducing an
> >> EEPROM_CLASS, but nothing ever seems to have made it into the
> >> mainline kernel.
> >>
> >> If that class isn't there, this code shouldn't be either. You can always
> >> add it back in case we decide to introduce that class later, but then
> >> I wouldn't make it a compile-time option but just a hard dependency
> >> instead.
> >
> > Thanks for the feedback.
> >
> > Some background will explain how optoe got here...
> 
> Ok, I see. For the upstream submission of course, none of the forked
> kernel code bases matter at all, what we want is a driver that makes
> sense by itself, and none of it should depend on any third party code.

Got it.

> For traditional devices, we would use a header in
> include/linux/platform_data/, but a more modern way of doing this
> would be to use named device properties that are either put
> in the devicetree file (on embedded machines) or added through
> the .properties field when statically declaring an i2c device from
> a PCI device parent.
> 
>       Arnd

Thanks for the guidance.  It turns out that getting into mainline makes
it easier for my partners to consume a header in
include/linux/platform_data.  I'll restore that file and remove all of the
unnecessary items, which should address the concerns you have raised.  

Rev 2 coming soon.

Don
