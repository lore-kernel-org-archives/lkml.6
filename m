Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A264CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D524206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXlGp+v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfAJPtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:49:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42689 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfAJPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:49:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so13468521qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UzCHN6ZAYfuc+bAQ6pxUDfDKwJ3nHkac1f0dov90bVc=;
        b=GXlGp+v71dHwIXM2GMAjfxUkBb//yY5taoCw5mJOGIEhwcuwbLYSnMxM1amea+lj+X
         +fgVqRytyvHNt4AOtomFmGess4SoYoZoaVrfTwqh3z41m/BJs0xqYaJqkhXKxdCKcKGq
         +JCS8lhfcD2uR/y81zhJWYJV2vYMvblVO4J5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UzCHN6ZAYfuc+bAQ6pxUDfDKwJ3nHkac1f0dov90bVc=;
        b=gfM9MZpAf1iSJAtXe83+JRnKYfewYoFUs2IK+J/fjJ6wpgteraJv+SdYRhfyTh+3hv
         +6Pc4k3mPSkwV3yOc78RHRvjllxi1HUHBKReYa8jKKD7G4gtDonX/iOArLqQRK35jrD8
         1ALy3B2QH4aBfCauu5IN8v/iqBSBR//lr/Wo074OvL3Gi/YamMFOPA6826wtUM5t+p9n
         Eqv0wgXrJQAhuyk12Tr3da7L4hLU4Wp4phgfpAxZ/RdunR60Qmw7fgt7xEcd0B89AnQs
         8r0Uvqe6lx1sA1tYpdTKoJ9UgyJnFLNCXqazuakjAxAfFBjzHOWzth4vUek5726uScT1
         gnvA==
X-Gm-Message-State: AJcUukcqOMjO1nhMmz9p+yK8MpJ+RQ8P1Pz7DcrqwYGDeQ6zwaoXedrX
        uLn5xJvXNYuw5ESSuL+FeeJicQ==
X-Google-Smtp-Source: ALg8bN7jFpIPweZZQarWLl3QA5Pf/TMswCi0ehHSF1gzqlsrz+FFsDt0fGYpHnPTM87XsoH4KdsFBA==
X-Received: by 2002:a0c:96c9:: with SMTP id b9mr9881168qvd.238.1547135351421;
        Thu, 10 Jan 2019 07:49:11 -0800 (PST)
Received: from google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.gmail.com with ESMTPSA id 20sm46011180qtp.54.2019.01.10.07.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 07:49:10 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:49:09 -0500
From:   Kyle Williams <kdgwill@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] USB: quirks: Check device interface LPM capability
Message-ID: <20190110154909.GB142026@google.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
 <20181208014724.951-2-kdgwill@google.com>
 <20181212113709.GA20058@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212113709.GA20058@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:37:09PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 07, 2018 at 08:47:21PM -0500, Kyle Williams wrote:
> > From: Kyle Williams <kdgwill@chromium.org>
> > 
> > Description: enable the ability to disable LPM for all devices matched
> > by interface information
> 
> Why have "Description:" in here?  Of course this is the description :)
> 
> And the subject doesn't make much sense, what does this have to do with
> quirks?
> 
> Also, you need more information here in the description about why you
> are doing all of this, as it is, I have no idea why this patch is needed
> at all.
> 
> thanks,
> 
> greg k-h

It seems the underlying issue has been solved in
0472bf0 xhci: Prevent U1/U2 link pm states if exit latency is too long

However, the patch to fix the issue when matching the USB_QUIRK_NO_LPM
quirk by iterface could be useful in the future. Currently nothing will
happen that quirk is matched by interface instead of by vid/pid pair.
Is their anything that would need to be changed besides removing the
Description tag?

-Kyle
