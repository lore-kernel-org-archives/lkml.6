Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C17C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C55251BA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C55251BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeGAJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:23:12 -0400
Received: from mout.web.de ([212.227.15.4]:36363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeGAJXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:23:09 -0400
Received: from [192.168.1.3] ([77.181.193.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1fn54z0Kzx-00MITK; Sun, 01
 Jul 2018 11:22:40 +0200
Subject: Re: [PATCH v3 12/16] treewide: Use array_size() for kmalloc()-family
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180601004233.37822-13-keescook@chromium.org>
 <b4c01457-7ea5-e7e3-be8b-f00fba6bac2b@users.sourceforge.net>
 <alpine.DEB.2.20.1807011100110.2748@hadrien>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a98a68c8-8b08-b3e9-da7b-ff57a2614f96@users.sourceforge.net>
Date:   Sun, 1 Jul 2018 11:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807011100110.2748@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nhphkcdQ4vZGS50OQT1JOSEEpeAuBXy0hOC+wFrNXWn1CKSKUQP
 sU+CUVHX/z5sOG4JiEWt+4BsbY8Bp1fnXUdZz9F53knUsp8+5OQw7r3E60zvDIDwd358yCr
 9dV+a3iCByIX2HVd8BXxRia/P10oyVHmYYy2HTMBHrpTc4BjvTmQuZPES4wkr201FzeHFzs
 VDNZmX6aHNuFA5noC500w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N1G1Wk93Sg8=:uo3QLi3cBDf89j1OCISRd4
 k7iGS5cgXCxXh8QkUhaGMPJB7X7h1eSwSO2M43fgVdqfDjambpkGdoSTvuXeJhdLlWSM3OIQY
 SNn2DFNP4wfjIvG2QOjVbjfiG1TzLI1dWhL6uG19Ofrwn+Mpu4WJvamCgKbWXiklM5RfUbgqI
 m4nZJfM/QGWAZbGKaeH+YD9oVt/QKVse5AT5cUgZSZszOxCrlNyhv4z0kdGGJa+1VSlV+tEVc
 uRGwrNW1Qg4WLe6KVw3I6d9XX+OLLff6KT93i8vYI8b8zGJ3WiZjWlZubTwSq7FLubu6GY7lI
 uBLXdjgORzEYkjd6F9S+8OjtGMqRPARJ2aRkXhLm+Ydzw7xTwY5QWGs1+Hp2NB/1XDD1lhxOi
 tAlZ+7FfI7VJbsYl3/s2zWO15r2HfdaQe4EALrOJt2TF0J3SPO9Mz7u+ur2T4tDdMjKyPiKzJ
 KkKdBZqvwcTUtLOXfx5QPzqWRMfepwsvsLQzqeH1f4zIkN1jBZy3he72detWty9KhhW2IbZiB
 1rIB+zJ5BOJRRnfPrd7YHTit8hryQzGaUa3G5Eo2G167D6UwfmFJw0xEcohU8j2bP932fI3lb
 qgFtB7QxY9rMvdUV9ONP8dOypIjdtWkAgvQ9oAEI1FUc48Nx+Wgn3KXoDyaN3M27PP5l6+wq0
 YnlcfOwFek0ivl6FGFUjINaIHrHiny6Pv+QhbvcEke8VBZyEOr39T4HPYSqa/3kOP3qB7PXJv
 Ldy91LCo3ZuLolwY9yijPh9m08/tDTXCdkBqHHbEsrq9RrcZJpAxtySJSNtUX4nzXwSjjr2cx
 F0g7B2a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * The repetition of such a constraint in subsequent SmPL rules could be avoided
>>   if inheritance will be used for this metavariable.
> 
> This is quite incorrect.

I suggest to consider additional software design options.


> Inheritance is only possible when a match of the previous rule has succeeded.

I agree with this information.


> If a rule never applies in a given file, the rules that inherit from it
> won't apply either.

I would like to point the possibility out to specify a source code search
which will find interesting function calls at least by an inital SmPL rule.


> Furthermore, what is inherited is the value, not the constraint.

This technical detail can be fine.


> If the original binding of alloc only ever matches kmalloc,
> then the inherited references will only match kmalloc too.

Can the desired search pattern be extended in significant ways?

Regards,
Markus
