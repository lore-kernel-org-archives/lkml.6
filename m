Return-Path: <kernel-hardening-return-11585-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226xKP4w+aP+ub4VFWITIfjnicddwvr5hes9piGOL2AE+Flx8g9z4zseTrB4gyFUvn8beVjx
ARC-Seal: i=1; a=rsa-sha256; t=1517785451; cv=none;
        d=google.com; s=arc-20160816;
        b=EKkaNu0T/IHqEcREi37chR6mQ2tpX4akHaM9bYbUofQ4rGYSW2MW1quxzfkrjU6M8z
         y4aSOOXvkFeiPzaZbuVKoAAC6v6m6UYYCbgIAlYbqo+POeuG9+z9Mlcky51H5L762H3/
         mkVx0cwPkLyAhQwvDwEOEu7K4PsaEdhHDE/hAEBQtdYgs5lX0+W1fFjDWBJ/8Ac78ghU
         ThTyWVLjU96v2hoaIFSwXJOZbaD9ZJOvnR8OfGkduSQb6HntXW/zTL3HtHWCEvjKHNIh
         vhiURCzgeKAYQgtiKdo03ojh0xIHhpBfPGAr6S3ud9hAsJAgRt7/2oIQc5QYcyuSc2CJ
         94vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=4cogbVntqsqOzwt42q+TFln6mJwLpnv8Cw4kp4+LIyU=;
        b=pXYz/GSL/h6uCJeB7AGKbZYUpOerWEDi7uYSbJETszD5Kai3UuSEbOrDDCizQecV4a
         QJEu5nABZeW/Jzwt9CMsXnQkJr+BF6i1JOURwLHYLkOadmsXHl52W8NwEMHUxQPHELKp
         JHJIeFLGYCnNEZEaxsaHeucm43IXdIUMntN6yhvS0uGA4CIZiFXsLgO7SI6BEer8cEs9
         Ou74gstCeAKpvdDerPJOeml/zyGpwHAaPJutXj5OOvhAv9lAwHgG7chMnjc8+ufB1XWT
         ls5t+hiTV3HpaB1x3zn42yxk+1zFgZaduLQUI1iWztiKpFSdijnsVPcuX97MbXwnukZX
         kzsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=nLlOjvqP;
       spf=pass (google.com: domain of kernel-hardening-return-11585-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11585-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=nLlOjvqP;
       spf=pass (google.com: domain of kernel-hardening-return-11585-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11585-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 4 Feb 2018 15:03:46 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/6] genalloc: selftest
Message-ID: <20180204230346.GA12502@bombadil.infradead.org>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-3-igor.stoppa@huawei.com>
 <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1591513397285824258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 02:19:22PM -0800, Randy Dunlap wrote:
> > +#ifndef __GENALLOC_SELFTEST_H__
> > +#define __GENALLOC_SELFTEST_H__
> 
> Please use _LINUX_GENALLOC_SELFTEST_H_

willy@bobo:~/kernel/linux$ git grep define.*_H__$ include/linux/*.h |wc -l
98
willy@bobo:~/kernel/linux$ git grep define.*_H_$ include/linux/*.h |wc -l
110
willy@bobo:~/kernel/linux$ git grep define.*_H$ include/linux/*.h |wc -l
885

No trailing underscore is 8x as common as one trailing underscore.
