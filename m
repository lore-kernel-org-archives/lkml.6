Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeBZW2H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:28:07 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45495 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:28:05 -0500
X-Google-Smtp-Source: AH8x2275GaW/8IAKILcgI11QM8geauBbVMEQ4IXntjKAtRnAzm4uLdwlrB3qJpJmbd4eVZmFf0g4Jg==
Date: Mon, 26 Feb 2018 14:28:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226222801.GA5924@roeck-us.net>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
 <20180226205204.p37lf7dcl5k7az37@ninjato>
 <20180226213406.GB2211@roeck-us.net>
 <20180226214307.irourq2svpd7ok7e@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226214307.irourq2svpd7ok7e@ninjato>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:43:07PM +0100, Wolfram Sang wrote:
> 
> > It is an alternate and somewhat simpler solution which does not
> > attempt to change the kernel API. My primary goal was to find
> > a solution for the immediate problem between the watchdog and
> > i2c drivers. My solution does not attempt to fix the access problem
> > for (initialization) functions with no return code. At the same time,
> > I prefer to use functions which _do_ return an error if that is possible
> > since it _may_ after all be that there are other users calling
> > request_region().
> > 
> > Having said that, I'll be just as happy if Zoltan's series is accepted
> > instead of this patch (except for patch #5; the watchdog driver has
> > already been converted to use request_muxed_region).
> 
> Thanks for the explanation!
> 
> So, as I understand: I can apply this patch to fix the immediate (and
> long standing) problem and decouple it from the API change. The latter
> can then still be worked on and the changes for the piix driver should
> then be minimal. Correct?
> 
Correct. Actually, you won't need any further piix driver changes; my
understanding is that patches 1-3 from Zoltan's series can be applied
independently.

Guenter
