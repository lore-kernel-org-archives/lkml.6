Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD320842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551259403;
	bh=jo4xQSUDJwIm216RPmZuryQ7Sz0V5BwCaI9zADDESO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mRVRw57xifaptml3kbMIJ0Tqjcf00yqatvZ5VUdRUTLSIanYzfmsD+Y6i8VmFwGLd
	 +ZApe8vZsvQ18gaWZ9Rd3eazuaog68/tF+I+6+tdR/lBGop3lkKioLSta0uPV4erFg
	 L8kD8ZXTwHerC5inNBzNr1h9y82OM29dk1J33/zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfB0JXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:23:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43532 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:23:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id j1so11912942lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mab5R3HkebQGHJTVnPZODUD0aIr7OVZL5CTnP16eCeM=;
        b=gskAuwhfelTRprASwWigO03B/UilUvvlOf40P39PS9Q4dt82ePN487ApyUr4t6RCSg
         aGjAdFRudV4yTQ+/hso1K1xohe9+EwENB1hNCiQGeaGwtKYmzjvZ64uB35yX/60CzU2b
         WH2fpXDxCyPjk8r5wxMkubeO0vOOaXmawVOVYuoPij7hUjAah4asLa1ajZtjoqkUs4AJ
         nXoMxl/Ne11mkdkrwP1+6pyx7sau/L/8G0929LxoVaQUcxOc1zFwDTlB8H5wP7srXwr8
         XJHZ3e7qxCpQbnir5TrtixXmAxgS5U0D0kxEiqBvR/kGFNnms1+IQTBPMkn/QB4xytUf
         qS2Q==
X-Gm-Message-State: AHQUAubhDDWbx1/Y5CRizwf0cfQNArxtMWubQbQDnul4nzIDGc6tJFHy
        GpqjyCtTKB/TdgQtvftdoK0=
X-Google-Smtp-Source: AHgI3Ia5Z8SznD4vMv/VTsEAfHMuj/xSkjxMXC2fd/42XT8syU+A7y8pBtAgAt0sO34wLQHTHGo8fQ==
X-Received: by 2002:ac2:5624:: with SMTP id b4mr236428lff.41.1551259399733;
        Wed, 27 Feb 2019 01:23:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g13sm3798297lfb.57.2019.02.27.01.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 01:23:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyvQs-0007CE-3N; Wed, 27 Feb 2019 10:23:18 +0100
Date:   Wed, 27 Feb 2019 10:23:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227092318.GK4747@localhost>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226144108.25891-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> The dev_links_info structure has 4 bytes of padding at the end of it
> when embedded in struct device (which is the only place it lives).  To
> help reduce the size of struct device pack this structure so we can take
> advantage of the hole with later structure reorganizations.
> 
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..b63165276a09 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -884,7 +884,7 @@ struct dev_links_info {
>  	struct list_head suppliers;
>  	struct list_head consumers;
>  	enum dl_dev_state status;
> -};
> +} __packed;

This seems like a bad idea. You're changing the alignment of these
fields to one byte, something which may cause the compiler to generate
less efficient code to deal with unaligned accesses (even if they happen
to currently be naturally aligned in struct device).

I don't think we should mess with __packed unless for things that
actually require it (e.g. data going on to the wire) even if it means
wasting 4 bytes on 64-bit archs.

Johan
