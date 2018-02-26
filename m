Return-Path: <kernel-hardening-return-11967-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvWLOyUweF5QaUQLnBcMNgn+HzqY5UuMI4yF76YsPBTa+prx6Pakpd3iVbYjp34yHT83NeQ
ARC-Seal: i=1; a=rsa-sha256; t=1519672381; cv=none;
        d=google.com; s=arc-20160816;
        b=kBoPtry2g6jopA4G7SbnzBZn1pH0ZqymPCB/gLN/mUuEHXA+69Qb7LAwy0oTPJdlix
         KyL3tvjO00FtgiqdFJXNZPoAWhGsaaOH3VZxIR6Wct6nQQoUJN1rYc7BhsRvUcJ58QBv
         eCwOJlz/sZX3TpPau/min3MlJq1iEgs8BGV7GoqziliMPHlXUj12eMkoJkPvwuWwWfG/
         okW0/QJbMOjda1J0MGCW/hnvvljF93iMshzXMJHOOdOUpHRB0MDMVNLBoLHpgcrhxv5n
         CNWTi0sFEpMcnNBo/24aRkCTKvnR8vFdpW/vVqoCcyGAdK+XrYqPy34Kalkj6g2sbarz
         zxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=7BEyvtR35yHP00Pc8JiMt2byNsoe+iFTDB+hb4xY+aE=;
        b=PFD7XtQihxmlrjWeP7mZ/n3WlhIMmqjuADeT77L0ZEKrciWWn+TCmqrprLtI+P4+Vx
         p17HV2ZUwT5DleHczR0KWU5qVK5Sm5bKb7NuUqsVxBSXdyZGDfPAMRlStO2GSdmPihIX
         2uL/3O9+mEBDa1l6Vxf3wTTaoM6zmBwOVoudWrgVYVDpON0qkEjweG0Dgld05Syhoku6
         Bb8uzfSiKn+qn0QOlFpCz89QydaWmur9N/5tc4hJ6yyZ3uyG2j5bKafauqiqY6EByVmW
         nnZF714gWPbyjUpmxQjGJ4uvMRVxmgQDvWFMyyFY83AuhFpQgUOMTlgOvkGDgeqrxTfi
         U48g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=JTvZsUWy;
       spf=pass (google.com: domain of kernel-hardening-return-11967-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11967-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=JTvZsUWy;
       spf=pass (google.com: domain of kernel-hardening-return-11967-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11967-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 26 Feb 2018 11:12:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: J Freyensee <why2jjj.linux@gmail.com>, david@fromorbit.com,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/7] genalloc: selftest
Message-ID: <20180226191235.GA24087@bombadil.infradead.org>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
 <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
 <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
 <45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
 <20249e10-4a13-8084-bcf2-0f98497a755f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20249e10-4a13-8084-bcf2-0f98497a755f@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593491986935920867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 08:00:26PM +0200, Igor Stoppa wrote:
> On 26/02/18 19:46, J Freyensee wrote:
> > That's a good question.  Based upon those articles, 'yes'.  But it seems 
> > like a 'darned-if-you-do, darned-if-you-don't' question as couldn't you 
> > also corrupt a mounted filesystem by crashing the kernel, yes/no?
> 
> The idea is to do it very early in the boot phase, before early init,
> when the kernel has not gotten even close to any storage device.
> 
> > If you really want a system crash, maybe just do a panic() like 
> > filesystems also use?
> 
> ok, if that's a more acceptable way to halt the kernel, I do not mind.

panic() halts the kernel
BUG_ON() kills the thread
WARN_ON() just prints messages

Now, if we're at boot time and we're still executing code from the init
thread, killing init is equivalent to halting the kernel.

The question is, what is appropriate for test modules?  I would say
WARN_ON is not appropriate because people ignore warnings.  BUG_ON is
reasonable for development.  panic() is probably not.

Also, calling BUG_ON while holding a lock is not a good idea; if anything
needs to acquire that lock to shut down in a reasonable fashion, it's
going to hang.

And there's no need to do something like BUG_ON(!foo); foo->wibble = 1;
Dereferencing a NULL pointer already produces a nice informative splat.
In general, we assume other parts of the kernel are sane and if they pass
us a NULL pool, it's no good returning -EINVAL, we may as well just oops
and let somebody else debug it.
