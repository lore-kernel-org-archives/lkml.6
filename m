Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160574-2-10629921094963247816
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
    1527160573; b=kNJPLwcQ5s3pz8nOtezt4XK+YDlLaHH/5nCIpxxqx1zqCLr/Q/
    Kai3WSNULHnTlfQTD6khC633pZR06r5vXcpqVZFz1lY5R+qtl0YLIgjKaE1teecP
    OupQ828pIWsxNNc1pulz66wtI31p05Dk2rQlPF/IujrFDeqqAQy5j92CxAjHALZX
    g92vFFe8G0wvNkbsvm5bj498e5sajE3QpeDRUfKAmTWg896FoO1AEYafKXmnrlrr
    IrIQkx5Pw0Cm6sPS8PHSz+eBpG2a9QmAWw8ldfC4XKZpLkM3/dJzFoJRIT9G29Ts
    BURmCFhvJ8qHC7SVpS+cYEwpV3G2wraKQLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160573; bh=FRL4TAkBx2J8ynzd4ExLDxU77px6B7
    TlZLqC3zVgRz8=; b=FpYlQNGZoEyYpw8z/N3BemhLx4n7YQc3f7tBpK7lXmhsvS
    i/o/4D0c8/JNhTz0dtMxrG3En3LVNw6yYcP8S3paFmueycaZ/iUwvGZH0ZCJzge1
    hgM3oSGRgwIiySHFhr4k6FIWsWLNNV5uD1++RJlWmKF7LHyxJ0e1DaKd77MhHQsM
    uShbPVS6oM2EFfkA2YxZtkA/eoJ5eMHDDvnuYIarfm7UNTwtSsgjaNw1IcMrnWbh
    yA4lOtDqXlrvAxXvoKoNN6SkplpKMRUZNy24pBpcmoXd3tEkQ+NF34APbZvrl6xw
    RgJ7YBEevgmTDtJSr5dyL/+Eo/gkLw3vAPYLuSxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=feMnQ5oq x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=feMnQ5oq x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfA7YhAlrapxE58QhNcnsuBRqNNG+pHrpZpQavgmknIP1ye/aRJRaQHPCxckm4B/WjC6RteNDUuoM5rNcydMYRMxTNyQ1VCcq5N8pMvAU/hYuZeLJXRKN
    g/VDJgIOabP8josaGlroglnkLJTSkxirheYZTVLNm9rcZm4G+qVHdDxzfzKgTJbar+/wg34rZ6ASbtO3ZTD+h5cHOdznoUWmdAtIik00qhnyHcUM6e/gw/12
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PPvH6gBIAAAA:8 a=hD80L64hAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=mXfCqF82CJrjqBmwVF0A:9 a=QEXdDO2ut3YA:10
    a=N5Oz3-3tIhgPr_IzXtv_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967774AbeEXJxh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968054AbeEXJxf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Opasiak <k.opasiak@samsung.com>,
        John Keeping <john@metanate.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 054/165] usb: gadget: f_uac2: fix bFirstInterface in composite gadget
Date: Thu, 24 May 2018 11:37:40 +0200
Message-Id: <20180524093624.209719956@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -528,6 +528,8 @@ afunc_bind(struct usb_configuration *cfg
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
+	iad_desc.bFirstInterface = ret;
+
 	std_ac_if_desc.bInterfaceNumber = ret;
 	uac2->ac_intf = ret;
 	uac2->ac_alt = 0;
