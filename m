Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0340C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4082184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547237394;
	bh=O/JnLrWPzBj0phdqYf7aLfDgo3aQd7nlGWTSetN0CxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i/8S6woalwdUAZ2XI4OPvTQeg/iTkRuJQWHoY6Ec3uEJzszgNXVPOKNYCUPa1HOSF
	 2IejXiQWVOj5xDeE0bYP06/rpSe4WrCqS7gKO41cqHBJuMCunnQqhdo3lpltTVTATV
	 Pm2Q8ZZ6tfkIaUVg5gA+0vHy8IoIhQKnmEbrOgDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbfAKUJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:09:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34911 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731440AbfAKUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:09:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so14243917otj.2;
        Fri, 11 Jan 2019 12:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5EATsKvEbWnAGgVmPgG/PX4c3EZhoHCL7F8x3HwTdM=;
        b=W1J78bIlE1VDb6KgmgXvkhackKUdokxrl7SsDsn33rqlkd3P4ZxX3jijM3VGtkpV4I
         zpa6y2fbaE3U+5YXvyLyD5ihzFJHAo7zMgQOPcCdguyHNs0ZJGvaqPqVz5GXU7IhXXoz
         Hom6+Nonk8hhXMH5QuwnrkFsYqb7Z71kH4khvh9BhIOR5rEGdSoJbpC2BphDWZs7j6WR
         tuhyDeFbbeC6N5pW9M/rEeEhH9b+5wLl1USHPT6BEntzAAZnYaiuNEhn4bXqj3WsiULV
         PVoVSMVfUM6P1EgSq209NCv7nmjgGdzC2NS3W8RFaz2MpZjrZQ9lDw7Y3J3KNsAt7rr9
         8g8Q==
X-Gm-Message-State: AJcUukccvfnh/IROPICVUeZugrgkLa7R83Oddd8y+A458wu3Guzh4GpD
        eXKj7HzXfEtZVkjS88Cf7dZ08EeiQQ==
X-Google-Smtp-Source: ALg8bN6QQ+o/4rIihUetU9vWCxLQpXpZXNc7NfBksuz9ssX0VWTdt7tQRljRdO0EKOiVNBM7lxDfFg==
X-Received: by 2002:a9d:225:: with SMTP id 34mr11164365otb.224.1547237392707;
        Fri, 11 Jan 2019 12:09:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b23sm33599587otq.5.2019.01.11.12.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:09:52 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:09:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, nava.manne@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: Add ZynqMP PM bindings
Message-ID: <20190111200951.GA28752@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-3-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546638982-12954-3-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 13:56:20 -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP power management
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
