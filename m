Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629911-1521589767-2-388190588827170363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521589767; b=evRVHcNlmlkxDc99iMqDaYRlWZiZz2BNb0lFePucFVpKTTW
    fUDBAd2IBt7CjRF+W5gmzzBJeQXbnFAAn8hDwbDnBwtukC1f7/L5hHycB9F2O+Ps
    qCMZWApO2f8A/rR+TMrEQDrd0/FTMaU9ovaeUkShrVZwHgYDHGy5ba2HPmkjlfOx
    DedGiBHy1DwqaKRvc2xBR4pL9EMotG2oY0gfBe8ZIR7yGJG/8Rbf4e44weFlKGDo
    ix1AtWQ6UkniF3Al6nEFEurd685CLpRQw2CEZ/GMcyhjjkueRjX0qw39m2eu1hfH
    r1DHjtTh2vD0aNMRX2zJGR0fGY0oOkFkubCfE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521589767; bh=Bu264HVezm3q0Xzx+VciCCWs0vs6cv8eClaxmzyzhpE=; b=A
    /kfy9osBmjNTk/aQlNXRC2uTSHZiOrJjPC399G2P0jOo9mubSTd17iitZ+6jg1Qa
    XZNJOXcq/JDqvEdfueEKuzX+LN3MIAI/6x45Ys0wSrhlUlex6AURAdE5zg6T/Alb
    ARy6x+KvePR/imrrb03TbnKCNp1v/BzogaA+Kk3YRwoCeZdUi7FZF6C/tWBkIYOk
    6cjQTACh4ohtx8ma9vQm761pOmqwqmBqaTA673cKay4cfPrF07pWIPZlMeB7dNll
    FGzAw5o3C1XBK5lhe6jnGeyt8gbiu/Uvsx42jlKBzgWfPob2/OEtfSls5X4OICUA
    rjFJsCZZz/CKNgKNvPu4Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeCTXtZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 19:49:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47199 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCTXtZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 19:49:25 -0400
Message-ID: <1521589759.23626.120.camel@codethink.co.uk>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Tue, 20 Mar 2018 23:49:19 +0000
In-Reply-To: <20180318102738.GF32470@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org>
         <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
         <20180318102738.GF32470@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-03-18 at 11:27 +0100, Greg Kroah-Hartman wrote:
> On Sat, Mar 17, 2018 at 03:48:24PM +0530, Naresh Kamboju wrote:
[...]
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, qemu_x86_64 and x86_64.
> > 
> > NOTE:
> > CONFIG_LEGACY_VSYSCALL_EMULATE=y is enabled from config as default.
> > Enabled vsyscall=native and vsyscall=none from kernel command line for testing
> > selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
> > 
> > test_vdso_64 failed on x86_64 device when vsyscall=none is enabled.
> > We will investigate this new test failure.
> 
> I think vsyscall=none just went away :)

No, vsyscall=native went away upstream.  vsyscall=none should still
work everywhere.

However, test_vdso_64 isn't able to detect what the current
configuration is and it will crash with vsyscall=none (or the
equivalent default in kconfig).

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
