Return-Path: <kernel-hardening-return-12193-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsu7LOtnCgzQ5j8Ny2+m3fXnASRO2GeSejw/P3uUYWmiTZmH/yqnsp5nFn5zxxZ6Of13pgB
ARC-Seal: i=1; a=rsa-sha256; t=1520419968; cv=none;
        d=google.com; s=arc-20160816;
        b=TFgoP6k8cPBSAXRkNKh47Pxyb5muQGYlGQs7dQl9aREDeOabXnlRLHchCVaNg2ynee
         bt1vejwwjCfbo0bM4ZAUA75X81NZef73q1eZqClHEjcrRiyPLgkTwv7LlQ33vMtP8b+u
         ZOfSERb+5a/ZyHc4Yc99srXpq6SWqQlWJcT94Qcfnie1dMg+oJuCwmqJFp+GXLRmmMn9
         0EaJXAFvYczWdovSpl0LXOWtsa1WkouHLFvi7evtstT+aYK3Jtmwd9cGkpkkCoFcfwm+
         aVazWdDIzdTa8Cd8IT7pqV2gzWW0g5SGiz7mgXizr6evPyH3i5XNwSyU/Fv++QVmHWlT
         K9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=euuOf8uDTa5EENVWavXntgCEAFPMvLY3RoEE8U/khJk=;
        b=ZwhlmSCMMNxByuAgvCgbibYKqRa/OkXPK1ZOjTCdAs4G/Loya72HbiF0OUnn7CZInf
         vQ+jC5hBYdLZ/S6BvWBCnvoVoqlloYcINpavR2Hvk9Z1wq9ug3w0s1CpPKpBDvJjXtaa
         8Y6JQdptLUPpu+HxSoYNhU06+d5p7gXXIgFPoJz1WYqggvz7aHTARxt++ioGP0KcryBu
         KkjqOaL7+1mPQVJz2Hwljtfu7jEwr2qfgdOmm/vS86zoGWIe5M41HE51mIHSJJbBgcop
         MXjGDoiKPuD0Ub66PQbA4xN2OU+MM4JXw1Ufgu6TvwAiRfcJ5GBgWAaYoV4Wk5bxEi7p
         9S+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12193-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12193-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12193-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12193-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
From: Igor Stoppa <igor.stoppa@huawei.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <david@fromorbit.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
 <20180306141047.GB13722@bombadil.infradead.org>
 <6d27845d-a8f3-607b-1b6b-8464de65162c@huawei.com>
Message-ID: <a667773c-59fa-33d1-9621-16e702c1859f@huawei.com>
Date: Wed, 7 Mar 2018 12:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6d27845d-a8f3-607b-1b6b-8464de65162c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594275888777114424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 06/03/18 18:05, Igor Stoppa wrote:
> On 06/03/2018 16:10, Matthew Wilcox wrote:

[...]

>> This seems unnecessarily complicated.
> 
> TBH it seemed to me a natural extension of the existing encoding :-)

BTW, to provide some background, this is where it begun:

http://www.openwall.com/lists/kernel-hardening/2017/08/18/4

Probably that comment about "keeping existing behavior and managing two
bitmaps locklessly" is what made me think of growing the 1-bit-per-unit
into a 1-word-per-unit.

--
igor
