Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5849C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FC920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FC920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeG3QMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:12:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbeG3QMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:12:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E0FBAD08;
        Mon, 30 Jul 2018 14:37:17 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 73E3FA0BE8; Mon, 30 Jul 2018 16:37:14 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:37:14 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 09/17] ethtool: implement GET_DRVINFO
 message
Message-ID: <20180730143714.tlvze2xas2kk7zqo@unicorn.suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
 <20180730132107.GB10626@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730132107.GB10626@nanopsycho>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:21:07PM +0200, Jiri Pirko wrote:
> Mon, Jul 30, 2018 at 02:53:27PM CEST, mkubecek@suse.cz wrote:
> 
> [...]
> 
> >+/* GET_DRVINFO / SET_DRVINFO */
> >+
> >+enum {
> >+	ETHA_DRVINFO_UNSPEC,
> >+	ETHA_DRVINFO_DEV,			/* nest - ETHA_DEV_* */
> >+	ETHA_DRVINFO_DRIVER,			/* string */
> >+	ETHA_DRVINFO_VERSION,			/* string */
> >+	ETHA_DRVINFO_FWVERSION,			/* string */
> >+	ETHA_DRVINFO_BUSINFO,			/* string */
> >+	ETHA_DRVINFO_EROM_VER,			/* string */
> >+	ETHA_DRVINFO_N_PRIV_FLAGS,		/* u32 */
> >+	ETHA_DRVINFO_N_STATS,			/* u32 */
> >+	ETHA_DRVINFO_TESTINFO_LEN,		/* u32 */
> >+	ETHA_DRVINFO_EEDUMP_LEN,		/* u32 */
> >+	ETHA_DRVINFO_REGDUMP_LEN,		/* u32 */
> 
> This is a nice example of why 1:1 ioctl->netlink conversion would be
> a big mistake.
> 
> I understand that for ioclt, getting lengths of various things is
> important. Userspace can prepare buffer for next ioctl which would
> actually do dump transfer. However in netlink, this is totally pointless
> as the dump goes into userspace in multiple netlink messages.

Right, I already mentioned this in the ToDo part of cover letter. It
makes indeed little sense to put this information here - and even less
to put only dome of the counts and lengths.

Michal Kubecek
