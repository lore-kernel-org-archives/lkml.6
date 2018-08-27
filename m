Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283EAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF826208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcKcSghV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF826208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeH0XKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:10:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46415 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0XKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:10:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so31245edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g5NmqqrwuYo5W7kKF2b+R6mYgbXQW8HK3lyWmDSaoWw=;
        b=FcKcSghVtp+v8IfK+ikq+PF6RMbPo2NiWBhtG3HT4AO93EHG0jC18IokK8lJJAJLKJ
         0reVKlpOhAk6nDg8M7ntlmghn/e4CVXDJpsHHFf26rPqmHhGPkWiZxFDSeot5eyOmXAF
         WQ6OH3Q+rgS6D/DmQui41Go4fDuuCe2rHxB54mGtVqBVQjEFTQtPxhbv1C2y6TpzOQHu
         ZpcJ1EXKNMau/4f+zYdgbJ/8lnVABAnwt0fmpAcpLpbrij4LvIdC7RllpyzJ17OjBRwx
         yZ7B3EW+1m+C630IVZU5dkropT79zcdhRHIaK+lq/zrkeSMj3+3pz4dbetWpRdQmd5UW
         sOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5NmqqrwuYo5W7kKF2b+R6mYgbXQW8HK3lyWmDSaoWw=;
        b=Jbfyf6bVzA14+SRR8wnLctV1VLsJnAR4k1KPfxQaoxIHtCXWAjqXMV2xhToQDNU1+M
         DIZpt/sv94FpV3kU+xirHK1TT1cBVQE6AlWthiQ2URjRnDDhdp1hMqXywjGappIj8yzS
         6HWANQaVkZsUihEJ8T6nY9ldkO9W2D/ZERuOnysXFubuigRs5lUGUf8tk836dmzqdo9s
         WHUQuaM3hQXB3PTahHq1affUg7OsAAmDMDkUPBRJ4VghiwxVLtQn3tKICQNq5TfNjvMi
         rGwzgzSSmCHRaNfzvfqDXwBg6aMCILGcaxjq/sOE0PtAhCzQMaZZ2kJVkuww6E2tsHKx
         Y2MQ==
X-Gm-Message-State: APzg51DNIBn1Wzd8kUvFV800xsQpio5j9b8DuIcsnfgL/UeVIg094KYj
        Z5k+/W+WZZmJbL3f/ZnTzSk=
X-Google-Smtp-Source: ANB0VdYjG2j9MioxVKYxm7HJqcb7oiYHwSfuBZIE6nWaWgQr0aqCF2F3fIgjpSiQbrhmgNWC9Gi7Ag==
X-Received: by 2002:a50:b4db:: with SMTP id x27-v6mr18169331edd.155.1535397764321;
        Mon, 27 Aug 2018 12:22:44 -0700 (PDT)
Received: from xux707-tw ([109.78.255.120])
        by smtp.gmail.com with ESMTPSA id x44-v6sm33574edd.1.2018.08.27.12.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:22:43 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:21:36 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 01/17] staging:rtl8192u: Remove unused defines - Style
Message-ID: <20180827191648.GA19692@xux707-tw>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
 <20180821171537.9330-2-johnfwhitmore@gmail.com>
 <20180827172719.GA27393@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827172719.GA27393@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 07:27:19PM +0200, Greg KH wrote:
> On Tue, Aug 21, 2018 at 06:15:21PM +0100, John Whitmore wrote:
> > Remove a number of unused constant definitions.
> > 
> > This is a coding style change which should have no impact on runtime
> > code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h | 5 -----
> >  1 file changed, 5 deletions(-)
> 
> Is this series a duplicate of a prebious series?
> 
> it doesn't apply at all to my tree now.
> 
> totally confused,
> 
> greg k-h

Sorry didn't mean to confuse you, but now you've got your own back ;)
After this message I got an automated email to say that the patch
had been applied. I'll give it a few days for the changes to make
it into staging-next and if needs be I will resubmit the patch.

Apologies also for sending a snap response from gmail web App. I
still haven't learned that it adds html by default.

jwhitmore
