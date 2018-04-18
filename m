Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4/wgBAEYlZBYEtaXk6gWfMkcJKuCJQL7VCLnZ9S3BjdvTmnd+udzwF8nGCtXXy3Nlq2GY3D
ARC-Seal: i=1; a=rsa-sha256; t=1524054134; cv=none;
        d=google.com; s=arc-20160816;
        b=mwMBPASytDIQRDVe3a+qMFIIdsteh2iIb6lFEXXMrKftQBQUYR8EjQV6CnfTwwVhx2
         yR3aNX61cltDKLXd/EoYsrBBDmlO4u6wkdSlVyBKFApl8sJ6dFjsWuCQZvl1HE3SAIWm
         XJV5klGGuMiBd6Zg+9pAnhlVoeeshT0wyNMhmHG+zzlgTUeDE+zOO3ZIkn4QX4emnYIx
         Tka1KI66hP5JofBc8SW8eeof8m+9emgsLUYbvywn2GQ7jn+UZEb8imuyxR/zg7vmY45X
         dbKVPJTgInJLsXESBHFigSKX8qUDOzGyf4ZDvb+9eEjoajTeLTNzQF6BC2cEsjZbVo4N
         RELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=oOYPdQW8H9V2zsTWki8gzhEoCVWBUrtmCI733+mJzqM=;
        b=HDtKZeG1jIad6Psc/0xmF7730JhmygnuVdDvUfvCsUo/0zkbLO7D4YvmTL8wkgezPf
         ol4W06RfvatXIbAdZ/+EziL0LNugWPHZm0pBCuXk0QsuVflpEXGLeeLoKqkRO+gJZ8LC
         0eOTsz2QEfaE03hZDauAx/Co0T0AhDXaL4Ik2tGo80WrJbjBwb4U9bdIjgz3hbapaikJ
         TavvNWDVgiDzOUryDkRytj6WYqmXTFLlMD9Vy48djGQC9qeHtcgI7xTk+ZuWSMpvFcvA
         C/u6jW2G/WRLFMIQk4Cm4lCPqk/Rfl9s6cOoj2ACV/YHbl/EFUPbIKGGLE72JgvSBcvc
         T07g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Wed, 18 Apr 2018 14:22:12 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>, Ashok Raj <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180418122212.GA4290@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418120839.GA5655@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598086588082796620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 02:08:40PM +0200, Vitezslav Samel wrote:
> I switched to firmware-in-kernel early loading and that works OK.

Ok, and keep using that from now on.

People should all move away from that late loading dance. I'm saying
that in case someone else reads this on lkml.

> But still, the reported issue is regression in 4.15.17 and 4.16+.

Oh, I know it is a regression.

@Ashok: anything particular about his microcode revision not being able
to stomach late loading?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
