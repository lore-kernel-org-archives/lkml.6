Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-9445-1523640824-2-18084225539934627331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523640822; b=r1hktvNQQ4NINo0S9Fz2OHo8nilS6qQaQP7AQ00x4qnOPTqost
    c6uCJ1tpGN+eDizfKkUgG8iEEwWfK99Rq8pNvYWPGGPd1BgYMEex1e7iFrWi33QJ
    smuGqk4L9AWOSYsxZcLWid1nVAAOBKDcvJAIAkO/IA6jbW0D7Q1WqWV95Gtq5wn3
    IoEIoUtD9yXoGaiTQ9KATo0xPyNLx7HB2cyBxjyG1k+NIK21dz6iOUAcvqkE+shV
    q5IPqk4vCHDSp+4cCoAkGvesVsl58Hk1RWw/2sVplKXDe7wKPb6f6qXXqbW8GuHh
    JA/mMxYSXoosv6YDUi14zM+b79n5UoSCRWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523640822; bh=V/lLw9KcSlIEoQv29wh/YvW5elnDqC
    O+gJ4eL5IPkiE=; b=kvxpuuwK8VS0PQy9uhHyULEQ1Kc9Nz/TsVjAcMQ+QIhdO8
    g/v1lwq6/M4/ACPjgsQcbOZPvlLneHuDYHeqQwhmp8A21i+Kxvx2I5ibrcvoLEjL
    5N3gscK3itwJuBFomksT4YCONe/jRMflk8waDeHLJ/B5J1qW44t+cMoZVGREtjAa
    IY9fuuTxBYqPmXgg5Ec7M5kvMiyouVjo1ZOagF27FMiVo0FD6pIB6bzX6hNpgwtH
    dR3vvRSdJp/uRB/Qxsr66T8oIlltwmA3kcgStQtVml+EXYk+FmFEgqUxHqy+3Hld
    guVsDNpd6/0oHOyeLiLJNiimxsP4TWfXI2z7IQmA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=DclZkwpP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=IcfjLaRz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=DclZkwpP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=IcfjLaRz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP8il7dtDoT+DuV3gU+bDy05aeV2USsFfXQxxYqXTnYSBVnjMYhjGKvufcMOMzUfNL5jmng2YVy4cqvpTInUN84b4XYW2Jume2O0Q5N8aRRYKL4sBOhL
    7Q/Gac9R2WTzbk/PN+vbwfXYL/aL8qDvg6hhmMumPR8HbW61bJ2IZWSMfGxeICV40/YGaTxvet5JCNApwYOO+1rv0kA4vmGDQ4t4GxdT0uIYbiok4utBjZ1N
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=NA4y1kQx_IMWiGz-f5EA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbeDMRd3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 13:33:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMRd2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 13:33:28 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BFCF60F8E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date: Fri, 13 Apr 2018 10:33:22 -0700
From: Jack Pham <jackp@codeaurora.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] usb: dwc3: Add Qualcomm DWC3 glue driver
Message-ID: <20180413173322.GA30306@usblab-sd-06.qualcomm.com>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
 <1523638285-5742-3-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523638285-5742-3-git-send-email-mgautam@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Manu,

On Fri, Apr 13, 2018 at 10:21:23PM +0530, Manu Gautam wrote:
> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
> Some of its uses are described below resulting in need to
> have a separate glue driver instead of using dwc3-of-simple:
>  - It exposes register interface to override vbus-override
>    and lane0-pwr-present signals going to hardware. These
>    must be updated in peripheral mode for DWC3 if vbus lines
>    are not connected to hardware block. Otherwise RX termination
>    in SS mode or DP pull-up is not applied by device controller.
>  - pwr_events_irq_stat support to check if USB2 PHY is in L2 state
>    before glue driver proceeds with suspend.
>  - Support for wakeup interrupts lines that are asserted whenever
>    there is any wakeup event on USB3 or USB2 bus.
>  - Support to replace pip3 clock going to DWC3 with utmi clock
>    for hardware configuration where SSPHY is not used with DWC3.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>

<snip>

> +static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
> +{
> +	struct device		*dev = qcom->dev;
> +	struct extcon_dev	*host_edev;
> +	int			ret;
> +
> +	if (!of_property_read_bool(dev->of_node, "extcon"))
> +		return 0;
> +
> +	qcom->edev = extcon_get_edev_by_phandle(dev, 0);

Are the extcon phandles bound to the glue node? I don't see the
description in the bindings doc in PATCH 1/3. And if so, would it be
a duplicate of the child node's extcon binding? Then again, the
alternative would be to grab it directly from the child (i.e.
qcom->dwc3->dev.of_node) which I'm not sure is ok to do or not.

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
