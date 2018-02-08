Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHQwO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:52:14 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41958 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:52:12 -0500
X-Google-Smtp-Source: AH8x225dqhBk6Ka6NKjJ9+5sVjwBXhvZIS/p4HgnwUtRJMQ0WzZ/st9wXLE6zXiCMWoSGMj6rKs5XrBK9RKg0ZFx0/U=
MIME-Version: 1.0
In-Reply-To: <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org> <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
From: Matt Sealey <neko@bakuhatsu.net>
Date: Thu, 8 Feb 2018 10:52:11 -0600
Message-ID: <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
To: Channagoud Kadabi <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>,
        kyan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

On 25 January 2018 at 17:55, Channagoud Kadabi <ckadabi@codeaurora.org> wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.

[snippety snip]

> +- llcc-bank-off:
> +       Usage: required
> +       Value Type: <u32 array>
> +       Definition: Offsets of llcc banks from llcc base address starting from
> +                   LLCC bank0.
> +
> +- llcc-broadcast-off:
> +       Usage: required
> +       Value Type: <u32>
> +       Definition: Offset of broadcast register from LLCC bank0 address.

What's with the redundant namespacing?

Have we not, as a community, realised that we do not need to namespace
properties which are only present under
a single binding or node, or even those that aren't? This mess started
with the regulator bindings and it's never
stopped. What are we at now, 25 years of device trees, 10 years of FDT on Arm?

Notwithstanding the complete waste of rodata in the kernel image for
matching (& increased time to compare), why
wouldn't you consider why "bank-offset" for your node be any different
than a common property for any other node?

And if you need to describe register offsets... why aren't you able to
use the reg property?

Ta,
Matt
