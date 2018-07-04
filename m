Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FBC24108
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ExQEWK+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FBC24108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:58:47 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:44578 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeGDU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:58:46 -0400
Received: by mail-oi0-f44.google.com with SMTP id s198-v6so12845355oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5TGwy7wN2sRHezXczuvvVEjJRAPh3SzkdsERbfEsy/g=;
        b=ExQEWK+oYlfN3UfYK+DD6xGv9TdeEvuJdskYOcVu3up/bkrov+E/Vc5audZwIZbeDu
         7PbspI3l6UDeVYdwcMnOK367tka7PBUXTFMxXseB0tNgcExk6Fo9jmjnjZSNTY1IT16W
         gikwKG7XBVaU5E4OaWlJXyVbGLXciM84qCqTVzK+P94petcEDkEphJUStxTnIyJslpjO
         IjHhpNMBQrDglsWJa0pbY60SKfSzt3tZO6eMOxMcEDYF6qHCifxP8B66n2RT+Gy4kKbY
         NLui5LRroOv1slEdE3h7m0Fcs/741mzDkj7OhoeL9b9Y5yZgHwRpY3K1Z7/aIn3XPSCa
         NYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5TGwy7wN2sRHezXczuvvVEjJRAPh3SzkdsERbfEsy/g=;
        b=bPNBqrb2ZED2CVojG3QG0kiDuXZpTulRHQvQV0fx27rgYFi91imUrrbMprDZeVAEcG
         z87R9o3lqn9ZsY4bbNAVtrnIxG05IfKKFV404Oof+/bpFOCfrTpxJgSdGL1O4lcPJ3Oo
         3gsKBeB/BYktOgEJQfIAP5DsIMZi5HxY7MwI4MizbJUdpZxvXwxSp5+tn9eiubyVGyiI
         k7GxaArQwsPBoqqyIGiftSsoA+AGPNkE/kg+ChJVI6QxfyrxwkHoVE9fyoixDncGJ6fQ
         rKsZBgBVmlDO+6CAp1peY9reITMlF0LbPKnqZQnm5QRLwI7lefd7AvweuWCO+jUWumTa
         P1vg==
X-Gm-Message-State: APt69E0622klFF+Wha1aYd9tg/zyuZmtzZMyxBXid7lTH2T935j2je2c
        a8KFDRuymxr/2jII748ZecoDew==
X-Google-Smtp-Source: AAOMgpf+vQS4QvNgTTSbEc1ukL950iFaZwWJ9wtPh+z9hpyDVaTmtVoHuX7Gg2rf1ivpSsMXIG7P/Q==
X-Received: by 2002:aca:5004:: with SMTP id e4-v6mr4079833oib.111.1530737925296;
        Wed, 04 Jul 2018 13:58:45 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id h124-v6sm2237463oif.15.2018.07.04.13.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 13:58:44 -0700 (PDT)
Date:   Wed, 04 Jul 2018 13:58:44 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Jul 2018 13:56:26 PDT (-0700)
Subject:     Re: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index and type for 32-bit
In-Reply-To: <CA+ZOyahLiGS-7DQO8ncJ_=w-Mkav33FBBOC9-K08XSyhPgjtGg@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com
Message-ID: <mhng-640c8a78-7e3a-4ccf-9951-fc85a0969b9c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 09:53:49 PDT (-0700), zongbox@gmail.com wrote:
> Christoph Hellwig <hch@infradead.org> 於 2018年6月29日 週五 下午3:12寫道：
>>
>> On Mon, Jun 25, 2018 at 04:49:39PM +0800, Zong Li wrote:
>> > Use generic marco to get the index and type of symbol.
>>
>> Why do we even need this in a uapi header?  Shouldn't ELF_RISCV_R_SYM
>> and ELF_RISCV_R_TYPE move to module.c?  In that case we could just
>> use CONFIG_64BIT.
>
> Make sense. I even think the all definitions can be move to include/asm/elf.h.
> How do you think about that?

Sorry I've been slow about reviewing this, but I think just in the interest of 
getting a sane RV32I port up and running quickly (so we can try to get glibc in 
shape) I'm going to take this for now.

Do you mind submitting a cleanup patch?
