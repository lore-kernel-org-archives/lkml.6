Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031306-1521204954-2-3406085951989006731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521204954; b=svIGYsYZmGhKDF8NHZ0prvvjLW7XhBqjyWTZnq3H7Woojsy
    AvdS3lgKZ8zgXvkhQ8oefSqKVYHouPGPyOsnll7hNCjYcJV96AzCkpSBq2Xsm+RQ
    En01j9oaEJflGsqygWeE7mseI/dpZfVDNP97gQRiz9UUoXkSzxvj51eqyHvWE8jy
    XALWAnI/dNoPeMVfuUlBP1HQyURacPZApkzMN302JzQU6JZp/qlsWrhTA9c1Pt81
    vuDo9L0pNLNJZvV5/WIdBKufOxv+a/5d//9149QprVNhzB133sW5a39LPjMQVBiB
    DgZ3foXncCZfQMcDBFY7xzwnAlrXy/mCZCBsAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521204954; bh=JH00NQO0aZ7vjQjVwb72cNpHK5
    IiE0RxbOnRS/+ZQ5c=; b=hxw5WQ6YVyR4XySW3qCl+hdytMTczlHPgRkiVzZAIu
    GWn5lIWLYwioa8r919Rd5cocnLFkZ72wdnuAidnHy26JvbN2QUXXpMFRcqQ4iEMi
    +MeuKALIHgBkm5rXKc6P0HruURBkLhDSccVrKMVSEcV0cqkjy//PhD15Q/DlW4De
    nczgCLM+I4UxPFvPpOjTxaGZDUNmLhnMGF1DiOEqA5lHdXaHKWtVrQ8qWo+aYOwp
    6MKzbQ1pEuvpZh42EgODNZYNyLYL4AhnyWZBum9Qi0WPH45XnmiEmduElGIp/giQ
    8YdkHk4mfzft5SWC29ZJmxeh50M1Xw75p/rxW71yWVaA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCPMzh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 08:55:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:59909 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeCPMze (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 08:55:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="24610670"
Date: Fri, 16 Mar 2018 14:55:25 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180316125525.GB5035@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312150231.GA24717@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > behavior of tpm_read_log_acpi() to return successfully in this case.
> 
> The commit should explain why we'd want this..
> 
> eg Why does it matter to create the extra sysfs files to report an empty
> log?
> 
> Jason

The initialization of the driver will fail otherwise. Not sure if I
understand your question.

/Jarkko
