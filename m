Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4169591-1526659631-2-4802669044601907224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659631; b=HLefj8pDqJw+HXzANE+Gm9m3ntn6m3kLiKrHP9N3+cBwUF7F7i
    QFPQU8IB6hzQ27TnvdfP5aEmsioflP0czEwn0UWVlvE56VzIwBifj7vPZIo0yaAb
    4UKz6Wy2TRytGMGuWPHtB+AXSARQ3VE2k896yXA/wgC26Z18THsSbGaECIQIdiN6
    X2ZUiXrhf70oZlU11Q0pQTsj/mwh+2nDGR8+tlkFmi0ShQavbex4XJBW+GhoSUhU
    unGyXeKVmQcMTbTKe1yvPW7vymLTgEhIwd3+YNvyYiCl/QUB0WaAKd0wdngEtBCx
    KcToH/rvPaZVrOlJpYeCOHM3lqEdC9UhCywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526659631;
    bh=Bd/nFJf9oGQDaWCXT0NlxoJkKM1XHXzjRdEkMCz27fc=; b=hj0S0GOaQqIh
    xZ7AT8jthJ3W/QgxqX8hO6vMF4WC02lSXUBjbqDJJ9MRbdyoHelQBHMKhpRBNWSN
    wpbT04ictclg0lRiPh02kI+nH9yvhqUH5i7tFm0Ikjr9RM0SOyAX8U2Of9aockgl
    D9P4xx5GGjECt19PhRc2WZEnaoKM5z2hJZIoDHp14feJGJAt8bQS4uwP0eVNqFnE
    BX+fDg2vffkhg3TmEThWpGlI40yY7feC8lBkzqYCBc7hH+G6q1eblRxgFBp9rB/N
    54goMSsWkODFLj7E77qXginWjSazYlvDN/wRvXpmEztWBo1nrvl9hipqxTbmr2MQ
    oUEta2K0Fw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK6S/0D2jq3snmezQpAdK2QGekjep2yb2nf6cWiNdmqtbB2+Vm28w4znfUPh5xN2DUvby4ljdXl0dn+HlMEwnOcdxIrtBM/I3aURQgR+cq6p4+a1owpN
    20GjsWstzbAcmyucTtXpiH1XKD1KRWtYSuQ7fbTbi01QwuFp2N6u30r27dHQHVvzvDDqlbMS2egh9YVwe18nQEmVbsavetG/BXjv0CnRJcYHQaIxwdnfd1sk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=7xLxSbQvrZr6QBFMdIgA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeERQGv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:06:51 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:49017 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeERQGt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 12:06:49 -0400
Subject: Re: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180517201628.GA6090@embeddedor.com>
 <20180518134701.GA15598@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <a6e9c635-5749-6fa0-7d1d-c1390d7f61ff@kernel.org>
Date: Fri, 18 May 2018 10:06:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518134701.GA15598@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 07:47 AM, Greg Kroah-Hartman wrote:
> On Thu, May 17, 2018 at 03:16:28PM -0500, Gustavo A. R. Silva wrote:
>> pdev_nr and rhport can be controlled by user-space, hence leading to
>> a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
>> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
>>
>> Fix this by sanitizing pdev_nr and rhport before using them to index
>> vhcis and vhci->vhci_hcd_ss->vdev respectively.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>  - Place the barriers into valid_port.

attach_store() doesn't call valid_port() - can you make the change to
have attach_store() call valid_port() to protect that code path.

> 
> Thanks for the change.  I'll wait for Shuah's ack/review before queueing
> this up just as she knows that codebase much better than anyone else.
> > 

thanks,
-- Shuah
