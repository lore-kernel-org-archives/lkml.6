Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B18320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544109824;
	bh=t8T7oBZxJgExiqgSPRBrW7bl2ZNp8q8akD17BYJSZ1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yySt4c++Ufz0yq8FJflzuYJkSaHnvF6hgHt07Tp98PkmR7hLUMhvlEW54+FzxaNt6
	 YuanbkawJQ8Un3uJOsVEzKzzpOGHExaoTMUQ2AI+iaAATwsIQ2LAxAMZqIhuuVJCSK
	 7rslROkV+ZM3vLfeIjd7YMtGDVKG5tz5ljKYUYjU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B18320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLFPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:23:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:23:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so742782oth.4;
        Thu, 06 Dec 2018 07:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUuv3pyaruZzNdS5r9zNvuPeTst46YAfxD5ODYRTe6Q=;
        b=T94rTslOS/W0rWi/jqgqXunmdrLK696H6pmTeUFWlza4Pabn2R+VssXRJ7AsnazL2+
         RipcB9aLYUYT1bE4MioiU8nN6A5o2jhZr8IF7gXs20HtSeYDMO6Ecz9tFjpynXC99Ija
         061AA7/I+OCIUMpP+J7rJW+bEruIy+RMnlRXFXB0UtxF2FHGyqdmwO9af9br0reOQoqt
         bJgMPgK7G/kF+QUiGanwr+LUQ6Aa5nbh86Ar8P8LleW+X1875uKcMs7HxoDdL9vlXQoy
         rXVsG22WWN+dwqkiiOpoETbcz8VU9B+il1VgwayQBSDqzPa45657iNfXCbQ3SWVNW3RZ
         QStQ==
X-Gm-Message-State: AA+aEWbQRjyBRPH1kUpT6+0FjPZkpLXPQRzXPgkBnqG/EfkSqXnMQNSr
        Izuzm03q94xZNsftsdag57jrR8HJq48UWMR5AGo=
X-Google-Smtp-Source: AFSGD/UBd04LwlO+TKqIsQIShIuxbcr4l/9OKfvhzD0LtVk1QqWSCJRou+RIbqtcTnY409qHLteiw29CMmDvZIGzOxQ=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr13812051otf.124.1544109822097;
 Thu, 06 Dec 2018 07:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20181129180844.31138-1-colin.king@canonical.com> <20181206145748.GA8360@kroah.com>
In-Reply-To: <20181206145748.GA8360@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Dec 2018 16:23:30 +0100
Message-ID: <CAJZ5v0g5DEmxq7wyMTL4USctSy-2PWGMFm843vGS85n=SeJSfw@mail.gmail.com>
Subject: Re: [PATCH][next] drivers: base: remove need for a temporary string
 for the node name
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 06:08:44PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the node name is being formatting into a temporary string
> > node_name, however, kobject_init_and_add allows one to format up
> > a node name, so use that instead. This removes the need for the
> > node_name string and also cleans up the following warning:
> >
> > Fixes clang warning:
> > warning: format string is not a string literal (potentially
> > insecure) [-Wformat-security]
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/base/swnode.c | 5 +----
>
> I don't know where this file comes from.  It's not in my
> driver-core-next branch, who is creating it?

It is in my linux-next one, comes from a series of device properties
patches by Heikki (CCed to you).

This is the patch adding it: https://patchwork.kernel.org/patch/10676063/

So Colin, please resend and CC linux-acpi@vger.kernel.org.
