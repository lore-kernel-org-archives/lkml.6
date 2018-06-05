Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2311314-1528181719-2-15910678564481891002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528181719; b=DPCt950KcRwl3N8+8rp8OeZpYxwRXR3h8Q5bM2Ka75MeVH2gO0
    rm5ze5UJ+MBnM657Df817OCwChE0UPWBIc2NlMyU/udilD5i1oQBdZw6RCX+L8mB
    RdaoNUt/smi0E6p8WtH8kbNRBDrYWw17vf0Du+QLfhiFqUQl2R9IBweX3mfc1d7Y
    tSLDT51swF5tOkPebhiyBtVgR0zAOdw0XthCo6DdO0SxyGa8Gb2T5TuEYsZak8VY
    4RNJbBcyB627j0o2m7qRofs+V2Db09YO0eDLtcZqdARj59cJ7kYbV1PQFLgsoapX
    ZHWy/FF34Fe/AwXEsGmCJpOSOKr6IcYBNfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1528181719; bh=9p45BzijAaH
    +oGuUxuzd6Npv1RLSmjrbOD9eULO+Jy8=; b=Mgr8JjeegtNMVgilVvp70XlYAvX
    Eb9Y1h/PNS2s+zfN/ugb70HY86noLzZUIOTzVL5lVgPq5YrQGdQtjJyLk3lyOvnS
    rCRWKh1KG1OQHQki2+3jbW2sF5cEzkvdIwVNg7nS5U7MA13UrBjPM88mSjY/YKNC
    MsutkQjNWQ0ryVbc3RyVEiJsBOrAYP0AT0Hal/NRbQObE8aQJyGaRhS62imb0jWz
    BvOqK9kyOkkCSaZU1QbVUU9NDRhiXrFatH/Rx+bWmFoialnY03SstXigWv1ANOmO
    024zZ/yZqureBBSCp42r+n2nDgh/o2yEhegA6kJcfqoUxy8M2W/wMU7AWWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=gzxaNMDz
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ML7dzQwH;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=gzxaNMDz
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ML7dzQwH;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCne6+PG7j+KYwxkYfOKtgXtESUEBSIr+Rdffie+9JKjVZY7Pg70b9W10ytrARY8TmltuiGD7K0U9xoISLq+jbfJTveYeaXIjsm7dFnyxobQkLAtns9J
    TxFUD9hWMzxrwMmcOuP7h3XjR25QghT9PaRh+wDTZcqCTGLmZUVO+6tR6uoCjewek+zGAzTAeOH+d2+Cx/3hJNkqAdu2moxHCKiMnQur85neDvJMObSQ0ydh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=tpklbuFrzDe4DuDInv0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeFEGzR (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 02:55:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50731 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeFEGzQ (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Tue, 5 Jun 2018 02:55:16 -0400
X-Google-Smtp-Source: ADUXVKI57KzJE13olw4ee3G11o57PfY+aDzCgwEnrtF9tbN6Dw5Vhx0KqO2rFFB4Ju58Q6LeTVtv4w==
Date: Tue, 5 Jun 2018 07:55:13 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: linux-next: build warning after merge of the mfd tree
Message-ID: <20180605065513.GD21163@dell>
References: <20180605131507.3f217038@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605131507.3f217038@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 05 Jun 2018, Stephen Rothwell wrote:

> Hi Lee,
> 
> After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/mfd/cros_ec_dev.c:265:13: warning: '__remove' defined but not used [-Wunused-function]
>  static void __remove(struct device *dev) { }
>              ^~~~~~~~
> 
> Introduced by commit
> 
>   3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")

Thanks Stephen.  Will chase today.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
