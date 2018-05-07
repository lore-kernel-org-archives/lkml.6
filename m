Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AB8JxZquqdOaYEoKHLSnxxxcWs54J0HehiT1MTAVqyPP1HocDnEeNKX8hmZ0pXghGDjAWBRvEmxn
ARC-Seal: i=1; a=rsa-sha256; t=1525708239; cv=none;
        d=google.com; s=arc-20160816;
        b=QOLZF/Y0k/VDpKPXsHEapgYhoBkC4xepqvE4zgd6VCEVppl30n6Uict7+ZMHHS44tz
         isiifupxavvm8TKT/f0TJj2gZOUUN6ehBEGBLFbBnOsbHptiSynY7IP+8mCp42Qm997B
         whMItG42xArW8Y4KR1iqB0xaJiJa+kkd5bRwTD3WPzarzAM9I3RRr/Z7HuawkIWbbBjj
         DJwn66UE4L83T99bd0wyTa24OO7tfUBeHam3NMvt9XbxVOs6fzFNTm/xinLVvgV1sOxE
         Mdt6IeJHnntfd9/rlI+OAAZiAwqEYHbcmvGEhRL4RVIcrS26HHj27J6CuG8kmvv+ZNHl
         mtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=JbSxfk+ikUPh2h6FS2MQiDBHt673XY5Oi2GTIgjvX4A=;
        b=EzeGeconyKNdpCH0xu1hnjFDW7I6yfhv7QWTjZgz44/zSawQjJN/qPNY/O7VKpvDKw
         z1w9ECe8o/XnrG/te8ivb9j2lJ4CBCwnS8ZCWDpAoDS/3iA8MNrYt5PnSmNsYsQ406ji
         VHG/MMSL351hJw/OazE+MqmkVWJ9X0mg+UllULnDIIykWnUao5WqzDcOluhQlKn9UtcE
         U9GT3B+l/qjEe/LEQDGrU/CWKKvkbpVuq9ISPhKgimA0CZaFipkI3DEf14R2cFEEZWX+
         1Dm2LTKuHO0VIpEVVdvW2cqwrTV8XGzr/Vic5nPWeWCM5hr6u9yBushHuVUKMEk1dFON
         2x0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Mon, 07 May 2018 11:50:36 -0400 (EDT)
Message-Id: <20180507.115036.2237866742963204693.davem@davemloft.net>
To: laforge@gnumonks.org
Cc: ast@kernel.org, daniel@iogearbox.net, torvalds@linux-foundation.org,
 gregkh@linuxfoundation.org, luto@amacapital.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180507152435.GE19042@nataraja>
References: <20180503043604.1604587-1-ast@kernel.org>
	<20180503043604.1604587-3-ast@kernel.org>
	<20180507152435.GE19042@nataraja>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599821043147007708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Harald Welte <laforge@gnumonks.org>
Date: Mon, 7 May 2018 17:24:35 +0200

> But if the ruleset loads but behaves different than before (because e.g.
> it's executed from a completely different place in the stack), that's
> IMHO an absolute no-go that must be avoided at all cost.

That's not what we are doing nor proposing.  I'm sorry if you are
confused on this matter.

The base implementation we strive for will execute the BPF programs
from the existing netfilter hook points.

However, if semantically the effect is equal if we execute the BPF
program from XDP, we will allow that to happen as an optimization.

The BPF exection is where it is in these patches for the purposes of
bootstrapping the bpfilter project and easy testing/benchmarking/hacking.

I hope this clears up your confusion.

If you would like to become involved in hacking on bpfilter to help us
ensure more accurate compatability between existing iptables and what
bpfilter will execute for the same rule sets, we very much look
forward to your contributions and expertiece.

Thank you.
