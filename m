Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-392315-1518538720-2-14638809547543952226
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518538719; b=wW7LVNOI6sUHZii3F4Wf2hNeDIhY+1ElJvnylgYpcLqm1iC
    5wH9B2d+UX62u2h7J3krctPioBBYXtY+ad0luvkcUkFDAVwmt9yD4rxo0qbUE9DK
    na6zwYWFbMcUYQ15Wx9qBzkhVdqbfzjr2T2tqp5qI/X752hpJDZJuFqtck3bOVe5
    y33d1beiqkE3Anpxk71RO+kJnfb0pfJ324QtpDV/hmdfN15ChBoz1fgtFZrns+c+
    u+nMOdfzV+913uxxiKX6lVKI2dm9sVkkmNYQOnN/vhefwR0jaw6PwcfLBbRlicWb
    qsInaeLNxv0YD/uqvFXiqQt7NNyj0mSSXyAOUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518538719; bh=IvYg9PghR3Bb4dPvGZv512dge0G9bdkhTRswGm6tie8=; b=i
    pnSr4IFk1j4nrXrxwXVX77T0B/hJn3fHuWOcyr6rjy3/zp7i5T48t3NnsYk74VBJ
    2PmvF9ISs6+Jt0b2JgEPe+mNjnk8eQf7LpOwKps2KMUw6vdYWATvrsq17AjsVjvq
    Nn0+JtDa3PVi85F87EdyTJnklX2HmS78vMN6A5DcXgiAFOSaoyezTfUDe2ZOL6YA
    Z5y0TxHu231Q//kuHuFL7Ifxr0wxU2e3oy0EqGR2b4WwMF7PQl6zTPBylQWqebbt
    5E0IhXq1TbYddTdC4VVWHFylarIgBtppCE5NRb8VzGRnj2HaOJYvjuMWUtV8cTbb
    /ckmFHynq+Q7cPVznreJQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeBMQSV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:18:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:44621 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933927AbeBMQSU (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 11:18:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26965983"
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Andi Kleen <ak@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com>
 <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <20180213155603.GK10945@tassilo.jf.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Lowe <nick.lowe@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, gnomes@lxorguk.ukuu.org.uk,
        ashok.raj@intel.com, karahmed@amazon.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0dfbc8c1-87a4-ae51-2fac-bd4c2f674f83@intel.com>
Date: Tue, 13 Feb 2018 08:18:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213155603.GK10945@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 07:56 AM, Andi Kleen wrote:
> On Tue, Feb 13, 2018 at 07:09:44AM -0800, Arjan van de Ven wrote:
>>> So, any hints on what you think should be the correct fix here?
>> the patch sure looks correct to me, it now has a nice table for CPU IDs
>> including all of AMD (and soon hopefully the existing Intel ones that are not exposed to meltdown)
> I don't think the table is nice, it's a white list that would need
> to be maintained forever.

On Intel, we have that RDCL_NO bit in the ARCH_CAPABILITIES MSR going
forward to show that we are not vulnerable.  So, at least for Intel we
don't need to add new models forever.
