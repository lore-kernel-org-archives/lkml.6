Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9379F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547463096;
	bh=4G/3P5Rfla0KnmUAc/ZgdHU6a0UE3iWIenxQj5oe7t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mGUzak+BYGVT5+lTXGFaqrR/NMMRZJiBtJaA5+hZoU7JDCNFZoafiRdRJYs5IdeeD
	 iQTVopecbLqieyvXfd7izKid3KlnZX5kvCw8VjOCTgLv9maT3/plrYIqRu2GGrBPnj
	 aHDk8NFU0NqWPfH4NwZpeYSFVdM3l2+zUmNYiFLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfANKve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:51:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45464 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfANKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:51:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so18547305ljd.12;
        Mon, 14 Jan 2019 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I6O+HHr2wGw/vOzYej1U2m5fcAzlU2OSoavAio8ll9s=;
        b=S0tVGOSeuWuDu6SUk1g8jbf+WI2XyM2haf++XFXZAzttIjTpi6m1NkkEqXGBRwCim7
         E44g/CI317mpNHbxnBUezKMAwv2qNVgJwNackAnyfxSSv4JqwPW7HUWWx06J+suybEUL
         mWAHhfyIStTXFPsqAvVLvAhtGZB9debXjFMtPqVNCGCVODpUfCPmNPPdVYguPKTIa6+r
         u8c8DFShVYc0Tu1ejtwDok9bbNIbY7c7jnpZ9hVk/A4L8o7DbEBOyVCfwxRtgX5TSalT
         +chnSJYy84rF+QZbY4Co46fiuXpOEhg172oSeJKhqjXEzhh6LBJqMNyDjaCJgYRxaA8f
         lRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I6O+HHr2wGw/vOzYej1U2m5fcAzlU2OSoavAio8ll9s=;
        b=ijlPwtvHl+NdXzut7x3YWx/nKNck6i3cJZjKgtV8Hwb2su8rCxf75+lnAoz/WasiuL
         e/ivRWT0q98i3aG8xqwUecYr2lB4URYth+Pv7CsstpohuBzQvCAYbyLkZxOIlusbLwZd
         /9zD6dHIUKPHZo1Xb5h4DP+U8tGv9gxO+oJR18EPQ8dq2zT2x1Zwx1+tAHAkfY4KabsR
         7H0kIl9ebxrjVEFzp3Pozwn06qBXbNDaFei7giDtnpf6yyatExkewrnsDhpBJ3pQeD15
         sgaqPWzj7V8DeJD0GpUZXwBzf1BdQXke3dojzX2iJVf/4DMiMikkJOQlE0bp/vc8jk+t
         ZYww==
X-Gm-Message-State: AJcUukcf/iph19GFDAuwlCD9IfT7yv0GTGVNZ8jg0dg56BlvmreA5R47
        6jDxM2Kum6flpnGhVWF/N94=
X-Google-Smtp-Source: ALg8bN5BBhTc6yj7k6H1GfKbbvOEaIQOubs0J0fMxhHv764au1yK4e22nUkj01bmfzHmZslJ65dDhA==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr578947lji.145.1547463090513;
        Mon, 14 Jan 2019 02:51:30 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q3sm16643lff.42.2019.01.14.02.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:51:29 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gizq5-0000uR-5g; Mon, 14 Jan 2019 11:51:29 +0100
Date:   Mon, 14 Jan 2019 11:51:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190114105129.GE3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-3-andreas@kemnade.info>
 <20190110121038.GA9725@localhost>
 <20190110230223.18ecbd87@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110230223.18ecbd87@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:02:23PM +0100, Andreas Kemnade wrote:
> Hi Johan,
> 
> On Thu, 10 Jan 2019 13:10:38 +0100
> Johan Hovold <johan@kernel.org> wrote:

> > On Sun, Dec 09, 2018 at 08:51:47PM +0100, Andreas Kemnade wrote:

> > > Additionally it checks for the initial state of the device during
> > > probing to ensure it is off.  
> > 
> > Is this really needed? If so, it should probably go in a separate patch.
> > 
> Well, it is the main motivation for the new try of upstreaming this again.
> You know the loooong history...
> It has several times messed up my power consumption statistics. As I try
> to test patches on top of mainline, this has often led to false alarms
> regarding pm bugs in other drivers.
> 
> We could also come from another kernel here via kexec having the
> device in another state. 
> 
> And why we do not want to check for uncommon things here? We e.g. do
> multiple tries for changing power state. 

You still need to argue why it is needed (e.g. the kexec case) and that
needs to go in the commit message of a separate patch adding something
like that as it is orthogonal to supporting configurations without
wakeup.

This may also be better handled by a shutdown() callback which is where
such kexec concerns are supposed to be handled, and that would also take
care of the reboot case. This way, not everyone has to pay a penalty on
every boot for the arguable rare use case of kexec.

