Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116657-2-6575199113895062225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116657; b=g6He8eo1UsMkaq91CHhwP4oOZP/M7BJSphUYRdq9CdY32fFhdW
    qP6MY62fdW4REmlzamhR+SPTqEg7m3HTdKapCmEmZpwOe/3fUg8N7I/F0tKffMW+
    VlO3LukNlBwJFelVSA7gCwo4ILUVfSNvJSJp7foWGQRfNM7C1XhzW0WPfvEK8Vxz
    crsj4PBcdwAWocLg/e1yPtXu5Ozuzh9prGpsNa2kZJhyc+8oHSCwkb339svkfNkI
    +f6k1LIRuGImFoKAvgUjqdDqQiX2tHGW5ldGih0mucH9MRErlVugqxxetv5I2c3c
    AWC2eg4CAJS0qs3YmPEeUyqXRltLTAN7epYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116657; bh=7YG6bYrNVL6kLzTYwFqN3vF1x4QGtp
    XHBKW/LdaAzRM=; b=esoNlc78LSvI/S0d2YmGvwROi++2rnF/rkIqpLXIQnUe+w
    hUe76VveoLtV291MOI0LrJoCZy1WSiW/ZracCo8jgW5E8aWVk0YslbmC0viLtOtn
    G6roVlRMWHfjpyFQPFFT2ZyaOiPUeKSEqdorzmgDV33gVE/o8SNwpcBvtru2nUyS
    J1l0KlsWwAUgCs+wADaSMAcQyIS1TJkkIJIFn66jUQxysgPlBrQ+XEpxec0kbgfB
    gTgei9JxM/JE0Zq2zi4H2yjL2LL/8sil5JsIblnCmQ1cZTSsENsXa9TMyhfMZLkD
    uiW0gJ1Eb+Pv2tgZB00g1nrt4oORcdjy67KimyCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOAuzBSS0hjBOYLoV+g+3iJ2JUWD1Q2ELw+0Sbmb1HFWCZltkt+C36Y5FvqmD/Q+o4Fpb75eH8vqU8RzGCpkUIjJDm4UoVsTJOgAEkGbuwM8RWHIbvjd
    z+6Ekcq0PEkjz+pIORgMVTQKQugsaE140KANFTUbx0PdB3+coBeOS7OzilEW06bQABKFxbs04KUJDRBZpqf5TWx1aOWkVQoQWKCEcDNqdk8DJa0Dr1bnBbgN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=RPJ6JBhKAAAA:8 a=ag1SF4gXAAAA:8 a=1LLt1D0RfLeyhq938B4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=fa_un-3J20JGBB2Tu-mn:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756505AbeD3Tal (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756483AbeD3Taj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:30:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FCF22DAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.16 002/113] ext4: set h_journal if there is a failure starting a reserved handle
Date: Mon, 30 Apr 2018 12:23:33 -0700
Message-Id: <20180430184015.170310390@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit b2569260d55228b617bd82aba6d0db2faeeb4116 upstream.

If ext4 tries to start a reserved handle via
jbd2_journal_start_reserved(), and the journal has been aborted, this
can result in a NULL pointer dereference.  This is because the fields
h_journal and h_transaction in the handle structure share the same
memory, via a union, so jbd2_journal_start_reserved() will clear
h_journal before calling start_this_handle().  If this function fails
due to an aborted handle, h_journal will still be NULL, and the call
to jbd2_journal_free_reserved() will pass a NULL journal to
sub_reserve_credits().

This can be reproduced by running "kvm-xfstests -c dioread_nolock
generic/475".

Cc: stable@kernel.org # 3.11
Fixes: 8f7d89f36829b ("jbd2: transaction reservation support")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/transaction.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -532,6 +532,7 @@ int jbd2_journal_start_reserved(handle_t
 	 */
 	ret = start_this_handle(journal, handle, GFP_NOFS);
 	if (ret < 0) {
+		handle->h_journal = journal;
 		jbd2_journal_free_reserved(handle);
 		return ret;
 	}
