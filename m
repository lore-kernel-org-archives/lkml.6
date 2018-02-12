Return-Path: <kernel-hardening-return-11720-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226XMqGO8UXNUZojrUfONsKn6HZn6nYzm2uLT4PTAKeLyyzTy7JFdkj9fobAv2UoyUTM/dOA
ARC-Seal: i=1; a=rsa-sha256; t=1518449353; cv=none;
        d=google.com; s=arc-20160816;
        b=X8AdIyNrjzbwotZ2PDJTbQGbm1vxp+aqhUQwAQF2FlTUJ1NBw4R7EzuPl0CcREipte
         4Yg8jdUZMeuBuxsugNDUj43ME3qSqJCxOnDdx5hNFaZA+j8td304gX9jyTq83gqTpBvA
         2RE7KySZ9/+2OLIf+IbH9f95WubnlI1xNVRHViLu7f/rIVxIJnAfs+NYRSSyIAUzKub1
         4QFetpAToWoAKHYLOpflleT0ydF6T2EZUQeLuoduahqu0BTRB6OQWQ5Gy2XvA6LnR/Vi
         fD7Ol90MF1aFPA1eFbi1Y4vbxHBumpOYR2GaZwbVr+eO6f33sG/Rkv/y2nyFQoAVSGux
         nTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=DeiZmT+GfIS1SCQhAECgh4E8AnDnKm8H+k/9DpMX+/g=;
        b=FMbRgiQxEpFcef5V+KuV8kx2mCy0HbzEaau5uvoCTTYwyKKjXt2KjNAmOchtderMS0
         g06JOPXA6dc8YNfrOMRnumdefUuwt+DqEEP7MvziKfWscCmYFx8Md60OhZyWTcoJYov6
         DQ2IDSXQZlPTAc/6TL8FFbIst3cePENpy9Kh51B+ejGdNFqDHSMu8xWFJ0nBndVyu+Ss
         VYFoM5Ga3DB+QIQLQzDS3K4XaazB+B8oOmtvXg01iQtUTae9B/dbt0qFoPqUOpDTgb7y
         y7ZrkfSqGbDneJ6PVq9O8254CSUSpTsk1ib6ZAIh5GUlqV+9ltfNPewm414+lKv+JMDN
         Otkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11720-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11720-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11720-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11720-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Feb 2018 08:28:49 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
 keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
 hch@infradead.org, cl@linux.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 5/6] Documentation for Pmalloc
Message-ID: <20180212082849.1377f7e6@lwn.net>
In-Reply-To: <20180210033714.GA12711@bombadil.infradead.org>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-6-igor.stoppa@huawei.com>
	<20180130100852.2213b94d@lwn.net>
	<56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
	<20180210033714.GA12711@bombadil.infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031095823992296?=
X-GMAIL-MSGID: =?utf-8?q?1592209549313957723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Feb 2018 19:37:14 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> I've done this as the first line of my new documentation files:
> 
> .. SPDX-License-Identifier: CC-BY-SA-4.0
> 
> I think this is the CC license that's closest in spirit to the GPL without
> the unintended consequences of the GPL when used on documentation.  The
> GFDL seems to be out of favour these days.

I think that's a great license.  I still fear that it is not suitable for
kernel documentation, though, especially when we produce documents that
include significant text from the (GPL-licensed) kernel source.  The
result is almost certainly not distributable, and I don't think that's a
good thing.  The GPL is not perfect for documentation, but I don't think
that we have a better alternative for in-kernel docs.

jon
