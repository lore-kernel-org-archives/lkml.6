Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2390FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29712083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qca.qualcomm.com header.i=@qca.qualcomm.com header.b="Kbuka5D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29712083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qca.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeFSHT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:19:56 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:14464 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755463AbeFSHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:19:55 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 03:19:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1529392795; x=1560928795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkzrQAu6JYiOdbQtMqjBU2Bx+KEuNoIkRxwTuqtuHpk=;
  b=Kbuka5D3bHOfYXpSI/3LKFbEb1AXldhZ9HtBWF0mA3Su4tUQmUVstI16
   0bpaPie5gXssAXCcHBvhepcjax9Rwlv8MfxMQrI2eW/muudq/hF4c6nZl
   Emqnlx9ljPjfY74Q0jD8WpKS1CSDSksCtNlXT0eXH26RRUZrA4jtrx1KR
   o=;
X-IronPort-AV: E=Sophos;i="5.51,242,1526335200"; 
   d="scan'208";a="620473"
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 19 Jun 2018 09:13:39 +0200
X-IronPort-AV: E=McAfee;i="5900,7806,8928"; a="3269035"
Received: from euamsexm01b.eu.qualcomm.com ([10.251.127.41])
  by ironmsg03-ams.qualcomm.com with ESMTP/TLS/AES256-SHA; 19 Jun 2018 09:13:39 +0200
Received: from euamsexm01a.eu.qualcomm.com (10.251.127.40) by
 euamsexm01b.eu.qualcomm.com (10.251.127.41) with Microsoft SMTP Server (TLS)
 id 15.0.1365.1; Tue, 19 Jun 2018 09:13:37 +0200
Received: from euamsexm01a.eu.qualcomm.com ([10.251.127.40]) by
 euamsexm01a.eu.qualcomm.com ([10.251.127.40]) with mapi id 15.00.1365.000;
 Tue, 19 Jun 2018 09:13:37 +0200
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     Govind Singh <govinds@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>
Subject: Re: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
Thread-Topic: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
Thread-Index: AQHUB50KryeRyjUyzkaaT9hZMzSgJQ==
Date:   Tue, 19 Jun 2018 07:13:37 +0000
Message-ID: <87muvrdza9.fsf@qca.qualcomm.com>
References: <20180605123304.31969-1-govinds@codeaurora.org>
        <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
        <974e34efd334d921e49d08df879c1b97@codeaurora.org>
In-Reply-To: <974e34efd334d921e49d08df879c1b97@codeaurora.org> (Govind Singh's
        message of "Tue, 19 Jun 2018 09:36:05 +0530")
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.106.107.6]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Govind Singh <govinds@codeaurora.org> writes:

> 3) once supported pd info in known to Q6, tftp client in Q6
> establishes the connection with tftp server in Q6 for user pd loading.

This sentence doesn't make sense, should it be that the tftp client in
Q6 establishes the connection with the tftp server in user space?

--=20
Kalle Valo=
