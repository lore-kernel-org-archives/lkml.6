Return-Path: <kernel-hardening-return-12251-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELttDxuKgxk5J9JwktfzQ+DlpY15Qir35nRv9ZkBr0FtukuIZ5jOxITT/Q8zi1BvyUpacBBA
ARC-Seal: i=1; a=rsa-sha256; t=1520535892; cv=none;
        d=google.com; s=arc-20160816;
        b=b4uxX86b2pJV6cN6EXquRprLrGtmPrpG75jkrkkUSGVk0BKYPIUXEFx20e2L6qMNjQ
         IzjTfVhmpK4+RxiEiHOytaGpLZ3nt00PJo8DBvagR1zW6Brbe8SOXz5M5W9aas2zvvXH
         P/Yu4Vp9xmkMDBXHweL9wzQ2sQXUkWf24EGeNFn7Gs76VPaDWAE3yTRVhyIerj0DGdh5
         AHwSoeKSgxBOBr9Le6vyG/eP5dwSnlVuPicTJIHOs7J1jbcKv8KXmOXgBR9Y1huHwvw7
         WcWHSY4NhMHuki+pszopBIW3OxoI79XWiAwsl9q9qsoy2OPMb+3M2kEplMP3cRPkUA3v
         nkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/fJ/WH+B9Fj9jwkFJ2RVPgiRu0mpZVlE+ZOYTf7PiYA=;
        b=LV7QbH1luJDwafZOH+ytQxE2vj32OeV9jezI3SGK8+1ELbCvS0ry0lDk3n7fXZTC+M
         Ujkg7J1LH3rWY7Q1RJALPWq+BagxHi4NsZ8nXj5fR22VSTWhDEHR0SUyc+foWyJ/lkBS
         UF1pj/BUtgP3/cjp1gCGUcBDwr/DPofsfO3iCvXZAPhwjTGmb04PbhMGuIz8x4J7dFr+
         I+vTWyl2GcApzqoB7dHpIN8BVxsty5NxPWAk6ZjbIK277Sls1fFNut8J5S3KtQ9xySrl
         qvLG+ifiR/p6TSti6Viy3s41ceLRJ/2bH7dS8IFIYDlZuZu0Xd6uK+jqeMlRLej8u8Yh
         5r4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Ru2Rb2Jk;
       spf=pass (google.com: domain of kernel-hardening-return-12251-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12251-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Ru2Rb2Jk;
       spf=pass (google.com: domain of kernel-hardening-return-12251-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12251-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:04:31 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308190431.5fstqsjmbpquzqii@smitten>
References: <20180308171456.2597-1-tycho@tycho.ws>
 <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
 <20180308183721.mnsrmhekyfo2dbso@smitten>
 <1520535030.3605.64.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520535030.3605.64.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594397443641167141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 01:50:30PM -0500, Mimi Zohar wrote:
> On Thu, 2018-03-08 at 11:37 -0700, Tycho Andersen wrote:
> > On Thu, Mar 08, 2018 at 07:47:37PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > > In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> > > > from ima_audit_measurement(). We need to adjust the return type of
> > > > ima_audit_measurement, because now this function can fail if an allocation
> > > > fails.
> > > 
> > > 
> > > 
> > > > +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> > > > +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);
> > > 
> > > > -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> > > > +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > > 
> > > kasprintf() ?
> > 
> > Sure, in fact I think we could just do:
> > 
> > -	snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > -	audit_log_untrustedstring(ab, algo_hash);
> > +	audit_log_untrustedstring(ab, algo_name);
> > +	audit_log_format(ab, ":");
> > +	audit_log_untrustedstring(ab, hash);
> > 
> > and get rid of the allocation entirely. I'll test and make sure it
> > works and then re-send.
> 
> The hash algorithm name is an enumeration that comes from the kernel.
>  It's defined in crypto/hash_info.c: hash_algo_name.  Why do we need
> to use audit_log_untrustedstring()?

Yes, I suppose we don't need it for the hash either, since we're
generating that and we know it's just hex digits and not any audit
control characters or "s or anything.

It looks like we could get rid of the other allocation too by just
using audit_log_n_hex, but that uses hex_byte_pack_upper, vs. the
hex_byte_pack that's currently in use in this function. Is that too
much of a breakage?

Tycho
