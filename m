Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7F820862
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pb74nJ/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7F820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeGJWwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:52:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39882 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbeGJWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:52:41 -0400
Received: by mail-io0-f195.google.com with SMTP id e13-v6so21893633iof.6;
        Tue, 10 Jul 2018 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aZFW0jKrMCw7eCaAGSC7m0mApzQTiEJGq/x3sMcTug=;
        b=Pb74nJ/4Stm8TkRn/cdfg1CimYClZo8xrM/gjpf5Fbzrp/JfhpbV45Tji2CC5/3p6q
         zCSklHBZzNFS83hmKkzLIeUiMtePq3f5GkFxnCq7kJ6gTE6lZZFIY8hKVj+w8xs4k6tO
         cVc8oDsk4nnqxek++7oVHB9Vum2N7sVGHB0Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aZFW0jKrMCw7eCaAGSC7m0mApzQTiEJGq/x3sMcTug=;
        b=C2opfrfSVKcHoozxUvVZySunc6o9JF0MxPUBSEykwTx0+d4UQbbX7GzSCIazV+J0cJ
         0s0pNt/O08bb1qF3Ao8VpThkZdQXd81JZqE1+Yd/a1jf4M3B3/ZAEBmcBJdNrIMXXKg+
         R+XO1CW+/kRPr2I2g9LC64JGNQ7LDcqbt7Lm2QlaAWpy8vfhrmpEqAoMAxeZSQR8EJTv
         UQXSXLhDT/dFe0kkQCyRzkkSl0r8rv5vkS5OnrYscCyy0XTFTp9C63J/ebPm+wJcjDST
         g/4D4Hk6nEOLx/k/TtbQSZktfTNz+Z+x10FdP960J1/EwG/8UizsH/PEd+pkrQ3RUcBF
         HIaQ==
X-Gm-Message-State: APt69E1DcKbSpxFyk2VXL5NiBbEMpp5T3nHghI5uhRbQDfgpV9zx+lug
        8RvTTdWCINhZp1ksiMIrWGWMb6HBQcISMfaEH/Q=
X-Google-Smtp-Source: AAOMgped7+vIVJd8hVNmWGZTQgtpdZqNXnKJEA2E46Lfveo1/Y/xZ7I5RKcc6XGtuC/t7HS22QMnilLDRftW+QY0L+4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr23847025iov.203.1531263085161;
 Tue, 10 Jul 2018 15:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126256385.14533.193725036463937359.stgit@warthog.procyon.org.uk>
In-Reply-To: <153126256385.14533.193725036463937359.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 15:51:14 -0700
Message-ID: <CA+55aFzq1+pETim0MfJa0+F=H=5jnJk-dX1NrAK+Zy0XE9Zggw@mail.gmail.com>
Subject: Re: [PATCH 11/32] vfs: Require specification of size of mount data
 for internal mounts [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:42 PM David Howells <dhowells@redhat.com> wrote:
>
> Require specification of the size of the mount data passed to the VFS
> mounting functions by internal mounts.

This should not be patch 11/32 in some big and complex series with new
user API's etc.

This should be a prerequisite patch that stands on its own.

          Linus
