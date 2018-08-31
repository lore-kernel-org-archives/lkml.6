Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C82F20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C82F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeHaQYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:24:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42209 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeHaQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:24:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so14205747qto.9;
        Fri, 31 Aug 2018 05:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=snefKMlFr28o6bEQKxLsCEAb3qd67evDrL/puO+qyjI=;
        b=lzBAuXi7yTegvyV6BGr+5e/FzfygTidxwydCNJ5JI/4zS/TJ5HXnnjKXwPYaLjiBe/
         VWJx+VqkxHE0mT8Kx3DoCZSTHbakVNXlfYSJQhwSnHTf+qD0SIqo1C6B0Qov1Cggewi1
         0P0jvH94E/OZ+6OPJJytT9w7yYlN2FfjxaVYJ52m5yVqZazcd7s7a5aGOUxHjn5Wf/3s
         c11qpvB5lokuWdmQJeNxyMCTIqJsZl5D26ByyCB5l63TrKNYXbH70Zwfwm7f+ISc8wxG
         7Hyz/W0yALO2wUwnNu0OKZ6AUJJwDNds1JVfcpU7UvLy7cqvCOu8QLJRKS1JsFlwoMqH
         arKQ==
X-Gm-Message-State: APzg51A2ckG2DD2IBMM0hTG9GPdvDYagqBDY7njorCqrmIkFw8k6DPAf
        wyglCxMyMDzukS2DIQ9UHg==
X-Google-Smtp-Source: ANB0VdY4lQU/6DwNu1iSCDWiUfpB7oo/Fh3oDSAj9J+I7XBpMjOdBHBl3zLAtHPjo1bslrAkDB+8Zg==
X-Received: by 2002:ac8:3525:: with SMTP id y34-v6mr16512984qtb.151.1535717807559;
        Fri, 31 Aug 2018 05:16:47 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id n24-v6sm6297913qtf.0.2018.08.31.05.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:16:46 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:16:41 -0400
From:   Rob Herring <robh@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add support for USB-PD PPS
 APDOs  to bindings
Message-ID: <20180831121641.GA20591@bogus>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
 <0d3a589560b519ab07ed6aaaf012959098c5a2ea.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3a589560b519ab07ed6aaaf012959098c5a2ea.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 13:28:21 +0100, Adam Thomson wrote:
> Add support for PPS APDOs to connector bindings so a port controller
> can specify support for PPS, as per existing FIXED/BATT/VAR PDOs.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  .../bindings/connector/usb-connector.txt           |  8 +++----
>  include/dt-bindings/usb/pd.h                       | 26 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
