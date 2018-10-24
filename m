Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFD8C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B262075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B262075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeJXXXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:23:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35356 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJXXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:23:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so5316059oth.2;
        Wed, 24 Oct 2018 07:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gsgGgBe2ayl8tVgI96Uzufi9WAt/ExPaCGGCjQQkQY=;
        b=QdZzi/T03wjr+89qD+Dg9zncsIeKtbF+DU3rZvSdXQ0O/I4OWk8rODcFipyT8adLvR
         lewbzcRr0q0DrpDZ7cw0zS/qk/Fv98xnRAmstlPTqR21i1cxZRGdnDMEiV+5E/cnI+JN
         Ntp5MUYFuOB20aE9srzoaQISbGVpS8W1jpZoa2jKUeuBYzeu353/CAyKLtwnlseUoiVO
         IXC/ZEf1gmXHQMNjDtDVPSzpzD0x+L6TM3+zHAqrXESSxeoLl3Q5PW3vAoZIWr37Q60x
         ILPg1pjULxp6emhjGSh3QJ6qW08UL01g9bKerUkoxlHccq4DilwisN65BFWaC6IMIemn
         7wcg==
X-Gm-Message-State: AGRZ1gJEd5BLytiKWelBoHrHuspLAdZejLFZg2x00Chr3Q84gpWs5n4a
        eFhK2WKUzX07aWgJ84frVQ==
X-Google-Smtp-Source: AJdET5dHmPsj2iE+vFzTn1p0Co7bBqI12lSUwWBixi4q7wTXcnCWQslWrLfqIKQnoZ1vZ926vlVxMg==
X-Received: by 2002:a9d:7519:: with SMTP id r25mr1435984otk.231.1540392876333;
        Wed, 24 Oct 2018 07:54:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u43sm1704128otf.56.2018.10.24.07.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:54:35 -0700 (PDT)
Date:   Wed, 24 Oct 2018 09:54:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181024145434.GC9327@bogus>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
 <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 07:07:57AM -0500, Dan Murphy wrote:
> Pavel
> 
> On 10/24/2018 04:04 AM, Pavel Machek wrote:
> > Hi!
> > 
> >> The LM3697 is a single function LED driver. The single function LED
> >> driver needs to reside in the LED directory as a dedicated LED driver
> >> and not as a MFD device.  The device does have common brightness and ramp
> > 
> > So it is single function LED driver. That does not mean it can not
> > share bindings with the rest. Where the bindings live is not imporant.
> > 
> 
> It can share bindings that are correctly done, not ones that are incomplete and incorrect.
> 
> Where bindings live is important to new Linux kernel developers and product 
> developers looking for the proper documentation on the H/W bindings.
> 
> >> reside in the Documentation/devicetree/bindings/leds directory and follow the
> >> current LED and general bindings guidelines.
> > 
> > What you forgot to tell us in the changelog:
> 
> I can add this to the changelog.
> 
> > 
> >> +Optional child properties:
> >> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
> >> +				the a higher brightness level.
> >> +				Range from 2048 us - 117.44 s
> > 
> > The other binding uses "ramp-up-msec". Tell us why you are changing this, or
> > better don't change things needlessly.
> > 
> > We don't want to be using "runtime-ramp-up-msec" for one device and
> > "ramp-up-msec" for the other.
> 
> This is another example of how the original bindings were incorrect and misleading.
> 
> The LM3697 have 2 ramp implementations that can be used.
> 
> Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
> different end user experience.
> 
> So having a single node call ramp-up-msec is misleading and it does not
> indicate what the H/W will do.

The existing ones aren't documented (present in the example is not 
documented). This seems like something that should be common rather than 
TI specific. Though it also seems more like something the user would 
want to control (i.e. sysfs) rather than fixed in DT.

Rob
