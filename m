Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD5C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C52172D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859C52172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGGLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:10:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:32335 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeGGLKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:10:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 04:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,320,1526367600"; 
   d="scan'208";a="62942963"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 07 Jul 2018 04:09:52 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 07 Jul 2018 14:09:51 +0300
Date:   Sat, 7 Jul 2018 14:09:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nathan.d.ciobanu@linux.intel.com, linux-kernel@vger.kernel.org,
        michael.jamet@intel.com, andreas.noever@gmail.com
Subject: Re: [PATCH] thunderbolt: fix small typo in variable name
Message-ID: <20180707110951.GL2534@lahna.fi.intel.com>
References: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
 <20180707081950.GA6660@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707081950.GA6660@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 10:19:50AM +0200, Lukas Wunner wrote:
> On Tue, Jun 26, 2018 at 04:34:20PM -0700, nathan.d.ciobanu@linux.intel.com wrot> Fixes small variable name typo and the associated
> > checkpatch spelling warning
> > 
> > Signed-off-by: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>
> > ---
> >  drivers/thunderbolt/tb_regs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> > index 5d94142afda6..693b0353c3fe 100644
> > --- a/drivers/thunderbolt/tb_regs.h
> > +++ b/drivers/thunderbolt/tb_regs.h
> > @@ -202,7 +202,7 @@ struct tb_regs_port_header {
> >  	/* DWORD 5 */
> >  	u32 max_in_hop_id:11;
> >  	u32 max_out_hop_id:11;
> > -	u32 __unkown4:10;
> > +	u32 __unknown4:10;
> >  	/* DWORD 6 */
> >  	u32 __unknown5;
> >  	/* DWORD 7 */
> 
> This is not an improvement.  The bitfield is marked unknown because
> its meaning hasn't been reverse-engineered yet.  But you work for
> Intel, presumably you don't have to reverse-engineer the bitfield's
> meaning because you know it or can find out about it.
> 
> So please submit a patch that changes the name to the bitfield's
> actual meaning.

It is an improvement since it fixes what it says (the typo). Besides the
patch is already applied.
