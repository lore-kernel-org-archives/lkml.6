Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8AC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750821ADC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ByTyZ9f9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muOXfRcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1750821ADC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933652AbeGDG3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:29:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39695 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933609AbeGDG3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:29:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0154A21EF0;
        Wed,  4 Jul 2018 02:29:02 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Wed, 04 Jul 2018 02:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=z9uqWfECnptBOoeJInuOyVvl/P9l4
        MwQYg/S0qNwDpw=; b=ByTyZ9f9HGbFoCuza4J3MVK+YfaYK7AXwVsqEbnNzBsy3
        cNWgpFOtU9BxE7XdAFmVsGgoaz+mpeFqkemiJLxFmcxjjHKYHRtmk30e5R09CZr2
        aAKF0YyD0GJbOZ4fq3yZEUAOBzAx1Gj0QPifrlK5MoLWh2cOxe+i1KTUJyVjoyTP
        7ApkoY6FcrgdgLas65aI+xE/R4lYDcNC9xLA2lIXBtGRIxd6vcbc8TH+C1KK08KO
        125Y4ChUuQBcuWdlfhZgRSUCV3H3aXaPDhpXSQ74duZYQjHxnbwEjqEVS3KOPTTB
        0ILzn3BKsMgCA8mzeJHruLhUBD17FcUSdYfmoxLAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=z9uqWf
        ECnptBOoeJInuOyVvl/P9l4MwQYg/S0qNwDpw=; b=muOXfRcmZ3/b7at2MlQ9hR
        +6PTiWBvMhgF7ekJ7dOEHBvqY1ECd+Y9pJ9BZ50ni2EnZhyLqmbxVP+CFO8KsRbW
        JETgZt7ngdRcvSXvuXPJUPZNDUrbhVLR6qjO49yh2qtEzrUTirKz6d3uRYX5UUEa
        vXPWvMKIFDboSyVFiBiyM0/wq6Zw6+ioWSo7HZ6nM5/4PPyvY0N3RMMIENfDCk0y
        cfT3Thwq+UuvYBTVvv5uEa0IHyhvYQtJL/ls7dj4/eDReXZsIwqFeaHRRY1b2oMP
        +dZpCdOa/Q8Uy1AELww5d+odGbaiM8A4QP+Qok2z8ul7TNynYATlKg2C9l9LYn/A
        ==
X-ME-Proxy: <xmx:LWk8WzhfvlLJeXrv3cr2AF4qohFUQPmN-M2f1NWwbZcVLIeDtpqq3Q>
    <xmx:LWk8W3mqzPLku5zpNbrZnJ1ygOec2uUGz3aqnTsYjVEEyNiRARgjgg>
    <xmx:LWk8WytWhHJdAe-buLa9VvbwpFHO2-nq_SrMr2E2Cd6-C6hTkW62yg>
    <xmx:LWk8W9CxGhWvcP7VoKiy8H00tFQvIL96RTBkOZaHNNv1pBDy4QqRXg>
    <xmx:LWk8W3UdMFjc8mVmszyHCqjpqV5429DBNV6AjRaQ-zyI1abVkJ3C7g>
    <xmx:LWk8W-Tc_z_LZChEyk7AjCraqEneKB_4VArowRsXjy9MdJXFgiT20A>
X-ME-Sender: <xms:LWk8WxkvrHnHJ2dpH2OfjvmTPVb0YpQ0zEaFIXHbXjUY0dxnpypyWQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id C65139E48F; Wed,  4 Jul 2018 02:29:01 -0400 (EDT)
Message-Id: <1530685741.3894652.1429464440.6E988BDD@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-0d8ea36c
In-Reply-To: <20180703075018.GB27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-3-andrew@aj.id.au>
 <20180703075018.GB27649@kroah.com>
Subject: Re: [RFC PATCH 2/4] Documentation: ABI: Add sysfs-class-bmc
 documentation to testing
Date:   Wed, 04 Jul 2018 15:59:01 +0930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, at 17:20, Greg KH wrote:
> On Tue, Jul 03, 2018 at 05:04:11PM +1000, Andrew Jeffery wrote:
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Same problem here :(

Will fix.
