Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0AE2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRuSdT2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0AE2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeITBgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:36:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39521 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITBgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:36:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so174935pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOIJury+YbaTTJcDdNQrT1QPJxXmmxfcUjCipfjvxJM=;
        b=eRuSdT2iOCzr5cpwTL3Q03lv0Ovv+bI85qEciM6IdCep1O7wc862XWnzvGwkHtesGM
         H6Vde8vOyJ+wLaHKG+aiUv7+mpxz0LtDSKZ6dM4S8QzlEPcfn90WSj5vER7ww4rXAz0N
         5c/V4FcU1fCpsXgRIR30t9kOFFPn5wFdBhu77VrtBgguLRo5qJwSoHWvbuWoEleQTu3L
         JBobBXVcZpFIyC7hZttvLbrq2AJb9hqKDuJ3fuJL47UYWCJXL4O36q4KdOI2kl49Ih26
         ccQf9h/Ugm3jzUmNJ3xvzyt0lGVy777r8uLGKvqdTUFGBgWxA0vojjnhIatutjC4Vyud
         ZhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOIJury+YbaTTJcDdNQrT1QPJxXmmxfcUjCipfjvxJM=;
        b=m2A8BSh7b5PS2vaaKAf0Ry7MbyO9oz40Ua9AXTSeD+hD+3EoWOnVN0Kv5NKujWjkpU
         tkncfszCtlwBvDKRhEa4S7yi4ToNhs2G+5P2rtKG6SIr9KaCcKWbrsj+mhTVlyRMBzJh
         YVmS0Yv0Ky06Fi3utUNee0jVz4YUAOeNvs6lUI8J95lvI5zes8hVOybUp+UH1ZI4BOA3
         0Rq9pRzItliDd/coubpxpiJbzV3wCAdpVaLC66OxhU4dxlEa3MLRHphpWNXVEajib3ld
         sR9VkEz3AVXeLKni3UWY44rJKLt161ylbyVqI0/nGieLJhLXZE5cGQHBDBdBkqjtGi35
         8FmQ==
X-Gm-Message-State: APzg51ACMw0PQXme35w0QZi8w/S+j5v8glzHOSrK6VnMXQI7CKaEIQwL
        1liwxyCMS9f5JP4vaJzejRS/KimpPr2zDsDi2e4oQQ==
X-Google-Smtp-Source: ANB0VdZlttaAWBLNEORNnIuph47XDtjTTq0ELXWdD94AfLySuXR529HhDak/0zpSgftAG2lNrvOTe2GyCg/hR1SYoDQ=
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr38121308pfd.194.1537387029827;
 Wed, 19 Sep 2018 12:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180911225630.124502-1-venture@google.com> <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
 <CAO=notzHoqsjuSdEZby0mr3KgtoxtYjdr_X0nM_2zBu0NcOOAA@mail.gmail.com>
 <CAO=notwkMAe_9=32D+ycPwiZ=c_un7sQ+Le9PW_oDiVeBp25jg@mail.gmail.com> <966e9741-6a27-a511-8d39-6576d8cfc8f8@gmail.com>
In-Reply-To: <966e9741-6a27-a511-8d39-6576d8cfc8f8@gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 19 Sep 2018 12:56:58 -0700
Message-ID: <CAO=notzJxVuf+jfLaSde1iMRBE2=qwWGSCj+JzJociYK6yGTdQ@mail.gmail.com>
Subject: Re: [PATCH v2] ipmi: looped device detection
To:     Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 2:37 PM Corey Minyard <tcminyard@gmail.com> wrote:
>
> On 09/18/2018 01:42 PM, Patrick Venture wrote:
> > On Wed, Sep 12, 2018 at 3:54 PM Patrick Venture <venture@google.com> wrote:
> >> On Wed, Sep 12, 2018 at 3:10 PM Corey Minyard <minyard@acm.org> wrote:
> >>> On 09/11/2018 05:56 PM, Patrick Venture wrote:
> >>>> Try to get the device ID repeatedly during initialization before giving up.
> >>>> The BMC isn't always responsive, and this allows it to be slightly flaky
> >>>> during early boot.
> >>>>
> >>>> Tested: Installed on a system with the BMC software disabled
> >>>> such that it was non-responsive.  The driver correctly detected this
> >>>> and gave up as expected.  Then I re-enabled the BMC software unloaded
> >>>> and reloaded the driver and it was detected properly.
> >>> The patch looks fine, but I wonder if this is something that is really
> >>> valuable.
> >>> I have wondered about this before.
> >>>
> >>> The question is: If the BMC is unavailable, what are the chances of it
> >>> becoming
> >>> available by the time you do 5 attempts?  I would guess that is a pretty
> >>> small
> >>> chance, which is why I haven't done this already.
> > Friendly ping.  I'd like to get a sense of whether you're likely to
> > accept this.  If not, it's fine, will close out patch in current
> > downstream rebase.
>
> I'm ok with doing this, but I lied about the patch being fine, there are
> some issue.
> Well, I didn't lie, but I didn't look closely enough.
>
> Can you use dev_xxx() instead of pr_xxx().  I know the driver isn't
> currently
> consistent, but there are a number of patches I have pending to make it
> better and it's a longer-term goal.

