Return-Path: <kernel-hardening-return-11668-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227GY/XvViTW2aHP5ZpSglIPKtT+u71Kv3oyBIpCNa7R2lSiQydc59YJQsk9PIpyZBNq4lXQ
ARC-Seal: i=1; a=rsa-sha256; t=1518176080; cv=none;
        d=google.com; s=arc-20160816;
        b=eL3yJS0tblogvDjML+cJdaSt6oAJ+P81JfNdCEg0KKhOuKGiTTqhu47gjwynwAw6bV
         /4s8XcY3SNSK5v1uGLYPQfmeTvQ3JjJN04EKRIf/IP0deBldOKdm55nwaR7YMeU5giVt
         jTUgikyeqpodw90kKCPG2H36AoGvPnod5RCtNg6vmgI+kRX1dBcce69tmRRZlAf56cN2
         AwN4v+xMU8HFnZmHgm3RXsnVyAlTyzJcQ4C49gxtbHaOeqpZGcx3ajTaHW6VP+GZtyg5
         py0cUnp7V7AtZJseYn0kOxj60IaM+SCVhQSC4Jymnzf8gtoQgAu+tE7kfmfaUokp6Vtg
         Sl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=X3yQUMdhgQCoKAbBYDiaBYroQjt/Olukc4cmrE9MxCM=;
        b=SB2sB5Gu0KdHdPAxDeCbTPXmn8NxqKVWj/docqfV2kSOC3dPNf42N206rSmoF4+hSz
         ZpnwQ9tz4gyNcQ0On8/MQaVI4rN9eOS77tu5UzJLri1EgUUSVEQz1gzgpkcn9BqKEd35
         V11Y8jJ5JG4fcwDi7ZO824ydi43ixAjG9WISA5+xbylkRBGWX+L4fLD8fxmH+GsEDlOG
         BXVJ+wPVqeVW+tEd4AbgY2873BqpWHfdKM5qhLAovPgNg2K9EK/n4aGEGJIR99gmtdUd
         hyfEs37XJWJeWgBos57fdWg5x4CR3AUtdnvEDKoXNgdHtk38VTtB7uVYybHuIR1xnltO
         o+FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11668-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11668-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11668-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11668-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Christopher Lameter <cl@linux.com>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com>
 <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
 <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
 <alpine.DEB.2.20.1802021240370.31548@nuc-kabylake>
 <a12afe9b-79cf-d5c1-3795-89fbf61c6c9d@huawei.com>
 <alpine.DEB.2.20.1802050931190.10647@nuc-kabylake>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <47f64329-32e2-44ba-c878-ee3cccdebfea@huawei.com>
Date: Fri, 9 Feb 2018 13:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802050931190.10647@nuc-kabylake>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591923001461272462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/18 17:33, Christopher Lameter wrote:
> On Sat, 3 Feb 2018, Igor Stoppa wrote:
> 
>> - the property of the compound page will affect the property of all the
>> pages in the compound, so when one is write protected, it can generate a
>> lot of wasted memory, if there is too much slack (because of the order)
>> With vmalloc, I can allocate any number of pages, minimizing the waste.
> 
> I thought the intend here is to create a pool where the whole pool becomes
> RO?

Yes, but why would I force the number of pages in the pool to be a power
of 2, when it can be any number?

If a need, say, 17 pages, I would have to allocate 32.
But it can be worse than that.
Since the size of the overall allocated memory is not known upfront, I
wold have a problem to decide how many pages to allocate, every time
there is need to grow the pool.

Or push the problem to the user of the API, who might be equally unaware.

Notice that there is already a function (prealloc) available to the user
of the API, if the size is known upfront.

So I do not really see how using compound pages would make memory
utilization better or even not worse.

--
igor
