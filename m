Return-Path: <kernel-hardening-return-11722-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226eeBe8ERnmU2xGOuHbOLEt81zYIuHlKWx1WhLQ6u+/CyB76up/OLMS6kPjzo6chCzSs0cs
ARC-Seal: i=1; a=rsa-sha256; t=1518450146; cv=none;
        d=google.com; s=arc-20160816;
        b=fN990rKwUlIrSn9xetcpcctd9oCPo0q2afuidjf19EtyTApwfZu+KWN00U1uhwBme+
         HCD5j1JeQCxwXL2Z8gar+cUO+Gug2KIb1K0Pv+yGXxoTrqCrei20stBuyaZyH3tbjrfo
         rgXKqxPkGv1pcYv5epDw0/x2cNzE0AOLCGsKv2JnBjb0s++Aa8eKispvhZBx3aQG3E+E
         tDRR2Ua2qz703AEXRgxPb3n6s87Q7K0gvtxUaMVeNJwmARkwGXA8XI0z5xVcEHk8VvdI
         kKmMMDH4ThN2nKYzVCAmTsF6oCFMwXND9AIPhSehtaZjFCwk0CKxmBomootDSdxhb3Vz
         OvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=pgH4+ScrBSqt7vgO59eNkLLgFtUJzt9iIoWjw1Xrgzo=;
        b=w7Rlx+uwDv54AryozDrH83yr2PwH4rocV6Mcl0q+AMBiVA1CAZUgLehXEDJ0DVtdtY
         E2PMp8EqzVNyJD0PvBuQGQCJ2fUH90IELw3BgIrVdiafhSQaa6J6yFoiOrM7EMiYFqR5
         WvxPLtT00zonlrWk0+nRpn9j4/IWiqikfCw8plx3CaIu6STt+bqjGKwgSpT+4ceCatpU
         6KiIHixD1VjcZrmgoQtQLLCfB8m2Kvln2TX8FZx16KTYv+H1scSvWpZZpibu4xLdXIHy
         2+EExv674DNk7edDfzVtPK01tl0kumUPETglTajKfOK8PILFOUImWbaY3nM51H5jRGOa
         Af9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11722-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11722-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11722-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11722-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/6] Protectable Memory
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-5-igor.stoppa@huawei.com>
 <20180211123743.GC13931@rapoport-lnx>
 <e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
 <20180212114310.GD20737@rapoport-lnx> <20180212125347.GE20737@rapoport-lnx>
 <68edadf0-2b23-eaeb-17de-884032f0b906@huawei.com>
 <20180212153156.GF20737@rapoport-lnx>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <f5c08b12-a274-f2db-5cf2-8b774489c425@huawei.com>
Date: Mon, 12 Feb 2018 17:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212153156.GF20737@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592210381296233726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/02/18 17:31, Mike Rapoport wrote:

[...]

> Seems that kernel-doc does not consider () as a valid match for the
> identifier :)
>  
> Can you please check with the below patch?

yes, it works now, than you!

--
igor
