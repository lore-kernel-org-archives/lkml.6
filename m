Return-Path: <kernel-hardening-return-11692-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224xAOBnlSIYI53bzQnZaE4bBT1oRcJCIF+U99w1jhLk9WV5JJ4fS5xS2NFgHZyjT/bsLX5c
ARC-Seal: i=1; a=rsa-sha256; t=1518303633; cv=none;
        d=google.com; s=arc-20160816;
        b=ZjtSVvBz7eCA4Ys4ds7SHqcFVIB6TfxvvFVT8Q5ROLozOty3c+3fyev2l8jLf7nAOd
         nr8FEtRLA1+xgbVM0oBve1x4Af1dRz7YJwNSucdxxud8WSfj0Ap1gYPet0spaadJvJA3
         SJZs508o3qzp7GVt5xK6rTmYJI5c08tAhycv6J6tjncvBevuvmgO2uaPV+oKrGYTIsBf
         4DUtU4ChOgT8JNvKkTgM4iQs5Ohj7LRzvTH19wu2xVcfn8lPNR6idqGl3mV+NZ8crOVW
         JtncD+yDWGbLivlotkfdMJyYurgoNS0YPAaadeCa7tIuzLMInxxUUKwgpbGdetLkvEia
         F7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=v83ACRzBk4FC2Y0NwMoLDwRfDZ9kwOO7Nln//zut3oI=;
        b=ABocGY+7+1lel35GUpDWDtmubIsQEnFm8Vb3JFSRvU4UDuvZ+nqtHnsSVPecaDkfEi
         QahKCV06mHs66PgYqLCoduvvMPQJB44Z7aV3Ls0fB3nZUETJazzojQ/EXryu6PoI4FV/
         g4EDR7VQij1jGWNchbIX9Vxo372Hkk9F5NM1RyoyTTqHvCRJXgToXrb35H2oW5usFTvx
         lGm0XYxsEUu96drlAnyNSBUPESGharQeVlkwxPwtbdbSYHsvAo79R+273n9waXSJd/bs
         M2qJBkBWCuVX3lrKHmfOIUuhsh2S1H8iKqyLI2E1+Le8MTyOkOvm4eU+eVi7ZUWol8ZA
         gAxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11692-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11692-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11692-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11692-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Randy Dunlap <rdunlap@infradead.org>, <jglisse@redhat.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-3-igor.stoppa@huawei.com>
 <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <0183b04c-1fde-4840-2977-c9eea77e0c99@huawei.com>
Date: Sun, 11 Feb 2018 00:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1592056750693757961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/18 00:19, Randy Dunlap wrote:
> On 02/04/2018 08:47 AM, Igor Stoppa wrote:

[...]

> Please use kernel multi-line comment style.

ok for all of them

[...]

>> +	BUG_ON(!locations[action->location]);
>> +	print_first_chunk_bitmap(pool);
>> +	BUG_ON(compare_bitmaps(pool, action->pattern));
> 
> BUG_ON() seems harsh to me, but some of the other self-tests also do that.

I would expect that the test never fails, if one is not modifying
anything related to genalloc.

But if an error slips in during development of genalloc or anything
related (like the functions used to scan the bitmaps), I think it's
better to pull the handbrake immediately, because failure in tracking
correctly the memory allocation is likely to cause corruption and every
sort of mysterious weird errors.

--
igor
