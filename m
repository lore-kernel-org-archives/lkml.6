Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1178636-1523948839-2-6416957127128068136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523948839; b=bfkVw+9zyTLdisJ55G0/oIrZy9vi4LreRO6JPloZjLJRCRm9Ci
    i66PO//IVLTMi7/BGs+LfmRtPCSJ5c2P8ZLfthUkY3/ZtDV1aNM0PjUiGYtBv+BO
    em8gaY4rrVV/BByxKc/aW+bg+NzM4k63oujqkmD2oIci1Wb2IRpnMHOQBkQTU59u
    +gWzCkYvZF/YM0G0/1tCw3GuJLGxYz6wue2FCaLbtWZdTxpUjW7B43caLmkH+JMQ
    K1ZiXI4yNC85FCsQqqX7B/92X7jpW/2sN+IdvLZsTdcQN89r/hMQCCKggTBgTA5s
    Tuo2hVVP/zghzXRW1grKD64mErOLP/RFDy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523948839; bh=//t84boOWygn26WE/wc7lKcwsMJPSl
    sKxQjLbiwchrU=; b=SZxsFvAT0ZSuG+GqGtC+NYo7VC+XGrTn5zhaxzRdpuyPXg
    25WMhaUkOS9G2GMIcTG665BNecBsZXmyibD2cN/fpuAa1kWbtAblOtX96XuP4931
    hXsqqNX0cEAr+W7/9pKdb7T+0c2kOBdAdJoiybHBEVWEPfpPJxFcuDnKRoWlVB2x
    ug8n6vxwTYC3hXBm35fAn0kkY5NVq4iMsfPtG2Yq7/AubMJd5MuHFySyhohBy4D+
    +9IXsp1E7vKYPBvadEXt2nY46nxohao/24Q53IsJMFFqSimovK7reazHsttieCR9
    /2GVfmLutMul2vuC1puetQOl7zE449VhYNgHAlIw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=twUNoTFK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F9rJDUl5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=twUNoTFK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F9rJDUl5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfArGuPjRNo3hcZqMoRiH96QAeYeYaFtgvtVOe5nATHiIJKMJct5bJYuprYX1OzPgHn/T9q3Kkvpe9aDN+01E063Cda87YgRVp71LemVV4TKB1O/TKWRD
    QD0bnzmTiqnbe82g+MPRaIgVc5X2tOv85JpebgcvjN+nZEoBj3gk4D6UlqVBaWr6s3zPXCnzvFjxoQAprqaD9N3QHuUzcm9yDqUFXEPhINLIbEprvBSsfTEQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=wA7ap76nvnz9HeOUlkQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeDQHHP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 03:07:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39399 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeDQHHM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 03:07:12 -0400
X-Google-Smtp-Source: AIpwx48aiw4HE7fkBTaA4YDGNJr85CyEd8puYiOT/bbEXtW0IBTVdRPAukYCXHCaZqxIIkQPES8n7g==
Date: Tue, 17 Apr 2018 09:07:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB: musb: dsps: propagate device-tree node
Message-ID: <20180417070707.GB9198@localhost>
References: <20180413151505.32663-1-johan@kernel.org>
 <20180413151505.32663-4-johan@kernel.org>
 <20180416200312.GB14921@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416200312.GB14921@uda0271908>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 03:03:12PM -0500, Bin Liu wrote:
> Johan,
> 
> On Fri, Apr 13, 2018 at 05:15:05PM +0200, Johan Hovold wrote:
> > To be able to use DSPS-based controllers with device-tree descriptions
> > of the USB topology, we need to associate the glue device's device-tree
> > node with the child controller device.
> > 
> > Note that this can also be used to eventually let USB core manage
> > generic phys.
> > 
> > Also note that the other glue drivers will require similar changes to be
> > able to describe their buses in DT.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> I will take other two patches for v4.17 rc cycles, but is there any
> problem if I take this patch for v4.18-rc1?

None at all. That sounds good to me.

Thanks,
Johan
