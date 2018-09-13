Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49745C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CDC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OZaz/Z9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CDC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIMLbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:31:05 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41776 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeIMLbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:31:04 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 582D324E099C;
        Wed, 12 Sep 2018 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536819782; bh=FvWCKKU8cv6weFSA1Hp6wAFlMkgncqSdeBPx01/Dqec=;
        h=From:To:CC:Subject:Date:References:From;
        b=OZaz/Z9K6pjAUZMO1x4gxF4g82pHZ3SSr0nrAU0/pELFKuDSMppsE1leYfTrUvRmO
         qegN8fizvMJ1m7OkeoLS+ghvU7e+tyXI8MfWcPcY1+E1Og/NgHIX0UdPad1xWxKB0D
         aol5YIU4vCu26tFxpUbsdc1/ogZdzeXmDgUuBVJ/gKNxgpM5acW5/s10ohf6vHyE0L
         /0olabKF4WsPuCPKDvPtX72wEYlAAap2D7QihYX4OWwnqYCq+Gk2FOFnW2oZ8kk0S3
         DiKueZK7T8r0V7vSg2y1AClYGOCd1cuTfDrGxeDMg6PRQdo4QzBT34LTSyYHIFAi18
         tTkDjABfUVnOw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 06D355796;
        Wed, 12 Sep 2018 23:23:02 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 12 Sep 2018 23:22:51 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 13 Sep 2018 10:22:48 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 0/4] usb: dwc2: fix host mode external vbus supply
 management
Thread-Topic: [PATCH 0/4] usb: dwc2: fix host mode external vbus supply
 management
Thread-Index: AQHURQ1CtuXxa1UsAEm+X5SsTyLaSA==
Date:   Thu, 13 Sep 2018 06:22:47 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A769B0C@am04wembxa.internal.synopsys.com>
References: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.57]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2018 3:40 PM, Amelie Delaunay wrote:=0A=
> This patchset fixes and improves host mode external vbus supply managemen=
t,=0A=
> mainly around suspend/resume use cases. It also avoid 'vbus regulator"=0A=
> to be requested lots of times upon each call to dwc2_vbus_supply_init(),=
=0A=
> especially when pm runtime is enabled.=0A=
> =0A=
> Fabrice Gasnier (4):=0A=
>    usb: dwc2: get optional vbus-supply regulator once=0A=
>    usb: dwc2: fix a race with external vbus supply=0A=
>    usb: dwc2: fix call to vbus supply exit routine, call it unlocked=0A=
>    usb: dwc2: fix unbalanced use of external vbus-supply=0A=
> =0A=
>   drivers/usb/dwc2/hcd.c      | 45 ++++++++++++++++++++++++++++++++++----=
-------=0A=
>   drivers/usb/dwc2/platform.c |  8 ++++++++=0A=
>   2 files changed, 42 insertions(+), 11 deletions(-)=0A=
> =0A=
Tested-by: Artur Petrosyan <arturp@synopsys.com>=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
