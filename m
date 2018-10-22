Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECE8C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AF620645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AF620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeJWD2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:28:03 -0400
Received: from vie01a-dmta-pe05-2.mx.upcmail.net ([84.116.36.12]:47246 "EHLO
        vie01a-dmta-pe05-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbeJWD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:28:03 -0400
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gEfYl-0008IP-LB
        for linux-kernel@vger.kernel.org; Mon, 22 Oct 2018 21:08:15 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id EfYkgbHWckosQEfYkgxBem; Mon, 22 Oct 2018 21:08:15 +0200
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=NEAV23lmAAAA:8 a=8qEL3EHZ_qRsqNYWS68A:9
 a=CjuIK1q_8ugA:10
Received: from ubuntu (unknown [77.75.241.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 3FB214E607;
        Mon, 22 Oct 2018 20:08:13 +0100 (IST)
Date:   Mon, 22 Oct 2018 20:08:05 +0100
From:   Mike Brady <mikebrady@eircom.net>
To:     Kirill Marinushkin <k.marinushkin@gmail.com>
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com, tiwai@suse.de,
        nishka.dasgupta_ug18@ashoka.edu.in, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-audio: interpolate audio delay
Message-ID: <20181022190805.GA4551@ubuntu>
References: <20181018105715.GA6660@ubuntu>
 <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22867d63-12f1-31f7-acb6-ce9a58fcbe71@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfJJZWw9FAjzl+7NGOTcdt3LE6/9qqDY2xjzKNK8mS3wGYwPwixiLqfT0cDP/O8fGNIH5ol6jlaFnluY8p0x5Xp/ZcajVMotGq5p9bRjcjO0kb35cWUmG
 Vro0+dBtoO87coSuW2bJAKfw6tKiSR7CktuCwezToIDUf8kskb6cS/7OVlveaJf9zvZ6LUfMejuQ1C96OzM8qdgD8jmFMWUKDuCxskYjQw8DsQZGus17W9qM
 Dm/g3B/2CyupXkaV9LGC2ZiXMku/NdT3mgNa+6gfNWbW5nEmYNH0SFs07TP9UHdR9gAzJiyal83TNXT4nnlSU/2FIiU1HKELF+ns3rEFePHd49h3XcgwEy5r
 rXRMlL/7SYCI4BSbF0NQ5XWipksMhgeqIPhicAwhW+DbWAzyJXFJ4ZH56aL/nSrXfCt08xlSPt7Q8jo24eJNm8W00IPp+w4AFRaEb1QruesfOky0Lji/3hIf
 t73H+kGTE/AruHk3Ipfbr3oVINC5Pnraio5XKsWzS+eC8W0rsAKDA8vFfl3wp2+IuxOeYe1el6i9OfBoqHrdHMJizYrx2GrtMwcfCwJdwf80t0R3AFlihgnB
 WOMn3YtzHefC7LW+8Gajdb/A
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill.

The problem that this patch seeks to resolve is that when userland asks for the
delay -- the time to hear -- the driver responds with a figure that is only updated
when a GPU interrupt occurs, now approximately every 10 milliseconds.

As far as I am aware, there is no way to get a more up-to-date delay number on request,
hence the present patch to interpolate based on the time of the last update, the time of
the request and the nominal frame rate.

It does have the drawback of relying on the accuracy of the CPU clock and on the
nominal rate but on reasonable assumptions, it will not be in error over
the approximately 10 ms interval.

As you'll probably know, this is the built-in DAC in the full-sized Raspberry Pi devices and
is widely used. As a developer of Shairport Sync, I have noticed that the "slop" in
delay on the Pi's built-in DAC is very large by comparison with other DACs. FYI, there is
a discussion of the effects of a downstream equivalent of this suggested patch at:
https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016.

Best wishes
Mike

On Thu, Oct 18, 2018 at 09:48:36PM +0200, Kirill Marinushkin wrote:
> Hello Mike,
> 
> On 10/18/18 12:57, Mike Brady wrote:
> > +	ktime_t now = ktime_get();
> > +
> > +	/* Give userspace better delay reporting by interpolating between GPU
> > +	 * notifications, assuming audio speed is close enough to the clock
> > +	 * used for ktime
> > +	 */
> > +
> > +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
> > +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
> > +		u64 interval =
> > +			(ktime_to_ns(ktime_sub(now,
> > +				alsa_stream->interpolate_start)));
> > +		u64 frames_output_in_interval =
> > +			div_u64((interval * runtime->rate), 1000000000);
> > +		snd_pcm_sframes_t frames_output_in_interval_sized =
> > +			-frames_output_in_interval;
> > +		runtime->delay = frames_output_in_interval_sized;
> > +	}
> 
> This doesn't look like a good solution for me. More like a workaround. What is
> the root cause of the delay?
> 
> Best Regards,
> Kirill
