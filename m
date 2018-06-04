Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1803419-1528128882-2-2853635053976149046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528128881; b=KS49jDm+SberEUc1Xaa/2TVK4sVwBEQgCvYtyoceoS3++eVjI2
    anzrMlcR+FC/eyHHN7raCSXja645DfnKo68hdPRgfmLtcaUIc45MpOcb4j4XRefl
    MoRoSkwWqsplr+TWZ8j8xpLILs5328bf9pSyF2+ir0Mz+W/kanle5Nko8S+RoFCv
    MXRQLIx+NdkovwasrjHIGzK8sozEdhJUGmworP1rs10QgYfWYHo9csWvTUorPqVn
    pvsVD6L6xi9R934ZAQbdUTwW4Pul9Hmd8rBuJBMNgmw+tmYUTNy1xVTSP1V8Vet8
    bLxYg1uj7IlMQubB40Uk19wSv701JpditSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:from:to:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1528128881; bh=47J1XykScNATtJ5eAjoUMch
    FxnXf/xwLB+R+dgYCoVU=; b=QfSIVU9oYD9VX7RzY0P7J59ebR0G2ZJey/m84l2
    BihjrIJKtTl9CMMOHAchFXlxKvKsKeCgDaZK39wc0FE+1pA+WjmHXneB2fjxWA+w
    2zljdRD3qkQeT/tH0QxBcIAn4Hk7nC4ikJE/SyWK2gAMjNb73xWBi3vyTSEd8MRq
    gRaEA3Nr9bTc36Cwek+jQWtY9dhCwDxIbz+pZgY8lip7IouEGLIgIzU71MKRl6zW
    u0isxM7GnmjkV4BCyZ093qUonRyN35p5AOeoScA+rUG20+agBy0b//cq8e08TOBy
    2+dWCRs6fIZRYkUNvwwK4OF3WRSTQQvl2M6wiwq/wlPnUZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=dellteam.com header.i=@dellteam.com header.b=oN1TtMEp
    header.a=rsa-sha256 header.s=smtpout x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dellteam.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=dellteam.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=dellteam.com header.i=@dellteam.com header.b=oN1TtMEp
      header.a=rsa-sha256 header.s=smtpout x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dellteam.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=dellteam.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0U0Ug2wcll1vzoEGSyC8GMK8YDQrT8FqAXSnFfwmjPHxBN+SCrW3l2yVeEpKKI+zKkcdFM8H2n+VlTGlcHa1FfnrS0w3p2IFkieF6guzAUwvegdVhH
    3AphfIOiO386tfCD4r8qJjyzGR7DMlXjTn1s5+ZGed7vZS+MCp1HxeD8tccex2Qz8JlX0//G4jOhJrJF17vOSMICbZIf08NzQoZ3xAcw9pMyxMZsbLucTOAJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wCHvqnb4SGkA:10 a=kj9zAlcOel0A:10
    a=7mUfYlMuFuIA:10 a=61qQ6bqwk63o1NBio6sA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeFDQOj (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 12:14:39 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:56845 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbeFDQOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 12:14:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GTAQAvZBVbmGKa6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQXgQ0ymGCBeZZDC4FHgyWCEyE4FAECAQEBAQEBAgEBAhABAQE?=
 =?us-ascii?q?BAQgLCwYoL4I1IoJUAQUnEz8QAgEIGB4QVwIEARqDGoIBqFYziD+BaIhCghOEH?=
 =?us-ascii?q?IRzhVQCmG4JBY5WgUSGW4UDK5B0gViBdHCDFIItjiCOboEZAQE?=
X-IPAS-Result: =?us-ascii?q?A2GTAQAvZBVbmGKa6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?XgQ0ymGCBeZZDC4FHgyWCEyE4FAECAQEBAQEBAgEBAhABAQEBAQgLCwYoL4I1I?=
 =?us-ascii?q?oJUAQUnEz8QAgEIGB4QVwIEARqDGoIBqFYziD+BaIhCghOEHIRzhVQCmG4JBY5?=
 =?us-ascii?q?WgUSGW4UDK5B0gViBdHCDFIItjiCOboEZAQE?=
Cc: <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.49,476,1520917200";
   d="scan'208";a="200957634"
X-DLP: DLP_GlobalPCIDSS
From: <Alex_Gagniuc@Dellteam.com>
To: <keith.busch@intel.com>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: access.c: Piggyback user config access on
 pci_read/write_*()
Thread-Topic: [PATCH] PCI: access.c: Piggyback user config access on
 pci_read/write_*()
Thread-Index: AQHT/Bt0fiWdh+4fjkeQtPKc7fe5pg==
Date: Mon, 4 Jun 2018 16:14:36 +0000
Message-ID: <02be2689d0b44afdb449b4dc17415b8f@ausx13mps321.AMER.DELL.COM>
References: <20180604154803.14185-1-mr.nuke.me@gmail.com>
 <20180604161213.GA7712@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6/4/2018 11:09 AM, Keith Busch wrote:=0A=
> On Mon, Jun 04, 2018 at 10:48:02AM -0500, Alexandru Gagniuc wrote:=0A=
>> +++ b/drivers/pci/access.c=0A=
>> @@ -223,16 +223,9 @@ int pci_user_read_config_##size						\=0A=
>>   	(struct pci_dev *dev, int pos, type *val)			\=0A=
>>   {									\=0A=
>>   	int ret =3D PCIBIOS_SUCCESSFUL;					\=0A=
>> -	u32 data =3D -1;							\=0A=
>>   	if (PCI_##size##_BAD)						\=0A=
>>   		return -EINVAL;						\=0A=
>> -	raw_spin_lock_irq(&pci_lock);				\=0A=
>> -	if (unlikely(dev->block_cfg_access))				\=0A=
>> -		pci_wait_cfg(dev);					\=0A=
>> -	ret =3D dev->bus->ops->read(dev->bus, dev->devfn,			\=0A=
>> -					pos, sizeof(type), &data);	\=0A=
>> -	raw_spin_unlock_irq(&pci_lock);				\=0A=
>> -	*val =3D (type)data;						\=0A=
>> +	ret =3D pci_read_config_##size(dev, pos, val);			\=0A=
>>   	return pcibios_err_to_errno(ret);				\=0A=
>>   }									\=0A=
> =0A=
> If it wasn't for the block_cfg_access check for user access, this would=
=0A=
> have been a nice code reuse cleanup.=0A=
=0A=
Great fresh catch! I'll get that fixed in v2.=0A=
=0A=
Alex=0A=
=0A=
