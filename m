Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A57C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6399204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWQjUzvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6399204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeKBWwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeKBWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:52:15 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F31B2082E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Nov 2018 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541166303;
        bh=s9VqPcmp0iieYqStGEfGHpieqcvUpKrIf8DnrJYNijg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eWQjUzvrjZ6f5H+r1K0NNtWbn8e4quy1j+jzUkKR1UzDs8KS/QC9eSPD3drFmvK+P
         baLgIb5zbI+FwCSUlHzqNmrjsCLwYDKoZ0VtM0uPBgJ3L0GHALKFV7+suqOW+PkEbf
         gnCKl9dmCAxH7qkwgtwUIMK2ET649jldBR0SlOyM=
Received: by mail-wm1-f49.google.com with SMTP id w7-v6so2043244wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:45:03 -0700 (PDT)
X-Gm-Message-State: AGRZ1gK+1jWlnOUiqnF6BZQ+Y7gCmXsMDoD18rQzRFAW9YcK9fIhAqEK
        7AKbhUMRJ3yPZH2i+zK8iaNJiRrzr3HOwqqHZIjAJA==
X-Google-Smtp-Source: AJdET5cajSa8ltzyMMJORFpDn6YwvZn9qfeP4jCNXQ/37fUaKfvkxTwn6QzGWEQELzY1AghccMLY8aoqFjQFYNmw7q0=
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr3216wmd.99.1541166301604;
 Fri, 02 Nov 2018 06:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181001194501.58338-1-badhri@google.com> <20181102132758.GA6543@kuha.fi.intel.com>
In-Reply-To: <20181102132758.GA6543@kuha.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Nov 2018 08:44:50 -0500
X-Gmail-Original-Message-ID: <CABGGiszdDau0ohsXb_SROAJU6AFcvx=7ucTAEXzC0dWzbZ3rAw@mail.gmail.com>
Message-ID: <CABGGiszdDau0ohsXb_SROAJU6AFcvx=7ucTAEXzC0dWzbZ3rAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: connector: Add self-powered property
To:     heikki.krogerus@linux.intel.com
Cc:     badhri@google.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cw00.choi@samsung.com, a.hajda@samsung.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>, jackp@codeaurora.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:28 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Oct 01, 2018 at 12:44:59PM -0700, Badhri Jagan Sridharan wrote:
> > >From USB_PD_R3_0
> > 7.1.5 Response to Hard Resets
> > Device operation during and after a Hard Reset is defined as follows:
> > Self-powered devices Should Not disconnect from USB during a Hard Reset
> > (see Section 9.1.2).
> > Bus powered devices will disconnect from USB during a Hard Reset due to the
> > loss of their power source.
> >
> > Therefore it is necessary to know whether the port belongs to
> > a device which is self powered or bus powered. This change
> > adds "self-powered" flag to the connector class which present indicates
> > that the port belongs to a device that is self powered. Else it is
> > bus powered usb device.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> Rob, I can see you acked one of the patches modifying tcpm.c in this
> series, but did you mean to put the tag to this patch instead?

Hum, indeed. Looks like a scripting fail in my reply. The R-by was for this one.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
