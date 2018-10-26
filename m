Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88CECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B09207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B09207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJZTzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:55:43 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:43732 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeJZTzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:55:43 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 15:55:42 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 7861823F240;
        Fri, 26 Oct 2018 13:09:12 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OUgGX45SwA-I; Fri, 26 Oct 2018 13:09:11 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-248-240-114.ewe-ip-backbone.de [91.248.240.114])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 3274A23F366;
        Fri, 26 Oct 2018 13:09:09 +0200 (CEST)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Peter Zijlstra <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <094556ca-ea87-9c4a-2115-600d2833fb2a@darmarit.de>
Date:   Fri, 26 Oct 2018 13:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.10.18 um 11:26 schrieb Peter Zijlstra:
 >> Jon,
 >>
 >> So the below document is a prime example for why I think RST sucks. As a
 >> text document readability is greatly diminished by all the markup
 >> nonsense.
 >>
 >> This stuff should not become write-only content like html and other
 >> gunk. The actual text file is still the primary means of reading this.
 >
 > I think Igor neglected to read doc-guide/sphinx.rst:
 >
 > Specific guidelines for the kernel documentation
 > ------------------------------------------------
 >
 > Here are some specific guidelines for the kernel documentation:
 >
 > * Please don't go overboard with reStructuredText markup. Keep it
 >    simple. For the most part the documentation should be plain text with
 >    just enough consistency in formatting that it can be converted to
 >    other formats.
 >
 > I agree that it's overly marked up.

To add my two cent ..

 > WTH is with all those ** ?

I guess Igor was looking for a definition list ...

 >> +Available protections for kernel data
 >> +-------------------------------------
 >> +
 >> +- **constant**
 >> +   Labelled as **const**, the data is never supposed to be altered.
 >> +   It is statically allocated - if it has any memory footprint at all.
 >> +   The compiler can even optimize it away, where possible, by replacing
 >> +   references to a **const** with its actual value.


+Available protections for kernel data
+-------------------------------------
+
+constant
+   Labelled as const, the data is never supposed to be altered.
+   It is statically allocated - if it has any memory footprint at all.
+   The compiler can even optimize it away, where possible, by replacing
+   references to a const with its actual value.

see "Lists and Quote-like blocks" [1]

[1] 
http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks

-- Markus --
