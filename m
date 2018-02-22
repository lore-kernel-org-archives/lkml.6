Return-Path: <kernel-hardening-return-11895-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22562IbxaEb5upJAsWqFaZHOBGrhC/sza7DSl0TT0KngFhHzK/cvxKoYMO8UCLXPWGrvzMY4
ARC-Seal: i=1; a=rsa-sha256; t=1519309278; cv=none;
        d=google.com; s=arc-20160816;
        b=Zoz/NFXu7Z4FmymaFhE3IONUlSoZ60VFk8p4mybaxT9OO+EzbFhzXKBxtlm8lvQ5CO
         c/Tb8Wl9d2TwkU+DzBEx9Qw1fQ0p47LCqhrk7qX8OSxv3oB04QpLIZH6CaroVeklsUy5
         l8pHYOC14mdbRla9XLcpPhHXog+abuj8+ZJiE25NKnktGtR4Bw9hR+m5rtgaQeBe3z+T
         FVKNIVD0zVJbMVoRnQuw3zV0O7IIr8tdlklhwetv5p5vs1bDrviW9fTQrJ9o4fwNbLjk
         rT/F+wDxcZG628I2c7aX5sKf88sfz9YVbFqRD1qXKwUMpwA2q350naBaT5cr3iatMxjO
         5sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=7CDcr/ukAh6LrAi1diqjfVry8ESehI8NifWpEkzxfGw=;
        b=ZVxVCF77dFO/yUXxR1JB5ARfBLKbuItZ7kY6lDDx0q9zpdLDzb1mnAoITlp1LIOubU
         vpDJDnkEgsgKyp3ikrMs2tMLMqxeHo1lJrqt+yX2wlPMbGseoWiIk6kj57ZpZYp9H/+C
         5xo6t1p7elxUOgo+S2M2L5g2dhpGI+29wrIw16HxU85gxqPak12D2q5KFDN6yXDthTwp
         hnGFkZuModA/kIZdGLE3erO6DvZu+SWCiosZb6/bw8H7Hzeupwr2SB+n2MjhGWNnaLfZ
         mjUbM2Qkx7lEQztPEVBmcJOUWXT57gxVJpeamhrSJh5Z6PjUt0FJhPFvSziBYBo3YHIq
         Bvvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11895-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11895-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11895-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11895-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
From: Igor Stoppa <igor.stoppa@huawei.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <rdunlap@infradead.org>, <corbet@lwn.net>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <jglisse@redhat.com>,
	<hch@infradead.org>, <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
 <20180211211646.GC4680@bombadil.infradead.org>
 <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
 <b59546a4-5a5b-ca48-3b51-09440b6a5493@huawei.com>
 <20180220205442.GA15973@bombadil.infradead.org>
 <c4c805ed-5869-81c2-4c05-cf53bfbef168@huawei.com>
Message-ID: <bc62d1e7-96ec-d8c5-3149-9dd1922555e4@huawei.com>
Date: Thu, 22 Feb 2018 16:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c4c805ed-5869-81c2-4c05-cf53bfbef168@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1593111245810513107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/02/18 14:01, Igor Stoppa wrote:

> it seems to return garbage also without this patch, but I need to clean
> up the code, try it again and possibly come up with a demo patch for
> triggering the problem.
> 
> I'll investigate it more. However it doesn't seem to be related to the
> functionality I need. So I plan to treat it as separate issue and leave
> find_vm_area untouched, at least in pmalloc scope.


Follow-up:

https://lkml.org/lkml/2018/2/22/427

--
igor
