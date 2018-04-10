Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+/V36aU2cB13x5yBjlaqFYeFIvNyr2WRXC5Arccft4oFy1MRAwkjkT4HzOtWBCw8Cl1U0X
ARC-Seal: i=1; a=rsa-sha256; t=1523396285; cv=none;
        d=google.com; s=arc-20160816;
        b=WwAw6VkpSrHxzoOKehUktkpsX/ZZp1Oo81as+W0tbfAfLo7xMAI1N8FtolU3k1MGvm
         1evGlmDa/gKVuwZJhmEN5MKH37khXXTuIe2EhqwGktALTYSG3M2ShucCGNhlN4DOym9A
         BKa7ms4xPK9K3rKZfzy3PlvJSRXm258d47M7FoEhN4PgVxZHod8qoi5Rd7+AV3zHWGx2
         PSRnhNcX0vIZm2ZZKYFaDDl1YBMyKNiCGpUnbDubaqFLdEtmeW69y/EeXt+byT2rJbi4
         uqt5rMajw+ab5BiUgR26XhIXftsN9qzdzWeR5voZMCSC04wmR1N9mGbregRde4Apta/Z
         wTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=7UofQwcAT/ly1MPX3fPS7FcxNGwxJHQ3/Mh1unPprNA=;
        b=YqnEbyeWLtw9O147UQEqMCqCSJcf0pgG1oHcvFrWAZkGcHdfsc9iApfNZC4Fr6pfQh
         jhgbCIyvDQFFCjw7l1XsIanAYVMA5HMxlCv8IlhxIWq5q4PPck8eNaRWfG1jT6R2gIed
         9R2VfG2O6bqk9y9AC3f4o5hx3C6oLd8GflXemrMxkOLc15Tch0M7u4AItg19zfzA6ngV
         OoDHNXBh5486WWR8y8pn3W11ktYt2aqahy3f4YWw74YTc1dPhjym1kf/xYOVS2C5/3YN
         Mn8XY+l3lifm7LtNHSScnzX8h4VeITcu82GTBDsVlIuEsFuXRe/ARxZU9Ag2sP2RrpPc
         Y38g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeDJViE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 17:38:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:60831 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDJViD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 17:38:03 -0400
Date: Tue, 10 Apr 2018 23:38:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] selftests/livepatch: introduce tests
In-Reply-To: <20180410213354.ma5wfe3jc23pzmw4@treble>
Message-ID: <nycvar.YFH.7.76.1804102337070.28129@cbobk.fhfr.pm>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com> <1523373354-10801-2-git-send-email-joe.lawrence@redhat.com> <20180410200059.loy3hw6tcwdi4m5z@treble> <daac17e1-6e32-fce9-51b0-24ec25bda69f@redhat.com>
 <20180410213354.ma5wfe3jc23pzmw4@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372767626625774?=
X-GMAIL-MSGID: =?utf-8?q?1597396783156001363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Josh Poimboeuf wrote:

> I think CONFIG_LOCKDEP is always a good idea. 

FWIW CONFIG_LOCKDEP mostly enables the infrastructure, but 
CONFIG_PROVE_LOCKING is what turns most of the cleverness on.

-- 
Jiri Kosina
SUSE Labs

