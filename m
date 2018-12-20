Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95670C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C7218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338367;
	bh=a5Jkggq6lI+wCj/pjXFmXzgULeZc0L4V3TGsD1jDlv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b0YEwgrpHqc6RG5EztKABleN3HfJXlzfW69psq10+6vn3BFjmlzZqZT07/BpLSt38
	 nXM4NP6NVELRigKuZDHZB/QEPm+8T1uD9X2NAGhUqyXWOg72Ipc9FG7hPHZuQO7MIh
	 oBYlc2X395HKqcR9M+ie6H00Ulc8VD4UaV/0SsPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeLTUj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:39:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLTUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:39:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so2989834oif.13;
        Thu, 20 Dec 2018 12:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NjZ3uGV3/N4a5p3ZJCmNx8dIQpyI8WAt/Uy3gLR/HY=;
        b=es9EF0MtyZDRg1SnRoKRFbFea2PWm/i/VvV48towhhW0eXeNzGqbC+NkOg5qw+eF1s
         kVOsCplj/OTK46EJy4JxZJoOPAmwPWcnAYfCSN07cTmpiVo5XIvQ6znPjw5BCzJhLZA9
         50gK7d8KP0eA4/FUdU3pA6NcWygbw9eI7OdxekwMbP+NrYFulHsk4pZf/41R3N8r4sjc
         hrOIm7Z5e88wSXs4bqZXx3jj+9oKBdgQA27IgibiZ1c3LxADJAfpA4O0esOd6PSGeD7E
         hm1K9p8t0HuPpQ1ZMkUzZ9N53edIRkfBkv5PCUV5yyIyngp8PC7T9Jt2I4Y+jRhBnZLm
         qStg==
X-Gm-Message-State: AA+aEWYfrYs/diQi4VQx4h9uXj9htEF3eNQLlt09XOMv8Ak3VI8kW2qg
        eMBNxWEooHlJiG5UX4fg1A==
X-Google-Smtp-Source: AFSGD/WWJTwT8R0Xv4BnUrNOLiOefTrzVONwd7Iuv5SzX9j1iZq+DNoSPA162GUcnpQr7dUEXpLyPA==
X-Received: by 2002:a05:6808:155:: with SMTP id h21mr191847oie.34.1545338364825;
        Thu, 20 Dec 2018 12:39:24 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id d10sm10016352otl.62.2018.12.20.12.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:39:24 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:39:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
Message-ID: <20181220203923.GA23341@bogus>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:21:03 +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
