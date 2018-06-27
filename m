Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF1C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517E24718
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517E24718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965868AbeF0SaL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:30:11 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:36774 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbeF0SaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:30:10 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id EFD181A403CC; Wed, 27 Jun 2018 11:30:09 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:30:09 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [REGRESSION] 4.18-rc2: X61s thinkpad display unusable after
 xlock & lid close
Message-ID: <20180627183009.vqlp4kto7erqdspb@shells.gnugeneration.com>
References: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
 <20180627141839.GE20518@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627141839.GE20518@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:18:39PM +0300, Ville Syrjälä wrote:
> On Tue, Jun 26, 2018 at 05:05:48PM -0700, Vito Caputo wrote:
> > Hello,
> > 
> > Beginning with 4.18, when I lock my X server using the `xlock` command,
> > and close the lid, upon reopening the lid I am not presented with the
> > xlock UI.
> > 
> > The system is not hung.  If I blindly enter the password, I get an
> > intact and functional pointer but none of the desktop is displayed.  I
> > can move the pointer, and cycling window focus generates some random
> > noise occasionally, but it's all nonsensical.  No windows are
> > discernable, it's just blackness with ephemeral noise on window cycles,
> > and a movable pointer.
> > 
> > The system does not suspend on lid close, with "HandleLidSwitch=ignore"
> > in logind.conf.  So this is a bit odd, since I don't observe this when I
> > just run `xlock` but don't close/open the lid before unlocking.
> > 
> > This is on Debian 9.4 amd64, the hardware is a 1.8Ghz X61s ThinkPad,
> > kernel config attached.  I'm using the modesetting Xorg driver on i915
> > KMS.
> 
> Ah, a Thinkpad with lid notifier. Now were getting somewhere :)
> 
> Can you pls test the stuff I listed here
> https://bugs.freedesktop.org/show_bug.cgi?id=105902#c5 ?
> 

Cherry-picking 8860e829faad on top of v4.18-rc2 seems to have fixed the
problem here.

Unfortunately I'm short on time currently to perform a bisect in the
interests of identifying the lid notification-breaking commit between
4.17 and 4.18.

Thanks,
Vito Caputo
