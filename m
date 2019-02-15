Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A60221929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKkcru9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390021AbfBONnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:43:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34609 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBONnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:43:25 -0500
Received: by mail-it1-f194.google.com with SMTP id d125so4721202ith.1;
        Fri, 15 Feb 2019 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT6xTx/Tgx/TnfNjqPjVMOvQTzotlx5VZkqNpMggYoo=;
        b=DKkcru9tmok39Nu7b5ynGxf0cih89l0SZJxRxKMhD65wBMYlam1bLQjlDlld11cx3Q
         vfleGcK6W8rBrFrIY16TxkG8crkFhCo17rVPqyJlu9Vk6qZ+hdjteqb0wRxe+BPLhXm3
         uGgecR8YpL+fY1wKcxcEefS8t63wcEyUActeczdNSezNld8JgoVFZXaWdH4W2nXKeOGK
         xAkt04WUJi9VeK1e5JuV+QF95Y7gLU5cHzj32+3sjZWKk+X119rIv56zEPasWUtDMRh+
         phqzq2W07y6ZE07u5O0dcZkDOAfUt2rkIriy51Rr+tbmhXiYh7b14LFOMJGOu/nYQ/ji
         osRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT6xTx/Tgx/TnfNjqPjVMOvQTzotlx5VZkqNpMggYoo=;
        b=J4cQY/PIrHS7cI2zhGL2nxBILT0MMTQLFRpU1XgSwVmn4gqtzXpv6pgRYAK84Fonyv
         LTp9eOf8NUWi/EarHnJoAVVIXFSWGOiKtkZPOTQsCsZol93N+L8hdqQ6iMfP+vZZAUvs
         wVEa83Ac36NfHMBOfgLm2XLzA3L85ImQPeiUBb2yDW/vbToXIVS9BeNc9jXpV9+r05Jt
         OxoNOTIBkoL+RfuEzFszAlTRejyUjlDBdPft7kjsqqZnh+lTZ5+/ZExB3MSuv51fqKMU
         vjcnYg9j5vLpi61cebjFUnrUtOVYdb3t5IJHgCDmlIEAb2xI54U2BCkKpejlvz0w+0Wv
         XWGQ==
X-Gm-Message-State: AHQUAubZxV0TQpjmROLUuLCFHHHfgc+0sobl7RFqaI5TyjYRDSCVrMy4
        p8w9g0C2X9Trfut0x07R6sf0k6MERZeJKDTEybI=
X-Google-Smtp-Source: AHgI3IbVG2jp6sePJV7mSOIIajatGM8tsu40pGOoXaT3oZLo1QB4EVLTc582iHNNXRFukCCK197wIKrlkhtDlKLPbO8=
X-Received: by 2002:a24:e44:: with SMTP id 65mr4407476ite.154.1550238204201;
 Fri, 15 Feb 2019 05:43:24 -0800 (PST)
MIME-Version: 1.0
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com> <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com>
 <5C654C39.2030308@ti.com>
In-Reply-To: <5C654C39.2030308@ti.com>
From:   Matthijs van Duin <matthijsvanduin@gmail.com>
Date:   Fri, 15 Feb 2019 14:43:13 +0100
Message-ID: <CAALWOA_7QvtDeNZjXTwbT10MeWJ5wF776mENbX5w1DZHDNVVhA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Roger Quadros <rogerq@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        ohad@wizery.com, bjorn.andersson@linaro.org,
        David Lechner <david@lechnology.com>, nsekhar@ti.com,
        Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Robert Nelson <robertcnelson@gmail.com>, dan@kulp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 at 12:08, Roger Quadros <rogerq@ti.com> wrote:
> The beagleboard community is a primary user of this driver and we need to
> find a solution so that PRUSS is usable either via remoteproc or via UIO.

While being able to switch drivers without changing the DT by forcibly
binding a different driver would definitely be a nice feature, and
would have been possible with the older remoteproc-pru bindings, I
think it's a stretch to say this "needs" a solution. Right now, in
practice, selection between uio-pruss and remoteproc-pru is done
simply by modifying the device tree appropriately (typically by having
u-boot apply an overlay to the DT), and I don't think anyone views
this as unduly burdensome?

Matthijs
