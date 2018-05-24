Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162328-2-14496089931474349443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162328; b=CDxnxOKvgE1EbMPIu3dwbBpg0CSdx2NdJ9LUhWPCRSEJjSS6GA
    SJXjB6a9s0mOeSfg+3C8jLzYVOk5UeT9AynxRfPreheZcdqFp807s1vq2RMe9fEw
    z/XCSeD0WmO+u5vSyhGtu6mv0K3Ps+YBETFn/3XKw1ePOI8SMWRjyNlztnGAsaFH
    mGMu+jCZK3fJzHiYYV+9d7/QPxtHDyd3OXx+TbBABh8vGRur5xrstouhXKYgfuy6
    pLEuMH/CUDPSbQKac3TowfJtGt6wNGnINXWyZworajLUUlsLXRZkfZadAQDeOuZS
    q63qEZhkuI/0a7RFWehPLSyh5l3Ktg8DS8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162328; bh=TLB7D1L9YVvBkK/+dJJTwI7LaMAxzM
    c1JbbFwCS9R8s=; b=FVPa6QPRS7V0wwQ1HDqJ4c4TvHuHtOUWKoCJPdcKJ+N3s9
    XN0MayqG2uFgL4piDhAW60e0lHnrQAEQ16qSAvVn6RL04U8C5fYb8j0GO9H64ufa
    ROcbzuH0z04gooq5qtoMAsesOIP0yKxC6EVzWzLwzzn+o6v8hqgxM9UEZ5QuVKYN
    mBn6r/iyY6TjtGHf2urRPVyyR3DRIbJMJ+5e9Q+8RFlAu3pi24QMYCHPBPoNL/Vj
    KTAAC4dRzFq83kiKxXEHYMA8bko2BSR8Z3B6esIRGPh/qDRZFCG1dXz4wlLimk2F
    lPxSUkHnkdu/CeuNmZId35L/64jVAxuLCjMBLc8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KcP0yplq x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=KcP0yplq x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDsXdZA+wovGC8L/6Bdb77wGAF9v2C7pPij4u0DhtroJrKSovamsywwnIvHTTSlHwZJC9uJIEv1gY740fham/IYE0wWXDmOMvSnghk11ZPZSvCUc06Md
    S17yuCdhuwMnqPs7sKYm/qBvJ6BhGd8NUQcALK7Sspk0MwqfMbPp9BxKNfLt4FR9FdgMhlE8+810RtK9y4+zg3+sDZGaheE8BjNg/oRpKlatfRr6PCTU2V2e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PPvH6gBIAAAA:8 a=hD80L64hAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=mXfCqF82CJrjqBmwVF0A:9 a=QEXdDO2ut3YA:10
    a=N5Oz3-3tIhgPr_IzXtv_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969077AbeEXLou (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966607AbeEXJsI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Opasiak <k.opasiak@samsung.com>,
        John Keeping <john@metanate.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 24/96] usb: gadget: f_uac2: fix bFirstInterface in composite gadget
Date: Thu, 24 May 2018 11:38:07 +0200
Message-Id: <20180524093606.976127859@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <john@metanate.com>

[ Upstream commit 8813a59ed892305b5ac1b5b901740b1ad4b5fefa ]

If there are multiple functions associated with a configuration, then
the UAC2 interfaces may not start at zero.  Set the correct first
interface number in the association descriptor so that the audio
interfaces are enumerated correctly in this case.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uac2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1040,6 +1040,8 @@ afunc_bind(struct usb_configuration *cfg
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
+	iad_desc.bFirstInterface = ret;
+
 	std_ac_if_desc.bInterfaceNumber = ret;
 	agdev->ac_intf = ret;
 	agdev->ac_alt = 0;
