Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeBERgq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:36:46 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:45834 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeBERgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:36:36 -0500
X-Google-Smtp-Source: AH8x227zBura0/v2vLAQH5HP+hxmo6Ou4v/6ei6I3qec4yfgp2rbjqP9eY8UdXYSsLwZZJR+uR0iO7rGiMumbou5RFM=
MIME-Version: 1.0
In-Reply-To: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:36:35 -0800
X-Google-Sender-Auth: N7veEVjFzqdvjd74VxIxHknCILo
Message-ID: <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Amir Goldstein <amir73il@gmail.com>
Cc: George Spelvin <linux@sciencehorizons.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 9:32 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Assuming the fix is not moronic, I wouldn't even know where to begin testing
> its affects, or how to prove if there really is a problem.
> Any suggestions?

So I *think* that this was on purpose, but it's a long time ago, and
we've changed some of the hashing since.

And I think you're wrong that it's a no-op on 32-bit. It's a very
expensive and pointless multiplication there too, even if the *shift*
ends up being a nop-op.

The name hashing is pretty performance-sensitive.

                Linus
