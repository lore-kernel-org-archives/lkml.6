Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DCCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C414020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Kk7wzPwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C414020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeIJPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:11:47 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39614 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeIJPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:11:46 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2EAA410C1458;
        Mon, 10 Sep 2018 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536574706; bh=qMJ2NaEptd2dsNb7UAO7Q+I07g2t8L/hfgI5s8b5Vpw=;
        h=From:To:CC:Subject:Date:References:From;
        b=Kk7wzPwo38XLd0VLjDp6qgjrEgYkGUgGuMy6lYSeXRNZlhbGEAF9gPUhCEWyZydDb
         E7BwuCi1MeHWS0w/vosy8xZmiKEpmNox6bBRF43Qeii8+pbesBIpTHxVEnfoDewsH0
         MCDakyqwxT9BR1Tk9+w5RocjXEdg2ZkboIbnsEnyqLMuRSe7UEeZVyED5WR26GHl5Q
         tsE55S0wuOWt5627jXQQBpGn6KA7bZAz/rYdz57CPFCK05Wm4dbqRW3LjeE+Pacib2
         LWx5W0QLsfpJWjXt/HvBOwJi+K9V+rfE+m0WBUVoKMi91TlHISpCgE0HbZWnMyAx8T
         lozwfoIQ9eoDA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 099AB5442;
        Mon, 10 Sep 2018 03:18:26 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 10 Sep 2018 03:18:25 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 10 Sep 2018 14:18:23 +0400
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
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
Thread-Index: AQHURQ1adYNtxHiM6kqO8x8tizZ/tg==
Date:   Mon, 10 Sep 2018 10:18:22 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532A5150@am04wembxb.internal.synopsys.com>
References: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.105.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 9/5/2018 15:41, Amelie Delaunay wrote:=0A=
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
=0A=
The patchset has been tested on Synopsys HAPS-DX platform.=0A=
=0A=
Thanks,=0A=
Artur=0A=
