Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3750221-1526032053-2-3185546977383141130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526032052; b=gt28CPqyMFVtnfX2zXI0F/1Lnv+zOEA1vGItD7tUH4YDxA4fOW
    tIZ/zcIgDZh1s0sPyQkKLJW87fY3D9eS9TLdVew1Ea95xDNOiuyP/6QvtvrVW+NW
    EAidkaFPILuUe2NFC6E2QopOkbBC3M1hL/thoNrWEjEVnMK7YG08FUq+VEplaPr2
    OWNDQIcCBOWBC0i/aQIWBRKwlkbwr93Ji+f0gG08GK2gwQa/KffRfqPy5BfC+k1m
    0139Mn599iODxDHBYWPT6ZHBxuEJpZVGWgl7SrrNaV4X+LCzYMEqTX+7d13+kv7O
    qWjWYfx0s9VtopQBSabjUX7BTvCZ5oyc4icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526032052; bh=o4tRp
    tE4xzSfwsHvZ83WFVm58CoPvklIsFjF6h9itJk=; b=bSkJN31IZnbMSfsFCILfk
    IkI3uEEc6IOdLL4ZQo0tzdPRvma1yIfy1UQ3Soj9yX4PIGVNPlj+EEN0k/Pui/xx
    ouPjFuJz+09MoJmC+3kXbQm6x/9oFvjaKdPbKaW1Yf2c5RF2uHC9e13PkeKdzo/O
    Hum8Na3e8JePkNKdM6rj7/nOYmMR7F+AiqNsEPN7jOMT6W1tqDWU/YIoqUYvf9T0
    byRnbdzRAt9pwrpAPXcKwOzyI0gvIkgZ3hP+0LTEbjeqSVS3z0Uie02q/qn4hWZ8
    3uVbhoQFYVkMYnxN/ivOkBx+O6r+6s4hyCLzmWWrT4DZw1nb+bGWdOcl5MxknR75
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=R80CLh/c x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=R80CLh/c x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMM2y1FWHIRcUFfMKiDeU9RlsM2+7EJSDdtFMwy7t4EZXiOnp3qr1axohmYxAgvAHKDedNpGPLNXXTgGoOY3Q+187qUR9SJ79y0KCjRZwxm+qjxmaqsF
    4zfScx0wc0+42zLmXAijsEOlsAatbOtqQPhK/WImISdYoVGbd4yJCI5rUWgHQxGU9Sl81TLMyttzh2+qks/iLTi3+9+Xwes/279EfHlO5SmKxNwptvJ0YvbJ
    omkYvlIN2cPA9qMmWIl2bw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=M62ClyTdAMHlj1xKk5wA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 11 May 2018 11:47:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Oucharek <dougso@me.com>
Subject: Re: [PATCH v2] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Message-ID: <20180511094707.GB18687@kroah.com>
References: <1525975621-4978-1-git-send-email-dougso@me.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525975621-4978-1-git-send-email-dougso@me.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 11:07:01AM -0700, Doug Oucharek wrote:
> Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling
> code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().
> That protects against the current thread from deleting the current entry
> it is looking at. It does not protect against another thread from deleting
> the next item in the list (which the tmp variable points to). The way this
> routine holds then releases a lock opens the door to other threads doing
> just that.
> 
> This patch reverts this commit on this routine.
> 
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9886

Please add a line like:
	Fixes: 5a2ca43fa54f ("Staging: lustre: Iterate list using list_for_each_entry")

when you know this information.

Also, I'm guessing you want this backported to the stable trees?  Or
does no one who actually runs lustre run a kernel.org stable kernel?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
