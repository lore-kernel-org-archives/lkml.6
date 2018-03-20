Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeCTXJy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:09:54 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33380 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCTXJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:09:52 -0400
X-Google-Smtp-Source: AG47ELvXqOpNHegZdqcLnYN/LxnjUQHKz7kEdAP0Z8RK/QOaRRQpASaz79YL1XndWDcfVj89G4UC0bdc7Us828uJnJk=
MIME-Version: 1.0
In-Reply-To: <1521587247.32102.1.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de> <1521587247.32102.1.camel@med.uni-goettingen.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 16:09:51 -0700
X-Google-Sender-Auth: y8XQH758aU3X3iksC3fuZ75ja14
Message-ID: <CA+55aFw0YtFYEVA7YJHfvfKFqt+sph2swDmMmf9A4A2N7xtJEA@mail.gmail.com>
Subject: Re: detecting integer constant expressions in macros
To: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 4:07 PM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
> talking of crazy ideas, here is another way to preserve
> integer const expressions in macros by storing it a
> VLA type (only for positive integers I guess):
>
>
> #define MAX(a, b) sizeof(*({    \
>         typedef char _Ta[a];    \
>         typedef char _Tb[b];    \
>         (char(*)[sizeof(_Ta) > sizeof(_Tb) ? sizeof(_Ta) :
> sizeof(_Tb)])0; }))

I liked your previous hack more. This is much more limited and not
nearly as disgustingly subtle.

              Linus
