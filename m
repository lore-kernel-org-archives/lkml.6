Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B678AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757382084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYOAd30v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757382084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeLLPxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:53:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40758 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:53:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCFrEvd128567;
        Wed, 12 Dec 2018 09:53:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544629994;
        bh=IRkFaSyvsOf5vf2b5eQr89QFmegthVjV9uUCXEA+Xjg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GYOAd30vU8iOqki+2sgJMJ09Hg+Mu1ffTPETbehi14Xy75dzJB1WGqfYE3vMc67e+
         oxfxSVw0zFvTOkQ9JC3/R5FyY+g6Xpl5WEfQALr36dmYPMig3tUrIwaV81MwdsdpWA
         BpGActErhYKyOFsR+se4YPbndS3bIE2j/+E1jbjg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCFrDkP051833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 09:53:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 09:53:13 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 09:53:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCFrDBg032099;
        Wed, 12 Dec 2018 09:53:13 -0600
Date:   Wed, 12 Dec 2018 09:53:13 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     <pawell@cadence.com>, <balbi@kernel.org>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
Subject: Re: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20181212155313.GA6502@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Peter Chen <hzpeterchen@gmail.com>, pawell@cadence.com,
        balbi@kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Wed, Dec 12, 2018 at 10:04:25AM +0800, Peter Chen wrote:

[snip]

> > >I strongly advise against using dev_dbg() for debugging. Even more so
> > >inside your IRQ handler.
> 
> Felipe, I use Dynamic Debug for debugging, and show debug messages with
> "dmesg" after testing/debugging. I see dwc3 using trace,  any benefits
> for switching
> to trace?

The benefits I see are

- *by default*, the debug log doesn't have to go through uart console,
  which is slow.

  I typically 'cat trace_pipe' from a telnet which is much faster then
  uart. But Dynamic Debug log by default got printed on uart, I have to
  set printk level to not print them, which is an extra step.

- tracepoint uses one place to decode the message vs DD has to repeat
  the similar print statement in the code; and tracepoint decodes it
  offline which reduce the kernel runtime overhead too.

- with tracepoint, it is easier to turn on debug for a specific group of
  messages.

- you can adjust the ftrace buffer size at runtime. can we do that for
  printk? I don't remember.

Regards,
-Bin.
