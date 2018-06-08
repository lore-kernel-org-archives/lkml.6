Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zjR4Ap5gGltXEAAAmS7hNA
	; Fri, 08 Jun 2018 10:56:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85DF2607E4; Fri,  8 Jun 2018 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528455376;
	bh=E9ALAvsCtWMZU9z3HM+b8JBaVy4mmQRgePINFT1+u2Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:List-ID:From;
	b=l9ACok+m8JD1e9TWRi1RCZWs9lE7cW7ZooQT5BPhHkuAZ3aAwMwh6SayL6ftlDYvM
	 KhTLkqa5ytSkFrwTdOEyHzcfttC8A0HEGbQRl/18W90bpfasMpUZGqDeS0OG6x0qdA
	 I+U8yx6IiOx5dcNnlfSflRy0pgVejZNkaV3kBIUg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6B37C60290;
	Fri,  8 Jun 2018 10:56:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtvgZA4A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nn+zqWH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B37C60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeFHK4F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:56:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:56:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E018607E4; Fri,  8 Jun 2018 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528455363;
        bh=E9ALAvsCtWMZU9z3HM+b8JBaVy4mmQRgePINFT1+u2Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=KtvgZA4Au+X1h/+P06ua5WqdLLIIBpLeploOVrfIwPLHT0qkTTiiRToBP3eGqb7n7
         k3ou+SwP6jF3C+1WvNRfQycQc2nfigKR40JPSObVt1kJzP25K8EgrQaGhdIr+avnBA
         KUwWkmflcEefsUFZBqIviSKJ0PbeuFZDqMHJQI/4=
Received: from SAYALIL (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C971A602FC;
        Fri,  8 Jun 2018 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528455352;
        bh=E9ALAvsCtWMZU9z3HM+b8JBaVy4mmQRgePINFT1+u2Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=nn+zqWH8QOo3yMCBK2spITZOwhpCUfBNVUywRXRbtmryPU4GHn1aKZ2ydGcIAUmNI
         pBWzza7yXF0vjVjoySkXJAtnT7zhIpDz6p0X76mzRiy7hYIzTMrcNZe4SeNbf+yQsL
         BrBoSwvln63Icfh+Fz2qENe5avPi0E9PO5/Ea4TU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C971A602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From: "sayali" <sayalil@codeaurora.org>
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Stanislav Nijnikov'" <Stanislav.Nijnikov@wdc.com>,
        <martin.petersen@oracle.com>
Cc: <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <evgreen@chromium.org>,
        "'Bart Van Assche'" <Bart.VanAssche@wdc.com>,
        <linux-scsi@vger.kernel.org>,
        "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1527849774-7623-1-git-send-email-sayalil@codeaurora.org> <1527849774-7623-4-git-send-email-sayalil@codeaurora.org> <MWHPR04MB113794E2654BEDA8E927F0FC9A660@MWHPR04MB1137.namprd04.prod.outlook.com> <20180605084200.GB8665@kroah.com>
In-Reply-To: <20180605084200.GB8665@kroah.com>
Subject: RE: [PATCH V1 3/3] scsi: ufs: Add sysfs support for ufs provision
Date: Fri, 8 Jun 2018 16:25:45 +0530
Message-ID: <000401d3ff17$4496a390$cdc3eab0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGja9h2+sAa9B7VDYjBpPLWNjYigGinHYVAlfCZYgA8/Aan6LJmiqg
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg / Stanislav,

Thank you for your comments. 
Updated my comments inline. Please check.

Thanks,
Sayali
-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org] 
Sent: Tuesday, June 05, 2018 2:12 PM
To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
Cc: Sayali Lokhande <sayalil@codeaurora.org>; subhashj@codeaurora.org;
cang@codeaurora.org; vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
vinholikatti@gmail.com; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
asutoshd@codeaurora.org; evgreen@chromium.org; Bart Van Assche
<Bart.VanAssche@wdc.com>; linux-scsi@vger.kernel.org; Adrian Hunter
<adrian.hunter@intel.com>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 3/3] scsi: ufs: Add sysfs support for ufs provision

On Tue, Jun 05, 2018 at 08:16:50AM +0000, Stanislav Nijnikov wrote:
> Hi Sayali,
> 
> I think that passing an array of values in a string is not proper way 
> to work with a sysfs entry. There are binary attributes to do such 
> things.

No, don't do that, sysfs is for "one value per file", and binary attributes
are for "hardware value pass-through" type stuff.  Unless this is "raw" data
straight from the hardware, binary does not work, and neither does a normal
sysfs file either.

So this needs to be reworked please.

[Sayali] As per Documentation/filesystems/sysfs.txt :
	"Attributes should be ASCII text files, preferably with only one
value per file. It is noted that it may not be efficient to contain only one
value per file, 	so it is socially acceptable to express an array of
values of the same type."
	So it seems sysfs can be used to pass more than one value given that
they are of same type (which is ensured as I am passing char string).
	Also I have noticed , in scsi_sysfs.c (store_scan() or scsi_scan()),
we do pass char buffer (more than one value) via sysfs .
	As sysfs is already being used to read descriptors, I thought of
using sysfs as write interface for configuration descriptor.
	Appreciate, if you could suggest me some other interfaces that can
be used here (allow passing more than one value) or
	do you think I need to pass each configurable parameter one by one
for provisioning ?

thanks,

greg k-h
