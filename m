Return-Path: <kernel-hardening-return-11689-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227eTPpgEMKLPzT7/ULppGhsn4EHXC9BOspi+6mp6Okr8skxfvy1f4wGO60RTJdwAOsNimti
ARC-Seal: i=1; a=rsa-sha256; t=1518196527; cv=none;
        d=google.com; s=arc-20160816;
        b=v8xd8Oy+8FKb9LMRPBcRUkDoZVRLtpxNjL8dCFlmjjiLBYzMu+ubW7DFu3HBkdWxbN
         7LumVMKTLQRYjGvm1CCk2q0KYn8kTPTkP58E3iW9fBMIq5DpAKKYAa8Os6wYDAaWvr+e
         JNVVvh20hj5hw7bjbr7LSseVrV2NCKZkVFlhAECWuhnylPl3Ls9Lg4EGQP9nw97kAOPd
         Qpm5xmEhy+JJY/R4RL5UWlvTHEnE1K5E9DX9j2CtvniNghfqwFAJC33e6j8Bpez6ekDP
         7JsNMWM6YTz4DOoGtH7nycOgSSg6Y2rmXrSCYWtcJ9fAPE6Mx1oaaLrIwgCmSPnjKm2q
         JCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=VK1OWCDjIx7jbKUlt5uBlpk3UdZL/gUr83mQCxkcGRU=;
        b=O+AOZdRYMN+f1h/gJJAlP61rPRNq7NxdwZViIXES5imWC2IvxUmv0qdPqgmo/cSIvi
         lTN8fHE2+CJPohhsRimJTUvrOlNxVcPkj/4HLrKRp+T9G+Toxp8QsXh66aBuEk4ZY/pA
         eS4dA6SiNoC4RCGavHTQekhzpH9wdUmdkZtfnhp8KWa68MMi9w2t3ibZm3UyTbIBL9ap
         FmkzR1+/ENGRimAYnjfe9JSf0rXuoZcHLNXRvLsiBiYCHIX/rUEKa2Oy1525tlrHl0Fb
         aHJYK16wiJR/fh4ieTSWj+E5O5eRGhZsJiIAcYClSG/MjLw6Fio6q0G/jGBNQXHM46j1
         FzWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pkUs0I3a;
       spf=pass (google.com: domain of kernel-hardening-return-11689-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11689-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pkUs0I3a;
       spf=pass (google.com: domain of kernel-hardening-return-11689-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11689-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
 keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
 hch@infradead.org, willy@infradead.org
Cc: cl@linux.com, linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-2-igor.stoppa@huawei.com>
 <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
 <947ea9c3-b045-17d3-51e5-df80b4fb27e6@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8b02744c-d527-f000-78c0-90142052b4ae@infradead.org>
Date: Fri, 9 Feb 2018 09:15:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <947ea9c3-b045-17d3-51e5-df80b4fb27e6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489766378692364?=
X-GMAIL-MSGID: =?utf-8?q?1591944441827443842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 08:18 AM, Igor Stoppa wrote:
> 
> 
> On 05/02/18 00:34, Randy Dunlap wrote:
>> On 02/04/2018 08:47 AM, Igor Stoppa wrote:
> 
> [...]
> 
>> It would be good for a lot of this to be in a source file or the
>> pmalloc.rst documentation file instead of living only in the git repository.
> 
> This is actually about genalloc. The genalloc documentation is high
> level and mostly about the API, while this talks about the guts of the
> library. The part modified by the patch. This text doesn't seem to
> belong to the generic genalloc documentation.
> I will move it to the .c file, but isn't it too much text in a source file?

No, that will be fine.

thanks,
-- 
~Randy
