Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7AFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB892147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="p2M5vUI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfA1Rbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:31:31 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25422 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbfA1Rba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548696669; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jTviIkeJiQDrbh4awTUmKKmtUsMEi9oA3oiOc8+k5c9d+9esZru4CWr80N42kerwuItgOCunKuL1sOxmIjvwoqMTMj4+WkEKMLwvKVPr//9fgnJjhfDcdX3SbnurHB5vlz2uOcdXQj+oBzWT774yy5mHOKX97PzLhR78JODc67E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548696669; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=4h/SRacjsE5sWTdHz/i45XxVfMRN1T/DgBrRVqIrJh8=; 
        b=Pg2d7c7CGzahoMNXqntypIeYLOrCTPpGNbJb4GhAfHQdD1oajfCoZnF/dIxxx2lORotyskI6zkt/rf7X+wBJ9hCvexVCjAQLc5LmqbY9pJ8Tg5GuKdJ/CYrqYHiTvRQ98JHKcXtnkw1N/LIxeywBPGe4EOA9039pkZ0LhJ/eSpc=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=UNjbSOIO9srFZ/SVQpuL4wm2P5ZEWHb123ZeJY1Bvo6g8/LqgoE8zzHQ+kkCXYzHd4hXvr1KnJ8b
    rmgyZ7SiU5GHhRVrr0b3eL+BUy/hDfIlaEXCQTgCGaY+blytTnAp  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548696669;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=32;
        bh=4h/SRacjsE5sWTdHz/i45XxVfMRN1T/DgBrRVqIrJh8=;
        b=p2M5vUI0Z1AKMf8F23cwY/2VB5KVWcWHFjPb5tlK+2dhqmx7E0DDFC0Igg/K05Im
        zI6dWR/RkWsiYnAO1+Ztl8r+Eq+wuNDGIFbO+B7LXvpj777r5g2bqZ/7+pVdwEd8Mnd
        BkM4/TAGhnEK3xAm0fp07IFN2menqGV6k35W0z2M=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548696666523202.48721867903066; Mon, 28 Jan 2019 09:31:06 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: Add Ingenic X1000 RTC support.
Date:   Tue, 29 Jan 2019 01:29:56 +0800
Message-Id: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ingenic X1000 RTC support.


