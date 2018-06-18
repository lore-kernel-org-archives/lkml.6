Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA79C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EECC208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EECC208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934053AbeFRLom (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933381AbeFRLok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:44:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19705AC71;
        Mon, 18 Jun 2018 11:44:39 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 59FD5A1080; Mon, 18 Jun 2018 13:44:38 +0200 (CEST)
Date:   Mon, 18 Jun 2018 13:44:38 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Aaron Brown <aaron.f.brown@intel.com>
Subject: Re: [PATCH] net: fix e100.rst Documentation build errors
Message-ID: <20180618114438.7ojkon6jayabcxei@unicorn.suse.cz>
References: <72f13386-c484-3eed-c363-a5b667aea2e6@infradead.org>
 <87efh4y0yk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efh4y0yk.fsf@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:04:51AM +0300, Jani Nikula wrote:
> On Sat, 16 Jun 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix Documentation build errors in e100.rst.  Several section titles
> > and the corresponding underlines should not be indented.
> 
> Really the content blocks below the titles should not be indented
> either. It's not an error, but the end result is probably not what you
> want.

Also the indentation of this part:

> Rx Descriptors: Number of receive descriptors. A receive descriptor is a data
>    structure that describes a receive buffer and its attributes to the network
>    controller. The data in the descriptor is used by the controller to write
>    data from the controller to host memory. In the 3.x.x driver the valid range
>    for this parameter is 64-256. The default value is 256. This parameter can be
>    changed using the command::
> 
>    ethtool -G eth? rx n
> 
>    Where n is the number of desired Rx descriptors.
> 
> Tx Descriptors: Number of transmit descriptors. A transmit descriptor is a data
>    structure that describes a transmit buffer and its attributes to the network
>    controller. The data in the descriptor is used by the controller to read
>    data from the host memory to the controller. In the 3.x.x driver the valid
>    range for this parameter is 64-256. The default value is 128. This parameter
>    can be changed using the command::
> 
>    ethtool -G eth? tx n
> 
>    Where n is the number of desired Tx descriptors.
> 
> Speed/Duplex: The driver auto-negotiates the link speed and duplex settings by
>    default. The ethtool utility can be used as follows to force speed/duplex.::
> 
>    ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
> 
>    NOTE: setting the speed/duplex to incorrect values will cause the link to
>    fail.
> 
> Event Log Message Level:  The driver uses the message level flag to log events
>    to syslog. The message level can be set at driver load time. It can also be
>    set using the command::
> 
>    ethtool -s eth? msglvl n

causes

.../Documentation/networking/e100.rst:56: WARNING: Literal block expected; none found.
.../Documentation/networking/e100.rst:67: WARNING: Literal block expected; none found.
.../Documentation/networking/e100.rst:74: WARNING: Literal block expected; none found.
.../Documentation/networking/e100.rst:83: WARNING: Literal block expected; none found.

as the literal block has the same indentation as preceding paragraph
(except for the first line).

Michal Kubecek
