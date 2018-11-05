Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C60C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B6720827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B6720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeKFBRf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:17:35 -0500
Received: from vie01a-dmta-pe07-1.mx.upcmail.net ([84.116.36.17]:27490 "EHLO
        vie01a-dmta-pe07-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729600AbeKFBRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:17:35 -0500
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gJhFX-0002xz-16
        for linux-kernel@vger.kernel.org; Mon, 05 Nov 2018 16:57:11 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id JhFVg4OgCkosQJhFVgedPx; Mon, 05 Nov 2018 16:57:10 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=NEAV23lmAAAA:8 a=foHCeV_ZAAAA:8
 a=2MdgUGKUEWYGyVkq8QAA:9 a=TY-650Qa1kY83FcW:21 a=IMO522PpoWrpW9Lq:21
 a=QEXdDO2ut3YA:10 a=h8a9FgHX5U4dIE3jaWyr:22
Received: from [192.168.2.4] (brady.scss.tcd.ie [134.226.35.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 8A40D4E607;
        Mon,  5 Nov 2018 15:57:08 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
Date:   Mon, 5 Nov 2018 15:57:07 +0000
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com,
        julia.lawall@lip6.fr, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.101.1)
X-CMAE-Envelope: MS4wfK6853s3i6ne7OPCTlKFQ8jfp81vVRsEdxZcXAKHNLd9maOXJ3GXS2JJpfkhgStSAus30xrkkJ55bbRcH1oH2a/PsL3PSSmvxzuFT10DFe9r3mj1hzyW
 NhjrT0ZvPYdK2R+RITuxyqzRlPc4vbX2qsd2A+JU6hAYsgwAiOGE1EtrAjNh4eA/WT2zXjCFbwlxIMv/cqzts9whn73Jfd+krO9Q0PTEOSg5dID200wN5411
 IEULaj1d5FIj++8/6ac+uJ7giskKPGiTq3EKUEzdN6ezhBKukAEm5MC6v70BlfKuPOuZ6kfi65Qf0SeSoGDgOrPFlJsz7p5F8n5wTHFwzdOOxNxhpdy/LHUh
 9i1R0xeIya0WmHN5lcxxxQ5rdVi7fBtS6AW6796TwixWklWrONI8IPfoLYSWVAdcCJ0N1xs9Uw+vszCo9cRmroCdRzaQILtZuMLuRd9/AuckvcV21GD0gdhQ
 Y4e067xHelOhenUQAciYCfmadv3qvvkVuTXfIj1jSIgDnxV8nUjbJ88hFdDv1tvmtHxXHGSLFLOD7QI8i8fqHlEGbEO6CsqCAwyQsakLws0D6Ce6WkCHIti9
 a/Dhm4dgfSMadgb4BzgSP9GVqWhYc39DCzJ4gDcjXoTAikNlHBl4JWsM4UdxgoxXBx4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments and suggestions.

> On 25 Oct 2018, at 08:37, Takashi Iwai <tiwai@suse.de> wrote:
> 
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.

As I understand it, this driver stages settings, data and status information for the true audio driver which is part of VideoCore (VC). The driver communicates with the VC by sending messages. Responses come back in asynchronous callbacks. There doesn’t seem to be any other source of data or status.

When parameters such as frame format, rate and period size have been set up, the VC executes periodic callbacks to retrieve period-sized buffers of data. At 44,100 frames per second and with standard 444-frame periods, callbacks occur approximately every 10.07 milliseconds.

> Though, usually the delay value is provided also from the hardware,
> e.g. reading the link position or such.  It's a typical case like
> USB-audio, where the hwptr gets updated and the delay indicates the
> actual position *behind* hwptr.  That works because hwptr shows the
> position in the ring buffer at which you can access the data.  And it
> doesn't mean that hwptr is the actually playing position, but it can
> be ahead of the current position, when many samples are queued on
> FIFO.  The delay is provided to correct the position back to the
> actual point.

 The information that the alsa snd_pcm_delay() function depends on is updated during these callbacks. Thus, a user program monitoring the snc_pcm_delay() value closely will see sudden jumps in the value every 10 milliseconds or so — a 10 millisecond jitter. 
> 
> But, this also doesn't mean that the delay shouldn't be used for the
> purpose like this patchset, either.  OTOH, providing a finer hwptr
> value would be likely more apps-friendly; there must be many programs
> that don't evaluate the delay value properly.

With interpolation, the number of frames that would have been output from the time of the last callback is subtracted from the delay to give a more accurate estimate of the actual delay at the time it is requested.

> So, I suppose that hwptr update might be a better option if the code
> won't become too complex.  Let's see.

Having looked at the code, there does not seem to be a good way to avoid interpolation. Later versions of the interface include a message type of VC_AUDIO_MSG_TYPE_LATENCY (see https://github.com/raspberrypi/firmware/blob/master/opt/vc/include/interface/vmcs_host/vc_vchi_audioserv_defs.h#L158) which seems to be a request to return the latency. However, the latency would be returned in an asynchronous callback (see function audio_vchi_callback in bcm2835-vchiq.c). One can wait for the result, but it seems that it could take up to 10 milliseconds (see function bcm2835_audio_send_msg_locked in bcm2835-vchiq.c). This is hardly tolerable, and to avoid it, one would have to store both the latency returned and the time the request was sent (or the time the reply was returned — it’s not clear which would be correct) and interpolate from that to the time the delay is requested. In other words, from the point of view of avoiding interpolation, this is likely to be no better than the presen
 t suggestion. There wold also be a need to make the latency request periodically, adding to the overhead.

Without getting a good deal more information about the VC, which may not be available, I’m afraid I can’t see a way of getting a better fix on the instantaneous values of pointers such as the hw_ptr. BTW, I have not been able to find a source for the file vc_vchi_audioserv_defs.h, which looks like a Broadcom file and which appears to have two  versions. If anyone could point me to the source, I’d be grateful.

> One another thing I'd like to point out is that the value given in the
> patch is nothing but an estimated position, optimistically calculated
> via the system timer.  Mike and I had already discussion in another
> thread, and another possible option would be to provide the proper
> timestamp-vs-hwptr pair, instead of updating the timestamp always at
> the status read.

Agreed — that would give the caller the information needed to do the interpolation for themselves if desired.

> Maybe it's worth to have a module option to suppress this optimistic
> hwptr update behavior, in case something went wrong with clocks?

Following this suggestion, I have updated the patch to include a module parameter ‘enable_delay_interpolation’, and I will post that later for consideration.

Regards
Mike


> thanks,
> 
> Takashi

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

