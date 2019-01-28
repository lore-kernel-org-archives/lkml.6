Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B70C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8599D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="K88q506y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA1JVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:21:54 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25476 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1JVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:21:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548667242; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=mINGlhNuJeL2m6ILcoXW5Mjrpj9nO/mZ9/c/XqhR2ejgguAmETCDtdvgllvBOHxeZnpidosS8B007R3FgjOOJZ4yI4PO554qIxHWIbXwW16JGS2Sv4P7UnpJdTPB1MZXEnt8kxgIuPqJ/mjVK8ZiqDd0txzmr5T25rzAyKzi75k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548667242; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=qw8czypaaWe79SZeoXkLCgUeNMSIHh+oSBPU/+9dKBI=; 
        b=bjBijhAiLJWz4rOr06qSj29HZKLKrv9JAX1scamx4KqCFBE7LJycfSN8vznd+ZX8tPe840X3xz0T9iAaMUHZv0/yIiA+kbDmXiItItw3pEbaiQLuZCq3MpT585P9IOsvzgi9JeRneSCM72ivs8xhGpRgBgekNc9kVDNMk32ZrlA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=WxVf3WUvuxn9cvCl97PDPwcfCNOneLv7Do0kTEPzNFMlrpo2xxNaVxLy37o+aGSRHZuE8AeCH7i3
    cXzSifHokUYvX3M7BaVnBnGJajSirHpU3EDiLX5F53BEiBV4YSw8  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548667242;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=35;
        bh=qw8czypaaWe79SZeoXkLCgUeNMSIHh+oSBPU/+9dKBI=;
        b=K88q506yWMlD+n4BWAFp/VhD/VrTV5i0ouN0uhGHHvmKf6Xi9XA1RYOK0v2+C/JF
        SNBmz9GWWaRM4GAl48mnqvvujn3UkYvL7r4nhlGUvOtg2lhOSe+zoZzog4+31DEvGAz
        RJ0SZJ0DO9DeajFO0B7i8iIth5muQttWXUv36L+4=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548667239400743.3906119745753; Mon, 28 Jan 2019 01:20:39 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Add Ingenic X1000 serial support.
Date:   Mon, 28 Jan 2019 17:19:34 +0800
Message-Id: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ingenic X1000 serial support.


