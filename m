Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1738DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1342173B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcepZJFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfAEByi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:54:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41210 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:54:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so19072300pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ik+cdxDc9QECPXpiHGct7yeImX1xxs5vHB/0mlBzmdk=;
        b=DcepZJFrBJ3b6Al4QnH7xYdg4jIZjyj15F2wjqCNPoLlJEyqvTu3Fs+xGC63SAnXyG
         IhYHT2mok2TjP5GoaGHULE4JxnQPbxt7Y7Rnl/POGeGAFayCMESBdAljp/elPEi2GcUF
         yuLZMkbOeJ9YrnbAjglsgExy0Ey8mQEh08z+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ik+cdxDc9QECPXpiHGct7yeImX1xxs5vHB/0mlBzmdk=;
        b=fK6JibEyMoBb81ZjXUL++nXIgJBtX7adKz0uko9/ima2j6wcgmgUL8oR9YQlktU+VY
         MbavFfimOku+7Vx0IchvD5hTPb9BMcMJUB2jES2OZkoEZ4sHGjB7uULceUtmEwCWlcy5
         oaYgW/GLXfvVRWIWR49tjOJ6dlII0UJcLnBb8tgzpTJSmW7PGJMbWPQl2kkEJLmdqYvc
         P3EgkzwsVXTqL3amWUyLdA+o9LK6nR7SLxdjHIhrf3J9kmUeJujo6b0i5EBUlLjmbt/A
         qcErOTCslOgFHdUD+bXLJbBRosjLA5D/JU6fMtmksbn8QVXzBLxfjbxTxl60d01qGlBp
         KGIg==
X-Gm-Message-State: AJcUukeySEozRcTEdkxxZUbbW8u8rTtIX4p1tjwNsp/KMlUAI7evFn7o
        OBDMXm6Z3dkbBbabOh54zy9Ljg==
X-Google-Smtp-Source: ALg8bN5x5PXB5AZwqBRf6338kO/lqPWOVXWLL0AP8vQNQ+c0X4iDfaovk8vEGSEfywz/5pC9WGurkA==
X-Received: by 2002:a65:4904:: with SMTP id p4mr3549861pgs.384.1546653276365;
        Fri, 04 Jan 2019 17:54:36 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b7sm85023031pfa.52.2019.01.04.17.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 17:54:34 -0800 (PST)
Date:   Fri, 4 Jan 2019 17:54:32 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190105015430.GA67838@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com>
 <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder>
 <20190104001158.GA200069@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104001158.GA200069@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Thu, Jan 03, 2019 at 04:11:58PM -0800, Brian Norris wrote:
> On Thu, Jan 03, 2019 at 04:01:45PM -0800, Bjorn Andersson wrote:
> > I share your concern about this, but I came to suggest this as the
> > driver cares about platforms but the firmware is (often?)
> > device/product-specific.
> > 
> > E.g. we will serve the MTP and Pixel 3 with the qcom,sdm845-adsp-pas
> > compatible, but they are unlikely to run the same adsp firmware. This
> > allows the individual dtb to specify which firmware the driver should
> > use.
> 
> I understand this, but that still doesn't mean we should be suggesting
> each DTB to clutter the top-level firmware search path, especially since
> lazy people will probably just use "modem.mdt" and similar. That means
> you no longer can ship the same rootfs that supports both QCOM and
> <other> modems, if <other> modem also uses the same lazy format.
> 
> It seems like a much better practice to at least enforce a particular
> prefix to things. e.g., the driver could assume:
> 
>   qcom/sdm845-adsp-pas/ (or if you must, just qcom/)
> 
> and your DTB only gets to add .../<your-string-here> to that path.
> 
> In case it isn't clear: I think it's also severely misguided that the
> existing driver gets away with lines like
> 
> 	request_firmware(&fw, "modem.mdt", ...);
> 
> today ;)

To add to my thoughts, since I think maybe Sibi was a little unclear of
my thoughts:

One of my primary concerns with the existing approach is that it's
basically a complete free-for-all. We should have some minimal standards
(enforced in code) such that our DTB can never point us at something
like /lib/firmware/<other-vendor>/foo.bin (or /lib/firmware/modem.mdt;
or lots of other bad examples). This could probably be done simply by
always prefixing 'qcom/' (I don't remember -- does request_firmware()
follow '..'? e.g., 'firmware-name = "../bar/foo.bin"'.)

As a bonus: it would be very nice if we can provide a little more
structure by default, and avoid arbitrary hierarchy in the DTS. That's
where I brought up ath10k's "variant" as an example; if we can use
'compatible' to capture most of this particular Hexagon core's
properties, then we only leave a single level of variability to the DTS.

But I might be off-base with the "bonus" paragraph. So I'd also be
somewhat happy with something much less ambitious, like just a built-in
prefix ('qcom/').

And you can also just ignore my thoughts entirely (and I'll be even less
happy), since Rob did already provide his Reviewed-by ;) I mostly wanted
to give food for thought, in the hopes that something in here would help
improve this a bit.

Regards,
Brian
