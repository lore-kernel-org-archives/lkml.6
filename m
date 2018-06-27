Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612CAC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9802658A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9802658A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeF0NhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:37:04 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:47064 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752898AbeF0NhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:37:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 58BDF181D32E0;
        Wed, 27 Jun 2018 13:37:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank86_5a2ed0527a406
X-Filterd-Recvd-Size: 2405
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jun 2018 13:36:59 +0000 (UTC)
Message-ID: <06bca9497a878d5f494fd97dbe2d8448caab9afd.camel@perches.com>
Subject: Re: [PATCH v2] staging: media: omap4iss: Added SPDX license
 identifiers
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Graefe <daniel.graefe@fau.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Roman Sommer <roman.sommer@fau.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date:   Wed, 27 Jun 2018 06:36:58 -0700
In-Reply-To: <20180627084013.ybnbxbgha77cdujn@mwanda>
References: <1529932892-9036-1-git-send-email-daniel.graefe@fau.de>
         <1530048656-4074-1-git-send-email-daniel.graefe@fau.de>
         <20180627084013.ybnbxbgha77cdujn@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 11:40 +0300, Dan Carpenter wrote:
> On Tue, Jun 26, 2018 at 11:30:56PM +0200, Daniel Graefe wrote:
> > Changes in v2:
> > - replaced "GPL-2.0-or-later" with "GPL-2.0+"
> 
> We should make checkpatch.pl complain when people use wrong tags like
> GPL-2.0-or-later.

I'd rather we use the latest version of the spdx forms.
https://lkml.org/lkml/2018/2/2/883
I think it's better to modify checkpatch when the kernel
uses the latest forms.

There is a separate script that validates the spdx forms.
./scripts/spdxcheck.py

That script, which still needs the patch below, would work
with either style.

https://patchwork.kernel.org/patch/10448573/

$ python ./scripts/spdxcheck.py 
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD

or for more verbose output

$ python ./scripts/spdxcheck.py -v
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD

License files:               14
Exception files:              1
License IDs                  19
Exception IDs                 1

Files checked:            60967
Lines checked:           646729
Files with SPDX:          17393
Files with errors:            1
