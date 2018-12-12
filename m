Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07378C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1042086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0YhQLm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLLCrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:47:03 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43646 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLCrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:47:03 -0500
Received: by mail-qt1-f171.google.com with SMTP id i7so18917376qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgEp1E5C6Qu8djtqrwabIex9jJmfchIPo+nfg3wWEGI=;
        b=c0YhQLm9sMVeFuGWYuCYYnzSsPxkbEtrOqjrJdeIytA44LPcWs4KXlgxpjxhhGrQ/m
         XqTMTZu288obYrKK4p/9nyodeoAyELrUgDzs+yVbFEfN4T/1yoxe3hqA1mRcAZi4bsvo
         yYnIqn9QFiekwudhEZWH9F1Ep2vEEzi+nzoMBKizEoyav+EUx48XVaK5TUKEAi1sw62Q
         gdWT47C9/OLpzrLl7a2ZSjdfmoUBJww0akIXvE/WweeTWCFq3TWSGcXUMEh4GnZMzeRi
         urn1ALV7BDaYzr4Sqx3ttzhDglIPbKV2GAp78TCgPZGmFVL7E8M9AWXAsBwRBRG77faT
         OEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgEp1E5C6Qu8djtqrwabIex9jJmfchIPo+nfg3wWEGI=;
        b=gbQqMFHT+vhQByfT+Q/+6OLxBgJspyevkwfK/P4iJg+ua8+Oy9dpE5KcuWbVFw51bd
         dpyD8bqXqFQgcVaQoiwNSH9DwlluIG4oNgf4zpwKOJEjltrmjHt3cjcrCVZvf/GI2zpx
         rxSM/PQ1lAi4ROszZBnOqYZHCXL2/rMP0dPc9Oz32fBpH6AG2wns3tqVpFAJWrf0jQYF
         xgbNoXtzYiyJA51UqMULrdkBxClGnKqf3nKbqleveuLrBw2fRvqnVGJ+6lksLfM1NYln
         m/u3uaJS11tONcJ8kkOin6cSDUmF+veTR9BOt7qJMoSletOnasZdskO8GDursUK11CPw
         CXhw==
X-Gm-Message-State: AA+aEWYpD0/Cx1iLYwA1JrAddVpjZ3crdMj5sVav7mNnvZdk4KoFhVny
        uI1jeU+f6QWXvNx7+OeWcPsPWMRXlJteMxw+u+Hh9Q==
X-Google-Smtp-Source: AFSGD/XlcoMrTwzfoSjT2hdsVcNgPvjzK18zgeI7biwWqOnnt5aAGPQYAsTSv+PoxkOvsQek4OYCZ+h8Y4h4aixUBkw=
X-Received: by 2002:a0c:8665:: with SMTP id p92mr16732660qva.182.1544582821451;
 Tue, 11 Dec 2018 18:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20181206030227.9507-1-kyletso@google.com> <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB099433159E3519D8F534E38F80A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB099433159E3519D8F534E38F80A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 12 Dec 2018 10:46:49 +0800
Message-ID: <CAGZ6i=3+8OOafaY8B5qRkDg1pzpTu0XRw-GAenubY74DM=85Pw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
To:     Adam.Thomson.Opensource@diasemi.com
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:36 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 10 December 2018 09:01, Adam Thomson wrote:
>
> > On 06 December 2018 03:02, Kyle Tso wrote:
> >
> > > Current matching rules ensure that the voltage range of selected
> > > Source Capability is entirely within the range defined in one of the
> > > Sink Capabilities. This is reasonable but not practical because Sink
> > > may not support wide range of voltage when sinking power while Source
> > > could advertise its capabilities in raletively wider range. For
> > > example, a Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed
> > > Nominal Voltage) will not be selected if the Sink requires 5V- 12V@3A
> > > PPS power. However, the Sink could work well if the requested voltage range in
> > RDOs is 5V-11V@3A.
> >
> > Is there a real world example of a sink requiring the 5V - 12V range? In that
> > scenario could we not add an additional sink capability which allows for this range
> > to be supported, and the current implementation should work just fine?
>
> Ok, I maybe should have waited until after my morning coffee to respond. So
> because the lower limit on the sink side, is higher than the advertised source's
> PPS minimum voltage it never gets selected? Personally I'd prefer to keep the
> upper limit checking as is as I think that's an additional safety benefit
> helping to prevent over-voltage scenarios. I think if a PPS APDO can supply up
> to 11V then the system should be capable of handling that voltage, otherwise
> it shouldn't be considered at all. The Source provides limits checking as well
> to make sure the Sink doesn't request a value above the maximum voltage limit
> for that selected APDO.
>

If the over-voltage occurs, it means:
1. the adapter malfunctioned. or
2. the code on the Sink accidentally requests a voltage level which is
over the limit of the Sink.

For 1., it is difficult to predict the behaviors of a malfunctioned
adapter. The over-voltage event may happen even if the Sink doesn't
select the APDO from this broken adapter.
For 2., it is difficult to predict the behaviors from the careless code as well.

> For the lower limit I'm more inclined to agree with allowing a higher minimum
> on the sink side as that's less of a safety/damage issue as I understand it.
> FWIW, what is the real world scenario? What happens if voltage drops below 5V?
>

Some products (in Sink mode) have under-voltage protection (the lower
bound might be around 3.8V - 4V before
the calculation of IR-drop) that will cause the disconnection.

thanks,
Kyle
