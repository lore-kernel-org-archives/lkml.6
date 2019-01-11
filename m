Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6250EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349372177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217053;
	bh=mr2j4//SVxhDSZdOIY7I+cjY8EI5VFtMhQjG5QDveZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sl8GyNU+LNbJWA3Big9gpE9pmNMdblVD81ydJAU/wCxRXUnawWWHKMeCFd7VoEuHQ
	 cM37zn3ZpPSK8+mTe6ourLRI8AU2p3RxTzZr439TASkn1hO0/sylzIABWWRk8kDV9R
	 OiGo/GKDywGUhmdwpP7UGnpcrgK7Js1YArLlavWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbfAKOaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39610 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389020AbfAKOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so12340975oia.6;
        Fri, 11 Jan 2019 06:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LyGxjJxH9IpIQ6cAvZLLTtGW7gb8aBmYjZ/0VXlh1EY=;
        b=d/yXIWdNMJZnLCDeXx4QyIBqW+5xJ9Lnu3YK6b0rbbZfc99FJN0OV1ftp4z84XoifN
         Nap6NPfO//nrQE64TtH9nsAA1P6JBdCcu02IgaXSRoJFOxPnSe7VmZ+Bi/wsS27hhx/S
         Ahm2FA000QrHOLALVIizvkULnQphjGxxl4lVr7q6QN785DVb0o4rVfDi+YX8QQ96WVuf
         D9WRvMXlybVWl0qHVhesqmtj+tTJlOtB54EHxj0Pcj8vdh/q6dI+tEUZczPhaW5UG3pF
         Jn5r+h5yor+HHMHF5oiiljhkNWI967yBeenQUcCQxI1RClbqSelQk2F7nxm08eI4vGkm
         UHZQ==
X-Gm-Message-State: AJcUukfr+E0R9lC7hnPwPy8JtyIlUjfbPnxhSMYcOnCyA46OPNRUWzoZ
        7yna0Nbw8sY9a34lO3X5cw==
X-Google-Smtp-Source: ALg8bN6qLiLOJRrRgWM8OOdjDKeX++yp7L0GgCDpoPrKixW4TkBJrDGqqgBv6m74wIdbF3RwGu3vkA==
X-Received: by 2002:aca:db04:: with SMTP id s4mr8779802oig.248.1547217044925;
        Fri, 11 Jan 2019 06:30:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm59162496otj.19.2019.01.11.06.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:30:44 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:30:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH v3 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Message-ID: <20190111143043.GA4914@bogus>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
 <20190107185346.30184-6-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107185346.30184-6-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:53:44PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Change property name from keycodes to linux,keycodes
> 
> Changes from v1:
>   - Because key codes could be bigger than 255, use ints for keycodes
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