Ack.

>
> Can you make GET_DEVICE_ID_ATTEMPTS more specific, add IPMI_SI_ to
> the beginning or something.

Ack.

>
> I am not sure that I'm ok with waiting up to 1.25 seconds in the init
> function.
> As I mentioned before, a large number of systems have broken ACPI/SMBIOS
> information, and for those it will add 1.25 seconds to the boot time of
> every
> one of those systems.  That won't make me a popular guy :-).

Yeah, that's problematic for the systems that'll never get a valid
response.  I don't think it makes sense to gate the feature with a
configuration option, do you?

>
> This is a harder problem to figure out what to do.  To solve it properly
> would
> mean having a timer or thread drive this, and unload the module later if
> the process fails.
>
> -corey
>
> > Thanks
> >
> >> This patch was actually critical for us to provide a reliable IPMI
> >> interface.  The version of OpenBMC or the state of the BMC at the
> >> point the kernel was loading was flaky, so following the example in
> >> the BIOS source, we just re-try a few times.  We also can hold boot X
> >> seconds until it's responding, but, this avoided some issues inherent
> >> with that.
> >>
> >>> You could have something that re-tested periodically, but there are so many
> >>> systems with IPMI specified in ACPI or SMBIOS that is wrong, and it would
> >>> try forever.  Also not really a good thing.
> >> If we did a periodic check, it could check X times, but I felt going
> >> for a simple solution was ideal -- and this idea was proved out on a
> >> few platforms.  We have other drivers that are loaded by the kernel
> >> (not at run-time) and they depend on IPMI, and without this patch they
> >> would then have a non-trivial probability of failure.
> >>
> >>> So I've left it to reload the driver or use the hotmod interface.
> >>>
> >>> -corey
> >>>
> >>>> Signed-off-by: Patrick Venture <venture@google.com>
> >>>> ---
> >>>> v2:
> >>>>    - removed extra variable that was set but not used.
> >>>> ---
> >>>>    drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
> >>>>    1 file changed, 22 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> >>>> index 90ec010bffbd..5fed96897fe8 100644
> >>>> --- a/drivers/char/ipmi/ipmi_si_intf.c
> >>>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> >>>> @@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
> >>>>     * held, primarily to keep smi_num consistent, we only one to do these
> >>>>     * one at a time.
> >>>>     */
> >>>> +#define GET_DEVICE_ID_ATTEMPTS       5
> >>>>    static int try_smi_init(struct smi_info *new_smi)
> >>>>    {
> >>>>        int rv = 0;
> >>>>        int i;
> >>>>        char *init_name = NULL;
> >>>> +     unsigned long sleep_rm;
> >>>>
> >>>>        pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
> >>>>                ipmi_addr_src_to_str(new_smi->io.addr_source),
> >>>> @@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
> >>>>         * Attempt a get device id command.  If it fails, we probably
> >>>>         * don't have a BMC here.
> >>>>         */
> >>>> -     rv = try_get_dev_id(new_smi);
> >>>> +     for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
> >>>> +             pr_info(PFX "Attempting to read BMC device ID\n");
> >>>> +             rv = try_get_dev_id(new_smi);
> >>>> +             /* If it succeeded, stop trying */
> >>>> +             if (!rv)
> >>>> +                     break;
> >>>> +
> >>>> +             /* Sleep for ~0.25s before trying again instead of hammering
> >>>> +              * the BMC.
> >>>> +              */
> >>>> +             sleep_rm = msleep_interruptible(250);
> >>>> +             if (sleep_rm != 0) {
> >>>> +                     pr_info(PFX "Find BMC interrupted\n");
> >>>> +                     rv = -EINTR;
> >>>> +                     goto out_err;
> >>>> +             }
> >>>> +     }
> >>>> +
> >>>> +     /* If we exited the loop above and rv is non-zero we ran out of tries.
> >>>> +      */
> >>>>        if (rv) {
> >>>>                if (new_smi->io.addr_source)
> >>>>                        dev_err(new_smi->io.dev,
> >>>
>
