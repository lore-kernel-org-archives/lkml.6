Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D565A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G29vB9Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfBYOoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:44:05 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:38581 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfBYOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:44:01 -0500
Received: by mail-qk1-f174.google.com with SMTP id p15so5405395qkl.5;
        Mon, 25 Feb 2019 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PatR+lAYcmiGZ5ZI69nPkc6kZ3l9Y1TRLZsIMV+WLvo=;
        b=G29vB9XvcB6RtuF1id7QtOoGMP09R83IqXhx/ypf+ui8n3V6jANAyTQ2xVk4WONgHR
         9CruZC8RFe7aZ9Z71uRrwyc3e983OLldWCK+irUYNIiDtuGhzCqiODD+gb3gVDhuvlL3
         lnAnmYtvbMSr8mx+9kazB35R3KZRyIh3v4vbhiCAaHE3ZeGmLWuXWtvZ2oiZnmjrvpS4
         XKFl2pzBc1MDzoaD5nzCO+ugdeiTWnbWxHFFBOczocXXcsm0iDcoZPrQwl1wTEDbgz/w
         v7wLIBi9k8sLVXW29Ez+VdnmzXtfGuXRt99IsC8VavAaLkffCceN+g1i30ybq5bpfNrg
         NDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PatR+lAYcmiGZ5ZI69nPkc6kZ3l9Y1TRLZsIMV+WLvo=;
        b=C6hRfESD+JF/bbivTusEHi6XO7rtHDBq1SRjSCz7cv9KPzivQfnny+8R8gS7YAyE2Q
         oECiyRrbxWVjJ+/IpXEkqphRORnXrDPICIhC0oEALN1U+WHIlmT4Ek3xSdNkqLujaD/u
         o7qyKOWor8OE/rUYNXNaTqBxGiTuW/hraELLpzncQ72hyk0kesXWHRXtp5vfE6hwOGx3
         DoDoVXxIwi6gOxnnAFt829/z9Yy3X8TpBMRA48bPW4caWFtkNMXAPipE/zrI3iPX15h/
         HCO3d74bhLMsNtdKVn573NVBpwPn4ftQmoAI5dxBucSjEmr0kXVSugVIDIsROaMCv5H+
         MC6g==
X-Gm-Message-State: AHQUAuY0droxXFJmYDLTSBPHHtQ21AWVRPwpC2yX1yBzrES9dKYdxPId
        HY9hAtK+4FFKipB/YUESYVs=
X-Google-Smtp-Source: AHgI3IbjmAa8wUJCL5USt8iaFsUVqPSdDy89IyRR1hW4haLW9R47IZpfTVkbXcIchX9SSpUNXUTc+g==
X-Received: by 2002:a37:38d4:: with SMTP id f203mr13229700qka.66.1551105840637;
        Mon, 25 Feb 2019 06:44:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id o26sm5323799qkk.51.2019.02.25.06.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:43:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 684FA4039C; Mon, 25 Feb 2019 11:43:56 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:43:56 -0300
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/15] perf script python: add Python3 support to
 net_dropmonitor.py
Message-ID: <20190225144356.GH31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-9-tonyj@suse.de>
 <20190225123755.GA30699@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225123755.GA30699@hmswarspite.think-freely.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 07:37:55AM -0500, Neil Horman escreveu:
> On Fri, Feb 22, 2019 at 03:06:12PM -0800, Tony Jones wrote:
> > Support both Python2 and Python3 in the net_dropmonitor.py script

> Acked-by: Neil Horman <nhorman@tuxdriver.com>

Applied.
