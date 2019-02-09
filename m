Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD7C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5512177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry+YCTt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBIAJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:09:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52546 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBIAJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:09:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so6280048wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhYIaC5gz39kMk0XdTT3RBhkaXLXWFgcj39sN67FslM=;
        b=Ry+YCTt7y/ppYSoDUEvZsYoqnYumg4MlJz70eigFujPaYOPk6qJLa0QViwmFj463NZ
         s9JpPnR0Vc5udq1uvkXl8rNuk5UrfV6uGdm7Bey6L+DbEgzGta8/SzBRfnWIVOJoEKXl
         hMPBvnK8fYx0QFRqW6c+4TwOYpbBzqnZwvqErQVqZyRFC4eiDMXvET5SL4kZ4ASwFN4h
         F1NMe+xx3IGpOkMOzCQDLjcfSoZhWOmLavDzvaWMBb3nyg+Q5NO4u2u12GrJi/Vd7+B+
         tB5T2qvgB6yeymkYPYdQHANwwngfSJDVyD0OdPQ0so33Jy1CdkIdJmZgRIPf7TnGnFHP
         tR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhYIaC5gz39kMk0XdTT3RBhkaXLXWFgcj39sN67FslM=;
        b=F7GGpXXh407J00CfKq1nH8csQ+Cqaly+vxsvR0QvkQ6GoJ0Vt0wjnO9YmRTSBMWjq/
         NoeKK2ZFTzQeOUSr4DkAUkN9NrRqu8x25v7G8e8VO20Sd5UlXa6SxUl2l/vCYbKEjMBn
         YM1ozCYLAYpCRIrcmUEt1a9K7OQQ7+w0HrrBcnzWZ/yETnhad86/9R7dN4pJoMrWlf8E
         OrteEEI2JNloH/Rw35w1o4jIijUOXgneSRDwXkWolfYmDVPeTrmvpmJ5ZSghRPLiilhR
         UQEC/HSWEJlWHOh9KvTWI1yKuwRvKUQ6WIjHmBlP8baWt6yp8YIcScPxAUuhPT+q0DmE
         +xMw==
X-Gm-Message-State: AHQUAuZ5eLU8Xg1auzKlFBVjd127LrFVDOv2+82FEYiyiMlUOAnSFeTA
        0aL8kpbWz14d3WSK7Ymu4lZp+SYL7dgDtw==
X-Google-Smtp-Source: AHgI3Ia/YqiBLhPJW+W4rBRdtLCsqQ5mV0sBOB6wVQM4O2XYDkv1JwPNpmwsFTnKQRi6ARG8T15vXg==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr18385976wrm.143.1549670943582;
        Fri, 08 Feb 2019 16:09:03 -0800 (PST)
Received: from localhost.localdomain (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id 65sm10483171wrb.62.2019.02.08.16.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:09:02 -0800 (PST)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Subject: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
Date:   Sat,  9 Feb 2019 01:08:37 +0100
Message-Id: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target, e.g.:

    void __cold f(void) {}
    void __alias("f") g(void);

diagnoses:

    warning: 'g' specifies less restrictive attribute than
    its target 'f': 'cold' [-Wmissing-attributes]

These patch series clean these new warnings. Most of them are caused
by the module_init/exit macros.

The first patch has been in -next for a long time already, and an alternative
solution (only __cold) for module.h as well. However, since we decided
to go with the new __copy attribute, I will leave the series for a few days
again and send the PR for -rc7.

Link: https://lore.kernel.org/lkml/20190125104353.2791-1-labbott@redhat.com/

Miguel Ojeda (3):
  lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
  Compiler Attributes: add support for __copy (gcc >= 9)
  include/linux/module.h: copy __init/__exit attrs to
    init/cleanup_module

 include/linux/compiler_attributes.h | 14 ++++++++++++++
 include/linux/module.h              |  4 ++--
 lib/crc32.c                         |  4 ++--
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.17.1

