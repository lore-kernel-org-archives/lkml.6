Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCPLOM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:14:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55026 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbeCPLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:14:10 -0400
X-Google-Smtp-Source: AG47ELsepo94XVYBZQmMFpAWXSuXnfUPAKGP4oKx74hOGtoTCLzvFscdVE4v7deumUCj3DLKlwGFQA==
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc0
References: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
Date: Fri, 16 Mar 2018 12:14:06 +0100
Message-ID: <87fu50e0ht.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 16 2018, Junio C. Hamano jotted:

>       gitweb: hard-depend on the Digest::MD5 5.8 module

I've just noticed this now, but while this module is in 5.8 RedHat's
butchered perl doesn't have it in the base system, thus this introduces
the do-we-even-care regression that git's full test suite won't pass on
a RedHat (or CentOS) base system, because the gitweb tests will fail to
"use" Digest::MD5.

I'm slightly leaning towards not caring about it, since there's no other
perl distributor that does this sort of split-out of the core, and if
you're on a RedHat system they're solving your package problems, so this
really only impacts the edge case of git developers and redhat
packagers, both of whom can just do "yum install -y perl-Digest-MD5" to
fix it.
