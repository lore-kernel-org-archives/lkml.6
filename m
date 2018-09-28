Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31769C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07B2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fij/dPXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeI2FLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:11:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32856 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeI2FLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:11:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id m23-v6so7598017otf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIJP7qiRACFlba3m29i0BoS3qipiLr0ms+CLYPYg0oM=;
        b=fij/dPXo+EbA7bqQzv2Tpp/z31OhLFnv9uu2oci2VgjM5EZTj0IIDqLW4sPyKjnqN+
         dvJi+6VvGyDdNOa26pQrrbGA7y9HYamugIORdMwrvkc4K1fXESt0OhzsKdib4Y2jXa9m
         EAOCNBULebj26NVGyYFbRRVe45ePj5K5vkZBBnH3RPD1leNgBmUOxhTO53OaQzBdNP/0
         koMULwJ1b4A9je/vsWqtlVnhq/7qMRDDVgweLipooWmQAnn9x+Se2e7Pk5lVGXm8nOn6
         FQGq1W2gIkP7P/hfcdsjSHlhNXGLNU+5pykUTqdJ37n4EDGCWW+m1Ql4h+UgS2wuqxC6
         ReGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIJP7qiRACFlba3m29i0BoS3qipiLr0ms+CLYPYg0oM=;
        b=dAvn1QnKuz+UzGVLzpmvHyyN8vT7DsYKsoaPXQ/N7XNO46feUEenl8MBw/nzuc9Vtb
         cOBeEsFiowv+Zq6e6dmuFMn2bt3pUdvC5UorvHGK+0WOB4nP9RjMkOaLOIlni2HbaNSV
         1XegD0qtfhDdBw/ohyaMW4f+JoyxyryL2FDKaGNhnsFT+jhExeocncKN749OAA3a4RGG
         +LxPQiNbb0Bq9Ryu1dxTk6pUBj0nPpZeohG2oOLhfmBTtUjJI63yPGWJr0AjjYjXCtV0
         RBL21Ng8U4/C505x3oDqM8OpoXmgbR9/zIK2CL0ueuLk7Ye2bs8fXaM1SZLmOVt3XOpU
         OyGQ==
X-Gm-Message-State: ABuFfoi6+ehk7AlOOB9L1S79kv3KDkaEiwIBUxnAmQE2QCvlzXj1aUA6
        2m1fSEhSoXGWhcIZSuKCXdHj6fsZYgu0Huhy1h5CAA==
X-Google-Smtp-Source: ACcGV6375tRJPnjfh5pKoKEicZntb0+EcYYNtKocusgsadY8sSdTCIx7SjUYIgrHl2vs3YjZStVhdpEk1gEsMWISS3Q=
X-Received: by 2002:a9d:41b5:: with SMTP id p50-v6mr450441ote.339.1538174721258;
 Fri, 28 Sep 2018 15:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com> <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com> <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
 <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com>
 <20180913170746.GB13306@jackp-linux.qualcomm.com> <CAPTae5+WyxADQfDJivzmCBpFbA8RqpCGKDys6tUpHwF8+vt8iQ@mail.gmail.com>
 <20180914184242.GC13306@jackp-linux.qualcomm.com>
In-Reply-To: <20180914184242.GC13306@jackp-linux.qualcomm.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 28 Sep 2018 15:44:44 -0700
Message-ID: <CAPTae5KOoNHwh1n8SLuE642uSYq_zJtXUZ3j8ob9VeE+9DXbEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at Vsafe5V
To:     jackp@codeaurora.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:42 AM Jack Pham <jackp@codeaurora.org> wrote:
>
> Hi Badhri,
>
> On Thu, Sep 13, 2018 at 04:38:10PM -0700, Badhri Jagan Sridharan wrote:
> > On Thu, Sep 13, 2018 at 10:07 AM Jack Pham <jackp@codeaurora.org> wrote:
> > > On Thu, Sep 13, 2018 at 6:43 AM Badhri Jagan Sridharan
> > > > Yeah thats for the source. But for sink, Say if the source isnt PD, then,
> > > > sink initiated hard resets happen during the connection. Sink would hard reset
> > > > couple of times before deeming that the partner is non PD. When connected
> > > > to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
> > > > a reason to setcharge to false or drop the input current limit. Do you agree ?
> > >
> > > Sure that makes sense. In this case I wonder if TCPM even needs to call
> > > set_charge(false) considering it does not yet know if the partner is PD
> > > capable or not. For sure, if the partner is PD capable and contract had
> > > been previously established, we'd definitely need to set_current_limit()
> > > to default levels and/or turn off charging.
> > >
> > > But in the case of hard reset attempts to try to determine if the source
> > > will send its capabilities (thereby being PD capable), wouldn't the
> > > initial default current limits still be in place? I think this is the
> > > point you're trying to make, that there is no need to disrupt charging
> > > if a hard reset is not going to cause VBUS to reset.
> >
> > Yes that's right ! I wasnt sure how to put that in words. Thanks for
> > doing that !
> > You do concur right ?
>
> Yes.
>
> > > To me it sounds like what you're trying to do makes sense only if you
> > > can make a run-time determination of a partner's PD capability, and not
> > > based on a config option.
> >
> > Yes this should be possible. port->pd_capable already has that info.
> >
> > To sum it up:
> > if the partner is pd capable, set charge to false in SNK_HARD_RESET_SINK_OFF and
> > readjust current limits to default in SNK_HARD_RESET_SINK_ON and turn
> > on charging.
> >
> > If partner is not pd capable, do not turn off charging nor adjust
> > current limit as host port is
> > not going to respond to hard reset.
> >
> > Does it make sense ?
>
> Right, although the "not pd capable" path could also mean the partner is
> PD capable but it is not determined yet. For example: if a sink is
> connected to a PD source, established a contract, and the sink reboots
> and has to initialize TCPM again. Assuming the sink never disconnected
> from CC when rebooting, the source won't automatically re-send its
> Source Capabilities as it will still be in its previous state(*). The
> sink TCPM however would send a hard reset in order to try to
> (re)establish a contract, so here is where this path overlaps with the
> not-pd-capable case. In this case I think it might be proper to readjust
> current limits to default also unless it was already done earlier--I see
> it is done in tcpm_reset_port() and in SNK_DISCOVERY, so you might be
> covered here.

Yes I verified this.

>
> The question I have is whether you still need to consider calling
> set_charge(false) for this example.


>
> (*) Just thought of one more thing, what if the previous contract was
> negotiated at greater than 5V VBUS? How does the sink TCPM handle
> setting charging parameters after a reboot but prior to hard reset?


Rebooting the device is an interesting case ! TCPM is unique in its own
way as it neither a platform_driver nor a device_driver. Simply its the state
machine of the type-c port's device. I see that I could register to the
shutdown callback in the lower level driver which registers the port
by calling tcpm_register_port and handle the shutdown operation by calling
tcpm_unregister_port and subsequently opening the ports but dont know
how to achiever this at the TCPM level.

However, this reboot case is not directly related to the HARD_RESET
state as this would have to be handled for all the sub states. Isn't that the
case ?

Updating the patchset to do the following:
"if the partner is pd capable, set charge to false in
SNK_HARD_RESET_SINK_OFF and
readjust current limits to default in SNK_HARD_RESET_SINK_ON and turn
on charging.

If partner is not pd capable, do not turn off charging nor adjust
current limit as host port is
not going to respond to hard reset."

>
> Jack
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
