Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D7E21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="WwCKj7zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfA1RFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:24 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25429 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbfA1RFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:05:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548695106; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=MAE/JjBl4Jc/PAVplJ+KTNgglncS6Xq+zFvGCAnLuL3inBh84uOSzxZLAFxGzLNZdS7ISW0BRxBjIS1hEiqVqLnBTzusBVBVfgO0UcCC3gJSojix3/Uwo2oMGNW2RScpNIEFg/R1mFtye3jgaO0aqH9M81cPRtmCvNYOuN0kgwk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548695106; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=WkTNFu8vnmPor/+WSZwPOqsAXvLDg8nbVLIOYlWMj8g=; 
        b=GkMAEK0tjdiABlA+p3mb7CVAuvL2Ym2bsJvAUBl3TBXfC449LVhsbIk0rChHz40uAw/o+Io8r413OWv3KDH6jbHCQYKb9MAUt7YxgdVugZgUx3gbLZ4vzS4RZITk9OURmqZkl0KboW4d6mJI8F6Ey1rCQdlFKGqwuzPm1o0mBq4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Nkf+P82bD2RhShO+JEjIcP3XQE8YCC4psFD1Ox74ifZ4YqXRif7uzHTm6b6hBMewOfVVW/9bgtUd
    VwwcXwsu4WgyYuLAKFjy2rYqz2Zw4aGl15eNCVjr2Ghb9yQQWSJM  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548695106;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=100;
        bh=WkTNFu8vnmPor/+WSZwPOqsAXvLDg8nbVLIOYlWMj8g=;
        b=WwCKj7ztdoVJGBczfJYw6LYp18KcJj4Has0bcn9mXcsGqo4aXxYen2srxS98W7vJ
        +XwzllcjZMxZjTSiKl6qRsSavdZJrX9H6At6ZLg5Pmtg+W/YkXBM8HtVcZN3f+EP/p0
        smib+xRArKK5gADFouLw0kQzw5TaroXrgOt7E+7w=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548695104299105.85452309761104; Mon, 28 Jan 2019 09:05:04 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Add Ingenic X1000 serial support
Date:   Tue, 29 Jan 2019 01:03:47 +0800
Message-Id: <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Remove unnecessary "EARLYCON_DECLARE".
v2->v3: Use different subject line for each patch.


