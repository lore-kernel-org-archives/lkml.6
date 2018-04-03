Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1832042-1522770990-2-15865680103895896296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522770989; b=Bi8ttmBpzefC571OWJxj2GeTSmLnZdkXVpf+9SrSy1b3d/EJwT
    hoBkrnoyXJtpszCkVgCfIM2DUUdqEiDpLYYn5nGAB3HRiRP+LnSfMDuwmaXR2Baz
    LF3BhMzGu3StnrvPdy5GbTZ0L49gX8sH2TN2P3Vk3hHpLDrLsp9OeGTAh5fkQN7p
    uvQIcZtVx0l42DbWxs3KJodpEtsC6r2RVfVYsvMh73jQjgvuKl8IbKlX24hArMH7
    1Eq1I3DAusebPS/eu1o7DKM2JTn7g2Lia54D0f/Grs13zraH0GwBxgGpvpHfDi7M
    AK1WN3r1B5EqrZj8HnOTvklEI52U2I6YeWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522770989;
    bh=DgLvjnQGtrmMkTvSHydPeM1+q6+dCTkITtAV/k5XKtY=; b=CQ3hEkkHmpUd
    XuJndKYsNoMn3ns3Uvtv89nqPGlrMoJJyt9CWaoXLxd0bpDXlb07egqFq4Coo2ek
    Fjmp3/zo7xN2+XP9a4S60/di3cTa6Cicudd3yOJ68Fy15kkTmunZLvJyOR1WqjiE
    NYDyL4JHbxLRYpeXcQZ8cSp4Yr01vopZ0WB+0pyo8aX/whKArSait1fF213k7Y6o
    oKSIrj0dqekcjzUDK4EIp5cCmm6mCxXBNpCD0rJD4VQwCp56E5RNmCyR4F6wpqeQ
    LfleZLr2Gm8OinBRJwI2klwUUR8dlzBuBqnYQM/Gyao3DnprBAAhzonRzizlLADS
    1DrAWnY30Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI5UKFIigLen6oOWdLK8QAUQGka8gnzJqmf0+MyU5Y/tbBIEICxKeA7kgeSmn/0L8F7sTTD0zvx9DSfMx8245/Grof0hh0um9AhDUuOjohOGsa9BUbOu
    99uwqX+H3/03bIDjGNq2rfCy38ol2FjJTGWz9tq0vTaOaOn1fL/DO0JaeiKAvuVQPkMuZrqzDAyKenjyNnfD69tvHHFxEH7/apUZKDcoW2v/S3oH5Z3o5LPX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=DtbWpz0cv7c7yaWVm8MA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeDCP4T (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 11:56:19 -0400
Received: from osg.samsung.com ([64.30.133.232]:57924 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeDCP4R (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 3 Apr 2018 11:56:17 -0400
Subject: Re: [PATCH] usbip: vhc_hcd: prevent module being removed while device
 are attached
To: Greg KH <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
 <20180403065618.GA1093@kroah.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6022b8f0-821a-2d1c-8032-4b298835feae@osg.samsung.com>
Date: Tue, 3 Apr 2018 09:56:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403065618.GA1093@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/03/2018 12:56 AM, Greg KH wrote:
> On Mon, Apr 02, 2018 at 02:52:31PM -0600, Shuah Khan wrote:
>> vhci_hcd module can be removed even when devices are attached. Fix to
>> prevent module removal when devices are still attached.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  drivers/usb/usbip/vhci_sysfs.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>> index 48808388ec33..6a54b9aa92be 100644
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/net.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> +#include <linux/module.h>
>>  
>>  #include "usbip_common.h"
>>  #include "vhci.h"
>> @@ -252,6 +253,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>>  	if (ret < 0)
>>  		return -EINVAL;
>>  
>> +	module_put(THIS_MODULE);
>> +
>>  	usbip_dbg_vhci_sysfs("Leave\n");
>>  
>>  	return count;
>> @@ -302,7 +305,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>>  	struct vhci_hcd *vhci_hcd;
>>  	struct vhci_device *vdev;
>>  	struct vhci *vhci;
>> -	int err;
>> +	int err, ret;
>>  	unsigned long flags;
>>  
>>  	/*
>> @@ -339,10 +342,18 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>>  	else
>>  		vdev = &vhci->vhci_hcd_hs->vdev[rhport];
>>  
>> +	/* get module ref to avoid being removed with active attached devs */
>> +	if (!try_module_get(THIS_MODULE)) {
>> +		ret = -EAGAIN;
>> +		goto module_get_err;
>> +	}
> 
> That's really not a good idea, trying to grab your own module reference
> is considered racy and we stopped adding that code pattern to the kernel
> a long time ago.

Thanks. Good to know.

> 
> What's wrong if you remove the vhci module if devices are attached?  You
> can do that today for any other USB host driver, this shouldn't be
> "special".

This is a virtual device associated to a real physical device on a different
system. My concern is that if the module gets removed accidentally then it
could disrupt access to the remote device. The remote nature of the device
with several players involved makes this scenario a bit more complex than
a regular usb case when device is physically on the system. It is probably one
of the minor problems that could happen with a remote device.

I found a few modules that hold reference to themselves in the kernel. Block,
crypto, net, md, vfio, nfs.

md for example holds reference to itself when it creates a blank device.
vfio get regerence to itself it when opens pci and mediated devices.
Some network drivers do the same for handling virtual functions.
nfs does this for rpc handling.

I am not making a case for adding one more, however I am curious if this
vhci_hcd falls into a similar special case of handling virtual connections
and devices.

> 
> Also, kernel modules are never automatically removed by the system, so
> someone has to do this by hand, so they knew what they were doing :)
> 

Yes. This will not be a usual scenario. The question is whether not kernel
should detect driver is in use and prevent it.

thanks,
-- Shuah