> > > Timeout values need to be increased, because the reaction on serial line
> > > is slower and are in line  with previous patches by  
> > 
> > I don't think this is an accurate description, but more on that below.
> > 
> I do not think so, but I do not have a too strong opinion here.
> 
> > > Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller <hns@goldelico.com>.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v2:
> > >  - style cleanup
> > >  - do not keep serdev open just because runtime is active,
> > >    only when needed (gnss device is opened or state is changed)
> > >  - clearer timeout semantics
> > > 
> > >  drivers/gnss/sirf.c | 114 +++++++++++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 91 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > > index ba663de1db49..c64369494afb 100644
> > > --- a/drivers/gnss/sirf.c
> > > +++ b/drivers/gnss/sirf.c
> > > @@ -23,8 +23,13 @@
> > >  
> > >  #define SIRF_BOOT_DELAY			500
> > >  #define SIRF_ON_OFF_PULSE_TIME		100
> > > +/* activate till reaction of wakeup pin */
> > >  #define SIRF_ACTIVATE_TIMEOUT		200
> > > +/* activate till reception of data */
> > > +#define SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT	1000
> > >  #define SIRF_HIBERNATE_TIMEOUT		200
> > > +/* If no data arrives for this time, we expect the chip to be off. */
> > > +#define SIRF_MIN_SILENCE	1000  
> > 
> > You only need to add one new define for the no-wakeup case and it should
> > reflect the report cycle (e.g. name it SIRF_NOWAKEUP_REPORT_CYCLE).
> > Specifically, it is the time we must wait in order to infer that a
> > device has failed to be activated, or succeeded to hibernate.
> > 
> GPS chips will have usually some boot messages. So it is not the
> "send nmea data set every X seconds" for the wakeup case, it is
> another situation deserving IMHO another name.

Ok, but unless all supported (sirf-star-based) chips have boot messages,
we'd still need to wait that long for wakeup.

Are these messages you refer to output also on wake from hibernate, and
not just on boot?

> > In pseudo code we have:
> > 
> >   activate:
> >    - toggle on-off
> >    - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
> >      - reception: success 
> 
> Note: we can also get the goodbye/shutdown message from the chip here
> so there are chances of a false success, but since we initially power down,
> we will rule out wrong state here.

Good point. Unless we know the current state, we'd need to sleep for
HIBERNATE_TIMEOUT before waiting for data reception.

> >      - timeout: failure
> > 
> >   hibernate:
> >    - toggle on-off
> >    - sleep(HIBERNATE_TIMEOUT)
> we could also additionally check here for 
>    if (last_bytes_received == GOODBYE_MSG)

Caching and parsing the stream for this could get messy. And is the
expected message clearly defined somewhere, or would it be device (and
firmware) dependent?

> or alternatively check for
>    if (!BOOTUP_MSG_RECEIVED)
>      - return success

This seems to suggest the only thing you worry about is the drivers idea
of the current state being out of sync (which could be addressed
differently and only once at probe) and not hibernation failing for some
other reason. And you'd still need to wait for ACTIVATION_TIMEOUT (as
well as allow the chip time to actually suspend).

> >    - wait(data-received, REPORT_CYCLE)
> >      - reception: failure
> >      - timeout: success
> > 
> > A problem with your implementation, is that you assume a report cycle
> > of one second, but this need to be the case. Judging from a quick look
> > at the sirf protocols (sirf nmea and sirf binary) report cycles can be
> > configured to be as long as 30s (sirf binary) or even 255s (sirf nmea).
> > [ To make things worse these numbers can be even higher in some
> > low-power modes it seems. ]
> > 
> As far as I see we will only might have a problem if 
>   - those settings are nonvolatile (or we come in with those
>     settings on another way)
>   - or a state change lateron fails which we cannot properly detect

So again, you only worry about getting the initial state right?

Otherwise, lowering the message rate would at runtime would affect all
state changes (as currently implemented), regardless of whether these
changes are stored in NVRAM or not.

But re-reading your reply above, I guess that's what you mean by your
second point.

> > Adding just a one-second timeout (the minimum supported cycle length)
> > seems way too low, even if whatever value we choose will be reflected
> > directly in the time it takes to hibernate (suspend) the device.
> > 
> > And since this is configurable at runtime, the only safe value would be
> > the maximum one...
> > 
> > Perhaps we can say that no-wakeup support depends on having reasonably
> > short report cycles, but this needs to be documented.
> > 
> Where should it be documented? Comment in code?
> devicetree bindings?

Commit message and code at least (not devicetree binding).

> So in general I see these possibilities:
> 1. just document tho problem with low cycle length requirement
>    lateron we might improve the solution
> 
> 2. do the data parsing like above just for the first or/and last bytes
>    if these things really come reliable, we would catch the low-power
>    corner cases like only data reports if you move around.
>    I have to do some research here.
>
> 3. monitor serial output in off state and send a pulse if data arrives
>   this would require the serial device to do aggressive power saving
>   in that time(you send an example patch for that) or giving a gpio interrupt
>   coming from the rx line to the gnss driver.
>   Those things look like more restructuring work (or having a separate driver
>   which is not that practical for further extensions) and would not
>   catch low-power modes

It would also be relying the serial driver to actually support
aggressive PM (e.g. currently only usable on OMAP).

> My personal opinion here is first 1.  later improve to 2. (and do some
> more tests in regards of 2.)

Yeah, I'd guess this is a fairly unusual configuration, so we shouldn't
overdo this, and option 1 is fine with me too. I just want to make sure
that the underlying assumptions are understood and spelled out.

Thanks,
Johan
