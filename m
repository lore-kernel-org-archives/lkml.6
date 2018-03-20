Return-Path: <pratik.jain0509@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521546078; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgNsC/6SyV0t3YLJTo2RDEqi4gDyTyxLLG5F1OBKfI5UmmXanKKCuFkF7zc5u8dRr6
         +YFKnQh33isFr0h1glooVeGJuDYE0nbBmXEyfduLV52JNFVlEur0md8olyaH4waolNbu
         29jp+YGDpqwyHN3LoLbIj+23t+MWSY4tE5A68FFDWuX3M3gFzv5DIdkShB/4brFuPL4R
         3uESdXsWc+Dp9+b5Yq4aEkbF77gtXDrUAFH2r7oi7c/dg8TDc+TOqp13KSx08oA+wHep
         a0nEwIFLw0WXPxIUm+atv4PmtUkKmzOctC6H8bwOlZLkEk7L8ErU+ed38mrOyfh5zzLp
         ES3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0VC8yznMOOJognLL8ZPnjEoPVqEqxrMV+MbqZb8gd4U=;
        b=IsJMA9rmhsBO8ujc76crwRJJNO0eRGjbI4DSIQ8M6ia+VOzJQP+NwdYCqm7KCqnjc+
         Aq76/IZuGgWq+7eeCCatP9TgYbuLnlifu62iQSZEyktciIq9IlD3RL668trZGXPzBKFF
         /9uKpoW/rOh67uit6BRJ9D/J+Xm68BbuY8f/kn9a7PxEOAoPWRcLpVWDy7A+XQ0kyNpL
         IrEmCNMDASE5PB5v+p4PgPnqrfKvB7PXp+iLNcPjZ0p1lwUvwzVMrUxNZM92n5YagdZD
         P26luvVa1X8JDaaUfn3yz/kaigOmT5HXMq0iIWET7axC2V1Xx1A2WqB6kaW5jURwPKVw
         rh1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IP8Wsj7G;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IP8Wsj7G;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsf+3Fb77m4CWbr5/PaHn2ejas3n6fTJ1lKcXmjNiHlbKGJhzw0vUSmLgA2jMmJzjMZKJ1JVg==
Date: Tue, 20 Mar 2018 17:11:11 +0530
From: Pratik Jain <pratik.jain0509@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: arnaud.patard@rtp-net.org, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Message-ID: <20180320114111.GA18734@archlinux>
References: <20180320083549.6795-1-pratik.jain0509@gmail.com>
 <20180320112053.zxudtqeemedogcel@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320112053.zxudtqeemedogcel@mwanda>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595445043191954085?=
X-GMAIL-MSGID: =?utf-8?q?1595456701458509823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

You got a valid point about `++i` and `i++`. But I still feel
that it is less complicated than previous one. I am explicitly
saying(in first loop) that we are skipping some values to get
to a specific index. Apart from that, we can avoid unncessary
wrapping and indentation. Logic becomes much more explicit if
broken down to two loops.
