Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvvpoB6wGoRPOWNbGGLP1eeBo6QfKjeRou2Vn4NsaYMlsehNHPgJ4gJ47BEvlTfyDOLs8bo
ARC-Seal: i=1; a=rsa-sha256; t=1521238525; cv=none;
        d=google.com; s=arc-20160816;
        b=zir9LI+UWWqCDa/nrlA58hf25eFPbS3bi9MdJ8wHbhtjR+NsyIK7ezyAbUnJT+mTut
         1ASFgXoVutP+6JOagqFgy4m+ADud9larQSKFdjpHvJmmbETcYnV4bAQP/WIqffsn/KzY
         gyDdCEFKeOzTro/FbJDBCuXbDesNzKC0clIXxokbziK18cRlJmgMhSj7X8B0j2XqYCzN
         aWgwQJ62uXftCwLTHf1t6GuJks4Pj2j69i/BPcqDT4RY4tcSI7HshYVs9axoif5CJhPF
         zzkI+uN3VzMhR2utuComwMY5PXauPYiQlHDjn3rDf9Hu+qhMm0O6F8Bi9aDVDlNMyYuV
         5kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=ye11fyySvbqBicUO+WUehZS1051VnQWzXPdK3/naudo=;
        b=QXy3l53tjruOpQ4poTs1LVOJKjJwXukdI72C11Ai/YB+8YvlTmh2+DGyHBizduJUIx
         7icNTObxJ4rNte9z0PmAEOAqIamLNKjWs4eH8Gp2zP5sb2q5hn00RAvruZ9RF6ZLeygh
         JKeLygX3ywwWhSdLhLmFyDWkVa2f9/63Yl+50XhaqVs/aOYV8A3Yxfpqjk1XdQkCghgl
         56KfJNNubfq81/cmZn7BHsaMpJuiUdvbj5zExEpapiyN+rhoMa0Njl4wefeUT7bGkHT2
         5PedIqdaHWBPE+etQLN/mmY3II90LaHXbhxBYious18vy8SPgnPxo70EmrZo50vMpYP3
         z3xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeCPWPZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:15:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:57423 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWPY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:15:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25370539"
Subject: Re: [PATCH v12 10/22] selftests/vm: introduce two arch independent
 abstraction
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b3a58839-6ded-16eb-79c5-cd26f89790bc@intel.com>
Date: Fri, 16 Mar 2018 15:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064631935429734?=
X-GMAIL-MSGID: =?utf-8?q?1595134208491042942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> open_hugepage_file() <- opens the huge page file
> get_start_key() <--  provides the first non-reserved key.
> 

Looks reasonable.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>

