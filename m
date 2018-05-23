Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3452472-1527042301-2-12256379929924251039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527042300; b=FtIG66ziC+28h4xjwcTecgMyHafJYf9cDto9EYk8snOa8yXN75
    1POUWhkDCPmlJFKZAQr+sUmDMz86HHGu/zHWXrH/9FHpAk8DHHWI9HFVV743Pr63
    ryV7oEsKCJQI7uct1iK4bSvym62s4xrHtVlvjmk/fHzM50FrXdWjURLPSMmlntAb
    2faumD0MtqKOB/jShDdGRqgTp+qJjhChzSgQw4oD5YkwjBzUTOSgTgsOvU2xX5hS
    ERL3DGePG4fytkkuzRKATvdd6d8M49zbTn0QcfAhui2nsztj3epDW6GBl8XJ7iE9
    Pd5SMFoh+UqRccGlZdTvQbHHRe/lTE+IRQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527042300; bh=3ug5j7NzslZrorvGaaNpKSdQWtKHfi
    oBZNG9NlFyNKI=; b=eXoYLS7qFAnP66z6DF1Lg7lxE+5ukaW6FI/tDcweW9boJ0
    68u347fBHvSSZGB4OznxTExWCTdmkMq2/wyP/kHz+vDh4FZ9RQ2V8a0OUQlXMIOR
    fRvFSDIgQCBMSygsY46h6x3lr3l5mhWHF41tk1abMu7iiPzCz1pOCpAbKcTPkULK
    8K1zTf8Gym1J5VqriUT+m1GRkR1oBRQYRtVDYqX4p/i7hDNp5ugs2jO4SvJR9u8n
    +4gSpY7iUguNarYfBo77B35XIf0ThR1wSemw3IO2+982dMLMeO0VwkG4nFvPJfgN
    fKV2zIOQeYBhf5MRanRqtHm7aAr3dmsU2r51VVyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wunner.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wunner.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wunner.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wunner.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+IVm55oNPql5ImfD09qCi2hZ9IymNlr2vwr+kk3UkcfGLuDj0DOhYGxjDQciHP0xL1XEtSSBmR7XgAda1kvvWO5HKp0DiFDgII78p4pFoTXUkva2rv
    fWmZymQh8XlQ2dqP6sb3lRFs7ZwaxpOWvdCuvgSOC6iMTv/rHusOf4MHCXNP7U9KE1q7eeOkiOS5/MkFd1A4NyZ52yL6fdwyC/TZhyt5uic2EZTj55ql4j4n
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=nY5xWAMQJNdZdYkv0qEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeEWCYf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 22:24:35 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:57033 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeEWCYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 22:24:34 -0400
Date: Wed, 23 May 2018 04:24:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
Message-ID: <20180523022431.GA15069@wunner.de>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 01:58:00PM -0400, Sinan Kaya wrote:
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }

Shutdown aside, pci_disable_device() is also not called in the ->remove
path with this patch, right?  Seems wrong.  E.g. when unbinding the driver
from the root port device, or when unplugging a port (happens all the time
with Thunderbolt).

Thanks,

Lukas
