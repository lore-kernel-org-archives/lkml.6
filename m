Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E43C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3052081B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGMJo+AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3052081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLLBik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:38:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46439 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:38:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so18765853qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 17:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRLb3PwR+JWZugChYugReqx6KbzwlhqR5I2ARRy0y9c=;
        b=pGMJo+AZcdpEe4x5VhG8S/IULoZZkQZkg9q3lAbEe1v7OGxwMzceKriGKZQtoSKAOK
         B4OjmzmqzrnuR4ncUNI9gq0X8l3l5CJuqfk6uoABb3cRB+DuBtfTK4es1fr5SZyZpwUC
         awIIhPUoahgbD5MdHKOMeBOUuiUL6Tj8tHjeDNlddWBEnNyeo/8IfCDPdMBy5TW62QOg
         JOEaooy71Vqunxce9PP0cn2ao0NB5GckY/Ixt0qjxBml0OsFA1jESsO1NxhrffEp/jnb
         te+jzvbEm+85eo+c/Szv7sLabawIJ/8gNMbvhDc1Qsn5NRUmzjtDo6VUvAxzrTEz6fNA
         nkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRLb3PwR+JWZugChYugReqx6KbzwlhqR5I2ARRy0y9c=;
        b=Nn+n1o2hPQib2mCKhuw2NLgY04Daae0ur/3YJ/R8FM6jTSLKbO7PfK+NCywbo/fHg2
         EjVwaECbWFlnhioHPrS8bmUyT9b6JR34DTpFhR1eg5zM1OGAWoJt7EK6IRoGL5fi3jSQ
         9CAWg/UAyPAp/QO1zhNKN9kGTlyHLS98qijpR7znXOzFmZIadpwT/otiu3EF82OGbvIQ
         QEleybWfh2YBIST7jgJISb6f7mMLxWc2Mkv+Bebwh+3jlYoHA4mXkDgfMV3X65Bu00tB
         kQpfLwrxJKhuQnpG0yXTM3EYv9sPwU359aGubQ4mpDRw/tcU21eKe7B55F/E+JaJQ4Xh
         exbQ==
X-Gm-Message-State: AA+aEWab7rQp9pENAvkZ83M3NMuKvK3fdQWrYWL93ZBHJ8gUedFkXhZS
        5V2vJvlOZMWMG/lSKSvtPGRuxy//HcSnN6QS+sA7Lw==
X-Google-Smtp-Source: AFSGD/X2msU/3E2x8SlloiddiUqrPXCsW8IedOtcIEAVcIbjDMJvBLwpQJX2rtI9yUsT4NLtkdOJel94/ClNLaCfh18=
X-Received: by 2002:ac8:108e:: with SMTP id a14mr17188725qtj.86.1544578718224;
 Tue, 11 Dec 2018 17:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20181206030227.9507-1-kyletso@google.com> <20181206175625.GA11808@roeck-us.net>
In-Reply-To: <20181206175625.GA11808@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 12 Dec 2018 09:38:26 +0800
Message-ID: <CAGZ6i=0TBGKGaUuHtjnv-d=UqqVNfujSian-STj3oT7HePT-JA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 1:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 06, 2018 at 11:02:27AM +0800, Kyle Tso wrote:
> > Current matching rules ensure that the voltage range of selected Source
> > Capability is entirely within the range defined in one of the Sink
> > Capabilities. This is reasonable but not practical because Sink may not
> > support wide range of voltage when sinking power while Source could
> > advertise its capabilities in raletively wider range. For example, a
> > Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
> > will not be selected if the Sink requires 5V-12V@3A PPS power. However,
> > the Sink could work well if the requested voltage range in RDOs is
> > 5V-11V@3A.
> >
>
> Maybe a graphical description would help ?
>
> Currently accepted:
>                 |--------- source -----|
>         |----------- sink ---------------|
>
> Currently not accepted:
>
>                         |--------- source -----|
>         |----------- sink ---------------|
>
>         |--------- source -----|
>                 |----------- sink ---------------|
>
>         |--------- source -----------------|
>                 |------ sink -------|
>

Sorry for late reply. I was on vacation.
Thanks for the suggestion. I will update the commit message.

> > To improve the usability, change the matching rules to what listed
> > below:
> > a. The Source PDO is selectable if any portion of the voltage range
> >    overlaps one of the Sink PDO's voltage range.
> > b. The maximum operational voltage will be the lower one between the
> >    selected Source PDO and the matching Sink PDO.
> > c. The maximum power will be the maximum operational voltage times the
> >    maximum current defined in the selected Source PDO
> > d. Select the Source PDO with the highest maximum power
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
>
> Makes sense to me. I am a bit concerned that it might cause odd regressions,
> though. Did you test it with a few adapters ?
>
> With the expectation that you did,
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Yes I have tested this patch with 3 different brands of adapters with
PPS capabilities.

thanks,
Kyle
