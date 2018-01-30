Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeA3KKx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:10:53 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:47764 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3KKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:10:50 -0500
Date: Tue, 30 Jan 2018 11:10:46 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Filip =?iso-8859-2?Q?Matijevi=E6?= <filip.matijevic.pz@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        bhumirks@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Message-ID: <20180130101046.GA16474@lenoch>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch>
 <20180130100023.GB18104@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180130100023.GB18104@amd>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:00:23AM +0100, Pavel Machek wrote:
> On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
> > On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijeviæ wrote:
> > > Hi,
> > > 
> 
> > > > Well, notice I'm converting existing driver to device tree. And that
> > > > one already has GPIO dependency. It is possible that more work needs
> > > > to be done there, but that should not be a reason to delay this. Feel
> > > > free to help.
> > 
> > Adding DT properties that need to be maintained for compatibility reasons
> > is a bad idea and very good reason to delay merging unfinished stuff.
> > And meanwhile it turned out it is not power-gpio :)
> 
> I believe reset-gpios and power-gpios are commonly used like
> this... and that's what the old code does.

Why do you care about old code when introducing new DT property?
Either it is reset, then lets call it reset-gpios or it is power supply
and then voltage regulator should be used (VAUX4.OUT is such a regulator
although it is unclear to me how it is controlled (*)).

> You are not helping.

The only way I can help here is to resend your patch with "reset-gpios"
used, which I'm pretty sure you can handle yourself.

(*) Remark "DAC33 enabled (for example, plug in a headset to the 3.5mm
AV connector and start music playback from the device)" in schematics
suggests it is controlled somehow.
