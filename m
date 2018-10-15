Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE7C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8884205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8884205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeJOJid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:38:33 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:40489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbeJOJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:38:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0BD57100E806B;
        Mon, 15 Oct 2018 01:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest56_4cb72aaaa3b19
X-Filterd-Recvd-Size: 2553
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Oct 2018 01:55:27 +0000 (UTC)
Message-ID: <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From:   Joe Perches <joe@perches.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Date:   Sun, 14 Oct 2018 18:55:25 -0700
In-Reply-To: <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
         <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
         <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
         <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
> On 10/14/18 18:06, Joe Perches wrote:
> > On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
> > > From: Frank Rowand <frank.rowand@sony.com>
> > > 
> > > Add test case of two fragments updating the same property.  After
> > > adding the test case, the system hangs at end of boot, after
> > > after slub stack dumps from kfree() in crypto modprobe code.
[]
> > I think this is worse performance than before.
> > 
> > This now walks all entries when before it would
> > return -EINVAL directly when it found a match.
> 
> Yes, it is worse performance, but that is OK.
> 
> This is a check that is done when a devicetree overlay is applied.
> If an error occurs then that means that the overlay was incorrectly
> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> in this patch provides an example of how a bad overlay can be created.
> 
> Once an error was detected, the check could return immediately, or it
> could continue to give a complete list of detected errors.  I chose to
> give the complete list of detected errors.

Swell.  Please describe that in the commit message.


