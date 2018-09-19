Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDDF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UES6L5Qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDDF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeISXeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:34:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeISXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:34:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so3058670pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHley7GlSctl9wz23eQk2RyGB6VFt2CdV+8KyrzrK5o=;
        b=UES6L5QsaU5uor+UG1n9/XT6iYri7GwEnO5UX3DowbjXA4RIKn1DaFdkumannEnnQP
         xMRsjaKGVAeC+m6gvG6IHq+qoC+nnccp79Ks7NRxxeLLkTLzu1d3LGMowu2K5OyHXFg1
         jBC/iEzDEwJK5a7sMjr+jUhsARumYYORwBwIkMzABVlPJomJSk828UJntngqjVMpnWrT
         sl6Nv/0Z4cgSN+vApu5ZQH/jZ8T6Kn9kSCi/qqOcJf6jiym+ouHqO8qKJmJrrBtOmB/D
         EZzFHZuBCjOi38VEyAOc0/dUTnDF/wa3Gc7A/9/o1jMAGVj9gdI+bUDHgmHUdcYCTevO
         G5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHley7GlSctl9wz23eQk2RyGB6VFt2CdV+8KyrzrK5o=;
        b=P+gvRBBCtVqv1NAdGdH1RMqvm795+b7h/fwydqY5X9pC6xrjg8gusSOnfSp76wtAgD
         TYiUUdUCFrsRqWh908zlhWDpMF9NC3O7hSV3RzneoI2CA3s29CxRkB1+uO7123sniITG
         uDHOOj1lAE7Z0r0uFenRquZy3A6NOLBPW7zspeM74c/4nOTUNY7g33csL4XpmEzrGQ+h
         D1xd5J/M/Vmt7ji0W3oyAP/Bx3fpTeSFG278p5Bol/jcOtqLLMadNgEnyGCD1NI6KYAK
         y9SHtBgncuiUozvpT3/1UJ4QfFdX4Dyrmi9GAc+COCTRQ+hGRzjl0JkGz/hkFsKaBShG
         fnXQ==
X-Gm-Message-State: APzg51Cao/3jD4Bys4dnBXWaED88OzOUiCGtwIcZVDkhv/DOff+zfeD4
        2Bl4P5Abpjw7JBpMd2kRX3DucAc4QVWITJ2/S1Oa8A==
X-Google-Smtp-Source: ANB0VdYCQJn2SgtBGQIsbGpL+Cy2zg01vNGwsth9wp2mbiU72LtnkBpzoiHT+igTNwcb20YzhZNXjCj95C1ixSuLhTw=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr34093350pgl.302.1537379720124;
 Wed, 19 Sep 2018 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <201809190938.CXi0coge%fengguang.wu@intel.com>
In-Reply-To: <201809190938.CXi0coge%fengguang.wu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 10:55:08 -0700
Message-ID: <CAKwvOd=woC0N8FO2EZH=1mxKRkvvGVU99r+KurOmOX67Ym6DSQ@mail.gmail.com>
Subject: Re: [ojeda-linux:compiler-attributes-v4 7/13] drivers/firewire/core-card.c:479
 bm_work() warn: always true condition '(root_node->max_hops < (16 / 1 + (0)))
 => (0-15 < 16)'
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 6:11 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   git://github.com/ojeda/linux compiler-attributes-v4
> head:   7c70bc9e399c67f5d1a84b845d2656f8808e0032
> commit: 431781b83c5e7ae3719498bf1e52ca99bcf6d20b [7/13] Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
>
> smatch warnings:
> drivers/firewire/core-card.c:479 bm_work() warn: always true condition '(root_node->max_hops < (16 / 1 + (0))) => (0-15 < 16)'
> drivers/ide/ide-cd_verbose.c:271 ide_cd_log_error() warn: always true condition '(sense->sense_key < (64 / 4 + (0))) => (0-15 < 16)'

If I understand this correctly, it seems that the condition:

479             root_node->max_hops < ARRAY_SIZE(gap_count_table))

is always true.  root_node->max_hops is declared as:

  187         u8 max_hops:4;  /* Max hops in this sub tree */

in drivers/firewire/core.h, while gap_count_table is declared as:

289 static const char gap_count_table[] = {
290         63, 5, 7, 8, 10, 13, 16, 18, 21, 24, 26, 29, 32, 35, 37,
40
291 };

Since max_hops is a 4b bit vector, its maximal unsigned representable
value is (2^4) - 1 == 15, and 15 is always less that 16, so indeed
this condition is always true.

One issue is that should gap_count_table grow, then this condition may
become always false.  Removing the condition might break the then
clause should gap_count_table grow.

Maybe this can be converted to a BUILD_BUG_ON?
-- 
Thanks,
~Nick Desaulniers
