Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B93C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91721471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVL1/S+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA91721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeIMEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:00:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33633 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:00:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so1729815pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIIxVhLA7530dA++L425P9dZD7WsRg0fvSPFQmWAdUQ=;
        b=vVL1/S+3AmNqk0C4cX0U0Alh0MgaQYOwwiZCsXRlSuI+hUmbZ0cNDgYjgozdWlUhNC
         Rrl845xDvBwXvEd3ViWdI180Yp1eQu6kgpzPq+bcR6P7tBm+a8TZnyjKKzfgQMAyvlWu
         8yerNH0JDKaUEYfwsEGcFtxSJBOquAkA6QWfklRepcfd1HdMfjLsWgC6gO/Sxv571vad
         fqvLLRT6tt4SwhrKh8cU0Sc1MHMOqZPVomYIxnEdxTCeDesQDJVRWAhOXTcgZddysn0L
         V3m/jsE6uWcGaNWUHxB3LvXzKyDEF60T3tm37TJ21CinhDgH7NybpKyPQq4okv/4aWZj
         CKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIIxVhLA7530dA++L425P9dZD7WsRg0fvSPFQmWAdUQ=;
        b=SQCC+z49HIt6purPknL3mT2pyXnM2dQ/Vsw0/8dXffL9w8hFszTwVmiurm0/xMs59+
         9198/gP95mEYGrmY5PxYzaNSvyftITQYus430pj9JyEYaQka/mRWf3v/EaHz7BcaDrWu
         8A7pfnGY+BGYO1eXlY28Gi73ao2FaVZTW5mVPEXKREQ9L/QyUtKxM/hsfgdcHkzTvnMo
         QshJuadMq3jkCHaUNdVjYdCC7Yq651z/Q7InlOh64UxaMrezrTD1dFynX7TyQR2MwoOO
         LcoRhZcCloTvI27hxtzYlcad21ICo75RqmzqPihl0EVsxXqD3JCtXUDd23qOICu2/R2S
         guTQ==
X-Gm-Message-State: APzg51CcXfgJ/3y8SISbNq02t9eigt88Kl48T0K2VbpdxYJ+D0gTO+FE
        tVed7Ugn9leUEgyv0scJrF32jTECMEgO9H/9ezewbg==
X-Google-Smtp-Source: ANB0VdbYfCfr9AXwYVxX8bSK3ZM/3u8Vq1GT2kuLmvDbR92QDsAEUzEk8nbGaVvshxaVP601IGoecryWuXaNksQctiQ=
X-Received: by 2002:a63:8543:: with SMTP id u64-v6mr4542139pgd.248.1536792856192;
 Wed, 12 Sep 2018 15:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180911225630.124502-1-venture@google.com> <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
In-Reply-To: <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 12 Sep 2018 15:54:04 -0700
Message-ID: <CAO=notzHoqsjuSdEZby0mr3KgtoxtYjdr_X0nM_2zBu0NcOOAA@mail.gmail.com>
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

On Wed, Sep 12, 2018 at 3:10 PM Corey Minyard <minyard@acm.org> wrote:
>
> On 09/11/2018 05:56 PM, Patrick Venture wrote:
> > Try to get the device ID repeatedly during initialization before giving up.
> > The BMC isn't always responsive, and this allows it to be slightly flaky
> > during early boot.
> >
> > Tested: Installed on a system with the BMC software disabled
> > such that it was non-responsive.  The driver correctly detected this
> > and gave up as expected.  Then I re-enabled the BMC software unloaded
> > and reloaded the driver and it was detected properly.
>
> The patch looks fine, but I wonder if this is something that is really
> valuable.
> I have wondered about this before.
>
> The question is: If the BMC is unavailable, what are the chances of it
> becoming
> available by the time you do 5 attempts?  I would guess that is a pretty
> small
> chance, which is why I haven't done this already.

This patch was actually critical for us to provide a reliable IPMI
interface.  The version of OpenBMC or the state of the BMC at the
point the kernel was loading was flaky, so following the example in
the BIOS source, we just re-try a few times.  We also can hold boot X
seconds until it's responding, but, this avoided some issues inherent
with that.

>
> You could have something that re-tested periodically, but there are so many
> systems with IPMI specified in ACPI or SMBIOS that is wrong, and it would
> try forever.  Also not really a good thing.

If we did a periodic check, it could check X times, but I felt going
for a simple solution was ideal -- and this idea was proved out on a
few platforms.  We have other drivers that are loaded by the kernel
(not at run-time) and they depend on IPMI, and without this patch they
would then have a non-trivial probability of failure.

>
> So I've left it to reload the driver or use the hotmod interface.
>
> -corey
>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> > v2:
> >   - removed extra variable that was set but not used.
> > ---
> >   drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
> >   1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > index 90ec010bffbd..5fed96897fe8 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
> >    * held, primarily to keep smi_num consistent, we only one to do these
> >    * one at a time.
> >    */
> > +#define GET_DEVICE_ID_ATTEMPTS       5
> >   static int try_smi_init(struct smi_info *new_smi)
> >   {
> >       int rv = 0;
> >       int i;
> >       char *init_name = NULL;
> > +     unsigned long sleep_rm;
> >
> >       pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
> >               ipmi_addr_src_to_str(new_smi->io.addr_source),
> > @@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
> >        * Attempt a get device id command.  If it fails, we probably
> >        * don't have a BMC here.
> >        */
> > -     rv = try_get_dev_id(new_smi);
> > +     for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
> > +             pr_info(PFX "Attempting to read BMC device ID\n");
> > +             rv = try_get_dev_id(new_smi);
> > +             /* If it succeeded, stop trying */
> > +             if (!rv)
> > +                     break;
> > +
> > +             /* Sleep for ~0.25s before trying again instead of hammering
> > +              * the BMC.
> > +              */
> > +             sleep_rm = msleep_interruptible(250);
> > +             if (sleep_rm != 0) {
> > +                     pr_info(PFX "Find BMC interrupted\n");
> > +                     rv = -EINTR;
> > +                     goto out_err;
> > +             }
> > +     }
> > +
> > +     /* If we exited the loop above and rv is non-zero we ran out of tries.
> > +      */
> >       if (rv) {
> >               if (new_smi->io.addr_source)
> >                       dev_err(new_smi->io.dev,
>
>
