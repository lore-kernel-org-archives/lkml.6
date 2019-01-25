Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A396E218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="czG5erjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfAYKB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:01:27 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25331 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfAYKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:01:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548410469; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=k3fbl7OIKc12IqseVW32/iZATbXba7DNV2BhcsQH6B3Zvk8Kv853p298n1bxdmReNVxKuDEY5c395b8aRHxzO49LeWGvQSQ0MqpWm/mrKH5nLyZ5UgfAEXQSm1FWA56h7eqGt8yoSbMc3RCeRVYvaR+PQXw/3GPk7cgJb5/F5JA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548410469; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Z+Hli7pNpAnxLizntlADKqOOLdwzj4WXa/nO3+ad5bo=; 
        b=k2d773yihluqP/KwI2e0HORl8sgi04Qms9fFNO34eahpbq9hWfAxuuPrMeuuBH5qSj992b2bl/1kPIU2+wJHoXUlMdAAwnjeQbpIuMn6C4Kzv80tM+RvU7epHvEEcgMm+/cvT9wjwUiRZUr9o3FCuqmH6l66PSvslsHWof5NqJ0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=FE9I6j/sZsdUbSwTZ6Iet1tbuer/uKmnnnGQLAoWRnXsGfO9ziS/RowNNHLC5T3ToS7uAuvyZFYA
    hMcIQav3iqFCjBR8Aong28lEzeFMUeA/4bhPzhconFqkOV3UKfoC  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548410469;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=52;
        bh=Z+Hli7pNpAnxLizntlADKqOOLdwzj4WXa/nO3+ad5bo=;
        b=czG5erjEPORRsGwc5Gu++PV9cpwOFbZK522uYE1dEEASizd+teDss+GfW+Eiahfg
        aszeuGuZz2Q2X1GK2RstpVQqqUj0IXaL6KPO3CrFoYNAdgri8U0SDLCu3Grz1H5K2PU
        4ehHE3apLQhtVjOe9vGLzqCnoUTGlmO7BkujfC6c=
Received: from localhost.localdomain (182.149.160.17 [182.149.160.17]) by mx.zohomail.com
        with SMTPS id 154841046722020.73630065595512; Fri, 25 Jan 2019 02:01:07 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        paul@crapouillou.net, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Ingenic pinctrl fixes.
Date:   Fri, 25 Jan 2019 17:59:49 +0800
Message-Id: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend because previous mail is blocked by server.


