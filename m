Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E91C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="dDM2rZNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfA1N6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:58:46 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25431 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1N6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:58:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548683907; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=k/Z4oKfYUxFozKB9A82we9Bq63n99j+zluAj1MxO6JiYDyYe70Q5nSaF4M7y8VaH4QdYMnlOc0M0Vdro9FwMn+1bmGmKcieSzBWiLf3BZ8QZb3YU+Nd7zBUo3nnTnnhykzBwKNQ/HHHfQJCJpSGBKciw2t2cKJ9AuxgiAETOjf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548683907; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=SqB3w4byS6UTfSLHEA4Uzgvi/xiyoym5ycrjk/9Pxkg=; 
        b=RJhVqEJ1jJfhIoOkI5H/0VolC4Gxs0q3sHCzzyEhnVr3G3NNC1qkrYsTPvVB1WIZIC+gV5ub3T8QwHobS6e5Q1tDPlmkqMGafgUfpU+iksxXOIy1fJ+jPzGRblHuGWyk+QzhHmAuqTGMHAz3r2noA6yf8pPlBr5yEkmmgdeO+3k=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=pqRpo/ABR2cat7JrdEPtgXzoAY3MR2Nem8INvr0ftLsA2qLl/8E6tdEFPV2b5XrjFj4JjlzgR8iN
    MnJv7H5/6GJ8zzPoKu2y0uCA0ZYY1stx/PtlwrckuzNCdz4uuL9g  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548683907;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=48;
        bh=SqB3w4byS6UTfSLHEA4Uzgvi/xiyoym5ycrjk/9Pxkg=;
        b=dDM2rZNtnh5p+LbIZwqT52F7KjMLHwfjqBkIZ8/UrlR0RwZtVrOwdP6hntnLCwlo
        w0Jz4gmeDggAKmHmZNozyCCUMFxR5L7rTuS9Xs47O626OqGGBcDUVQChaH0onzf/bCQ
        7XSboxRYGLlY7RRdDRc+PRfbRs2NP/svN7taSnzY=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548683906414282.5482739945153; Mon, 28 Jan 2019 05:58:26 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Serial: Ingenic: Add X1000 suppor for the UART driver.
Date:   Mon, 28 Jan 2019 21:56:59 +0800
Message-Id: <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Remove unnecessary "EARLYCON_DECLARE".


