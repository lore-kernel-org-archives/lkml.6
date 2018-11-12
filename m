Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94E2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hloTfgk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QczmXqGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94E2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeKLWeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:34:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:32905 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbeKLWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:34:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9045AC0E;
        Mon, 12 Nov 2018 07:40:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Nov 2018 07:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=v6zhlPCq0cUbATrkzj2K9O3D4nW
        P/3hk7qHSe5NI1KU=; b=hloTfgk+Jrl1uAHcVwag18NuwCQmvjCWmcjN2BzRJbc
        Bq0zJn/0K0NQXPfb2NBhjHGZlLOHko7/qAI74YZS1vvEfn0eDD3K//V0f2bOJpcT
        wb4zs7O5hAVfdZPOfAfRpX8MrWSklD6jsjLPvDUlXmRef8CpleVhazHmDrfXX0EE
        GP0oTC2XfgKvKYIQ4oPB2yGVGfjC/ESX4pRMz0QluPywluKwdIz2jpNbLcauJOTQ
        UsZKUlkd/52AoCmBE/nz+E2q/mYE8ILQDBPTxHCYtrM0YQATxd6rwIhuuoIQ/59z
        ddLezZAk5PKpC6U7qYelcxBGkzftbOJpIEe+PkKnXKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=v6zhlP
        Cq0cUbATrkzj2K9O3D4nWP/3hk7qHSe5NI1KU=; b=QczmXqGwoXkClsNMgtIWuO
        RP/0FlxQMgQGXO2ovoS1a1q0ejiDFeiW8DJD2KPwvxKtLDQiRkczrh4EOOrLcMtG
        Km8g8zh4I+VV9bplk6a89vWgd/b8+MlmdzeMGda5S6rfe1bRICjhoRyuViznNCIu
        bpXP4gT8E9G+kofniS4gbel8DVQA/udU6p4DE6WZ1dV5eqTUGECRGv35RyIjjZOD
        sjulALyoMeHKAP+sShCE5MfeZvIP0+PwUpue9foHdxpWcY0oGDI9d+dE4TtOG1e/
        Q2SFznXYm8PaYtx0rGBf9Ei7rJscYFuCSfxwymo9mHP90kjP/mtfKVKXqttk/ArQ
        ==
X-ME-Sender: <xms:03TpW5gbs619MZgE-kdu3r0eLaGM-GvUxabLG6qUNRe2vhQrR9ivVQ>
X-ME-Proxy: <xmx:03TpW_3yvjD4Y5ZOR1lXi97LgxOplqFODfdb5L1HusV-uRz1uL55Lg>
    <xmx:03TpW-S5IetYMomrO-NCCC4x1XywJhbRVPrl9k4sMhYlyEEa4GmLxg>
    <xmx:03TpWxtHaagDUoYqn5Qbk0NXxRggCasU99lefh8XCiETU4lA1mjEdw>
    <xmx:03TpWzYGYCuZqnEMW-pzT8zQGTyQQ3QR9Hau0J5X6V8r51_aDxlB0g>
    <xmx:03TpW2sU1-hmEyxtPrV80GIkbVZxMy79QZ5zZTVl42zUHoJw9kJ2iA>
    <xmx:1HTpW5SNbW9Gkuwey1GatGxoO5OGUkIrDDa2BnPep9qM2BoIvy9iyw>
Received: from localhost (unknown [206.108.79.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA1F2E45E8;
        Mon, 12 Nov 2018 07:40:50 -0500 (EST)
Date:   Mon, 12 Nov 2018 04:40:49 -0800
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     wahahab <wahahab11@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        ghartman@google.com, astrachan@google.com,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181112124049.GA2408@kroah.com>
References: <20181107023043.GA18052@ubuntu>
 <20181109171558.GA8323@unbuntlaptop>
 <6ADC007E-85BB-4CA1-89FB-9254937E8C63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ADC007E-85BB-4CA1-89FB-9254937E8C63@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:49:30PM +0800, wahahab wrote:
> 
> > On 10 Nov 2018, at 1:15 AM, Dan Carpenter <dan.carpenter@oracle.com <mailto:dan.carpenter@oracle.com>> wrote:
> > 
> > On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
> >> Add a attribute called permissions under vsoc device node for examining
> >> current granted permissions in vsoc_device.
> >> 
> >> This file will display permissions in following format:
> >>  begin_offset  end_offset  owner_offset  owned_value
> >>            %x          %x            %x           %x
> >> 
> > 
> > (I'm not totally an expert on sysfs rules).
> > 
> > Sysfs are supposed to be one value per file, so instead of doing this
> > you would create a directory with four files like
> > vsoc_device/begin_offset vsoc_device/end_offset etc.  And each would
> > just hae a %x output.
> 
> Thanks for your advice. I have started with this approach.
> 
> But when I trying to create this kind of sysfs hierarchy. I encountered the difficulties of file organizing.
> 
> My current thought is to create a folder under the device node called permissions and user can examine
> permission though file path like vsoc_device/permissions/permission1/begin_offset. But there comes a
> problem that it seems hard to determine the correct index of permission to make folder name unique.
> 
> The solution I come up with is to use memory address of permission node to be the index of permission.
> So the path will be something like vsoc_device/permissions/0x4d23f/begin_offset.
> Is this OK for sysfs?

Ick, that is messy.  What exactly are you trying to export and why use
sysfs?  Is this just debugging information?  Who is going to use this
data?

If it is just for debugging, use debugfs, that is what it is there for.
If you use sysfs, you then have to support your new api for a very long
time, as you can not break userspace reliance on it.

thanks,

greg k-h
