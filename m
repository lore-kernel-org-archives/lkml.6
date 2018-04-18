Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx49dKEYsa576lR2L2yf0e8Ks9UqN5VQ7tRDaQ2hzu+2zjV2BiYwrCMx28wmMah2DyCyHrcXL
ARC-Seal: i=1; a=rsa-sha256; t=1524046048; cv=none;
        d=google.com; s=arc-20160816;
        b=tOHdUAvcM2r2dPsyIJ22oPnh7vvQpsOzuJkiAxNN8DR171iXfk1KjJOXj5GhHJtRDQ
         wBFdB+Bgbxmqd/3Tv0CLQC187ZyPX66GxnItjraS1ezvqN8xoFBDr0lZVV89cxb9xvvk
         EpNXvIKB3om/wMt6IaUoEzo1DmdCF2ehj6axU1B9emUSe9SrEq8i/zyG/JICeEpdyEaE
         wIAX1KYyoRr+oNdE1AtAgUDjfWLci4y7GIziDA+xmja1QQmaijj0A7P6A12RJtJmB6Hg
         pKfAwFlrlxgSqFPlrGjj73KUVdAdvX2diSFl+oelPnpXip2pPYAbmo1aeZ6KwQat9lWj
         74DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=WyvftqwuWxcWJ0opkKZ/Ab93nWimIlHwfv8IGPOErbo=;
        b=siUVEIzJSSSKe3zyF+i+6ysAeu2EWmhom6h9gUhtBgu8CI6byRMq0fEoY3nqAclhUD
         HBt9FazlbMIZn3oFSufpvSuNkbVhBQPEWiLVwPUgedUfqqjvLizrQs3nuExxoCH21Ni9
         sy+svm2bYqtyCZWCdcDJukwpnTIHV8gW9NsTjlwP0BpHj6z10mIp5yIia+sxcq0nLCMt
         WoM5wp2laD6dIwQWX7JIkXNcBu2OTB7MQWUgTEo9L7vM+IHcmZXua4fYZxtSjmFr2hyb
         zcLU9Brl6FiRBoRy0co9NloeNFiD95Xg2Vm3/V2CWkRAsoAUcZauXSaYwVb1MQlnCw4S
         VlHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Wed, 18 Apr 2018 12:07:21 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180418100721.GA5866@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418081140.GA2439@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598078109606341038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 10:11:40AM +0200, Vitezslav Samel wrote:
>   Could be done anything to prevent this panic?

Yes, for starters, is there anything preventing you from using an initrd
and doing early microcode loading?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/x86/microcode.txt

If no, consider doing that and not using the late method which is
problematic at best.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
