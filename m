Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B735C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDAB21710
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kNGPB+OO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDAB21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeHRAKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:10:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHRAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:10:34 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7HL5Zd0122326;
        Fri, 17 Aug 2018 16:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534539935;
        bh=tWsMWw4fq21LFTotQodUxuBODVpUe6vgqsmNLpQJO+8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kNGPB+OOHs3GJhiDBUkAf21/Ej0ZJftvBGgrbwp75z5EdrixowUWUNgFOwGQupuWb
         ziN8vQlDO0kpPnciyfmNdrzs33qMeRmtwT0BG3ovps8f534KEIcpEs/gGUiEspLN/K
         TUNS/OOkwUKlkJLZo7jRzb22OJwUsZxTZfxff770=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7HL5ZPS016398;
        Fri, 17 Aug 2018 16:05:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 17
 Aug 2018 16:05:35 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 17 Aug 2018 16:05:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7HL5YZ6013029;
        Fri, 17 Aug 2018 16:05:34 -0500
Date:   Fri, 17 Aug 2018 16:05:34 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>
Subject: Re: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Message-ID: <20180817210534.GA11144@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 19, 2018 at 06:57:33PM +0100, Pawel Laszczak wrote:
> This patch set introduce new Cadence USBSSP DRD driver
> to linux kernel.

Does the driver have to use 'usbssp' as the controller prefix? Is 'ssp'
acceptable? It would make the tons of variable names shorter and the
code much cleaner to read.

Regards,
-Bin.
