Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9252C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8367620651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYXUjElJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAOCEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:04:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32788 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOCEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:04:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so1337308eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 18:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8drTYmAGzr1YaHbMn+Y41JzayyBRNODBp/Wml76uZc=;
        b=gYXUjElJbbTyrlXMZK0Jyp2ErzM46jSagThzvcl9CJNZawntNvj3ubTlI2mNLS2xUr
         Ndt/xhyNk1Q8kDXrZbvUJlsrPRI262poC4q/+s+QMJI4R9lD50vrYRFEfiHrEyh+6XZ9
         JDYSR6Ytom36W604xTqrQms8/0ub8ypDwyt2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8drTYmAGzr1YaHbMn+Y41JzayyBRNODBp/Wml76uZc=;
        b=CA6hnOqE7z7DHPp5g2B+NhlD8glHyI+wL+AW2W2rKexU5KET9i5ZYxFkgz0tKvA/K+
         xDD7HltgtHEbUSrY/AtdRZ6lbXjw1mijUDg7t26WJhCdXFHMElb/zCBhblRxjMlf+rtg
         /GXUnl+XClG9F61UaeSC1ah6rQSvwAjIGrqcsTkuyczMCq7Ofp5j92MN7qbfCpgfLf0M
         vFS78TFXHtJ7R4D15b4n/mdPHCjBSsmMfVJOtzymO0u4URSZNCdiFRmZCBMMTqkDCRLF
         S1FIwkgyRM2DtPZUVV32v/DfL0spw6yteU+GRuia/cgKnm5wPtR0IfcowbSkJ2UlExpF
         O/bA==
X-Gm-Message-State: AJcUuke2UUPnKs0N3Nu7f8Ap/e4UMRx1c2dRFLpRdNwV4wSQwnqWNNeN
        0DqvVoOHIDhidpKuLp/KyH704zZgObI=
X-Google-Smtp-Source: ALg8bN4JZ72RpeUJy22tG8yyUYsZJV6kHqbWF0H0l+BN6tu0wS/a/joVCCd7mMohU7G9LWyew4aUQQ==
X-Received: by 2002:a50:ce0f:: with SMTP id y15mr1399914edi.207.1547517848887;
        Mon, 14 Jan 2019 18:04:08 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id g31sm4488824eda.96.2019.01.14.18.04.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:04:07 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id h15so1317799edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 18:04:06 -0800 (PST)
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr1496662edg.121.1547517846078;
 Mon, 14 Jan 2019 18:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20181129195548.204153-1-egranata@chromium.org>
 <20181207222223.GA240898@google.com> <CAMHSBOU0qNrCfg5=N-4KXBS_0fTBRbHGY2V9R7Q9E9ZY7R-1Mg@mail.gmail.com>
In-Reply-To: <CAMHSBOU0qNrCfg5=N-4KXBS_0fTBRbHGY2V9R7Q9E9ZY7R-1Mg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 14 Jan 2019 18:03:54 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPt5fws82r71xjuVucB=gZCYVSjx5dMaGdbW6qFOuG0vA@mail.gmail.com>
Message-ID: <CA+ASDXPt5fws82r71xjuVucB=gZCYVSjx5dMaGdbW6qFOuG0vA@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
To:     Gwendal Grignou <gwendal@google.com>
Cc:     Enrico Granata <egranata@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On Mon, Jan 14, 2019 at 3:50 PM Gwendal Grignou <gwendal@google.com> wrote:
> On Fri, Dec 7, 2018 at 2:22 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Thu, Nov 29, 2018 at 11:55:48AM -0800, egranata@google.com wrote:
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
> > >       ret = cros_ec_get_host_command_version_mask(ec_dev,
> > >                                                   EC_CMD_GET_NEXT_EVENT,
> > >                                                   &ver_mask);
> >
> > It's not exactly new here (although you're using 'ver_mask' in new
> > ways), but cros_ec_get_host_command_version_mask() doesn't look 100%
> > right. It doesn't look at msg->result, and instead just assumes that if
> > we got some data back (send_command() > 0), then it must have been a
> > success. I don't think that's really guaranteed in general, although it
> > might be for the specific case of EC_CMD_GET_CMD_VERSIONS.

> It is guaranteed: if msg->result is not EC_RES_SUCCESS, then ret can
> not be greater than 0. At best it will be 0, or a negative number if
> we can already qualify the error in the errno space (see
> cros_ec_pkt_xfer_i2c() for instance).

Sorry, where do you guarantee that? The only enforcements I see in
those xfer implementation are:
(1) if result == EC_RES_IN_PROGRESS, we convert that to an errno
(2) if the expected length or checksum are bad, we turn that to an errno

So technically, the EC *could* be sending a valid, checksummed
response of the expected length, while still setting the ->result
field to something besides EC_RES_SUCCESS or EC_RES_IN_PROGRESS. And
we would treat that as a valid 'ver_mask'.

Albeit, that seems unlikely, given understanding of how the EC is
supposed to behave, but our code is not properly defensive AIUI. This
is basically why cros_ec_cmd_xfer_status() exists -- so that
sub-drivers don't get lazy and use cros_ec_cmd_xfer() without handling
the ->result field properly.

Brian
