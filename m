Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91578C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5125F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+lIUol4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5125F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbeKPJQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeKPJQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:16:10 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C4A2087A;
        Thu, 15 Nov 2018 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542323179;
        bh=lsZv0KXeLhOEeGfJ0rwWgLpr3SFYCsmh0Iaeaa6Ylvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+lIUol42x6yLa4NWa176jf0qYnUCNtw6qkH3wwwo6FJil2Be4AQqzjV6FMIGnWMu
         DeflREAahtq0DQlXO6Odr8V4byDkUGd1tKsIVOn42hK7VPy+TbAgZcvFkEhY6YkRKA
         X478ZGIoeNwoP9j0zaA7cRZO3MhaAJ2fS2fhdvTM=
Date:   Thu, 15 Nov 2018 15:06:18 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v3 2/2] Embedded USB Debugger (EUD) driver
Message-ID: <20181115230618.GB26568@kroah.com>
References: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
 <1542310374-18474-3-git-send-email-pheragu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542310374-18474-3-git-send-email-pheragu@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:32:54AM -0800, Prakruthi Deepak Heragu wrote:
> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, charger enable/disable, pet
> EUD to indicate software is functional. Reusing the platform device kobj,
> sysfs entry 'enable' is created to enable or disable EUD.

If you add/remove/change a sysfs file, you need to also have a
Documentation/ABI/ file update as well.  Please do that here.

thanks,

greg k-h
