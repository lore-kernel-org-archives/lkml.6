Return-Path: <kernel-hardening-return-12253-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuPJRfmPgGEFU2CG6hjCoZIpXZUHKqij4NpAY69+v+wjK0QMBM0eB0tzHGVsgfAJxxxpPha
ARC-Seal: i=1; a=rsa-sha256; t=1520538487; cv=none;
        d=google.com; s=arc-20160816;
        b=mZ4GyJZHouJhOB2OTlp1oTTT15nLMHek1/hapreaK5X8dC4nwkweZaEoQCa3wXkqBS
         lyDvGuMIG4ANbuTIKzxXuT1Mft/AyqWxOW+VqalrjUBycynV+AQOvKfAeYXc00GwkBa1
         TxFI9/5XXPtu13t5zopGoou1hugjQSNeDgoKLEh8ATBfJVNjHcWf8Ik053XUPsYKD+5X
         Ra9puJRe97tcnyIVqryHfVCmd1MLJniTKchtMn6ogGEQ/LAL38x26ezl/1H3Aw61W16p
         72vYwwkaPcjrbPSm/w20+dXlVE7ahACz/A+dwU5mrNwqSh1MKDzQ2xSiparLZsJAAs2H
         4mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Dt9Ka2+3/15KqLNnSgI3/UTCU+kZO2dWzAYwA20Pjo0=;
        b=NpTH1IOljKgGw3dQJiBApz6RJdnMkbO+vREdd1Nan63cFMQZmIZTz1j/mbaE9VdmG1
         2EaoLoC+raynAxxsC0RwNxMRkxnOilc/e/ju8xzeZwCrZO0fzG8Zslou8BxIkMieTxHo
         KZaK5QXUTiYax+llxQlGHrn/i/ihMzk8U62dNmrOSy3aQ9VFoFrhHChilaGFz6CrVcta
         p+5uXefLqoTaqC/KBp3kgNtOY9obp+8Yc7MzDCc4jhVwK7zLUVMwprxNitqfNZV3bgUA
         Eg8zHdP0dyiAfMWmwRAaHzEoeQsdOvdwuAvb7j0tUTWd3+jZTyCdIpdr/zTNDs6oMcuH
         RtEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=SBkP83bu;
       spf=pass (google.com: domain of kernel-hardening-return-12253-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12253-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=SBkP83bu;
       spf=pass (google.com: domain of kernel-hardening-return-12253-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12253-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:47:46 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-hardening@lists.openwall.com,
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308194746.r2b5jwfqpq2pah35@smitten>
References: <20180308171456.2597-1-tycho@tycho.ws>
 <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
 <20180308183721.mnsrmhekyfo2dbso@smitten>
 <1520535030.3605.64.camel@linux.vnet.ibm.com>
 <20180308190431.5fstqsjmbpquzqii@smitten>
 <1520536817.3605.74.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520536817.3605.74.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594400164341518890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 02:20:17PM -0500, Mimi Zohar wrote:
> On Thu, 2018-03-08 at 12:04 -0700, Tycho Andersen wrote:
> > On Thu, Mar 08, 2018 at 01:50:30PM -0500, Mimi Zohar wrote:
> > > On Thu, 2018-03-08 at 11:37 -0700, Tycho Andersen wrote:
> > > > On Thu, Mar 08, 2018 at 07:47:37PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > > > > In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> > > > > > from ima_audit_measurement(). We need to adjust the return type of
> > > > > > ima_audit_measurement, because now this function can fail if an allocation
> > > > > > fails.
> > > > > 
> > > > > 
> > > > > 
> > > > > > +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> > > > > > +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);
> > > > > 
> > > > > > -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> > > > > > +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > > > > 
> > > > > kasprintf() ?
> > > > 
> > > > Sure, in fact I think we could just do:
> > > > 
> > > > -	snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > > > -	audit_log_untrustedstring(ab, algo_hash);
> > > > +	audit_log_untrustedstring(ab, algo_name);
> > > > +	audit_log_format(ab, ":");
> > > > +	audit_log_untrustedstring(ab, hash);
> > > > 
> > > > and get rid of the allocation entirely. I'll test and make sure it
> > > > works and then re-send.
> > > 
> > > The hash algorithm name is an enumeration that comes from the kernel.
> > >  It's defined in crypto/hash_info.c: hash_algo_name.  Why do we need
> > > to use audit_log_untrustedstring()?
> > 
> > Yes, I suppose we don't need it for the hash either, since we're
> > generating that and we know it's just hex digits and not any audit
> > control characters or "s or anything.
> > 
> > It looks like we could get rid of the other allocation too by just
> > using audit_log_n_hex, but that uses hex_byte_pack_upper, vs. the
> > hex_byte_pack that's currently in use in this function. Is that too
> > much of a breakage?
> 
> Based on the discussion with Richard Briggs, we need to differentiate
> between the ima_audit_measurement() and the ima_parse_rule() usage of
> AUDIT_INTEGRITY_RULE.  The ima_parse_rule() will continue to use
> AUDIT_INTEGRITY_RULE.  ima_audit_measurement() will need to define and
> use a new number.  Auidt name suggestions would be appreciated.
> 
> When we make that sort of change, any other changes are insignificant.
> How different are the two formats?

It's just uppercase and lowercase in the hash value, so:

Mar  8 16:56:46 ima kernel: [  104.922927] audit: type=1805 audit(1520528206.082:53): file="/bin/cat" hash="sha1:79e52322102f073684e2dd0ab7653c7c6fcc49b4" ppid=2049 pid=2123 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=1 comm="bash" exe="/bin/bash"

vs.

Mar  8 19:45:12 ima kernel: [  207.124383] audit: type=1805 audit(1520538312.740:239): file="/root/.viminfo" hash="sha1:3322BE0C00190AB0D20C47574575842EC3020BF5" ppid=2045 pid=2195 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=1 comm="vi" exe="/usr/bin/vim.basic"

I'm happy to do either way.

Tycho
