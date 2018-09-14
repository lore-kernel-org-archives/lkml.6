Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECFF20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECFF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeINPI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:08:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:9123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINPI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:08:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 02:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="89998192"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2018 02:54:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 14 Sep 2018 12:54:40 +0300
Date:   Fri, 14 Sep 2018 12:54:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] typec: tcpm: Do not disconnect link for self powered
 devices
Message-ID: <20180914095440.GF19329@kuha.fi.intel.com>
References: <20180913021113.18150-1-badhri@google.com>
 <20180913132408.GC19329@kuha.fi.intel.com>
 <20180913175108.GA11749@roeck-us.net>
 <CAPTae5JVv0F_9mrXSTxmB2n9A9fJvcakwC0AKV6GbB+6Y79rGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5JVv0F_9mrXSTxmB2n9A9fJvcakwC0AKV6GbB+6Y79rGg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 13, 2018 at 04:16:08PM -0700, Badhri Jagan Sridharan wrote:
> > > You do need to introduce a new device property already. Then read the
> 
> This would be part of usb-connector binding. right ?

Yes, that is probable the correct place for that. It's not tcpm/tcpci
specific.

But I don't think it's Type-C specific either. Perhaps it should
go under "Optional Properties" instead of "Optional properties for
usb-c-connector"?


Thanks,

-- 
heikki
