Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuQg3icPbFup8FiAbbrBPzWmRtps0opkBFlrCsmjnWj2vwc5Q0ICa5pkmwIVub8fdgXQtUe
ARC-Seal: i=1; a=rsa-sha256; t=1521239447; cv=none;
        d=google.com; s=arc-20160816;
        b=QCkZwHV1Gl5wcZ6Z0PQL4bo/1jkktJM2I8l1Urx8pwHroVCLGkEjeFACUGY9SkAkrX
         inllvrtS1PY9iFPU0tZoDonEUtkr+bc9zljgRgzfPxAdwMF8iNmqm9VUnyVyU0ZaJdId
         NBmyalIEIzegkEDDGsQF+/myT1PgZhbWzFoW+RBUct8eIAJRQQSPWxMQcGpE979myALs
         4lQQ+wB58aCcv1hl5O1xXNyUsscB0utSdMTKFbqppT35qaFooaui0qqP32YLZ9/eWnV4
         WtGDd01O+xTl7UlpCHvv39tLp++ORfB+4sFUnOz1/vgObJM7xdW2HOgPzSN7w/PIsPge
         JfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=0z3Rtjq4ASM3/UaYi3CQda9lSdZVZu4zhLUSEBSdonU=;
        b=I1WuKYi+dpMcT5LBjmomhUJFT7iiSiBc049mEV5f8CLEROfjmpykM7a+EQHeW10xRh
         pmZvNWRz69XGrBilbqdDAz1vMNP6AN7h0aG+y6T3AA7QsUUZvu8NFoAm9MfkZ84mrOA2
         jeJbJBZkGmbYFee6fR7wVuEn25PMMj6HK4ubkjKIdl9vdY6CsiiEzuewCmCud2w68SSN
         /yVjyzoiqZL557zA4NJtXdP7YO35rxvOzHcT7kTVT9I3V9qBVeIoH2dy+wCEOC5aJ+Ma
         iPT0mY4JE1tASK0UCzrR/FGxetdTaIGfvIxKcZQG6sLDKpb3yDy/TCNrubrcnXBF00mL
         7YVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCPWaW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:30:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:64206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCPWaV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373102"
Subject: Re: [PATCH v12 17/22] selftests/vm: associate key on a mapped page
 and detect access violation
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-18-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <bec09b77-ca65-5724-1191-a21f4cfa7cd3@intel.com>
Date: Fri, 16 Mar 2018 15:30:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-18-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064551027163997?=
X-GMAIL-MSGID: =?utf-8?q?1595135174939386497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect access-violation on a page to which access-disabled
> key is associated much after the page is mapped.

Looks fine to me.  Did this actually find a bug for you?

Acked-by: Dave Hansen <dave.hansen@intel.com>

