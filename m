Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117572064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX0bL339"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117572064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJQM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeJQM6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:58:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE612064A;
        Wed, 17 Oct 2018 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539752700;
        bh=C4LQ0LDoN/ZwaCtObVFwcaHrZMagUrroaaUdm+27C1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LX0bL339AOA+Kl7pZ78qAphTRs7Gh3/rBV9r9HhKDD31zMr9LkybYQkWkpEyT+QzM
         MLljNE+hLQDuHUXgUVnp7aWLkQmwKBIPVJ44imUIk/fhLp++9bc9va2PzbLP4Z/OwO
         8UoVNKRlPFDu11hz3jHq/0LbOo1A538jw2w/+V1g=
Date:   Wed, 17 Oct 2018 07:04:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com
Subject: Re: [PATCH 1/5] Drivers: hv: vmbus: Get rid of unnecessary state in
 hv_context
Message-ID: <20181017050458.GD22447@kroah.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017031406.773-1-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:14:02AM +0000, kys@linuxonhyperv.com wrote:
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Currently we are replicating state in struct hv_context that is unnecessary -
> this state can be retrieved from the hypervisor. Furthermore, this is a per-cpu
> state that is being maintained as a global state in struct hv_context.
> Get rid of this state in struct hv_context.
> 
> Reply-To: kys@microsoft.com

Why is this here?

greg k-h
