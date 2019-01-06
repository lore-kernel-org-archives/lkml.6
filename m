Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B762C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D9020830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 22:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbEL36OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfAFWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 17:21:55 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40991 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAFWVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 17:21:54 -0500
Received: by mail-lj1-f177.google.com with SMTP id k15-v6so36547135ljc.8;
        Sun, 06 Jan 2019 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuBMLjLwMN2QTKxORFPSq3+SPWrzDaEE+ybQKLSLHfE=;
        b=UbEL36OSgjjSDVXEVniBjLodFkqoar5UHbDD/HpfZic6o8HNCZbEZJMQSaGuP6ZFbL
         qgUFAHMwJ/Ndv0qtkshRTL5uj2AYo2aITBVThqT70TQc0YYSU4v/7T0yCqLTKjnyknPv
         L+tU+BAnCFLLJFgMOprUWcXSqF4wwrnLg2cQAPA5v3I86dwtJiYP45IxuZPmze7nR2oP
         OVK3E34+qGhhg7w1OsTqvdiFIx74A/iqNhe/9L7aV8dGinQM19xN/8fMEpfyRbiW7uZy
         chFEIi9hN5C+sa1kaCrcColcXyzMo3Gr8b9M5bTzj81Pc5PjO/oXxqtVpqj0J4PO7i23
         btBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuBMLjLwMN2QTKxORFPSq3+SPWrzDaEE+ybQKLSLHfE=;
        b=BXMFIPj86Tg6+fyuTzvJK+mQkimyFHMeSRt5NoTWyqdOsG2U3zyesWgVyFSg0utZZT
         YMiXCh7PVO4qrX4Ruh17KXpbslElAopeS/wYWI+rrxpYbd7R+gGsemIDQoReuu3aUaPl
         N+tuAjlqKTuCHFHj0cAncg1NUEn4jBYqZj+rrbl6dWxY69alaZAjlWt7zN7wxYzoXPgZ
         ZXosrBQNBa78uhHapcoGYld9HhiqBV29dsEXBYX01baSuR7/6XWnq31sXYCcutravVJ/
         Dbe1eeoCVQhPtc8M8Qf1WdoXAAi9Lts/GtLsphJKw4ZBNE9MTn/vdKRKDLQpBob+1u7u
         2Hzg==
X-Gm-Message-State: AJcUukcgiMX+uzrQS3TaS5PLsv4a+JN5v5rApgUJHulXl+lMuIQJccr+
        uLoaodmVG1W3ylu0jv/2Fm9m9FmYOhkrUmQIJmYM6cYL
X-Google-Smtp-Source: ALg8bN58Iy5tUcbZg33BkZ17oMgQWIHl0wCU0fAFGToN1EN80m08Ed9isqPZGvcnpUoTH6st9NWdQ8HKEuZw/6OCsK4=
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr32159095ljj.108.1546813312132;
 Sun, 06 Jan 2019 14:21:52 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
In-Reply-To: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 6 Jan 2019 23:21:40 +0100
Message-ID: <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
Subject: Fwd: [BUG] v4.20 - bridge not getting DHCP responses? (works in 4.19.13)
To:     Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     jeffrey.t.kirsher@intel.com, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the repost, screwed up the netdev address...]

Hi,

Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.

My firewall (which also runs the dhcpd) runs VM:s and it does this by
having physical
interfaces attached to bridges - which the VM:s in turn attach to.

Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
seen - a response is sent but
it never enters the interface attached to the bridge.

Basically:
VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
dhcpd eno1 -> siwtch and... gone.

Any clues?

All the nics are handled by ixgbe
