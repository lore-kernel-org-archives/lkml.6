Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1307548-1524890623-2-16139027303924684835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524890623; b=Ulq7EtTB2bgFMX8sM/dIsTZz7Y5/yw8jD4QJ2K3SB4bNpZii2N
    KP4Z5O7LXXUVB3+n371mmE2Brwk66X2CLWNDWdHXJ/Q8e656OTI9gvsR7E0WniSQ
    j9GOzTR9sJMeyixVSi3Qw0uMmFzP5YhfJ9Q/TdbBAoZKadUtLNiSd1rhKlUCF+pY
    WiNaOvJPUZEIdslSQS9SncF1kqlvL9IcQq2bzteZrm8JARGWHRkZh/O5vseJHYHf
    Qc1nr+1DF8ESpdnU9MUlM+ELQlFvdG/rM9nBASTh+r1kMKhIXzrAadkDRZDlk8pr
    p8hmxSgzomLSNC1iUM6qgHHxH2XaCDnHANxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524890623;
    bh=AncWaSh7EuAUOz22rFVy+QkNE5pGfb9ZSGgzGHmH5sk=; b=OOagcwPPfkm6
    wYqRj3kuUal9SAZJA2lWjGxdTm0h+FyYo94zUCmIDWgZns5QPD5Qm9c78xRuCXR1
    KomEN7U5vKQc+fu7gAj4PXLQRmFHfCQm+V05vHGmLTmlXUt/Q4U4wTlo4v3lNIMd
    E6kd5hTu3r1jW78dgxrq+PNcjiWYu0GwvvoOo8F8k4FbhMBBosYKp1vop5kHq16n
    6iQrHboS081ApH7vn1Q9T4lWTQikP/uEaNGKpV35Yz8L91HK6jCAWN+maXpylbST
    OD+i8er4Ztg+8kunAiXFKgURwqyOL1bSZw3pMYjGuvQW1GrFwg+snWMo4irz02vZ
    gWUjbmOoAQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLY8FV7yWBIoM/k5zQgt8DPh24ABoK5r8z4HWSh5Wg77F1f57+wipF5rPFhjYSO+g7nrH728ijZGeJzXQ1KJtT3fdxQjrBg/eqeTP7bdd02l4M9HAGEA
    EypBfo1Jqiub+GgDMh9ii0M8JcQUbXRGaqwvHHnXjR9AEqgDQNPg5rTl3IEbVLeh1cKZI4LqPY3EjhGKfLP466lAM/zRu96AzqrtGsgQcOOOv/xpBvPPe1Qz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Pd4lJAvJ9TW2jtgjWYgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeD1Enk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 00:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbeD1Enk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 00:43:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091CE2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 28 Apr 2018 13:43:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Message-Id: <20180428134333.6e1b878fc9748dac67387476@kernel.org>
In-Reply-To: <20180428004202.4297e781304b5eda53100f67@kernel.org>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481130062.22588.10747314456340608852.stgit@devbox>
        <20180427065636.ells635z7cw4b4oz@gmail.com>
        <20180428004202.4297e781304b5eda53100f67@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 28 Apr 2018 00:42:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > +/* Caller must NOT call this in usual path. This is only for critical case */
> > >  void dump_kprobe(struct kprobe *kp)
> > >  {
> > > -	printk(KERN_WARNING "Dumping kprobe:\n");
> > > -	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
> > > -	       kp->symbol_name, kp->addr, kp->offset);
> > > +	pr_err("Dumping kprobe:\n");
> > > +	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
> > > +	       kp->symbol_name, kp->offset, kp->addr);
> > 
> > No, this function should just go away and be replaced by a WARN() in 
> > reenter_kprobe().
> 
> Would you consider to use pr_err() here? If so, I'll move this
> dump as you suggested.

So, this is actually called right before BUG(), which means we found
a non-recoverable error while recovering from reentrant kprobes.
Since the BUG() dumps all registers and stack as same as WARN(),
I think we should keep it.
(I would like to dump all kprobes fields like flags, etc. so that
 we can find it is broken or not.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
