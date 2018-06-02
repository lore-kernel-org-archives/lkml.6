Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeFBMCo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 08:02:44 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41921 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeFBMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 08:02:43 -0400
X-Google-Smtp-Source: ADUXVKKUSB3aXLPvXHV2xQYeXI+cAlPjD5gxYjO85UM4hb1jhlSNpzlT9/rJOl4Kqwh4jzYlWo1tjA==
Date: Sat, 2 Jun 2018 15:02:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/17] signal: make unhandled_signal() return bool
Message-ID: <20180602120238.GA11282@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -int unhandled_signal(struct task_struct *tsk, int sig)
> +bool unhandled_signal(struct task_struct *tsk, int sig)

This most likely makes code generation worse on embedded arhcs
which will '& 0xFF" internally.
