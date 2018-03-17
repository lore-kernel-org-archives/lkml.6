Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AG47ELufG/0/nrkQNlTKeyfHel4Mgt2awwecVO/KiNr0RyGPdVvRa/w/cqf98PvKU4TSlkxrJ2qY
ARC-Seal: i=1; a=rsa-sha256; t=1521282546; cv=none;
        d=google.com; s=arc-20160816;
        b=DAD43c2zlmtk5gf5TrwL5K7bjfKoozEXUuB+dOvuLyw0LhbdGK1IAcGElv6QoG86do
         2hHYMxyD9wupDBVaYNIKqRxkM9cBRX9g6q+ih3P6mjob6Dpqmub9Dzr7qDAPm4OZlHhr
         JMkuIGKLFTqJdGVlYZKa3kRh1793zrnCzp9Fvipw69L0SSZPgrvqptkckBGW3vT7EM/j
         biWVtP1P2XyKFWq9YhyONtDGLi99+k7rNC188Ll+UNKuvQBBuEEO2C8DEKHiZogTAKP1
         uKA/trJiN3ZRgfWb2bLcxc6gRx5Qf+sxnbjX4KWHAtXIIUUmhg4b8O0cVZ8ZugB6qcY+
         mTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fnDAh+kzlCZKeVTYtcR3JuwPew8WWrM7In26S056CPY=;
        b=TZbJXGLenxPOix9W/Qh0YsD7H7UWhfX5KnGM4SuSORfaC5kfcnWyxnFS4TIdehWVmH
         n6mjDqsIx37WCArbOSmjH3eW1Yj4zRky8AuvWRUTT5+eTAKp5JUYMWJ5PmFPupsSirW3
         N7ge2bs9mupE5768YhQwphNU8ve1YWXQZx20ZTn+pTICRHl7C+3a0mAgCB9nJNKsGjPY
         pccCnXyPm7p6pqIgenAikTpUOK3Jbl+F+NfC/SwgvnaDyK7tJFa1coFrA5k1YFl6XJM7
         tVlpDikCp8/Rwf0q7oY9KcTWecGZA0rKUzhAl16Y4N6048qgR3Lj+j9Ix6F/flTCfuew
         dqDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Date: Sat, 17 Mar 2018 11:29:03 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: David Miller <davem@davemloft.net>
Cc: christian.brauner@ubuntu.com, ebiederm@xmission.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, serge@hallyn.com,
	avagin@virtuozzo.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH v2] netns: send uevent messages
Message-ID: <20180317102902.GA4301@gmail.com>
References: <20180316125030.23624-1-christian.brauner@ubuntu.com>
 <20180316.144145.1695554148709004295.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316.144145.1695554148709004295.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595098694946431538?=
X-GMAIL-MSGID: =?utf-8?q?1595180367177590232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:41:45PM -0400, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 16 Mar 2018 13:50:30 +0100
> 
> > +static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	int ret;
> > +	/* u64 to chars: 2^64 - 1 = 21 chars */
> > +	char buf[sizeof("SEQNUM=") + 21];
> > +	struct sk_buff *skbc;
> 
> I hate to be difficult, but please use reverse christmas tree ordering
> for local variables.

No problem David, coding style is important. I'm about to send out
another version with:

/* u64 to chars: 2^64 - 1 = 21 chars */
char buf[sizeof("SEQNUM=") + 21];
struct sk_buff *skbc;
int ret;

Thanks!
Christian

> 
> > +static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
> > +			      struct netlink_ext_ack *extack)
> > +{
> > +	int ret;
> > +	struct net *net;
> 
> Likewise.
> 
> Thank you.
