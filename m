Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A872C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199A20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544027449;
	bh=dHQfDerNuj2N49NiI3C9axw+52chXrULOjae4wogl1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v8txTWVMSHw1RfAgNhpkjFPNk0Vvg2qfol9AIMzM0f0vZGXv2zEaUg6QX3x61t6S8
	 uVLEbbJFhl9pdh9o2jnr6xRpSFY8LGxVNemC9RsJBMEH+ej85H19n6R8bXOlBELqpy
	 pZwaQr4UfR8fF8hxfAuH1SqBidEfJJ2RtCNegMMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4199A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeLEQas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLEQar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:30:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484E62082B;
        Wed,  5 Dec 2018 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544027446;
        bh=dHQfDerNuj2N49NiI3C9axw+52chXrULOjae4wogl1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Os7JCdUIi7I/vQg1fUg0wshtF77uk+pcyYzqkvGHPRkWTpDx6aRB2urU30GrireD1
         suuxBYKOP0ydlCJtcctmi5mboc/5zVAlOzjhgfaKgAtbKLAFLMuDQzhck7wTY7BDDv
         47WLvZ5kr5RVhggiGLw0T51YXbVu1RmEJeTSDvnE=
Date:   Wed, 5 Dec 2018 17:30:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rajnoha <prajnoha@redhat.com>
Cc:     rafael@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org,
        msekleta@redhat.com
Subject: Re: [PATCH 0/2] Fix return code and improve feature check for
 synthetic uevents
Message-ID: <20181205163044.GB7185@kroah.com>
References: <20181205112745.12276-1-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205112745.12276-1-prajnoha@redhat.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:27:43PM +0100, Peter Rajnoha wrote:
> Two small patches to aid handling of synthetic uevents back in userspace:
> 
>   - Return error code back to userspace on /sys/.../uevent file write
>     failure so userspace knows and it can act accordingly.
> 
>   - Add new 'kernel/uevent_features' sysfs file to make it possible for
>     userspace to check that the extended synthetic uevent arguments are
>     supported without relying on kernel version check only.
> 
> Peter Rajnoha (2):
>   kobject: return error code if writing /sys/.../uevent fails
>   kobject: add kernel/uevent_features sysfs file

Did you send this series twice?  Which one should I pay attention to?

confused,

greg k-h
