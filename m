Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12C2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB12C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeIESFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:05:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:58279 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeIESFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:05:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 06:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="70770864"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 05 Sep 2018 06:34:51 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Sep 2018 16:34:50 +0300
Date:   Wed, 5 Sep 2018 16:34:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     whitequark <whitequark@whitequark.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: USB type-C altmode support for UCSI
Message-ID: <20180905133450.GM2283@lahna.fi.intel.com>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905132429.GB25121@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:24:29PM +0300, Heikki Krogerus wrote:
> +Mika, Mario, LKML
> 
> On Mon, Sep 03, 2018 at 02:17:46PM +0000, whitequark wrote:
> > After looking through LKML, I've seen that people refer to you when
> > discussing issues with USB-C device compatibility. Do you think you
> > could help me with an Apple Thunderbolt 2 to 3 adapter? I've spent
> > quite a while studying USB-C, reverse engineering platform and
> > adapter firmware and so on, and I'm quite stumped.
> > 
> > I have a Dell XPS13 laptop. UCSI advertises port altmodes
> > 8087:00000001, ff01:00001c46, 413c:00000001, in that order.
> > When I plug in the adapter, UCSI advertises partner altmode
> > 8087:00000001. A billboard class device enumerates. Nothing else
> > happens; the Thunderbolt NHI device doesn't appear, and if I force
> > it to appear via the WMI hook, there are no Thunderbolt events,
> > and the only device on the Thunderbolt bus is the root switch.

Some Dell XPS systems do not support that TBT2<->TBT3 adapter. I think I
tried this on XPS 15 9550 and XPS 13 9365 and in both cases it is
rejected. I think it has something to do with the PD controller
firmware. Same goes if you Plug TB16 dock and to that dock then connect
the adapter + device.

Mario probably has more input about this one.
