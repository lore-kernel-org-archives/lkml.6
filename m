Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A1C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A9F20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sn0jRHMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A9F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeINEu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:50:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45698 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeINEu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:50:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id a19-v6so2920614otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5CW1YWpZFdvpCnLDej1XlHGV1b5XayREpWf1XPP9ag=;
        b=Sn0jRHMf/58BcOuJz5Cj+Ijmq7Zlh9Pr9tRQcJK60xRRcCsxTE/jQtFUaw88aBmhuN
         OAdDhNtCeWUZCDR2HGRurxjnZZ2B4nwPpGQfvbDky1svgxOxdnurpIKIEqJ7Pqtkw+3W
         TdaqdjsEF8HzQfI7m+TTBtU38xe0I5h6IF0SADTNWER2WjYWqY44jRre9enOVuFZpatl
         o2y9cuN0cWDdm7kUXFxQ6b90etRCPFYSbBmC4uKuAKYL7XU7QAAXan5e7g+BkHKg8Aw9
         uNhgHxXT0HG3X1zVKrNVl7G29PPWSShqnQ5YDITm0aloU6DvhkukzYZn45sxyO+fmAhE
         PGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5CW1YWpZFdvpCnLDej1XlHGV1b5XayREpWf1XPP9ag=;
        b=nBtwHh2eRYrIGT3KEUPQMjRNUT1eWZKJrM4biZBucoOCNMr00RTmrdu3HasVuf8qfi
         XmwmKtxHrrmifsTiGjhFlEfggeZBovwmO6Jjg/hSknZ09FM7L4GO5TwHG3khTsoKYbsu
         4jk5Q7p2UVh6Lkb2inm9bAbbD4NvflQiQ/S7eJsi0E/JZlnhp+tUmh4CeAhTlZI2VCWz
         9S9k0yewXRQNZi2j0SQhQlvjFKkq9R5DQQrzFIjid9m2/gvcl3Kjh3IVWr678TVVS2+0
         RqNi6u3QxkNUpogjrd2uevqLjqMloE7sYl9SH8jKxOI2Ego1xtqdKWI0REAdq2A7/+EE
         v+PQ==
X-Gm-Message-State: APzg51AHxThM6sCz6ULSJDcMkitpSeXkNx7Ay8TyNg/+IrhbDDsiCpI1
        yP034/6qBQ2pcEuqSh67AUHrDXaCHK00QVyfHWiFGA==
X-Google-Smtp-Source: ANB0VdZAE6j5e/8/1DGLRfsB5wIknTDCt/IBcoS1ie/mAGmFL0GguSyiU+iwHdPYAUBjwl9gB8n7+Hf4vORLbidKV7c=
X-Received: by 2002:a9d:5b46:: with SMTP id e6-v6mr2917599otj.331.1536881926592;
 Thu, 13 Sep 2018 16:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com> <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com> <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
 <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com> <20180913170746.GB13306@jackp-linux.qualcomm.com>
In-Reply-To: <20180913170746.GB13306@jackp-linux.qualcomm.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 13 Sep 2018 16:38:10 -0700
Message-ID: <CAPTae5+WyxADQfDJivzmCBpFbA8RqpCGKDys6tUpHwF8+vt8iQ@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 10:07 AM Jack Pham <jackp@codeaurora.org> wrote:
>
> On Thu, Sep 13, 2018 at 6:43 AM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
> >
> > On Wed, Sep 12, 2018 at 11:39 PM Jack Pham <jackp@codeaurora.org> wrote:
> > >
> > > Hello Badhri,
> > >
> > > On Wed, Sep 12, 2018 at 07:11:13PM -0700, Badhri Jagan Sridharan wrote:
> > > > During hard reset, TCPM turns off the charging path.
> > > > The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.
> > >
> > > This doesn't make sense. By definition the sink isn't sourcing VBUS, so
> > > how can it control whether to allow the voltage to be 5V or 0V?
> >
> > The way I understand it, this is for the current limits that can be
> > set on the Sink side.
> > During hard reset, sink has to fallback to VSafe5V or VSafe0V if
> > higher pd contract was negotiated.
>
> Ok, you are talking about sink current draw limits but vSafe{0,5}V are
> voltage definitions so these are orthogonal. Again, the sink can't
> directly dictate the voltage that's being sourced so I don't see how it
> has a choice here. If a PD contract was negotiated for greater than 5V
> and a hard reset happens then yes the voltage would fall to 0V and then
> rise back to 5V and during this time sink needs to draw appropriate
> current.

>
> > > > From USB_PD_R3_0
> > > > 2.6.2 Sink Operation
> > > > ..
> > > > Serious errors are handled by Hard Reset Signaling issued by either Port
> > > > Partner. A Hard Reset:
> > > > resets protocol as for a Soft Reset but also returns the power supply to
> > > > USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
> > > > Sink.
> > >
> > > I can see how the wording here "vSafe0V *or* vSafe5V" is misleading, as
> > > I think it actually is both. In later parts of the spec, the source's
> > > VBUS behavior is well defined in that it must first drop to vSafe0V
> > > and then return to vSafe5V. Please refer to section 7.1.5.
> >
> >
> > Yeah thats for the source. But for sink, Say if the source isnt PD, then,
> > sink initiated hard resets happen during the connection. Sink would hard reset
> > couple of times before deeming that the partner is non PD. When connected
> > to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
> > a reason to setcharge to false or drop the input current limit. Do you agree ?
>
> Sure that makes sense. In this case I wonder if TCPM even needs to call
> set_charge(false) considering it does not yet know if the partner is PD
> capable or not. For sure, if the partner is PD capable and contract had
> been previously established, we'd definitely need to set_current_limit()
> to default levels and/or turn off charging.
>
> But in the case of hard reset attempts to try to determine if the source
> will send its capabilities (thereby being PD capable), wouldn't the
> initial default current limits still be in place? I think this is the
> point you're trying to make, that there is no need to disrupt charging
> if a hard reset is not going to cause VBUS to reset.

Yes that's right ! I wasnt sure how to put that in words. Thanks for
doing that !
You do concur right ?

>
> To me it sounds like what you're trying to do makes sense only if you
> can make a run-time determination of a partner's PD capability, and not
> based on a config option.

Yes this should be possible. port->pd_capable already has that info.

To sum it up:
if the partner is pd capable, set charge to false in SNK_HARD_RESET_SINK_OFF and
readjust current limits to default in SNK_HARD_RESET_SINK_ON and turn
on charging.

If partner is not pd capable, do not turn off charging nor adjust
current limit as host port is
not going to respond to hard reset.

Does it make sense ?

>
> Thanks,
> Jack
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
