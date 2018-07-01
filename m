Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1A24143
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D1A24143
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeGAIr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:47:59 -0400
Received: from mout.web.de ([212.227.15.3]:36073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeGAIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:47:56 -0400
Received: from [192.168.1.3] ([77.181.193.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlnQO-1g8bmT2P0i-00ZPZ0; Sun, 01
 Jul 2018 10:47:13 +0200
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180601004233.37822-13-keescook@chromium.org>
Subject: Re: [PATCH v3 12/16] treewide: Use array_size() for kmalloc()-family
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b4c01457-7ea5-e7e3-be8b-f00fba6bac2b@users.sourceforge.net>
Date:   Sun, 1 Jul 2018 10:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601004233.37822-13-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KY50xjN06J2j+XRRb90gZGSHbtq+81xTCsEWHM+H7rnbOV6nE2h
 iKghSo4YHDUtgwCKTkXGLMv4OmyH2vs60+yucDH1Wr67Pzs0STSJITJ+H994bjAIqsO6sWm
 S6lKzGNSJoOYeC9pUf7rCxqEMPDuv8yzMpilfhGD7v8/0w5b0mbdsB/A+LPnarAfhldPVtT
 2IUR+TKaO8QVag9V6x3rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vn8fXjOXSEY=:yg/z7w2B2ZeT3AAhRB0c1Y
 m7IRKhU+7P9IcVcV7T/zueVVo8F7YK8tI+f5T3W5YJ/Hvo18AyNlH9nMOsS5e403eZbTNso7T
 VHxRY2O0q6QPB42yHN+pZRKrAymDbPoKxMosA4/XyfWcj/BeKhZXd10YfdEdxs5wADSHjbqdq
 noQpIdiSu0Q1mPswL340NPaJ4s/whgc1fSmbfMYx+eUYh3Kz7K78ERtji4nnsASH472hkze5f
 WNDbqSGCaXig+tBweR7LWf7Vvri68JZiLiCwaaJOt+PRNL98a9Eume2Etmdt53iQ1VivF6XiR
 n8Ew7EJ4PocE21WFHrDT5yKX6/mah7sk+4Ta+j9iqAlaWPZWCF8YQSFbIxA4XCnz3SeVUqzqc
 1DE8oykqtHcHREEJhOcE+8h77he47HdlQOgNiVh/No0cbDUtHNC9B9K654wbcBIleoPeJuHTz
 zpCljt4Ik2kl91bbJmGj1KNwWN5r+6YSd84tS0bnWYBL8pcIPGKjBDvW1Z3s4qRsrGwe3a0NK
 e6bZVAbBeWzJBGL8xf2zUC5H0xw+4Pwm0F/ij+vN+cPNzpWpKTZAJ0isbLYjkUehpZqjxRL1h
 PGNbgrK8koV0LxvU5gkYNAFXyShX9LYvngtnEJjX5vd2I9Ya6tf9e/9LS3mNokRkt8aSJyvJ1
 nmv/mcGQB/sQ3PFP9Af/mtrRbJCu5Kki8knjzn2qrzBe7iMie04PM4qP2XvG1P0l34Tl6OyLr
 1ywgGbxw+lMHQROPpl1eAf59vfn+Zslji0jOwWKxf2aI4EvfVIwhsMDVxMW5x2KtBxEW8//i1
 SeEgAXk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For kmalloc()-family allocations, instead of A * B, use array_size().
> Similarly, instead of A * B *C, use array3_size().

It took a while until my software development attention was caught also
by this update suggestion.


> Note that:
> 	kmalloc(array_size(a, b), ...);
> could be written as:
> 	kmalloc_array(a, b, ...)
> (and similarly, kzalloc(array_size(a, b), ...) as kcalloc(a, b, ...))

This is good to know, isn't it?


> but this made the Coccinelle script WAY larger.

Such a consequence is usual when the corresponding software development
challenges grow.
Are there further approaches to consider?


> There is no desire to replace kmalloc_array() with kmalloc(array_size(...), ...),
> but given the number of changes made treewide,

The number of changed source files can be impressive overall.


> I opted for Coccinelle simplicity.

I suggest to reconsider corresponding consequences.

I find that an important aspect can be missing in this commit description then.
How would you like to determine if the array size calculation (multiplication)
should be performed together with an overflow check (or not)?

How do you think about to express such a case distinction also in a bigger
script for the semantic patch language?


> This also tries to isolate sizeof() and constant factors, in an attempt
> to regularize the argument ordering.

This desire is reasonable.


> Automatically generated using the following Coccinelle script:

I have taken another look at implementation details.

* My view might not matter for the generated changes from this run
  of a limited SmPL script.

* My suggestions will influence the run time characteristics if such a source
  code transformation pattern will be executed again.


> // 2-factor product with sizeof(variable)
> @@
> identifier alloc =~ "kmalloc|kzalloc|kvmalloc|kvzalloc";

* This regular expression could be optimised to the specification “kv?[mz]alloc”.
  Extensions will be useful for further function names.

* The repetition of such a constraint in subsequent SmPL rules could be avoided
  if inheritance will be used for this metavariable.


> expression GFP, THING;
> identifier COUNT;
> @@
>
> - alloc(sizeof(THING) * COUNT, GFP)
> + alloc(array_size(COUNT, sizeof(THING)), GFP)

More change items are specified here than what would be essentially necessary.
* Function name
* Second parameter

This can be a design option to give the Coccinelle software the opportunity
for additional source code formatting (pretty printing).


These SmPL rules were designed in the way so far that they are independent
from previous rules. This approach contains the risk that a metavariable type
like “expression” can match more source code than it was expected.
This technical detail matters for the selection of the replacement “array3_size”.


The comments in the script indicate a desire for specific case distinctions.
I have got the impression that the use of SmPL disjunctions will be more
appropriate for the desired condition checks.
A priority could be specified then for involved pattern evaluation.

Would you like to adjust the transformation pattern any further?

Regards,
Markus
