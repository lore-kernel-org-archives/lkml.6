Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0797FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB372147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="WI82k5Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfA1P15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:27:57 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25399 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1P14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:27:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548688869; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=lj7cLwAdKk4UetaRrgE6V1gGg3zgQdnQljhU9tJ5L7ExD4AihMr969ZHKXLHapF90yTZ8DL+9BefWhyPxCHqPJvG2SdjGE608Yh6wdlCx2++SMBimH3j5k99nLVZOqzYekLfF0ctSPAjXXgSZo+S6Qn/7j4Cb1tfvdeeGOHs27c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548688869; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Avbxp/BFW1EpPjqqq5Xv23FAeNUj0cqZNYWufesVm0U=; 
        b=C5fL5WMCbWlr6QewmMwK4Xpzp3H5ARXZwXobtt9e3Fqay5xR0L2XXO0bo5IHhiv7BpH6qk5yLwUMKZnaWgr4apFKq38NwILVv5J7LzW+BD3njKeHyzE3Wk/GKzCF1zv6jMclu+SrBVw6Mygk7x+Ap19n5QslG8U4mr2XeS3wX3Y=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=SEjr/lIvLIqQE9nqbmQCwp6VeQtOi6HBtj91b3wFsdJGJXWINJftEQR/WWjeKG986cLL3m52bVUc
    BDnprX2y+E1IiSajWU5Hh/jO8aGKOss1TCYGMDMLaVXnpKxigXAD  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548688869;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=28;
        bh=Avbxp/BFW1EpPjqqq5Xv23FAeNUj0cqZNYWufesVm0U=;
        b=WI82k5GxIgb1uNoJlclpGOC9+oxxny4SJ6fpsQax9bz5oWpCGUteGpe122SSHpVF
        L89ny37SyRfwCZ6oZ1EZJfR1wOd2L0Xldgzxf/d1bD+3VTDw7RkGKNni912/KNrb+y7
        h8+HyuWjCsXlyxnvft4+fhhqNUnM/qaW6pJHrCZk=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548688867746720.1209328285148; Mon, 28 Jan 2019 07:21:07 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        paul@crapouillou.net, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Ingenic pinctrl fixes.
Date:   Mon, 28 Jan 2019 23:19:56 +0800
Message-Id: <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile-time warnings.


