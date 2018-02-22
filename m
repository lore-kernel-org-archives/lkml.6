Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2247Qm3fN8TGY0cgd7DUWHK8cd+EKgTigvJ9vbM/vOeOXreI+TVU5jYZ5H+ulzh6nlRbFDaa
ARC-Seal: i=1; a=rsa-sha256; t=1519278703; cv=none;
        d=google.com; s=arc-20160816;
        b=DFupP+DjNSbtzwXtHMWVJiUs/cr5Qiu4JqFnQBQh0a9wiXlMoYHEDTsVAd+rwcLKgX
         2aAg+zo3SuRovhytTGkEBIO4tojw3RpuKQ0kx1Qr/lBxqDusZ+jmI8lb/80UAhgU9Mp6
         WZD22d3OTF78EbLwW5dn+3hiHe06hwMk0m3RzCGFUWRTQtxJke2zSe5LHfggI6gjV+FI
         YMju+GQwIPu1toNMUuLI+pv3yhPyZRbW22TNZdTEduob23eUV15RjKWmtZRF9BvuvdmH
         V6LlZ7u/eEOgnXgcXEJCh/d0sg4zjX3e/QJpspLte61jbOUpQn7RAmZ14Z5BDC9wO8Zd
         3KKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=npiZfTMriHEcofpayqVLuZJnIATAwwAmKVzdk6CxsAU=;
        b=panFQVM34IOKAy8qOATKxWGxEoa9fjA2h7tEm4yjnU/O8febN6TuiyJ3QE5/k1M7tE
         Yg1Ui9gDnufdc9FmM86Mi9mn1zCn1QIvYVyIE+gnCOgjhjOuMVHHOB9PXHt5gQuQcYTa
         CU8m8yWCofGy/9/r01YoAL+oD07WQ9OyFUL+V2PR3BGLcaMeoEJjzYI6FrfYwrmc9E09
         GNI5pzJ9DBIw3AyDIOiwkPBEN5NTnyiu4Wi2An4pyBGuEimV6FBSHyY/s8eQ7yXz3nKZ
         R4omump6N9SrINMe4d6yA6qXi48HuK2YmjFe30RKkxO3IURT8FnrSmyORVk+RKM76NgM
         KQkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=GPeywjI/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=GPeywjI/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeBVFvm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 00:51:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34591 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeBVFvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 00:51:41 -0500
Date: Thu, 22 Feb 2018 06:51:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Subject: Re: [PATCH v12 01/22] selftests/x86: Move protecton key selftest to
 arch neutral directory
Message-ID: <20180222055135.6m43xt3mt47sz37q@gmail.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064388709830395?=
X-GMAIL-MSGID: =?utf-8?q?1593079185624974880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ram Pai <linuxram@us.ibm.com> wrote:

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile           |    1 +
>  tools/testing/selftests/vm/pkey-helpers.h     |  223 ++++
>  tools/testing/selftests/vm/protection_keys.c  | 1407 +++++++++++++++++++++++++
>  tools/testing/selftests/x86/Makefile          |    2 +-
>  tools/testing/selftests/x86/pkey-helpers.h    |  223 ----
>  tools/testing/selftests/x86/protection_keys.c | 1407 -------------------------
>  6 files changed, 1632 insertions(+), 1631 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
>  create mode 100644 tools/testing/selftests/vm/protection_keys.c
>  delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
>  delete mode 100644 tools/testing/selftests/x86/protection_keys.c

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
