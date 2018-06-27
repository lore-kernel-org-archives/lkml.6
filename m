Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3631CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1324238
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C1324238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965110AbeF0OSp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:18:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:28227 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932579AbeF0OSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:18:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 07:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="50342542"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 27 Jun 2018 07:18:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 27 Jun 2018 17:18:39 +0300
Date:   Wed, 27 Jun 2018 17:18:39 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [REGRESSION] 4.18-rc2: X61s thinkpad display unusable after
 xlock & lid close
Message-ID: <20180627141839.GE20518@intel.com>
References: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:05:48PM -0700, Vito Caputo wrote:
> Hello,
> 
> Beginning with 4.18, when I lock my X server using the `xlock` command,
> and close the lid, upon reopening the lid I am not presented with the
> xlock UI.
> 
> The system is not hung.  If I blindly enter the password, I get an
> intact and functional pointer but none of the desktop is displayed.  I
> can move the pointer, and cycling window focus generates some random
> noise occasionally, but it's all nonsensical.  No windows are
> discernable, it's just blackness with ephemeral noise on window cycles,
> and a movable pointer.
> 
> The system does not suspend on lid close, with "HandleLidSwitch=ignore"
> in logind.conf.  So this is a bit odd, since I don't observe this when I
> just run `xlock` but don't close/open the lid before unlocking.
> 
> This is on Debian 9.4 amd64, the hardware is a 1.8Ghz X61s ThinkPad,
> kernel config attached.  I'm using the modesetting Xorg driver on i915
> KMS.

Ah, a Thinkpad with lid notifier. Now were getting somewhere :)

Can you pls test the stuff I listed here
https://bugs.freedesktop.org/show_bug.cgi?id=105902#c5 ?

-- 
Ville Syrjälä
Intel
