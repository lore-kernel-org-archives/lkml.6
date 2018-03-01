Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELsYRjuVhccAdC8NgMFwvOGN4hQDAUAiJK+Fpb+glro/Jf2IRty0tJa+wQsM1lf2VAvIjWL6
ARC-Seal: i=1; a=rsa-sha256; t=1519925108; cv=none;
        d=google.com; s=arc-20160816;
        b=aXzBQH4eZTzp+dYFuGH/dt6K2CBf+aUrifQskxmDcgU5eCm8vr4CFHX/Nhk3INtiBz
         vCH3edfswD3/OulscRUR8lQCYf6BHPQAqn1yEuyEdHGuxbtkgoU5XweMjcOFm285EfMu
         DdP/ZP8N39g8erQuFYJ+SAAg+BQaZ39gdmCK1eJLk4a+AYovdNhuqUFiP7jQBLSNSOdC
         Yq/YxjAjv8JVfWs8ea4x+YSJxZCZSqyGJN+8JI4AhqE/rX9KIDTsSrP0e7sr6qsnNWw1
         qfJ/QG9B2txIAFAtp1pBS9+CA5E+y8M4BDVakvVdfxATWUA546uenccg5/hMJKovhsNR
         cNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=/VesKZlrKeeROQCf3f1qpxjmdpRaNcS+WGy7hnU3VUI=;
        b=h1Wvl/b+bKHgb1tX6CNwDvmp0oNVOs4AblIjNWi0SLrIOj8iLUwiVozuKpi/zFRlNW
         sNbv/0AQm+b9lIfOjeU5jnkDnbV16mAWpmtuufO5vqSjZibpvg811v9zKjVB0ZrpfA9B
         drKaOZej6lWPNP29u+U9Wd4dlv8k4RfXj4sdCr81P3HKis6ATMxPTO8KBIwzneO1LRDX
         NFF7+Ngmbg8RES+Tp66qxZFc5KLySr5rrG/Jmmh82uDqUteW2GEoYRNtjv5SBYXp8pyh
         Y5ObhA11axoQ05XxYGQpR2M5o9khyk2V/6ZJFvBlS+tz9fen92yTXP94bKsB4IwG8XGK
         dn+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=L5LiUxsP;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=L5LiUxsP;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
To: Paolo Bonzini <pbonzini@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jgross@suse.com, boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        andrew.cooper3@citrix.com, hch@infradead.org, JBeulich@suse.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
        hpa@zytor.com, linus.walleij@linaro.org, mingo@redhat.com,
        rdunlap@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
        kirill.shutemov@linux.intel.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
 <20180228210814.GK11576@char.us.oracle.com>
 <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <b3be9cac-dd04-d558-2d68-f1ff47446991@oracle.com>
Date: Thu, 1 Mar 2018 09:22:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593756990163082597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/28/2018 1:35 PM, Paolo Bonzini wrote:
> On 28/02/2018 22:08, Konrad Rzeszutek Wilk wrote:
>> +obj-$(CONFIG_XEN_PVH) += pvh.o
>> +obj-$(CONFIG_XEN_PVH) += pvh-head.o
>> +
> Probably a better place for these would be
> arch/x86/platform/pvh/{enlighten.c,head.S}.  (Just because there are no
> .c or .S files in arch/x86).

Sounds good. Will make that change.

Thanks,
-Maran

> Maybe Xen ought to be moved under
> arch/x86/platform too.
>
> Paolo
