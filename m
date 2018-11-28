Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B5D206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zh57Ea+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B5D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeK2Krn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58156 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeK2Krn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:43 -0500
Received: from zn.tnic (p200300EC2BC0240021C853CE8979B2E0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:2400:21c8:53ce:8979:b2e0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C07901EC02B8;
        Thu, 29 Nov 2018 00:44:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543448660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GGKhNtFqT6BgwsLkRHVSYBMvWLRJn6kozrfo9Xs32ss=;
        b=Zh57Ea+NXm/bBy2bo6BQXv6Linb1jhBpjRA+6H/0YIYskvS+LUF1DxsJv9HBhOTDy2BiRN
        m8s2ya50PD898VZ0plrxZW5Ej+QOC1iZVKQSLgx/PTBwlMHZYwWppx8hlMSArUE/SWvgjr
        QbZHfsyaAWf5Q2davYmOFN1Yc8p6WPo=
Date:   Thu, 29 Nov 2018 00:44:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tracy Smith <tlsmith3777@gmail.com>
Cc:     york.sun@nxp.com, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: edac driver injection of uncorrected errors & utils
Message-ID: <20181128234415.GH16830@zn.tnic>
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:14:24PM -0600, Tracy Smith wrote:
> Is there another way of creating an uncorrected error without crashing
> Linux using the layerscape driver? I would like to see a UE error
> collected without a Linux crash scenario because I need to validate
> UEs are being collected.

It depends on whether the hardware is causing the crash on uncorrectable
error to prevent data corruption or the error handler is calling panic()
or somesuch. If it is the former, then you need to disable that feature
- if at all possible (no clue what that platform does).

If it is the latter, you can comment out the panic() for testing
purposes only and inject then. For an example what x86 does, see
"tolerant" here:

Documentation/x86/x86_64/machinecheck

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
